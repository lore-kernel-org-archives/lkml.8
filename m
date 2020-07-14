Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845462084C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slP0ybNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGNLL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:11:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:11:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so20848789wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8L83i4HihMypZF1wnFq/6H4pb0OI6PUTC8JUPd7zbM=;
        b=slP0ybNptJTzqZ9taPgBUEUsOOX2CAg0rSWNF2aKNWfmbuGESlQYLtaJSODv5FJXDH
         JmoGxLDkRTqYlTO+yEk6dI+3AFmsqzxjYJ3DCplQGZfEj4kIEgxsPdzZzH61LU1XdGHW
         VtzhMEqzvPROaQc5F5DYfC1I9azQoYLxACJgtoXX6IAWila8Va+h+p4g7fL4zXj+KxMT
         N1+Jm0UdwPOFW2GinjCwuRGLIbMk3rmCjh1Hgr0VBBuGrvgQ0bnvRjl+FELlqmGUc8+V
         /kb6VlGpQBlLqn9eKaGfUNeFCIPneUoOt/BcZFOQO1BUI0q2AowiHrXTMbCB+pCiZ9tw
         ltjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8L83i4HihMypZF1wnFq/6H4pb0OI6PUTC8JUPd7zbM=;
        b=YL7Ppv1KIU4Otl5jAcDmYRVShphYAtbXPcQcdVv1bTJ9zezwjioLV/nYSAFqSu4k6G
         JW/G0pDoEaTIs44SyXD7oe5yRcrwPjOPbIaxh6x0k0InkH6SMMKe4oygCNe3KEiJVtGI
         DZMWFT4E1UdpG5mrpP7uPwOs8PkgU7ftB0NvA+s++S3YpxPmYOj4BI7O8Irsuk2sQrev
         kAEIDaQYtK9Doa5nMwLuNWx+NemhXymUxUtD4DD/FiLJZsCj+OShIlyckdEmTuS/Py/H
         94dJAJI07V5+vxcmTMcRZG/4f+1VvSnIBaOQCdfCAqsypSbRHVQH80xKzbUvizSGqLoJ
         81YA==
X-Gm-Message-State: AOAM530keeAl5rEReM4jSIIKvY9bl5rADTcCgru6qP7d8ZpRr4gYGcS/
        nwm+T95fy6PTwYPaiCqutmtpySUKHuUfQA==
X-Google-Smtp-Source: ABdhPJwTjENx9AKgb1naSaHyy/7vqh8Lx3x8X4zSu7jymEOk8MGtDIDGoo3rrPFxqVPaqQUx6k7ZCA==
X-Received: by 2002:adf:e701:: with SMTP id c1mr4688637wrm.350.1594725085278;
        Tue, 14 Jul 2020 04:11:25 -0700 (PDT)
Received: from localhost.localdomain ([46.114.111.105])
        by smtp.gmail.com with ESMTPSA id 69sm4131068wma.16.2020.07.14.04.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:11:24 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
Date:   Tue, 14 Jul 2020 13:11:03 +0200
Message-Id: <20200714111103.14591-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a patch.

With Jian's patch applied another issue raised up when CONFIG_HYPERV=m.

It turned out that the conversion of vectors to IDTENTRY_SYSVEC in
case of CONFIG_HYPERV was incomplete and fails with a build error:

<instantiation>:9:6: error: expected absolute expression
 .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
     ^
<instantiation>:1:1: note: while in macro instantiation
idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
^
./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
^
<instantiation>:9:6: error: expected absolute expression
 .if HYPERVISOR_STIMER0_VECTOR == 3
     ^
<instantiation>:1:1: note: while in macro instantiation
idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
^
./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;

I and Nathan double-checked the hyperv(isor) vectors:

$ rg --no-heading "HYPERVISOR_REENLIGHTENMENT_VECTOR|HYPERVISOR_STIMER0_VECTOR"
$ rg --no-heading "HYPERV_REENLIGHTENMENT_VECTOR|HYPERV_STIMER0_VECTOR"

Fix these typos in arch/x86/include/asm/idtentry.h:

HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR

For more details see CBL issue #1088.

With both fixes applied I was able to build/assemble with a snapshot
version of LLVM/Clang from Debian/experimental.

NOTE: My patch is independent from Jian's patch and should be applied separately.

Cc: Jian Cai <caij2003@gmail.com>
Cc: clang-built-linux@googlegroups.com
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
Link: https://github.com/ClangBuiltLinux/linux/issues/1043
Link: https://lore.kernel.org/patchwork/patch/1272115/
Link: https://github.com/ClangBuiltLinux/linux/issues/1088
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
Changes v1->v2:
- Add Wei Liu's Reviewed-by
- Add note to clarify my patch is independent from Jian's patch
- Add link to latest version of Jian's patch

 arch/x86/include/asm/idtentry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index eeac6dc2adaa..d79541bfc36f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -626,8 +626,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
 #endif
 
 #if IS_ENABLED(CONFIG_ACRN_GUEST)
-- 
2.28.0.rc0

