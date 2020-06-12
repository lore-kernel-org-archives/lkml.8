Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4389C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717CD206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zqy3GTt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFLOiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:38:08 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB1C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=l+xbgdcfE1SSxQ3zHr1yPabOzpbvtiXlQZDA6pZzvco=; b=zqy3GTt5a9A1vSfatyBluqE+A9
        KwCTh3tKztu71v1FEAdM0LlpdjZGzbWfLAVAfegOajiHeE4YsSVHfbb+8yT1W6FqwcgW5YIR2A7zg
        YR0rs88zUC6bpT7zYLTkgYDigj0jLmMj9WNJDzNOiyMugECUWEi639NP8Da6W307RILMUuWDycHyA
        TOvCawCIFqKVT9mqPnmYXsj9jPVmhv1yqhI116qBiE+jGlaDy4ODRpxyh0mhnqLbuukAvV/SgOUqU
        UMNC7IbDSY74mNE6EsADNHPEir4ZlppEgXosb1wwII35ukM9t1q6vTedaNYHvCnoXzY25swZSt9kG
        bdfliU1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjkoI-0005Or-Lv; Fri, 12 Jun 2020 14:37:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2E34300F28;
        Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C5E352389EB9F; Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Message-ID: <20200612143554.012293047@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Jun 2020 16:30:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [RFC][PATCH 2/3] objtool: Provide elf_write_{insn,reloc}()
References: <20200612143034.933422660@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides infrastructure to rewrite instructions; this is
immediately useful for helping out with KCOV-vs-noinstr, but will
also come in handy for a bunch of variable sized jump-label patches
that are still on ice.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/elf.h |    7 ++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -562,8 +562,9 @@ static int read_relocs(struct elf *elf)
 					return -1;
 			}
 
-			reloc->sym = find_symbol_by_index(elf, symndx);
 			reloc->sec = sec;
+			reloc->idx = i;
+			reloc->sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
 				WARN("can't find reloc entry symbol %d for %s",
 				     symndx, sec->name);
@@ -848,6 +849,55 @@ static int elf_rebuild_rela_section(stru
 
 	return 0;
 }
+
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn)
+{
+	Elf_Data *data = sec->data;
+
+	if (data->d_type != ELF_T_BYTE || data->d_off) {
+		WARN("write to unexpected data for section: %s", sec->name);
+		return -1;
+	}
+
+	memcpy(data->d_buf + offset, insn, len);
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+
+	sec->changed = true;
+	elf->changed = true;
+
+	return 0;
+}
+
+int elf_write_reloc(struct elf *elf, struct reloc *reloc)
+{
+	struct section *sec = reloc->sec;
+
+	if (sec->sh.sh_type == SHT_REL) {
+		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rel.r_offset = reloc->offset;
+
+		if (!gelf_update_rel(sec->data, reloc->idx, &reloc->rel)) {
+			WARN_ELF("gelf_update_rel");
+			return -1;
+		}
+	} else {
+		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rela.r_addend = reloc->addend;
+		reloc->rela.r_offset = reloc->offset;
+
+		if (!gelf_update_rela(sec->data, reloc->idx, &reloc->rela)) {
+			WARN_ELF("gelf_update_rela");
+			return -1;
+		}
+	}
+
+	sec->changed = true;
+	elf->changed = true;
+
+	return 0;
+}
 
 int elf_rebuild_reloc_section(struct section *sec)
 {
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -67,9 +67,10 @@ struct reloc {
 	};
 	struct section *sec;
 	struct symbol *sym;
-	unsigned int type;
 	unsigned long offset;
+	unsigned int type;
 	int addend;
+	int idx;
 	bool jump_table_start;
 };
 
@@ -122,6 +123,10 @@ struct elf *elf_open_read(const char *na
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 void elf_add_reloc(struct elf *elf, struct reloc *reloc);
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn);
+int elf_write_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 


