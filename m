Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986EC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13402070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnVt/zS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgDZKr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:47:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58258 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgDZKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lqBHK1Qia+8A298KbiTPhxU1CHMMejP2vD7zTZ8rklA=;
        b=cnVt/zS5vUkKwDxFUIEYwOU4TMhTw7/OZCLJljEfKXUssgo2wJ9bfxrGlsgHJNlF/1y+ri
        qaKK2blNGz8tFnsUx9AR0g0vx6A2tQpouCVd79In9tMThZcwiXBmYCHOY6n4mbUgnCJjrY
        CYVq22BVBebkQxK3ARJCEbyUq631ogc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-oZgsmKvcNf2pcecckE1sHg-1; Sun, 26 Apr 2020 06:47:19 -0400
X-MC-Unique: oZgsmKvcNf2pcecckE1sHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FC71005510;
        Sun, 26 Apr 2020 10:47:17 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 401245D715;
        Sun, 26 Apr 2020 10:47:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI / scan: Create platform device for CPLM3218 ACPI nodes
Date:   Sun, 26 Apr 2020 12:47:11 +0200
Message-Id: <20200426104713.216896-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a patch series to deal with the way jow the CM3281
ambient-light-sensor is described in the ACPI tables of Asus
T100TA and T100CHI devices:

 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
 {
     Name (SBUF, ResourceTemplate ()
     {
         I2cSerialBusV2 (0x000C, ControllerInitiated, 0x00061A80,
             AddressingMode7Bit, "\\_SB.I2C3",
             0x00, ResourceConsumer, , Exclusive,
             )
         I2cSerialBusV2 (0x0048, ControllerInitiated, 0x00061A80,
             AddressingMode7Bit, "\\_SB.I2C3",
             0x00, ResourceConsumer, , Exclusive,
             )
         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
         {
             0x00000033,
         }
     })
     Return (SBUF) /* \_SB_.I2C3.ALSD._CRS.SBUF */
 }

Notice that the first entry is the SMBus Alert Response Address, this
is actually somewhat useful as on this sensor we must read a byte
from that address once to clear an alert which seems to be set on
power-on; and without doing this the sensor will not respond on its
actual address. Taking care of this is left up to the cm32181 driver
(I will Cc you on the patch series for that).

This series uses the i2c-multi-instantiate code to instantiate
i2c-clients for both addresses.

Note this series touches files under both drivers/apci and
drivers/platform/x86. IIRC in the past i2c-multi-instantiate changes
were merged through Rafael's tree because of this.

Andy or Darren may we have your Acked-by for merging this through
Rafael's tree?

Regards,

Hans

