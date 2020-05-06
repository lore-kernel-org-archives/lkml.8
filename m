Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D775C47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA73206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="WWgQHX+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEFADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:03:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C57C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:03:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f15so244716plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Id4q2WjCYOrW61i2K14Kt2NNedsMqfC6xR/4pooTMDs=;
        b=WWgQHX+Y4p9hK1G/FEcHNTzvkaxWU0KQ8imb0c+RIKk5ZSkTMKVkHpqsV715tijoGT
         Z80hmH950M3h4QaqBw3xqEQI7fMdRBGHEKkN82NyEi9jO1C8Z9hczLrQpMZT6/QJ6stu
         UHfCqrxFw4PhETIA/3OdRRpCBlXcKXHPGGpyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Id4q2WjCYOrW61i2K14Kt2NNedsMqfC6xR/4pooTMDs=;
        b=LnilYNlvQ2tEbqMt37aoC0JQd8v3s4+3SvmmebXYronJVajbsLW83Sulue/Ray/159
         tT/2iFU79hiRh8u9u1/OCg/pYBMmVuezHYfyjFlnWX9Yp7jbgKbbbjvF02XI6asxF7Xm
         vBqVWxBg+5pr06ItGR0JNbo5USBDiLUB98xidmOkUSMqY3GzrS0j5mdqbQf59KnZW9og
         GRkDkIqPAoCz2JmrkS7ier4Z99bQoJCNyJLllZ30/PAKHN8fJm2v0AOL6zE7cRQ2LfuE
         Gt55CG9RNfXJgCEFX1eNOW1pLeOAZU23gAk7OKWrGRS4iOfUsxxAsqOLAXhmWkvUWtCq
         jMPA==
X-Gm-Message-State: AGi0PuYya6NgzbDLPX6yUpVA0DOMWg/MUn0kfdQFdWCUj6Dax+JWcX6s
        Rnp/d0t2mRQOEJKxf5C+ytD4/g==
X-Google-Smtp-Source: APiQypIGsXA7WERwt6mP7MtumZ6T6wthtsmMazY24L57aiRfQ7umVKhw5qH3l242C3V99Jnj+CTRdw==
X-Received: by 2002:a17:90b:3751:: with SMTP id ne17mr5833508pjb.114.1588723411567;
        Tue, 05 May 2020 17:03:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id u3sm133912pfn.217.2020.05.05.17.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:03:31 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf, riscv: Enable missing verifier_zext optimizations on RV64
Date:   Tue,  5 May 2020 17:03:17 -0700
Message-Id: <20200506000320.28965-2-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506000320.28965-1-luke.r.nels@gmail.com>
References: <20200506000320.28965-1-luke.r.nels@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66d0d5a854a6 ("riscv: bpf: eliminate zero extension code-gen")
added support for the verifier zero-extension optimization on RV64 and
commit 46dd3d7d287b ("bpf, riscv: Enable zext optimization for more
RV64G ALU ops") enabled it for more instruction cases.

However, BPF_LSH BPF_X and BPF_{LSH,RSH,ARSH} BPF_K are still missing
the optimization.

This patch enables the zero-extension optimization for these remaining
cases.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index d208a9fd6c52..e2636902a74e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -515,7 +515,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_LSH | BPF_X:
 	case BPF_ALU64 | BPF_LSH | BPF_X:
 		emit(is64 ? rv_sll(rd, rd, rs) : rv_sllw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_RSH | BPF_X:
@@ -692,19 +692,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_LSH | BPF_K:
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		emit(is64 ? rv_slli(rd, rd, imm) : rv_slliw(rd, rd, imm), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_RSH | BPF_K:
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		emit(is64 ? rv_srli(rd, rd, imm) : rv_srliw(rd, rd, imm), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_ARSH | BPF_K:
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
 		emit(is64 ? rv_srai(rd, rd, imm) : rv_sraiw(rd, rd, imm), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 
-- 
2.17.1

