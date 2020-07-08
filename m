Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E018C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CB0206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222996;
	bh=77Pwbz2Ibtd3eXN44zEppeNjg+PFIjq22Z3J+DkX3Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WurO6RPfIx+ClQC3jtuiH/dBi2GpUcEcfvhSpI9gWVSGCnuMOp5al5iUJDg9Rjn0F
	 l+iZAIZ2WuO5AuRo141lNB37R0GpiLE945UM5mAae40dlXICU6A0C/1ujisS6mnDM+
	 akwwZIFxtIlv2f1iqojCVMNTS4Px3NN+n+PqYZQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgGHPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbgGHPlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFFB20720;
        Wed,  8 Jul 2020 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222912;
        bh=77Pwbz2Ibtd3eXN44zEppeNjg+PFIjq22Z3J+DkX3Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyXihRzaOB+Z5JtS/vRmkWQW/RktfAGJnDpo+pCBYmVS7e+aqx503BE7o/+CKgSSB
         gkHLHPZg4LHqByZNINHi1Q5yOWjLUXBt1MJeQJgy2/PpLLRRJU8jZGCRfYCNZ3cPbx
         forDi3An/omyBDKQhctII0hk9zHUIRMsrAHyzpzk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave P Martin <dave.martin@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 13/16] arm64/alternatives: use subsections for replacement sequences
Date:   Wed,  8 Jul 2020 11:41:32 -0400
Message-Id: <20200708154135.3199907-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154135.3199907-1-sashal@kernel.org>
References: <20200708154135.3199907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit f7b93d42945cc71e1346dd5ae07c59061d56745e ]

When building very large kernels, the logic that emits replacement
sequences for alternatives fails when relative branches are present
in the code that is emitted into the .altinstr_replacement section
and patched in at the original site and fixed up. The reason is that
the linker will insert veneers if relative branches go out of range,
and due to the relative distance of the .altinstr_replacement from
the .text section where its branch targets usually live, veneers
may be emitted at the end of the .altinstr_replacement section, with
the relative branches in the sequence pointed at the veneers instead
of the actual target.

The alternatives patching logic will attempt to fix up the branch to
point to its original target, which will be the veneer in this case,
but given that the patch site is likely to be far away as well, it
will be out of range and so patching will fail. There are other cases
where these veneers are problematic, e.g., when the target of the
branch is in .text while the patch site is in .init.text, in which
case putting the replacement sequence inside .text may not help either.

So let's use subsections to emit the replacement code as closely as
possible to the patch site, to ensure that veneers are only likely to
be emitted if they are required at the patch site as well, in which
case they will be in range for the replacement sequence both before
and after it is transported to the patch site.

This will prevent alternative sequences in non-init code from being
released from memory after boot, but this is tolerable given that the
entire section is only 512 KB on an allyesconfig build (which weighs in
at 500+ MB for the entire Image). Also, note that modules today carry
the replacement sequences in non-init sections as well, and any of
those that target init code will be emitted into init sections after
this change.

This fixes an early crash when booting an allyesconfig kernel on a
system where any of the alternatives sequences containing relative
branches are activated at boot (e.g., ARM64_HAS_PAN on TX2)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Dave P Martin <dave.martin@arm.com>
Link: https://lore.kernel.org/r/20200630081921.13443-1-ardb@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/alternative.h | 16 ++++++++--------
 arch/arm64/kernel/vmlinux.lds.S      |  3 ---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 5e5dc05d63a06..12f0eb56a1cc3 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -73,11 +73,11 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	".pushsection .altinstructions,\"a\"\n"				\
 	ALTINSTR_ENTRY(feature)						\
 	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"a\"\n"			\
+	".subsection 1\n"						\
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
-	".popsection\n\t"						\
+	".previous\n\t"							\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
 	".org	. - (662b-661b) + (664b-663b)\n"			\
 	".endif\n"
@@ -117,9 +117,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 662:	.pushsection .altinstructions, "a"
 	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
 	.popsection
-	.pushsection .altinstr_replacement, "ax"
+	.subsection 1
 663:	\insn2
-664:	.popsection
+664:	.previous
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
 	.endif
@@ -160,7 +160,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.pushsection .altinstructions, "a"
 	altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
 	.popsection
-	.pushsection .altinstr_replacement, "ax"
+	.subsection 1
 	.align 2	/* So GAS knows label 661 is suitably aligned */
 661:
 .endm
@@ -179,9 +179,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 .macro alternative_else
 662:
 	.if .Lasm_alt_mode==0
-	.pushsection .altinstr_replacement, "ax"
+	.subsection 1
 	.else
-	.popsection
+	.previous
 	.endif
 663:
 .endm
@@ -192,7 +192,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 .macro alternative_endif
 664:
 	.if .Lasm_alt_mode==0
-	.popsection
+	.previous
 	.endif
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1af25dbc57ea..8d0374ffdd2d6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -172,9 +172,6 @@ SECTIONS
 		*(.altinstructions)
 		__alt_instructions_end = .;
 	}
-	.altinstr_replacement : {
-		*(.altinstr_replacement)
-	}
 
 	. = ALIGN(PAGE_SIZE);
 	__inittext_end = .;
-- 
2.25.1

