Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BC0C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851102081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgAOVw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:52:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:34246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgAOVw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:52:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 13:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="218293938"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 15 Jan 2020 13:52:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B5C4F301003; Wed, 15 Jan 2020 13:52:28 -0800 (PST)
Date:   Wed, 15 Jan 2020 13:52:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/cpu: Update cached HLE state on write to
 TSX_CTRL_CPUID_CLEAR
Message-ID: <20200115215228.GH302770@tassilo.jf.intel.com>
References: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
 <20200115211513.mxzembrm4hf44d6j@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115211513.mxzembrm4hf44d6j@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 03:15:13PM -0600, Josh Poimboeuf wrote:
> On Fri, Jan 10, 2020 at 02:50:54PM -0800, Pawan Gupta wrote:
> > /proc/cpuinfo currently reports Hardware Lock Elision (HLE) feature to
> > be present on boot cpu even if it was disabled during the bootup. This
> > is because cpuinfo_x86->x86_capability HLE bit is not updated after TSX
> > state is changed via a new MSR IA32_TSX_CTRL.
> > 
> > Update the cached HLE bit also since it is expected to change after an
> > update to CPUID_CLEAR bit in MSR IA32_TSX_CTRL.
> > 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> From the Intel TAA deep dive page [1], it says:
> 
>   "On processors that enumerate IA32_ARCH_CAPABILITIES[TSX_CTRL] (bit
>    7)=1, HLE prefix hints are always ignored."
> 
> So if the CPU has IA32_TSX_CTRL, HLE is implicitly disabled, so why
> would the HLE bit have been set in CPUID in the first place?

The CPUID is unchanged to avoid problems with software that checks 
for unchanged CPUID. Unfortunately that exists in the wild.

-Andi
