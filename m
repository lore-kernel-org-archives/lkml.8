Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558D6C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310EF21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWBXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:23:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:13205 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAWBXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 20:23:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 17:23:18 -0800
X-IronPort-AV: E=Sophos;i="5.70,352,1574150400"; 
   d="scan'208";a="250814494"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 17:23:18 -0800
Date:   Wed, 22 Jan 2020 17:23:17 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200123012317.GA21843@agluck-desk2.amr.corp.intel.com>
References: <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123004507.GA2403906@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 07:45:08PM -0500, Arvind Sankar wrote:
> On Wed, Jan 22, 2020 at 11:24:34PM +0000, Luck, Tony wrote:
> > >> +static enum split_lock_detect_state sld_state = sld_warn;
> > >> +
> > >
> > > This sets sld_state to sld_warn even on CPUs that don't support
> > > split-lock detection. split_lock_init will then try to read/write the
> > > MSR to turn it on. Would it be better to initialize it to sld_off and
> > > set it to sld_warn in split_lock_setup instead, which is only called if
> > > the CPU supports the feature?
> > 
> > I've lost some bits of this patch series somewhere along the way :-(  There
> > was once code to decide whether the feature was supported (either with
> > x86_match_cpu() for a couple of models, or using the architectural test
> > based on some MSR bits.  I need to dig that out and put it back in. Then
> > stuff can check X86_FEATURE_SPLIT_LOCK before wandering into code
> > that messes with MSRs
> 
> That code is still there (cpu_set_core_cap_bits). The issue is that with
> the initialization here, nothing ever sets sld_state to sld_off if the
> feature isn't supported.
> 
> v10 had a corresponding split_lock_detect_enabled that was
> 0-initialized, but Peter's patch as he sent out had the flag initialized
> to sld_warn.

Ah yes. Maybe the problem is that split_lock_init() is only
called on systems that support split loc detect, while we call
split_lock_init() unconditionally.

What if we start with sld_state = sld_off, and then have split_lock_setup
set it to either sld_warn, or whatever the user chose on the command
line.  Patch below (on top of patch so you can see what I'm saying,
but will just merge it in for next version.

-Tony


diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 7478bebcd735..b6046ccfa372 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -39,7 +39,13 @@ enum split_lock_detect_state {
 	sld_fatal,
 };
 
-static enum split_lock_detect_state sld_state = sld_warn;
+/*
+ * Default to sld_off because most systems do not support
+ * split lock detection. split_lock_setup() will switch this
+ * to sld_warn, and then check to see if there is a command
+ * line override.
+ */
+static enum split_lock_detect_state sld_state = sld_off;
 
 /*
  * Just in case our CPU detection goes bad, or you have a weird system,
@@ -1017,10 +1023,11 @@ static inline bool match_option(const char *arg, int arglen, const char *opt)
 
 static void __init split_lock_setup(void)
 {
-	enum split_lock_detect_state sld = sld_state;
+	enum split_lock_detect_state sld;
 	char arg[20];
 	int i, ret;
 
+	sld_state = sld = sld_warn;
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
 
 	ret = cmdline_find_option(boot_command_line, "split_lock_ac",
