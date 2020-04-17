Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1BC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1D920776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgDQRGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:06:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:40508 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgDQRGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:06:09 -0400
IronPort-SDR: AjGI3eJ9pNfrxViAu4x1MyLckr+vEONQDemp9LAnMlkk0JXEsU4zRpHPWLM2SOnuNt/tdVE2GS
 5/HFdOwaGX6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 10:06:08 -0700
IronPort-SDR: oWEEqNM+7i3WPWHh2w6V/2UblrE/Y/aK9kseWVHcyzKnhHPe1gpnMAp8zjfaAHZTDBcDdg4UlE
 ZWmfbiYUX4Yg==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="299663835"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 10:06:08 -0700
Date:   Fri, 17 Apr 2020 10:06:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
Message-ID: <20200417170607.GA18267@agluck-desk2.amr.corp.intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
 <20200416205754.21177-3-tony.luck@intel.com>
 <878siumnrf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878siumnrf.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:04:36PM +0200, Thomas Gleixner wrote:
> Tony Luck <tony.luck@intel.com> writes:
> > +	m = x86_match_cpu(split_lock_cpu_ids);
> > +	if (!m)
> > +		return;
> > +
> > +	if (m->driver_data && cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
> > {
> 
> This condition results in the following:
> 
>     driver_data     MSR_CORE_CAPS	 MSR_CORE_CAPS_SLD	SLD available
> 
> 1       0             Don't care          Don't care               Y
> 2       1                N                Don't care               Y
> 3       1                Y                    Y                    Y
> 4       1                Y                    N                    N
> 
> #2 does not make any sense to me.

Nor to me :-(

I got too clever trying to combine tests.

New version taking cases one at a time so my "stuck inside the
house for six weeks now" brain can follow the steps.

-Tony

From 8c9d779e358eaa239b9647b7a3fe8ebee9becd63 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 16 Apr 2020 10:37:42 -0700
Subject: [PATCH v2] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not
 architectural

The Intel Software Developers' Manual erroneously listed bit 5 of the
IA32_CORE_CAPABILITIES register as an architectural feature. It is not.

Features enumerated by IA32_CORE_CAPABILITIES are model specific and
implementation details may vary in different cpu models. Thus it is only
safe to trust features after checking the CPU model.

Icelake client and server models are known to implement the split lock
detect feature even though they don't enumerate IA32_CORE_CAPABILITIES

Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 38 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 6119deb32660..0bf0d7e3832a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1120,10 +1120,12 @@ void switch_to_sld(unsigned long tifn)
 }
 
 /*
- * The following processors have the split lock detection feature. But
- * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
- * be enumerated. Enable it by family and model matching on these
- * processors.
+ * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they
+ * should only be trusted if you know you are on a model that implements
+ * them.
+ * The driver_data field is set to zero to indicate CPU models like
+ * Icelake that are known to have the split-lock feature even though
+ * they do not enumerate IA32_CORE_CAPABILITIES.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           0),
@@ -1133,19 +1135,23 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 
 void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_core_caps = 0;
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+
+	m = x86_match_cpu(split_lock_cpu_ids);
+	if (!m)
 		return;
-	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
-		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
-		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
-	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		/* Enumerate split lock detection by family and model. */
-		if (x86_match_cpu(split_lock_cpu_ids))
-			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
-	}
 
-	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
-		split_lock_setup();
+	if (!m->driver_data)
+		goto setup;
+	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
+		return;
+	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
+	if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
+		return;
+setup:
+	split_lock_setup();
 }
-- 
2.21.1

