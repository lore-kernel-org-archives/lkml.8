Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335AC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F2D20767
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="FXIQhFby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDURQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729404AbgDURQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:16:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16179C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:16:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so2596568pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLSvbU4rb+oShXf3/xaOIk/8iC3V7cv0pXPIaRB7gas=;
        b=FXIQhFbyFxDd0yfZDoveFyAYihbUpl0AsbLQrJYGlMwBXwAiFuFrmwg33A6vQn9BxY
         0hEWwUtLK3H2dHb5eKlhTwcqQlbUJRC/m041/yaerXwlJ+oEz1DO1rViNnSaOP0nh/tm
         3iYPRWmJY3YmVlhE1BeKRDTOjICFezTU+5Ld4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JLSvbU4rb+oShXf3/xaOIk/8iC3V7cv0pXPIaRB7gas=;
        b=JdENZoS7zV2sNllaJ3RWpnfSP84r+Bow5hENXEyBc4iErjTRXzaL401mpxK/+xJDrW
         9fIMlNKMh6WT9O7qy3lEISIR7U1ZfYc1BqlCxILcMCrRyINRiGtomTmPCZ8ads2EEmCU
         L7VkqNc8Wyl+5wpxkPX8N+o9q43t7lD16CXKYsajq17SXYYFlZYJBmczkU4/P4apHKAu
         O+943CIv9WcPK2NWyR7KAWtqrb6iWSUuAP6vGIxXtSDbJhDx5Pl0pDM4ZfjUeEydhumE
         7OAtcmahur6LB3IWVeSsGMSOgzlD5ZRiHQ6YBEd77j6ws2j9QXytHNkRTOzkOFWkgKl9
         reYg==
X-Gm-Message-State: AGi0PuazxxeZDws5GLM3M96KdENmsJoSLIKT8Az5KJgb7jdiVa+kboJR
        5dm86Gg+/wC2QYCz4lzW+OC6RQ==
X-Google-Smtp-Source: APiQypJPoDAmSxZXe01yomlBdjPcOGDJGtKwAq2V7OtTrQuozGcBYLfIfUYNkfTKOSgfuq3DcKg29A==
X-Received: by 2002:a63:b23:: with SMTP id 35mr10303567pgl.170.1587489368378;
        Tue, 21 Apr 2020 10:16:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id mn1sm2911459pjb.24.2020.04.21.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:16:07 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
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
Subject: [PATCH bpf 2/2] bpf, x32: Fix clobbering of dst for BPF_JSET
Date:   Tue, 21 Apr 2020 10:15:52 -0700
Message-Id: <20200421171552.28393-2-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421171552.28393-1-luke.r.nels@gmail.com>
References: <20200421171552.28393-1-luke.r.nels@gmail.com>
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

