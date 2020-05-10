Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1CC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B512208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGyHdo9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgEJMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:24:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26195 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728874AbgEJMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589113482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaSfusBfcGuWtpLDZO+nitz176bAfcWOMkB3GTG1aLs=;
        b=EGyHdo9R7dMaV7C/oTUj9Qo6CksFdE4UhRTe//oUrvA1eLUUHbtRSYZDccusKo2cdHBgRj
        S5MgcFZgcVWZh1epqJ81+nkX5/1wLqMes0KLQzKlFDpGJmUz6Qe5IKsArtYhOLwtbHumaY
        gNMfpHytXF7zUE2E+9vkdtAPmfbmneQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-_rjgrsf6NoS5RNnuspAfRA-1; Sun, 10 May 2020 08:24:38 -0400
X-MC-Unique: _rjgrsf6NoS5RNnuspAfRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B5E1835B41;
        Sun, 10 May 2020 12:24:37 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 834BD5D9C9;
        Sun, 10 May 2020 12:24:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: asus-wmi: Ignore WMI events with code 0x79
Date:   Sun, 10 May 2020 14:24:32 +0200
Message-Id: <20200510122432.123751-3-hdegoede@redhat.com>
In-Reply-To: <20200510122432.123751-1-hdegoede@redhat.com>
References: <20200510122432.123751-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Asus devices, e.g. the T100TA, when the charger is connected
we not only get a WMI event with code 0x58, but immediately after that
event we also get an even with code 0x79.

This is likely related to these devices having an Asus WMI device with a
device-id of 0x00120066, which seems to provide some sort of charger-type
info. The T100TA charger over a micro-USB connector, the embedded-
controller register read when calling asus_wmi_get_devstate(0x00120066)
returns different values when connected to a USB port (max 500mA charging)
vs when connected to a 2A capable wall-charger. But the AML code reading
this mangles the return value so that we can no longer tell the difference.
So for now the meaning of the value return when getting the status of
device-id 0x00120066 is unclear.

This commit adds a key-mapping of code 0x79 to KE_IGNORE, silencing the
kernel logging the following message every time the charger is plugged-in:

[   79.639548] asus_wmi: Unknown key 79 pressed

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 6f12747a359a..b2887556fd4d 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -472,6 +472,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
 	{ KE_IGNORE, 0x6E, },  /* Low Battery notification */
 	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
+	{ KE_IGNORE, 0x79, },  /* Charger type dectection notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
-- 
2.26.0

