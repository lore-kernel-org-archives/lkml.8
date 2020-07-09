Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E6FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E4B20774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkpE3Mbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGIMJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:09:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgGIMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594296547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W75+jDnQUtrDtvhDOoLooacfHWuMTVDnvCx27hhagvk=;
        b=FkpE3Mbc0e0Ik1qS0bdLalTZFaahl0J+gaX8LBjYO2KCa+1bmviktF/T5qlqeV1GRi4Owl
        Q4MkuLBLS39jEAQqxUsg8L1GYW17gJcDTxx4zWLK5ESSgtIn3eIHwbiZRa3WAzbAYs5SKU
        xCdNpQfQj5wSzs8iCPtS7w4rePl9Re4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-O_L4b2PQPiypAWNHC2pC2w-1; Thu, 09 Jul 2020 08:09:02 -0400
X-MC-Unique: O_L4b2PQPiypAWNHC2pC2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EB14107ACF7;
        Thu,  9 Jul 2020 12:09:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-29.ams2.redhat.com [10.36.115.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5CC31053B28;
        Thu,  9 Jul 2020 12:08:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend v2 0/8] virt: vbox: Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
Date:   Thu,  9 Jul 2020 14:08:50 +0200
Message-Id: <20200709120858.63928-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As requested by Arnd, here is a resend of v2 of my vboxguest driver patch-set,
adding support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl, with
Arnd's Acked-by added.  Can you pick this up and merge it into the next
branch of your char/misc tree?

Regards,

Hans

