Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1DDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C259320801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="Gjc6mRDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCEXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:44:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:44:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id y21so164598pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 15:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CXMX6fYDwGAYuQgw3gIIoEsDSy+htyQIvrI+wvb2+8=;
        b=Gjc6mRDcST67ch0F2d8snDJxaX0MY/pG5uwlIGr31+nbXp8S0uE3YwChQ1qHzuQLxL
         P6vxhKDB5gDhglRfvnEYHG0bCTQo2prlA1AIn/BGmKqFUo8ZR4Pibv0u9NO8/pFdRN8J
         d5CvL4rE2OsCeveuUbpV8Ki2YiPQsBHoatL1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CXMX6fYDwGAYuQgw3gIIoEsDSy+htyQIvrI+wvb2+8=;
        b=gxBUjQRxZOazbFAmQeF1vXvTPB6AoX0JpTy2kmpPQmR+ZE3aoqPVlRPudn9XVX6wLz
         zxgHn3hUvadJhhAasK3C919r49O67/xLKK5r0byeRr9hOG6pj93U3U4vLDQQRS5KmESo
         dfNAyL8lsaVAzg8NSv3R9J1hAVKrmGN9QdneEJhKrIJYfT5ZOveaJBJoD0ZhmWAljx9M
         +JOQsuinG8WTgQw8aIbtOguAD0q+DSvJ9qb+p6iDjkZuqzAjvX3IiSnaNBfQorbQiqro
         m0m2C33e/IztcPWPSPgYh2CMiyZVldZgs80AZOUP9lAHeN3PM6neeWpiZZLIGNM1ZP+l
         8qDg==
X-Gm-Message-State: ANhLgQ0vFJQOqxgeq23Ow3KTk9FRzD9wM1knDa+qGbD+IDgGveHX4j6V
        /VWtzu0GUyszdDZbISMfcyrchQ==
X-Google-Smtp-Source: ADFU+vtF3P2k33NweA6Fex6hDs6vqelTVn0FS2/nOnTCDUSCKFMa3p1xx2Dagpz3OcKZWwoRk2B67Q==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr546605pgm.249.1583451864784;
        Thu, 05 Mar 2020 15:44:24 -0800 (PST)
Received: from ryzen.cs.washington.edu ([2607:4000:200:11:60e4:c000:39d0:c5af])
        by smtp.gmail.com with ESMTPSA id s123sm30103856pfs.21.2020.03.05.15.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 15:44:24 -0800 (PST)
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
Subject: [PATCH bpf 2/2] selftests: bpf: add test for JMP32 JSET BPF_X with upper bits set
Date:   Thu,  5 Mar 2020 15:44:13 -0800
Message-Id: <20200305234416.31597-2-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305234416.31597-1-luke.r.nels@gmail.com>
References: <20200305234416.31597-1-luke.r.nels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing tests attempt to check that JMP32 JSET ignores the upper
bits in the operand registers. However, the tests missed one such bug in
the x32 JIT that is only uncovered when a previous instruction pollutes
the upper 32 bits of the registers.

This patch adds a new test case that catches the bug by first executing
a 64-bit JSET to pollute the upper 32-bits of the temporary registers,
followed by a 32-bit JSET which should ignore the upper 32 bits.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 tools/testing/selftests/bpf/verifier/jmp32.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index bf0322eb5346..bd5cae4a7f73 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -61,6 +61,21 @@
 	},
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"jset32: ignores upper bits",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_LD_IMM64(BPF_REG_7, 0x8000000000000000),
+	BPF_LD_IMM64(BPF_REG_8, 0x8000000000000000),
+	BPF_JMP_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+	BPF_EXIT_INSN(),
+	BPF_JMP32_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 2,
+},
 {
 	"jset32: min/max deduction",
 	.insns = {
-- 
2.20.1

