Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C365BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F529206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgEDRAc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:00:32 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21368 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgEDRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:00:32 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 13:00:32 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1588610726; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LpZM+A3eSnXvUoRk8c7sfR6tMmE7RkkP2rmb3jRXGxaViJiVvbnCK74YKkfEgCM961ZjJuij0dYLeGyObjHytcfcd8mC1iJioiC9l4X4Gu9gG/gyuyHGbYfzjKHbnuaxuxRtCfZVyFEpl48Txz9oSPzUNeDd5aD5yuq3E2+1DeY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1588610726; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=der92XC6L6dUwBvuCzBUelP0mcwc9+VlTvwsypuIA28=; 
        b=iSBJq96KuRv/aVbpKX5UxRjE1Ttb7bx99VoG2EyAwc91n6f4TnBe1M1ZAs7iUzqJhEQdOaimbYeTqKeO3n3V6W5I4pJj4Fg4jo8WKwfr18AVtofp9oUjprAGyZ9lq3ZT8/0CRPMnpJ5iuRRFu0Stz/Y5dukUA1a1IPorHqrZijk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=a@dun.ai;
        dmarc=pass header.from=<a@dun.ai> header.from=<a@dun.ai>
Received: from localhost.localdomain (92.253.251.250 [92.253.251.250]) by mx.zohomail.com
        with SMTPS id 1588610722132356.4202852300126; Mon, 4 May 2020 09:45:22 -0700 (PDT)
From:   Andrew Dunai <a@dun.ai>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Dunai <a@dun.ai>
Message-ID: <20200504164514.18641-1-a@dun.ai>
Subject: [PATCH] Add support for Vinga Twizzle J116 Silead touchscreen
Date:   Mon,  4 May 2020 19:45:14 +0300
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/touchscreen_dmi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 93177e6e5..a3ab19ab0 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -640,6 +640,20 @@ static const struct ts_dmi_data trekstor_surftab_wintron70_data = {
 	.properties	= trekstor_surftab_wintron70_props,
 };
 
+static const struct property_entry vinga_twizzle_j116_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1920),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-vinga-twizzle_j116.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data vinga_twizzle_j116_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= vinga_twizzle_j116_props,
+};
+
 /* NOTE: Please keep this table sorted alphabetically */
 static const struct dmi_system_id touchscreen_dmi_table[] = {
 	{
@@ -1054,6 +1068,13 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
 		},
 	},
+	{
+		/* Vinga Twizzle J116 */
+		.driver_data = (void *)&vinga_twizzle_j116_data,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "VINGA Twizzle J116"),
+		},
+	},
 	{ },
 };
 
-- 
2.26.2


