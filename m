Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9620773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWYpjjP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgFROvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731167AbgFROvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:51:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90965C0613F0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cPNi5GydH9kAjx5H9Cs/6JIq+NUbUxCaD6AbMZp0vgY=; b=HWYpjjP/gT2tvD2OpPPfSp0Q0X
        XBxR0a12KnKFXJI/vb0pFg3RfHoXCYhKme9RxnYCsCIWnTOpikNJJFPLRJWLq8RbDKv94KOVDSul2
        9MXH/he+SZ9hnxogZeULZHDThjm1m0jCjjDV8HN0jTEhULeMFjFd22I2LllFlk1lwayXJgo4M7jZG
        LNHzS1z/mITNI3YOHvyOLwzpEhZysOVIsdvC7Pho8GyoejNLQj7EaK97EQEFjbS1NmDepey7u4j7G
        xOiE3v1WkdHulR3bhhNvY5XkjXq4f3fxj9i1jRM9S/hsKcwuTyIlv1fPx2wPdvD3G9UJp8epGKgZg
        CKijc9KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvsB-0006Ho-Fi; Thu, 18 Jun 2020 14:50:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68DB730791C;
        Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2DFEB2146C402; Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Message-ID: <20200618144801.877896100@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 16:44:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [PATCH 5/7] objtool: Clean up elf_write() condition
References: <20200618144407.520952071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With there being multiple ways to change the ELF data, let's more
concisely track modification.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c   |    4 +++-
 tools/objtool/elf.c     |   13 +++++++++++--
 tools/objtool/elf.h     |    5 +++--
 tools/objtool/orc_gen.c |    2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2740,7 +2740,7 @@ int check(const char *_objname, bool orc
 
 	objname = _objname;
 
-	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open_read(objname, O_RDWR);
 	if (!file.elf)
 		return 1;
 
@@ -2801,7 +2801,9 @@ int check(const char *_objname, bool orc
 		ret = create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
+	}
 
+	if (file.elf->changed) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -747,6 +747,8 @@ struct section *elf_create_section(struc
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
+	elf->changed = true;
+
 	return sec;
 }
 
@@ -880,11 +882,14 @@ static int elf_rebuild_rela_reloc_sectio
 	return 0;
 }
 
-int elf_rebuild_reloc_section(struct section *sec)
+int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 {
 	struct reloc *reloc;
 	int nr;
 
+	sec->changed = true;
+	elf->changed = true;
+
 	nr = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list)
 		nr++;
@@ -896,7 +901,7 @@ int elf_rebuild_reloc_section(struct sec
 	}
 }
 
-int elf_write(const struct elf *elf)
+int elf_write(struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
@@ -913,6 +918,8 @@ int elf_write(const struct elf *elf)
 				WARN_ELF("gelf_update_shdr");
 				return -1;
 			}
+
+			sec->changed = false;
 		}
 	}
 
@@ -925,6 +932,8 @@ int elf_write(const struct elf *elf)
 		return -1;
 	}
 
+	elf->changed = false;
+
 	return 0;
 }
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -79,6 +79,7 @@ struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
+	bool changed;
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
@@ -121,7 +122,7 @@ struct elf *elf_open_read(const char *na
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 void elf_add_reloc(struct elf *elf, struct reloc *reloc);
-int elf_write(const struct elf *elf);
+int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
 struct section *find_section_by_name(const struct elf *elf, const char *name);
@@ -133,7 +134,7 @@ struct reloc *find_reloc_by_dest(const s
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-int elf_rebuild_reloc_section(struct section *sec);
+int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -222,7 +222,7 @@ int create_orc_sections(struct objtool_f
 		}
 	}
 
-	if (elf_rebuild_reloc_section(ip_relocsec))
+	if (elf_rebuild_reloc_section(file->elf, ip_relocsec))
 		return -1;
 
 	return 0;


