Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E6C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5552073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="NBfIrE2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDVRg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbgDVRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:36:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2CC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:36:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n24so1201691plp.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=upttJD2FlVOwQ9TcHJ5acrg3a8ThasRlmqF+H/glYss=;
        b=NBfIrE2NjATpSGVDPNE+eakCKhcK491SMXS/kR2TKZL8ND/4YKdgiho0fYch+YM0x3
         XKtxnoC3m7J4rsHW0IJSKDqWhhsUHzLRXNRQ+dXmwE7HM4hPbnbD9SG3pq+bonaFUv1N
         OZsmFi2XvW6HsoLuZg3mj5gSfzRVJyzs3/4LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=upttJD2FlVOwQ9TcHJ5acrg3a8ThasRlmqF+H/glYss=;
        b=IDGI5Ol8kN0XA2HbGi2wBj2flG2+kzAaBRVQVtf/MSGO8FIKIFsze6skNib5/IYwzN
         LsakAd20AijjnmhCGBg+qNXCKEZVYx1GozrlFaxVXdOnHb8cPRsNrBgK3rb91IwBqlkA
         EhcP0GPZbKOqzAJWGf4weqG1FGq6vomP1EiRqExCgHQs6hBXrJyaTEBQefvBD4Stl32n
         yPTu5e5IEDIOjSpCEcY8UYJkrOiLzDKMtm3E6QwWibIE/EW7b9DO/DzwTi7JVFKPT2jC
         2qGdWzQS9STDPmGxYjMOtSGVk4oMMcWdluxACmZS3dtHBy9kgM87TbwWdqNkQ/wxZGXY
         X/xA==
X-Gm-Message-State: AGi0PuZKYGUg3aA+QUy1vKqRTnlEDAaQKdC5ProK+sQ/rJb4XxehI+0Q
        mwPphL9X1IojMJI2jfOwgcdMqQ==
X-Google-Smtp-Source: APiQypLCQlRsvYOCNibbXTv7c6Hr1Yx/DPiTsvnw69F/7aVpdz8tsAYZaMLNIKgW3A4iiDXLYk8n6Q==
X-Received: by 2002:a17:90a:b10f:: with SMTP id z15mr11890687pjq.188.1587577013353;
        Wed, 22 Apr 2020 10:36:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id 1sm59514pff.151.2020.04.22.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:36:52 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Brian Gerst <brgerst@gmail.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Wang YanQing <udknight@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf, x86_32: Fix clobbering of dst for BPF_JSET
Date:   Wed, 22 Apr 2020 10:36:30 -0700
Message-Id: <20200422173630.8351-2-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422173630.8351-1-luke.r.nels@gmail.com>
References: <20200422173630.8351-1-luke.r.nels@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current JIT clobbers the destination register for BPF_JSET BPF_X
and BPF_K by using "and" and "or" instructions. This is fine when the
destination register is a temporary loaded from a register stored on
the stack but not otherwise.

This patch fixes the problem (for both BPF_K and BPF_X) by always loading
the destination register into temporaries since BPF_JSET should not
modify the destination register.

This bug may not be currently triggerable as BPF_REG_AX is the only
register not stored on the stack and the verifier uses it in a limited
way.

Fixes: 03f5781be2c7b ("bpf, x86_32: add eBPF JIT compiler for ia32")
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
v1 -> v2: No changes.
---
 arch/x86/net/bpf_jit_comp32.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index cc9ad3892ea6..ba7d9ccfc662 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2015,8 +2015,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X: {
 			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
-			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
-			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
+			u8 dreg_lo = IA32_EAX;
+			u8 dreg_hi = IA32_EDX;
 			u8 sreg_lo = sstk ? IA32_ECX : src_lo;
 			u8 sreg_hi = sstk ? IA32_EBX : src_hi;
 
@@ -2028,6 +2028,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					      add_2reg(0x40, IA32_EBP,
 						       IA32_EDX),
 					      STACK_VAR(dst_hi));
+			} else {
+				/* mov dreg_lo,dst_lo */
+				EMIT2(0x89, add_2reg(0xC0, dreg_lo, dst_lo));
+				if (is_jmp64)
+					/* mov dreg_hi,dst_hi */
+					EMIT2(0x89,
+					      add_2reg(0xC0, dreg_hi, dst_hi));
 			}
 
 			if (sstk) {
@@ -2052,8 +2059,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K: {
 			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
-			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
-			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
+			u8 dreg_lo = IA32_EAX;
+			u8 dreg_hi = IA32_EDX;
 			u8 sreg_lo = IA32_ECX;
 			u8 sreg_hi = IA32_EBX;
 			u32 hi;
@@ -2066,6 +2073,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					      add_2reg(0x40, IA32_EBP,
 						       IA32_EDX),
 					      STACK_VAR(dst_hi));
+			} else {
+				/* mov dreg_lo,dst_lo */
+				EMIT2(0x89, add_2reg(0xC0, dreg_lo, dst_lo));
+				if (is_jmp64)
+					/* mov dreg_hi,dst_hi */
+					EMIT2(0x89,
+					      add_2reg(0xC0, dreg_hi, dst_hi));
 			}
 
 			/* mov ecx,imm32 */
-- 
2.17.1

