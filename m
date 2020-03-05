Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C420801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="DLRMzf7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCEXoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:44:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37678 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:44:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id b8so70438plx.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 15:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aODloWMH+16G+jblYOYaP3wMYDm9EtGNGFqttSX2s+c=;
        b=DLRMzf7h4mpOskip4ouIPR0SHCDuIPqH5OncwsmFJzBEKqHKjlJmeE2yLIz5+a+nez
         z1CihklS33zvnR8+UsqoMQpolFyiH/grjxX2KwacBuA4ve8c3cTN43i+meX3/mUdfZur
         JwZ9Gpo/sdNhdNq4WzQ70/nSHFX2JJGGQ2oeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aODloWMH+16G+jblYOYaP3wMYDm9EtGNGFqttSX2s+c=;
        b=J5EJzcuaAYidWn75PfzPRAraL3iLAffWwfh03n5Y3I/WcMW1enQ3zD9wcfU5eUY7xs
         /VUfyK7rhiuhShdpveUPmGENtvH15AJmEOc9nl9wct41xHyA1iXspdPR+c0LNy1B3mOf
         MKpOUKQ8NV7f3YBrZU2VaEkHeXA3aBBckl7/eO1UBgqiIoRuzUUL4/Qht/J3knBpps9u
         l0uNmed1HT3Nm5jrC4cg3XkCHG59mom3oeeGgQusEEokOdJ3r2YepSqZGxx3hUHGbf3W
         +Hu7fhX9Ouvw9Aw7XGSeEv0qjjq7NpZE3kAnpykwGU2GiPOCgXUwv+cIpTk9WP0TLkNo
         uBcw==
X-Gm-Message-State: ANhLgQ3viIrAJOMTWzg26k7LGgmm516YV2aQTRpy3csFd1juKWRgN5fu
        AVBLZVA64Q0JpoVrvyV9MuAVKQ==
X-Google-Smtp-Source: ADFU+vso9fE7zT/rV4B3bXR5NWkoobXDHEh3h6d5W3kgqFGDXSuUEjPGN9nvGO5Gfot1rEhID2VWzQ==
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr224807plb.274.1583451859886;
        Thu, 05 Mar 2020 15:44:19 -0800 (PST)
Received: from ryzen.cs.washington.edu ([2607:4000:200:11:60e4:c000:39d0:c5af])
        by smtp.gmail.com with ESMTPSA id s123sm30103856pfs.21.2020.03.05.15.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 15:44:19 -0800 (PST)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Wang YanQing <udknight@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf, x32: fix bug with JMP32 JSET BPF_X checking upper bits
Date:   Thu,  5 Mar 2020 15:44:12 -0800
Message-Id: <20200305234416.31597-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current x32 BPF JIT is incorrect for JMP32 JSET BPF_X when the upper
32 bits of operand registers are non-zero in certain situations.

The problem is in the following code:

  case BPF_JMP | BPF_JSET | BPF_X:
  case BPF_JMP32 | BPF_JSET | BPF_X:
  ...

  /* and dreg_lo,sreg_lo */
  EMIT2(0x23, add_2reg(0xC0, sreg_lo, dreg_lo));
  /* and dreg_hi,sreg_hi */
  EMIT2(0x23, add_2reg(0xC0, sreg_hi, dreg_hi));
  /* or dreg_lo,dreg_hi */
  EMIT2(0x09, add_2reg(0xC0, dreg_lo, dreg_hi));

This code checks the upper bits of the operand registers regardless if
the BPF instruction is BPF_JMP32 or BPF_JMP64. Registers dreg_hi and
dreg_lo are not loaded from the stack for BPF_JMP32, however, they can
still be polluted with values from previous instructions.

The following BPF program demonstrates the bug. The jset64 instruction
loads the temporary registers and performs the jump, since ((u64)r7 &
(u64)r8) is non-zero. The jset32 should _not_ be taken, as the lower
32 bits are all zero, however, the current JIT will take the branch due
the pollution of temporary registers from the earlier jset64.

  mov64    r0, 0
  ld64     r7, 0x8000000000000000
  ld64     r8, 0x8000000000000000
  jset64   r7, r8, 1
  exit
  jset32   r7, r8, 1
  mov64    r0, 2
  exit

The expected return value of this program is 2; under the buggy x32 JIT
it returns 0. The fix is to skip using the upper 32 bits for jset32 and
compare the upper 32 bits for jset64 only.

All tests in test_bpf.ko and selftests/bpf/test_verifier continue to
pass with this change.

We found this bug using our automated verification tool, Serval.

Fixes: 69f827eb6e14 ("x32: bpf: implement jitting of JMP32")
Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 393d251798c0..4d2a7a764602 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2039,10 +2039,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			}
 			/* and dreg_lo,sreg_lo */
 			EMIT2(0x23, add_2reg(0xC0, sreg_lo, dreg_lo));
-			/* and dreg_hi,sreg_hi */
-			EMIT2(0x23, add_2reg(0xC0, sreg_hi, dreg_hi));
-			/* or dreg_lo,dreg_hi */
-			EMIT2(0x09, add_2reg(0xC0, dreg_lo, dreg_hi));
+			if (is_jmp64) {
+				/* and dreg_hi,sreg_hi */
+				EMIT2(0x23, add_2reg(0xC0, sreg_hi, dreg_hi));
+				/* or dreg_lo,dreg_hi */
+				EMIT2(0x09, add_2reg(0xC0, dreg_lo, dreg_hi));
+			}
 			goto emit_cond_jmp;
 		}
 		case BPF_JMP | BPF_JSET | BPF_K:
-- 
2.20.1

