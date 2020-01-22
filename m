Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1DCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D3D2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAVQyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:54:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:59427 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgAVQyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:54:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="374973940"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2020 08:54:43 -0800
Subject: [PATCH] x86/pkeys: add check for pkey "overflow"
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        alex.shi@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, bigeasy@linutronix.de,
        gorcunov@gmail.com, pankaj.laxminarayan.bharadiya@intel.com,
        aubrey.li@linux.intel.com, dave.hansen@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 22 Jan 2020 08:53:46 -0800
Message-Id: <20200122165346.AD4DA150@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Shi reported the pkey macros above arch_set_user_pkey_access()
to be unused.  They are unused, and even refer to a nonexistent
CONFIG option.

But, they might have served a good use, which was to ensure that
the code does not try to set values that would not fit in the
PKRU register.  As it stands, a too-large 'pkey' value would
be likely to silently overflow the u32 new_pkru_bits.

Add a check to look for overflows.  Also add a comment to remind
any future developer to closely examine the types used to store
pkey values if arch_max_pkey() ever changes.

This boots and passes the x86 pkey selftests.

Reported-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dave Hansen <dave.hansen@intel.com>
---

 b/arch/x86/include/asm/pkeys.h |    5 +++++
 b/arch/x86/kernel/fpu/xstate.c |    9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.c~pkey-check-pkru-shift arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~pkey-check-pkru-shift	2020-01-21 09:20:26.542385466 -0800
+++ b/arch/x86/kernel/fpu/xstate.c	2020-01-21 09:28:18.068384290 -0800
@@ -902,8 +902,6 @@ const void *get_xsave_field_ptr(int xfea
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
-#define NR_VALID_PKRU_BITS (CONFIG_NR_PROTECTION_KEYS * 2)
-#define PKRU_VALID_MASK (NR_VALID_PKRU_BITS - 1)
 /*
  * This will go out and modify PKRU register to set the access
  * rights for @pkey to @init_val.
@@ -922,6 +920,13 @@ int arch_set_user_pkey_access(struct tas
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
 		return -EINVAL;
 
+	/*
+	 * This code should only be called with valid 'pkey'
+	 * values originating from in-kernel users.  Complain
+	 * if a bad value is observed.
+	 */
+	WARN_ON_ONCE(pkey >= arch_max_pkey());
+
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
 		new_pkru_bits |= PKRU_AD_BIT;
diff -puN arch/x86/include/asm/pkeys.h~pkey-check-pkru-shift arch/x86/include/asm/pkeys.h
--- a/arch/x86/include/asm/pkeys.h~pkey-check-pkru-shift	2020-01-21 09:23:36.733384991 -0800
+++ b/arch/x86/include/asm/pkeys.h	2020-01-21 09:41:44.797382278 -0800
@@ -4,6 +4,11 @@
 
 #define ARCH_DEFAULT_PKEY	0
 
+/*
+ * If more than 16 keys are ever supported, a thorough audit
+ * will be necessary to ensure that the types that store key
+ * numbers and masks have sufficient capacity.
+ */
 #define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
_
