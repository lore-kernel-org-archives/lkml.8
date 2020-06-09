Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FC9206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cb17Qv/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFIDPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFIDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:15:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A8C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 20:15:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so9456307pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CqK6Guno3gXrwz3/D+TZMYLBJMF7ZONm8ZADtpfFYTo=;
        b=cb17Qv/fm4r8TM/G1iFjkEL5MMZZSRhxRy0GlM37eJFvmhiQm9k/8fhwKL3RXhEKg9
         muyVFf05aksn2h/ImMZQTkY2kN7TC0/vW7XjWMu9tL+q5cdUBGWKX/bWlc40na4c0zA1
         zfNV3tqmo78rbn7r9XiltMsN/IPKJRtVAO71o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CqK6Guno3gXrwz3/D+TZMYLBJMF7ZONm8ZADtpfFYTo=;
        b=qwAMIBCHKXTN6C8nIAuk1snfmz+lGvnX2r2Ra1FOn/mNBJ6NaPZgnJq9JPDFeWnCnY
         nZcDziMItBayomq9DEMGNUY4SudmYUe6TGAdab8YZhBBmWTa+U9oqE/Wh/NvtIorisJL
         fpxJeFX6JcfhyZ+Ito5bbsIX77luS9MNMa4EpJds0q7fsl6XeTk+IEbGTMqdtj/RQwBQ
         QE14j/UEkjoBiZ1EH65gtbDPXJZTop9AKStoSxpUGR+TBVJR5JsDegafhU7BnUIdjMis
         vXedISlb3tHGVgh+LNW+JX+ku2mwi9U1VXXogtbogzcCrrAkuTVWeCmgNyysWDoXz4Ef
         9ijw==
X-Gm-Message-State: AOAM531b162+bQGLqURiagO+vk2XA8ZLq0WqXFOO4Gox7zTmqQR4+ZR0
        vqagydYiXScc4GajE34QLS8bSg==
X-Google-Smtp-Source: ABdhPJypGOQXdWk+nTZxJm5ZV0XHNKTJ5c1Bd13Yq8+/k0f165l6eIvPWL5VedUd7PaomM8yZp9V9A==
X-Received: by 2002:a62:cd87:: with SMTP id o129mr23123606pfg.74.1591672511227;
        Mon, 08 Jun 2020 20:15:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm13sm804362pjb.5.2020.06.08.20.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 20:15:10 -0700 (PDT)
Date:   Mon, 8 Jun 2020 20:15:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Use pinning mask for CR4 bits needing to be 0
Message-ID: <202006082013.71E29A42@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X86_CR4_FSGSBASE bit of CR4 should not change after boot[1]. Older
kernels should enforce this bit to zero, and newer kernels need to
enforce it depending on boot-time configuration (e.g. "nofsgsbase").
To support a pinned bit being either 1 or 0, use an explicit mask in
combination with the expected pinned bit values.

[1] https://lore.kernel.org/lkml/20200527103147.GI325280@hirez.programming.kicks-ass.net

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/cpu/common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb83fe24..677a7d593a04 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -347,6 +347,9 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+/* These bits should not change their value after CPU init is finished. */
+static const unsigned long cr4_pinned_mask =
+	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP | X86_CR4_FSGSBASE;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
@@ -371,20 +374,20 @@ EXPORT_SYMBOL(native_write_cr0);
 
 void native_write_cr4(unsigned long val)
 {
-	unsigned long bits_missing = 0;
+	unsigned long bits_changed = 0;
 
 set_register:
 	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
 
 	if (static_branch_likely(&cr_pinning)) {
-		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
-			bits_missing = ~val & cr4_pinned_bits;
-			val |= bits_missing;
+		if (unlikely((val & cr4_pinned_mask) != cr4_pinned_bits)) {
+			bits_changed = (val & cr4_pinned_mask) ^ cr4_pinned_bits;
+			val = (val & ~cr4_pinned_mask) | cr4_pinned_bits;
 			goto set_register;
 		}
-		/* Warn after we've set the missing bits. */
-		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
-			  bits_missing);
+		/* Warn after we've corrected the changed bits. */
+		WARN_ONCE(bits_changed, "pinned CR4 bits changed: 0x%lx!?\n",
+			  bits_changed);
 	}
 }
 EXPORT_SYMBOL(native_write_cr4);
@@ -396,7 +399,7 @@ void cr4_init(void)
 	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4 |= X86_CR4_PCIDE;
 	if (static_branch_likely(&cr_pinning))
-		cr4 |= cr4_pinned_bits;
+		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
 
 	__write_cr4(cr4);
 
@@ -411,10 +414,7 @@ void cr4_init(void)
  */
 static void __init setup_cr_pinning(void)
 {
-	unsigned long mask;
-
-	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
-	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
+	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & cr4_pinned_mask;
 	static_key_enable(&cr_pinning.key);
 }
 
-- 
2.25.1


-- 
Kees Cook
