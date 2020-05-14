Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31686C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E56720675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483011;
	bh=QUFetR9UqtfJBD0l1eafaBNbAy+eu3AJDBGIyKjgDC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zE6X4xO8H8OnYe8AmspYDWQYteD+ADk4tAp3w31PX+Zw+5byUwT//HmtzGbA8mnZ2
	 MM8fjE/OnUvoMqmyffWkvAniSH1KO9WjSd0MG6pgfgowrhz8fsmpBr/ST/0llfevOT
	 iqHGrDiOpdKO/d9CgJbjqUdYMjtrPWmNOmy3KhYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgENTDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgENSyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:54:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5D2207D5;
        Thu, 14 May 2020 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482488;
        bh=QUFetR9UqtfJBD0l1eafaBNbAy+eu3AJDBGIyKjgDC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwEd+cl1B4Ndd+gn4T3g5Q7nYrMLEAQa25Wxo7rx5HDkbQ7bHitqk1dkpTnB48rJ2
         5wNhRs4go4hR95rpcBOhm9YQlOJnMJfJkXr6W+tF1QA8SVQsDoTqek+qRwmiq6JWcm
         NraKXlxvrA+xGLlrrby7TwKVSBTqe/Skp3QPUbuo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/31] platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA
Date:   Thu, 14 May 2020 14:54:09 -0400
Message-Id: <20200514185413.20755-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185413.20755-1-sashal@kernel.org>
References: <20200514185413.20755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 59f3a37a44d7a..8db2dc05b8cf2 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -517,9 +517,33 @@ static struct asus_wmi_driver asus_nb_wmi_driver = {
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
2.20.1

