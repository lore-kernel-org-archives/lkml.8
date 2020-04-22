Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E440AC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C124C2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551570;
	bh=ewkoBHbHJxY5CrvIeBKC0dzVMq+kGM5Cv1GG4sWq4j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2fJH3gIL1CKi/WNipKHJ35a3YpUdNhW8zDuFYSEtE+7X+TwnvWVBICOzvhBjm0/he
	 QQ1FShY76tu2TmmDlwMNd5fKOB1mYcZPFs0DvOPliFcrNSdhsKmxh7n3kxzASOHOJk
	 6HHDZ3QctS9RaXPN5qufQD80LFmSthg0XQffFzxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgDVKct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgDVKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:32:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378FC03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so1729044wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOSmb4FNbQc6x3T+mRoZC0joYWCmW+ZeBUjg4eP6aXk=;
        b=Zm9KGFN5WhiJAMGvIS/8fs+K7TIH74Egwy+ahtjhZ7hyTvZf2WPAY1ohhPkUR4bnGU
         WARVTSb60uIFdCGRa0w3NMyvGFKex9AAsfatpQkJFc3UcEf9+GRPz1n1QzKv7nlO17XX
         MDfbkz+nLt6/7tqO7tl74oA0bg/dKqZSQhtrtcwYhBAXdpgkbSleTnu5BlbFPuOa7ZoQ
         P1x+OLPCx2iwGeahB8YIdwjvvokevpQwQJfm8MI970PtLvMm6Ptm7ixkBmB3K1gTX0tA
         bIFn+duuqMpZKItsW0r507SpwNE0zY1akPctSg2uOXa1+Gx4Ucchj4XLwyPgv/11ljuy
         9GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eOSmb4FNbQc6x3T+mRoZC0joYWCmW+ZeBUjg4eP6aXk=;
        b=mEkB3iLY0F0UaxWNiWmOAfoNz44D+mp3TatmAG5KFGK/dxN5p2BzXwO1q8o0TdY2Yc
         6sjThwO3UXOH3+t5jrLG8/tqeoseA52oHEtS+gFkQVp1tO9hBd3+oTxMAaBcxpB8alyf
         mciD026ICsSLSgi/uYaLLM8aI9YWC55/4t2AvIoH0PQ1spr5gWcPmPc+aL0Jhehdw7Bq
         5fT0fdaht1RRIT+oEY7BN6z6TqPOQ4raVgfim5Q+aSqoEVNBmf8wfskVYCxuhYHOD609
         fL2KumJ7oMvKlg88Js5QL3cX/XKzqrGpCYO9X+nQEscYfynCxoxAy06iuejGiOofU0Z5
         +6aw==
X-Gm-Message-State: AGi0Pubh179VQNn/xCu3mUOU9QOWTx2vOzCKZl4dZJOmxFmYGb9u7a8E
        /vYsTPmmvQws6FKMZ9K6j/4ahcCJ
X-Google-Smtp-Source: APiQypKDt445X4MTERp9wOMYIX8ok4hBlzelZltnx8LUq0sA1j7glgEufMILI4Amg4B2foHyXUop2w==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr9568179wma.19.1587551545700;
        Wed, 22 Apr 2020 03:32:25 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s12sm6891603wmc.7.2020.04.22.03.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:32:24 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/3] objtool: Constify arch_decode_instruction()
Date:   Wed, 22 Apr 2020 12:32:05 +0200
Message-Id: <20200422103205.61900-4-mingo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422103205.61900-1-mingo@kernel.org>
References: <20200422103205.61900-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly straightforward constification, except that WARN_FUNC()
needs a writable pointer while we have read-only pointers,
so deflect this to WARN().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/arch.h            | 2 +-
 tools/objtool/arch/x86/decode.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 561c3162d177..445b8fa73ccb 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -72,7 +72,7 @@ struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
-int arch_decode_instruction(struct elf *elf, struct section *sec,
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index f0d42ad7d5ff..c45a0b4e0760 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -27,7 +27,7 @@ static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_DI, CFI_R15},
 };
 
-static int is_x86_64(struct elf *elf)
+static int is_x86_64(const struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
 	case EM_X86_64:
@@ -77,7 +77,7 @@ unsigned long arch_jump_destination(struct instruction *insn)
 	return insn->offset + insn->len + insn->immediate;
 }
 
-int arch_decode_instruction(struct elf *elf, struct section *sec,
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
@@ -98,7 +98,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	insn_get_length(&insn);
 
 	if (!insn_complete(&insn)) {
-		WARN_FUNC("can't decode instruction", sec, offset);
+		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
 
-- 
2.20.1

