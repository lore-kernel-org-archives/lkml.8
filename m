Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69562087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579272801;
	bh=NKvl8pqM+SZeTyBOZdayAwjEIGElTONmX+PkukewNTc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fq6Rsvtbf5lmG6YvyHkQ2I0lEq8JACKxsEOUaJ1a8TF/Mwsx9HuHiuicItrzfiZDP
	 ZpDxFWspLM/mSiTsTbLdhZroZtK4epCs3VRTapR5SuT8QiPXqqxPaOEFZJprnTAD63
	 H84a6s1UDtbbCR/OtkH5NgW4BKf2JMX/xdO1TUEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAQOxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgAQOxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:53:19 -0500
Received: from linux-8ccs.suse.cz (x2f7fe76.dyn.telefonica.de [2.247.254.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D132083E;
        Fri, 17 Jan 2020 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579272799;
        bh=NKvl8pqM+SZeTyBOZdayAwjEIGElTONmX+PkukewNTc=;
        h=From:To:Cc:Subject:Date:From;
        b=FE4tCBjf9vYqsnxyanyleXsV3lL0AOUz+hI3jVef8wzS4gdT9rNt2NL22/nF/fuY/
         iuIWawdkESvYD0fcIkvbrYg9ilzsAPiXy5V2HdmWrLAbMxIoKDWh0vQiFhF/efl+Hl
         c/vf6mj3Yl0OmB7yCA8ALITgHbG7a9BLJbAIIX6Q=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: avoid setting info->name early in case we can fall back to info->mod->name
Date:   Fri, 17 Jan 2020 15:53:06 +0100
Message-Id: <20200117145306.15509-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In setup_load_info(), info->name (which contains the name of the module,
mostly used for early logging purposes before the module gets set up)
gets unconditionally assigned if .modinfo is missing despite the fact
that there is an if (!info->name) check near the end of the function.
Avoid assigning a placeholder string to info->name if .modinfo doesn't
exist, so that we can fall back to info->mod->name later on.

Fixes: 5fdc7db6448a ("module: setup load info before module_sig_check()")
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2b5f9c4748bc..f2379e54fae8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3059,9 +3059,7 @@ static int setup_load_info(struct load_info *info, int flags)
 
 	/* Try to find a name early so we can log errors with a module name */
 	info->index.info = find_sec(info, ".modinfo");
-	if (!info->index.info)
-		info->name = "(missing .modinfo section)";
-	else
+	if (info->index.info)
 		info->name = get_modinfo(info, "name");
 
 	/* Find internal symbols and strings. */
@@ -3076,14 +3074,15 @@ static int setup_load_info(struct load_info *info, int flags)
 	}
 
 	if (info->index.sym == 0) {
-		pr_warn("%s: module has no symbols (stripped?)\n", info->name);
+		pr_warn("%s: module has no symbols (stripped?)\n",
+			info->name ?: "(missing .modinfo section or name field)");
 		return -ENOEXEC;
 	}
 
 	info->index.mod = find_sec(info, ".gnu.linkonce.this_module");
 	if (!info->index.mod) {
 		pr_warn("%s: No module found in object\n",
-			info->name ?: "(missing .modinfo name field)");
+			info->name ?: "(missing .modinfo section or name field)");
 		return -ENOEXEC;
 	}
 	/* This is temporary: point mod into copy of data. */
-- 
2.16.4

