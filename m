Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1893A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699790;
	bh=3KRChEGwMrFyCZkXflHL2hF+PqaYvlhAhPObu7WcK68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BKGb4K5jOJo3qks1U9utBpZKJq5YRKOpz8vT3t+CTdiSDIMSy9AVBYLWuct4/xq9r
	 RP06xZjGKj99ZEBMwH5tZFzETCZpb2NcpV1xr2HImiLj+4toiD7abOwpE6Eq/2x21I
	 xgC1zxdmFHgbJ+FdZ1e/UzcjuakbX0Ita1soC/4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbgBNRDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404180AbgBNQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613C2246F5;
        Fri, 14 Feb 2020 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696957;
        bh=3KRChEGwMrFyCZkXflHL2hF+PqaYvlhAhPObu7WcK68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzOMUHkO9d2lWNBZwy0WT7NYMNsHTGq4UVTXq6lV0AebTQ+9Fp0utplGFrOQ8UY7P
         x2/k0fs49k2DflG8LTX9EylBXYq7g+/D5fVxliWn7q0TwgLc6MLoRiCB0G/EhS3qiC
         50g7LyTEi1n1qly5Vh5MzPr8YjRcweZg4F3eqY0g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 197/252] module: avoid setting info->name early in case we can fall back to info->mod->name
Date:   Fri, 14 Feb 2020 11:10:52 -0500
Message-Id: <20200214161147.15842-197-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 70a75a7216abb..20fc0efc679c0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2980,9 +2980,7 @@ static int setup_load_info(struct load_info *info, int flags)
 
 	/* Try to find a name early so we can log errors with a module name */
 	info->index.info = find_sec(info, ".modinfo");
-	if (!info->index.info)
-		info->name = "(missing .modinfo section)";
-	else
+	if (info->index.info)
 		info->name = get_modinfo(info, "name");
 
 	/* Find internal symbols and strings. */
@@ -2997,14 +2995,15 @@ static int setup_load_info(struct load_info *info, int flags)
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

