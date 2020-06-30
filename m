Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC4820768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KPjg9wkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbgF3SFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:05:01 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:36437 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729105AbgF3SFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:05:00 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 14:04:59 EDT
Received: from mxback24g.mail.yandex.net (mxback24g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:324])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 01E3E3C0040B;
        Tue, 30 Jun 2020 20:56:57 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by mxback24g.mail.yandex.net (mxback/Yandex) with ESMTP id v85Grp0WyM-uuhagsZ7;
        Tue, 30 Jun 2020 20:56:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1593539816;
        bh=IJcV8VMIHicqFXlSQM92CzBLaL8TW0Er/AJNF1POiuA=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=KPjg9wkdi+ipotCp/pZuU0AfxxHxRzZTZmOQRKHT6JYHWCtwNpxY+CEHmZaIhGTqm
         51c/ugkX/aEJRBvNcGtddimLN8iJuWlxEczTzWWfdRcxJE/U3glvMqyh/lWyi95NAc
         Pz4U2WSNlZv7IpVaDNFZKeI8HsoB9mzsfhBQZZxE=
Authentication-Results: mxback24g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 7Bay8XZxwY-uul0thte;
        Tue, 30 Jun 2020 20:56:56 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Vasiliy Kupriakov <rublag-ns@yandex.ru>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Vasiliy Kupriakov <rublag-ns@yandex.ru>,
        acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND
        EEEPC ACPI/WMI EXTRAS DRIVERS),
        platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC
        ACPI/WMI EXTRAS DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: 
Date:   Tue, 30 Jun 2020 20:56:01 +0300
Message-Id: <20200630175559.23966-1-rublag-ns@yandex.ru>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] platform/x86: asus-wmi: allow BAT1 battery name

The battery on my laptop ASUS TUF Gaming FX706II is named BAT1.
This patch allows battery extension to load.

Signed-off-by: Vasiliy Kupriakov <rublag-ns@yandex.ru>
---
 drivers/platform/x86/asus-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 877aade19497..8f4acdc06b13 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -441,6 +441,7 @@ static int asus_wmi_battery_add(struct power_supply *battery)
 	 * battery is named BATT.
 	 */
 	if (strcmp(battery->desc->name, "BAT0") != 0 &&
+	    strcmp(battery->desc->name, "BAT1") != 0 &&
 	    strcmp(battery->desc->name, "BATT") != 0)
 		return -ENODEV;
 
-- 
2.27.0

