Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51806C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A55207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgH2LOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:14:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2LOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:14:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36306B167;
        Sat, 29 Aug 2020 11:15:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH] module: Add more error message for failed kernel module loading
Date:   Sat, 29 Aug 2020 19:14:37 +0800
Message-Id: <20200829111437.96334-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel module loading failed, user space only get one of the
following error messages:
- -ENOEXEC
  This is the most confusing one. From corrupted ELF header to bad
  WRITE|EXEC flags check introduced by in module_enforce_rwx_sections()
  all returns this error number.

- -EPERM
  This is for blacklisted modules. But mod doesn't do extra explain
  on this error either.

- -ENOMEM
  The only error which needs no explain.

This means, if a user got "Exec format error" from modprobe, it provides
no meaningful way for the user to debug, and will take extra time
communicating to get extra info.

So this patch will add extra error messages for -ENOEXEC and -EPERM
errors, allowing user to do better debugging and reporting.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel/module.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 1c5cff34d9f2..9f748c6eeb48 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2096,8 +2096,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 	int i;
 
 	for (i = 0; i < hdr->e_shnum; i++) {
-		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
+			pr_err(
+			"Module %s section %d has invalid WRITE|EXEC flags\n",
+				mod->name, i);
 			return -ENOEXEC;
+		}
 	}
 
 	return 0;
@@ -3825,8 +3829,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	char *after_dashes;
 
 	err = elf_header_check(info);
-	if (err)
+	if (err) {
+		pr_err("Module has invalid ELF header\n");
 		goto free_copy;
+	}
 
 	err = setup_load_info(info, flags);
 	if (err)
@@ -3834,6 +3840,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	if (blacklisted(info->name)) {
 		err = -EPERM;
+		pr_err("Module %s is blacklisted\n", info->name);
 		goto free_copy;
 	}
 
-- 
2.27.0

