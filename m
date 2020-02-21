Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE591C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163220578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272847;
	bh=FGprxRun26IH1icAQXs7d2ZLvfCNFwA9W5z0AhAUZhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LFFzx2qMK7g6krAADcgp+CdqEqIIfd0uFrQY65oGW8T2v6CgKbpkoEigufnHxMR2D
	 ZhJyKTN2oYXOmjKjGUPCPzhE8kntE0yng3t1PrWPATZe5nxymJS7mJ44duLKZ07Dia
	 Ks7+ztVOVHXj26mviyDGTPCclozDGP1egXw18ot8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbgBUIOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732691AbgBUIOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:14:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE6124650;
        Fri, 21 Feb 2020 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272844;
        bh=FGprxRun26IH1icAQXs7d2ZLvfCNFwA9W5z0AhAUZhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIlVWDlPi/XwBv2rRmr/PYR/XK9RjBimphfjHfUsViFtWCq/ToqqdFQd5MwUZD0+p
         uTMgkvXj6BgVUgnl6y56DJFegEssVMzexJsaZjaq+WAqQgitwG2TY7KkpSSpt0c/m/
         E+JRvpPPjf2ypOaOBcE/NEdgrB1f3ogohoqznkGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Jessica Yu <jeyu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 267/344] module: avoid setting info->name early in case we can fall back to info->mod->name
Date:   Fri, 21 Feb 2020 08:41:06 +0100
Message-Id: <20200221072413.919611653@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Yu <jeyu@kernel.org>

[ Upstream commit 708e0ada1916be765b7faa58854062f2bc620bbf ]

In setup_load_info(), info->name (which contains the name of the module,
mostly used for early logging purposes before the module gets set up)
gets unconditionally assigned if .modinfo is missing despite the fact
that there is an if (!info->name) check near the end of the function.
Avoid assigning a placeholder string to info->name if .modinfo doesn't
exist, so that we can fall back to info->mod->name later on.

Fixes: 5fdc7db6448a ("module: setup load info before module_sig_check()")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/module.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 135861c2ac782..a2a47f4a33a78 100644
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
2.20.1



