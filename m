Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5410CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319132051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341181;
	bh=j2t6aAKl8zLrt0Hxrw86AzQhKEI6iRPEJt+Q45nQCAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VEHlGC9a/CUzXu2ecdfc8br7EqO5J6ObTXUdaY4Whob/o9loVmgpqpoKx2qGf7/LP
	 b6MuN4ZfRq+foFsbN5jVZKrhCkHu6DW0a6hUXWu0wQPzB1tBFvSZIe98cHhHfMn8/T
	 DNVOASysvEufirBc5H9uHEDaACsJJ/+EgkousBZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgEANxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgEANhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B42E2173E;
        Fri,  1 May 2020 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340222;
        bh=j2t6aAKl8zLrt0Hxrw86AzQhKEI6iRPEJt+Q45nQCAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqCT3LYPHJDGx3xA9//0oNCSgax8yV2SZyyKTN/gCR+of8EUTe0XVJZ5pMJmICG0g
         75y3pIASoFIbdH5Wfzp84ND7TYy6xQaXED7gzwPz+D98wp3lxLIU5pddq0lXLoI62x
         51zdV42Yv0XfotmCCdIzjnahQ8bPLfxNtIgDhnfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xi Wang <xi.wang@gmail.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 27/46] bpf, x86: Fix encoding for lower 8-bit registers in BPF_STX BPF_B
Date:   Fri,  1 May 2020 15:22:52 +0200
Message-Id: <20200501131508.182238651@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Nelson <lukenels@cs.washington.edu>

[ Upstream commit aee194b14dd2b2bde6252b3acf57d36dccfc743a ]

This patch fixes an encoding bug in emit_stx for BPF_B when the source
register is BPF_REG_FP.

The current implementation for BPF_STX BPF_B in emit_stx saves one REX
byte when the operands can be encoded using Mod-R/M alone. The lower 8
bits of registers %rax, %rbx, %rcx, and %rdx can be accessed without using
a REX prefix via %al, %bl, %cl, and %dl, respectively. Other registers,
(e.g., %rsi, %rdi, %rbp, %rsp) require a REX prefix to use their 8-bit
equivalents (%sil, %dil, %bpl, %spl).

The current code checks if the source for BPF_STX BPF_B is BPF_REG_1
or BPF_REG_2 (which map to %rdi and %rsi), in which case it emits the
required REX prefix. However, it misses the case when the source is
BPF_REG_FP (mapped to %rbp).

The result is that BPF_STX BPF_B with BPF_REG_FP as the source operand
will read from register %ch instead of the correct %bpl. This patch fixes
the problem by fixing and refactoring the check on which registers need
the extra REX byte. Since no BPF registers map to %rsp, there is no need
to handle %spl.

Fixes: 622582786c9e0 ("net: filter: x86: internal BPF JIT")
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200418232655.23870-1-luke.r.nels@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a32fc3d994076..46ab928312517 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -142,6 +142,19 @@ static bool is_ereg(u32 reg)
 			     BIT(BPF_REG_AX));
 }
 
+/*
+ * is_ereg_8l() == true if BPF register 'reg' is mapped to access x86-64
+ * lower 8-bit registers dil,sil,bpl,spl,r8b..r15b, which need extra byte
+ * of encoding. al,cl,dl,bl have simpler encoding.
+ */
+static bool is_ereg_8l(u32 reg)
+{
+	return is_ereg(reg) ||
+	    (1 << reg) & (BIT(BPF_REG_1) |
+			  BIT(BPF_REG_2) |
+			  BIT(BPF_REG_FP));
+}
+
 static bool is_axreg(u32 reg)
 {
 	return reg == BPF_REG_0;
@@ -751,9 +764,8 @@ st:			if (is_imm8(insn->off))
 			/* STX: *(u8*)(dst_reg + off) = src_reg */
 		case BPF_STX | BPF_MEM | BPF_B:
 			/* Emit 'mov byte ptr [rax + off], al' */
-			if (is_ereg(dst_reg) || is_ereg(src_reg) ||
-			    /* We have to add extra byte for x86 SIL, DIL regs */
-			    src_reg == BPF_REG_1 || src_reg == BPF_REG_2)
+			if (is_ereg(dst_reg) || is_ereg_8l(src_reg))
+				/* Add extra byte for eregs or SIL,DIL,BPL in src_reg */
 				EMIT2(add_2mod(0x40, dst_reg, src_reg), 0x88);
 			else
 				EMIT1(0x88);
-- 
2.20.1



