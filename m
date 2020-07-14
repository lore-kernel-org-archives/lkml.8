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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FCF22B37
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTrLEfAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgGNTsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgGNTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:48:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CA7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:48:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so24405844wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PdXksB6ym5DNUu14zeftWHgAGlRIBugL+8piZPGBmMg=;
        b=PTrLEfAE7TVq3S8Cv/1SSyBojskjncxTEkp1gbOr8rTNuBEEEjAolrEioRSwuqvjUu
         IXHMZ7RLHRzo0Nwde8HRncLslHVJe9dpMf44DgMiNzV/Ce4YVnrgAeDy1WwyYRjVzt4q
         Calh8F5kU/zO1+A4y0LnKUfs5dVAP/UYXPZGAuec8/fsc+XtR2/JwQazsVwRS5fy6Ftv
         vtrG080ps2yjvdjB/mxBLlO3H9n9YxQDxHGhInSfHWNuVw35yItQy2dUufYwpXEGLSic
         79RKuAOMCtjCoa2z2TNYNVFv/ZQ+lkHvLj4SYlWqsjYbuPF5CkEdqTNktukKv8UYFzi5
         /NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PdXksB6ym5DNUu14zeftWHgAGlRIBugL+8piZPGBmMg=;
        b=TjTDYGfLTXMGdfRs8WlFZdLFM4sC8v+JRdHDMRhiXHUcMAiaGx1iY2NVNUh0Plbfrb
         emtFbAHyuNXAbvsDd5f6rN2sB+P1SPeIhCWhMa25K/E8R+f8l6dvVMyPP8oK0KrjbWQA
         SFaLPElCvdrZswvgcD7hJDNB5QtSHYywXbvsVaNivREc83yy/2ZkkeQNQ32zBp8PXG6/
         PSTes0RpBbTXikUIxhtD6s1lQpfHk7Y0WAsNM2MSOoWPUmN0P7v7JnjzSZIoCbRmevpd
         EK+ZXrbSSjKhpf9TLVqBlUd6i64p70S4yaOjrhAz3ymMqhuyEx0YMCrTVTLoJKrJ8Rz7
         LS2g==
X-Gm-Message-State: AOAM530ERaZGs4UGLXLWYCEYUWk2tNjYVaRBlYuOejNc4feekLFY2l73
        fv84A6j6O2tJs1Wg4PBhklQ=
X-Google-Smtp-Source: ABdhPJw33rvxOsBdNeW8YTaAt56KT0JGNuI/lLm3X/WUx6D7sOvb8E9lSq5+xDVAODPGeLwLAw5BSA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr7329043wrn.48.1594756080972;
        Tue, 14 Jul 2020 12:48:00 -0700 (PDT)
Received: from localhost.localdomain ([46.114.111.105])
        by smtp.gmail.com with ESMTPSA id u16sm5676553wmn.11.2020.07.14.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:48:00 -0700 (PDT)
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
Date:   Tue, 14 Jul 2020 21:47:40 +0200
Message-Id: <20200714194740.4548-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When assembling with Clang via `make LLVM_IAS=1` and CONFIG_HYPERV enabled,
we observe the following error:

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

This is caused by typos in arch/x86/include/asm/idtentry.h:

HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR

For more details see ClangBuiltLinux issue #1088.

Cc: Jian Cai <caij2003@gmail.com>
Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
Link: https://github.com/ClangBuiltLinux/linux/issues/1088
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
Personal note:
I also needed Jian's patch to completely build with LLVM_IAS=1" but
I don't think that should be in the message that gets committed per
se. Without Jian's patch we did NOT catch this one!
Link: https://github.com/ClangBuiltLinux/linux/issues/1043
Link: https://lore.kernel.org/patchwork/patch/1272115/

Changes v2->v3:
- Fold in comments suggested by Nick
- Add Nick's Suggested-by
- Drop unneeded tags and order the rest alphabetically
- Move comments and links to Jian's patch to a personal note

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

