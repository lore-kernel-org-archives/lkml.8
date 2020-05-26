Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376CEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141EE208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520363;
	bh=sFwt3TDTfuCsjbihcQY/VzD3/H/dUMAmRatkpzDNB74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2uifM3iOFA6FY2TuVFJSsjX6L99+kqVwu83VRmp6cprhxOPT1znoTF4QOoDCqm+uo
	 11N/eoHF5R3uFIjitxYpdFAG2V1Bd9h6Zx2gtwdoDi5pEISJnXQU3IeIXEZtUQwijo
	 E6lh2L0O/8T8CjhdACSWxqQ16uY2m2tOoWMHMiSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbgEZTMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392098AbgEZTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CC720888;
        Tue, 26 May 2020 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520356;
        bh=sFwt3TDTfuCsjbihcQY/VzD3/H/dUMAmRatkpzDNB74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPOmej/Qnm/QY/1LwR+Imp4etBoTS0rZnOnxwSVkW5nqMc77l6vru1x6L7ZknMhl9
         xs5nRK83+o+Kfj3K/qiPlgjF/y9tZ2WcHHSgK/ShycCwFYlpC8snL/Fi2UWXdpInBG
         vYFLA2DjLZvRjmeGxO9i2Cqgu3WnZInFVPPyyk7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 047/126] platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA
Date:   Tue, 26 May 2020 20:53:04 +0200
Message-Id: <20200526183941.979805794@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 3bd12da7f50b8bc191fcb3bab1f55c582234df59 ]

asus-nb-wmi does not add any extra functionality on these Asus
Transformer books. They have detachable keyboards, so the hotkeys are
send through a HID device (and handled by the hid-asus driver) and also
the rfkill functionality is not used on these devices.

Besides not adding any extra functionality, initializing the WMI interface
on these devices actually has a negative side-effect. For some reason
the \_SB.ATKD.INIT() function which asus_wmi_platform_init() calls drives
GPO2 (INT33FC:02) pin 8, which is connected to the front facing webcam LED,
high and there is no (WMI or other) interface to drive this low again
causing the LED to be permanently on, even during suspend.

This commit adds a blacklist of DMI system_ids on which not to load the
asus-nb-wmi and adds these Transformer books to this list. This fixes
the webcam LED being permanently on under Linux.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 6f12747a359a..c4404d9c1de4 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -515,9 +515,33 @@ static struct asus_wmi_driver asus_nb_wmi_driver = {
 	.detect_quirks = asus_nb_wmi_quirks,
 };
 
+static const struct dmi_system_id asus_nb_wmi_blacklist[] __initconst = {
+	{
+		/*
+		 * asus-nb-wm adds no functionality. The T100TA has a detachable
+		 * USB kbd, so no hotkeys and it has no WMI rfkill; and loading
+		 * asus-nb-wm causes the camera LED to turn and _stay_ on.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+		},
+	},
+	{
+		/* The Asus T200TA has the same issue as the T100TA */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T200TA"),
+		},
+	},
+	{} /* Terminating entry */
+};
 
 static int __init asus_nb_wmi_init(void)
 {
+	if (dmi_check_system(asus_nb_wmi_blacklist))
+		return -ENODEV;
+
 	return asus_wmi_register_driver(&asus_nb_wmi_driver);
 }
 
-- 
2.25.1



