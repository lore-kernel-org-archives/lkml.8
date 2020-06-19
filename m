Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF99C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A313D207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgFSIQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgFSIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:16:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9BC0613EE;
        Fri, 19 Jun 2020 01:16:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmCBr-0003op-GI; Fri, 19 Jun 2020 10:15:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1CC391C0478;
        Fri, 19 Jun 2020 10:15:59 +0200 (CEST)
Date:   Fri, 19 Jun 2020 08:15:58 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Clean up elf_write() condition
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159255455891.16989.15854686934246598318.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2b10be23ac0f8e107fd575397361ddbaebc2944b
Gitweb:        https://git.kernel.org/tip/2b10be23ac0f8e107fd575397361ddbaebc2944b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Apr 2020 23:15:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Jun 2020 17:36:33 +02:00

objtool: Clean up elf_write() condition

With there being multiple ways to change the ELF data, let's more
concisely track modification.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c   |  4 +++-
 tools/objtool/elf.c     | 13 +++++++++++--
 tools/objtool/elf.h     |  5 +++--
 tools/objtool/orc_gen.c |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5fbb90a..91a67db 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2740,7 +2740,7 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open_read(objname, O_RDWR);
 	if (!file.elf)
 		return 1;
 
@@ -2801,7 +2801,9 @@ int check(const char *_objname, bool orc)
 		ret = create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
+	}
 
+	if (file.elf->changed) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8422567..bc6723a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -713,6 +713,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
+	elf->changed = true;
+
 	return sec;
 }
 
@@ -746,7 +748,7 @@ struct section *elf_create_rela_section(struct elf *elf, struct section *base)
 	return sec;
 }
 
-int elf_rebuild_rela_section(struct section *sec)
+int elf_rebuild_rela_section(struct elf *elf, struct section *sec)
 {
 	struct rela *rela;
 	int nr, idx = 0, size;
@@ -763,6 +765,9 @@ int elf_rebuild_rela_section(struct section *sec)
 		return -1;
 	}
 
+	sec->changed = true;
+	elf->changed = true;
+
 	sec->data->d_buf = relas;
 	sec->data->d_size = size;
 
@@ -779,7 +784,7 @@ int elf_rebuild_rela_section(struct section *sec)
 	return 0;
 }
 
-int elf_write(const struct elf *elf)
+int elf_write(struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
@@ -796,6 +801,8 @@ int elf_write(const struct elf *elf)
 				WARN_ELF("gelf_update_shdr");
 				return -1;
 			}
+
+			sec->changed = false;
 		}
 	}
 
@@ -808,6 +815,8 @@ int elf_write(const struct elf *elf)
 		return -1;
 	}
 
+	elf->changed = false;
+
 	return 0;
 }
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index f4fe1d6..aa9c64d 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -76,6 +76,7 @@ struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
+	bool changed;
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
@@ -118,7 +119,7 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 void elf_add_rela(struct elf *elf, struct rela *rela);
-int elf_write(const struct elf *elf);
+int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
 struct section *find_section_by_name(const struct elf *elf, const char *name);
@@ -130,7 +131,7 @@ struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsig
 struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-int elf_rebuild_rela_section(struct section *sec);
+int elf_rebuild_rela_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index c954998..4c37f80 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -222,7 +222,7 @@ int create_orc_sections(struct objtool_file *file)
 		}
 	}
 
-	if (elf_rebuild_rela_section(ip_relasec))
+	if (elf_rebuild_rela_section(file->elf, ip_relasec))
 		return -1;
 
 	return 0;
