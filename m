Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4881C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884B6206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEL8vD79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGLXLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:11:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:11:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so12438604wrs.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOnODFdxaf/iGRsoCulw/4z2XvDjjoLo9EZO9SOI1jQ=;
        b=kEL8vD79CZQ/XW95I8TiZ0Q8UtW05SD5TfoBnxWex2+5lGWpVB5J0Uik+Vjq5uBcrU
         472HIWiUhpjQVT+jVp0OxjLBotfLCYDB93KT4uFOaGlQ9hmsFiguPeEJjP4EfS9mMEhz
         T7ET/nXG4Y5etjeGTCQ0/CFUgm4E/DhjwJrkWpFWroeWOcRyiA5P2jFvZ7YbDHL0P3K+
         CpDO2CJJAjfql3w8Hc1sqUZs2acOK5YuFP9Kaa4/9EEzzTBT5OnquMtPdXxsd5+aJcPG
         59ZeSaETFpskptgN4yj+dy5gvKvDYt6nRLIlGZBqewrMrUcHu2IM74r5egKIvB/Cvq2R
         A4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOnODFdxaf/iGRsoCulw/4z2XvDjjoLo9EZO9SOI1jQ=;
        b=CEmFUtkMiowHzVPDhHt9HjOf+LxeZ7TOLPjfz9yESQipdfwN8pcRKbIQC2oVUZZGwi
         BtwjMYQkt7nW8kmmFJtdGnl5mZeoPzkU5IoTsj2WggjeN1LyhQw0evMwavdWuuTluCkk
         0xP0avBADWBzeeClq03cpjK8+K9vtDn62JnN1XulrgYBPNSJMcgM9jU1H2Pmtc5wvmEE
         am50qQJruU6NKsgf71fD0Ns2tKs5LQ53Z00KhFpLPfizDcwCl09uFKYFp9PF75zIYCOu
         bl18Ra19ChhEkJBLKgFD0tvSRPvItGl5rdpLLu6N8MWBzZZRnOnWGOKgLVN3hT8uYHUU
         MCtA==
X-Gm-Message-State: AOAM531k4frTGunM9yt4KMX4EW/NfH552I2ZjPj/RvCTtHHMQi7yKXY0
        NxJIBw6w9IDlF/6xoVqe/SU=
X-Google-Smtp-Source: ABdhPJzSYcWA/jMunUf5Itgr9tjo+KWGYssE4BRW8qieq8s5zZe6mVa3y5MkUfVsjgsmBwFvyzweZA==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr76096451wrr.259.1594595478907;
        Sun, 12 Jul 2020 16:11:18 -0700 (PDT)
Received: from localhost.localdomain ([46.114.106.47])
        by smtp.gmail.com with ESMTPSA id f9sm21238786wru.47.2020.07.12.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 16:11:18 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
Date:   Mon, 13 Jul 2020 01:10:50 +0200
Message-Id: <20200712231050.5147-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a fix.

With Jian's fix applied another issue raised up when CONFIG_HYPERV=m.

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

Cc: Jian Cai <caij2003@gmail.com>
Cc: clang-built-linux@googlegroups.com
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
Link: https://github.com/ClangBuiltLinux/linux/issues/1043
Link: https://github.com/ClangBuiltLinux/linux/issues/1088
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/include/asm/idtentry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 513eb2ccbdbf..a811f6c6cf15 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -624,8 +624,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
 #endif
 
 #if IS_ENABLED(CONFIG_ACRN_GUEST)
-- 
2.27.0

