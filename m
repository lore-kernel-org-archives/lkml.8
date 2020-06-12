Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F471C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F9B206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPjUOGaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgFLOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:37:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23439C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kakeDoR/GGglcn+BZp0dW1O4+OSB36QYcD/P0d2uCAM=; b=gPjUOGaWaNUZjaMfyu5tQPbDrp
        BCMoPSbTmxp2VokC0UQH2VUHVdbHzOUU6B9nilynt/XCQs4ZcS0IleYfVZKNID9a6f20pAABf4LR6
        g7uswkyAXHxmV8KmZlphdC2+q5/6vt8ZEeeS1DrvIs28bHyyHvflfyLT2ApR1Uvitr4bHmwHalQq5
        1jAQYlnIa6AZqaGRpqA10hzOzUZL91StZ9bYOJSF398Gta14oRRZym8CL8Ioab+1fX5L+UHAjym3+
        Ob+nH5gK5f2OR4wjBoddCSMPURB3aMzkJvth0XMQn1WbmuHG4EbyVE6Ne4OvdZ2eaIeVnsPUZ2Bts
        UfIGGClw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjkoI-0006ud-6S; Fri, 12 Jun 2020 14:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1D313003E4;
        Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C3D3C209C23B8; Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Message-ID: <20200612143553.953897818@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Jun 2020 16:30:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [RFC][PATCH 1/3] objtool: Clean up elf_write() condition
References: <20200612143034.933422660@infradead.org>
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
 tools/objtool/check.c |    2 ++
 tools/objtool/elf.c   |    8 +++++++-
 tools/objtool/elf.h   |    3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2779,7 +2779,9 @@ int check(const char *_objname, bool orc
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
@@ -746,6 +746,8 @@ struct section *elf_create_section(struc
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
+	elf->changed = true;
+
 	return sec;
 }
 
@@ -862,7 +864,7 @@ int elf_rebuild_reloc_section(struct sec
 	return elf_rebuild_rela_section(sec, nr);
 }
 
-int elf_write(const struct elf *elf)
+int elf_write(struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
@@ -879,6 +881,8 @@ int elf_write(const struct elf *elf)
 				WARN_ELF("gelf_update_shdr");
 				return -1;
 			}
+
+			sec->changed = false;
 		}
 	}
 
@@ -891,6 +895,8 @@ int elf_write(const struct elf *elf)
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


