Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78728C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8FB216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LMNWM7Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgEAUbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgEAUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F1BC08E934
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wjlQuu5IaKf/RJGmJMEw5KWBV/kPvPOZCeA7wx4rUZs=; b=LMNWM7Y6J4zJyHQTBJvU6Yks9w
        qQ8qy3j1Uqo9BnIVEKOLn18MZDXMR6LQzdGWvNINVet6tKm9biEu+/XL8fa95qCIATGwNUQRquvAc
        tMuweeYuFug/zeHbPZ40uyjb8pTScy1EBFgLRQpRqR4mTBK1cuGYBAoLmQCYLXp2wVbOHOsOhp6Qg
        3ceFfhg5Nf/bGzq0tvbE4tmTz6YjwPwREV3ui+8Xk49tlgxy1yTjogIN1VH1m2QP09DUF2OHQSBBP
        HgktyBqbo8tDSMNLebVex6ddiKlnLMM44hopLJ36Uwh3yVd6VGxRoY02068nK4zcpnIyojSHAj9bW
        +vzLHtbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJP-0002lt-81; Fri, 01 May 2020 20:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A14F8307623;
        Fri,  1 May 2020 22:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 14C2629BF626C; Fri,  1 May 2020 22:31:01 +0200 (CEST)
Message-Id: <20200501202944.820414787@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:29:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 18/18] objtool: Clean up elf_write() condition
References: <20200501202849.647891881@infradead.org>
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
 tools/objtool/check.c |    2 +-
 tools/objtool/elf.c   |    8 +++++++-
 tools/objtool/elf.h   |    3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2904,7 +2904,7 @@ int check(const char *_objname, bool orc
 			goto out;
 	}
 
-	if (orc || !list_empty(&file.static_call_list)) {
+	if (file.elf->changed) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -703,6 +703,8 @@ struct section *elf_create_section(struc
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
+	elf->changed = true;
+
 	return sec;
 }
 
@@ -769,7 +771,7 @@ int elf_rebuild_rela_section(struct sect
 	return 0;
 }
 
-int elf_write(const struct elf *elf)
+int elf_write(struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
@@ -786,6 +788,8 @@ int elf_write(const struct elf *elf)
 				WARN_ELF("gelf_update_shdr");
 				return -1;
 			}
+
+			sec->changed = false;
 		}
 	}
 
@@ -798,6 +802,8 @@ int elf_write(const struct elf *elf)
 		return -1;
 	}
 
+	elf->changed = false;
+
 	return 0;
 }
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -77,6 +77,7 @@ struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
+	bool changed;
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
@@ -118,7 +119,7 @@ struct elf *elf_open_read(const char *na
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 void elf_add_rela(struct elf *elf, struct rela *rela);
-int elf_write(const struct elf *elf);
+int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
 struct section *find_section_by_name(const struct elf *elf, const char *name);


