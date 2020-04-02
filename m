Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77962C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CBC206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbgDBQRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:17:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389458AbgDBQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:17:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA61EAE50;
        Thu,  2 Apr 2020 16:17:33 +0000 (UTC)
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt_elf: remove redundant elf_map ifndef
Date:   Thu,  2 Apr 2020 18:15:43 +0200
Message-Id: <20200402161543.4119-1-ailiop@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ifndef was added a long time ago to support archs that would define
their own mapping function. The last user was the metag arch which was
removed from the tree, and as such there are no users left. Let's kill
it.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/binfmt_elf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e82..89428c9732c4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -346,8 +346,6 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	return 0;
 }
 
-#ifndef elf_map
-
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -387,8 +385,6 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
-#endif /* !elf_map */
-
 static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
 {
 	int i, first_idx = -1, last_idx = -1;
-- 
2.16.4

