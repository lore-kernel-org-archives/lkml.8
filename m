Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D7C2074D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r3XAOqgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCLNvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:51:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=J51PsdwUNpuG7iBUFw8d0uA//ZyjfLA2T9k/WrUFANo=; b=r3XAOqgdsyaGMYOWhYNgeixTcn
        26SIDOkTYXLEk5Kb/o7UJobk8DZSEefk6sScilFWHm38ViDhyicOv5fXsOFU4YGjE/pnKjAa2H54Y
        aUBg7913SN87rWyAXVHKaGLvLLFsJly4ji5IBRh26EMEtjCns8m7H6kGEPcfIi/cZOV8zzAbzuS5p
        V798BfAM5mKMfQkDEoATe7CvkMMyZ4lyK3TK/1rJQbZXNo1Jys49YL6qXKmxPdo+iduVR8DzL7bLZ
        xxW46eiV7yAAqHAV/ZzF99TmPWu4TljXFbfQicUSHdaeicPiSBoQavEsxMkqCyMkhOYlk4s1gyV2k
        9+p3AtDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFN-0003AT-L1; Thu, 12 Mar 2020 13:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4483B3060C3;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F15A2B92DA18; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.817117618@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 07/16] objtool: Optimize find_section_by_index()
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a linear search (over 20k entries), add an
section_hash to the elf object.

This reduces objtool on vmlinux.o from a few minutes to around 45
seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |    7 ++++++-
 tools/objtool/elf.h |    2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -38,7 +38,7 @@ static struct section *find_section_by_i
 {
 	struct section *sec;
 
-	list_for_each_entry(sec, &elf->sections, list)
+	hash_for_each_possible(elf->section_hash, sec, hash, idx)
 		if (sec->idx == idx)
 			return sec;
 
@@ -191,6 +191,8 @@ static int read_sections(struct elf *elf
 			}
 		}
 		sec->len = sec->sh.sh_size;
+
+		hash_add(elf->section_hash, &sec->hash, sec->idx);
 	}
 
 	if (stats)
@@ -430,6 +432,7 @@ struct elf *elf_read(const char *name, i
 	memset(elf, 0, sizeof(*elf));
 
 	hash_init(elf->symbol_hash);
+	hash_init(elf->section_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -570,6 +573,8 @@ struct section *elf_create_section(struc
 	shstrtab->len += strlen(name) + 1;
 	shstrtab->changed = true;
 
+	hash_add(elf->section_hash, &sec->hash, sec->idx);
+
 	return sec;
 }
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -25,6 +25,7 @@
 
 struct section {
 	struct list_head list;
+	struct hlist_node hash;
 	GElf_Shdr sh;
 	struct list_head symbol_list;
 	struct list_head rela_list;
@@ -71,6 +72,7 @@ struct elf {
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
+	DECLARE_HASHTABLE(section_hash, 16);
 };
 
 


