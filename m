Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E0EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F07220748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHUB4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:56:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:11241 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHUB4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:56:31 -0400
IronPort-SDR: oDlFXY+QQu/nc/5/XZHvxPWpPRKB2LDEu230uy07D3x4M8ZOeFaVkO3BjWjDnPPJosW/ccInMN
 hoEy6jgG2Yfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240260123"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="240260123"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 18:56:31 -0700
IronPort-SDR: +51YzU+a88n12EbFcxBINApJoazCsH48jAdsUdW7Yg6+K4/2Ie1sAC+h15WS1NNLMwjdzqnh9g
 u4lref9jfyaw==
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="472869857"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 18:56:31 -0700
Date:   Thu, 20 Aug 2020 18:56:30 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
Message-ID: <20200821015630.GC13886@sjchrist-ice>
References: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com>
 <5756198D-C8BD-4290-BFCA-04424EB230A6@amacapital.net>
 <20200820220507.GA10269@sjchrist-ice>
 <CALCETrXxfZtLSPx+QFMRdnvDE6+zT=Jy8CYX03Va7o8M0VvKng@mail.gmail.com>
 <20200820223431.GB10269@sjchrist-ice>
 <30eb9d62-a883-2630-c51f-6f5ee4def07a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30eb9d62-a883-2630-c51f-6f5ee4def07a@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 07:00:16PM -0500, Tom Lendacky wrote:
> On 8/20/20 5:34 PM, Sean Christopherson wrote:
> > On Thu, Aug 20, 2020 at 03:07:10PM -0700, Andy Lutomirski wrote:
> > > On Thu, Aug 20, 2020 at 3:05 PM Sean Christopherson
> > > <sean.j.christopherson@intel.com> wrote:
> > > > 
> > > > On Thu, Aug 20, 2020 at 01:36:46PM -0700, Andy Lutomirski wrote:
> > > > > 
> > > > > Depending on how much of a perf hit this is, we could also skip using RDPID
> > > > > in the paranoid path on SVM-capable CPUs.
> > > > 
> > > > Doesn't this affect VMX as well?  KVM+VMX doesn't restore TSC_AUX until the
> > > > kernel returns to userspace.  I don't see anything that prevents the NMI
> > > > RDPID path from affecting Intel CPUs.
> > > > 
> > > > Assuming that's the case, I would strongly prefer this be handled in the
> > > > paranoid path.  NMIs are unblocked immediately on VMX VM-Exit, which means
> > > > using the MSR load lists in the VMCS, and I hate those with a vengeance.
> > > > 
> > > > Perf overhead on VMX would be 8-10% for VM-Exits that would normally stay
> > > > in KVM's run loop, e.g. ~125 cycles for the WMRSR, ~1300-1500 cycles to
> > > > handle the most common VM-Exits.  It'd be even higher overhead for the
> > > > VMX preemption timer, which is handled without even enabling IRQs and is
> > > > a hot path as it's used to emulate the TSC deadline timer for the guest.
> > > 
> > > I'm fine with that -- let's get rid of RDPID unconditionally in the
> > > paranoid path.  Want to send a patch that also adds as comment
> > > explaining why we're not using RDPID?
> > 
> > Sure, though I won't object if Tom beats me to the punch :-)
> 
> I can do it, but won't be able to get to it until sometime tomorrow.

Confirmed VMX goes kaboom when running perf with a VM.  Patch incoming.
