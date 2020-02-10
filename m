Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACE9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ACD20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339765;
	bh=m+U00sw7e0xmBxIhKSkjHZxP8XgULJD6o0SKO1wayGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ax8+1V/eY8G2nu23Ovx6M51lYB082nvnScEysDgtT+f7WlauTHfvWBPmVz8mveuG2
	 YMG+1KYdCh9446L1hSf0YOXJugy6GGGUXBSwLXaNwPbs37CpEISnUVVSEnfsZIcsb1
	 NYD8Jz5T4LmnxF/15gRO/Nz4qf5sWRmiFtz9oEOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgBJNCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgBJMkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:31 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3852C208C4;
        Mon, 10 Feb 2020 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338431;
        bh=m+U00sw7e0xmBxIhKSkjHZxP8XgULJD6o0SKO1wayGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3SmhTtIrhaBpVnzr2KK9b6Cc64Nq71uv87HPb3LTcx0aMmGpCc4leML9Xl0hfgZY
         wPlmnmkxM7337q+DiwIFfAgLi8y1T1vPbba4lZZgfJqCxgux0GQu90eGthRI6eH/+u
         m4fbSNpdF3pBWOz6o9kryQdnJMf5KV2fLETWzx+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.5 157/367] riscv, bpf: Fix broken BPF tail calls
Date:   Mon, 10 Feb 2020 04:31:10 -0800
Message-Id: <20200210122439.322516249@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@gmail.com>

commit f1003b787c00fbaa4b11619c6b23a885bfce8f07 upstream.

The BPF JIT incorrectly clobbered the a0 register, and did not flag
usage of s5 register when BPF stack was being used.

Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20191216091343.23260-2-bjorn.topel@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/net/bpf_jit_comp.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/riscv/net/bpf_jit_comp.c
+++ b/arch/riscv/net/bpf_jit_comp.c
@@ -120,6 +120,11 @@ static bool seen_reg(int reg, struct rv_
 	return false;
 }
 
+static void mark_fp(struct rv_jit_context *ctx)
+{
+	__set_bit(RV_CTX_F_SEEN_S5, &ctx->flags);
+}
+
 static void mark_call(struct rv_jit_context *ctx)
 {
 	__set_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
@@ -596,7 +601,8 @@ static void __build_epilogue(u8 reg, str
 
 	emit(rv_addi(RV_REG_SP, RV_REG_SP, stack_adjust), ctx);
 	/* Set return value. */
-	emit(rv_addi(RV_REG_A0, RV_REG_A5, 0), ctx);
+	if (reg == RV_REG_RA)
+		emit(rv_addi(RV_REG_A0, RV_REG_A5, 0), ctx);
 	emit(rv_jalr(RV_REG_ZERO, reg, 0), ctx);
 }
 
@@ -1426,6 +1432,10 @@ static void build_prologue(struct rv_jit
 {
 	int stack_adjust = 0, store_offset, bpf_stack_adjust;
 
+	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
+	if (bpf_stack_adjust)
+		mark_fp(ctx);
+
 	if (seen_reg(RV_REG_RA, ctx))
 		stack_adjust += 8;
 	stack_adjust += 8; /* RV_REG_FP */
@@ -1443,7 +1453,6 @@ static void build_prologue(struct rv_jit
 		stack_adjust += 8;
 
 	stack_adjust = round_up(stack_adjust, 16);
-	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
 	stack_adjust += bpf_stack_adjust;
 
 	store_offset = stack_adjust - 8;


