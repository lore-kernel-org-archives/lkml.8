Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A54DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2097120674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHTWef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:34:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:13363 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgHTWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:34:34 -0400
IronPort-SDR: hBjZ9GT3i0px5RDw5DDaDm54NjgS6Tmih0X8AydHbWKAcIRLdry2+RPAPoCM8BHzKGWgfWwYPs
 NzA8hioo9yTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="156473935"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="156473935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 15:34:34 -0700
IronPort-SDR: M9a8VIwmIYg9vmlw98pQBFNG63T5/n3EcIMbTlXje/QT7KcRQxs6jbVFMv80HTw62qbuClWvb/
 5GI5Kra5fi8w==
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="321053505"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 15:34:33 -0700
Date:   Thu, 20 Aug 2020 15:34:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <20200820223431.GB10269@sjchrist-ice>
References: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com>
 <5756198D-C8BD-4290-BFCA-04424EB230A6@amacapital.net>
 <20200820220507.GA10269@sjchrist-ice>
 <CALCETrXxfZtLSPx+QFMRdnvDE6+zT=Jy8CYX03Va7o8M0VvKng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXxfZtLSPx+QFMRdnvDE6+zT=Jy8CYX03Va7o8M0VvKng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:07:10PM -0700, Andy Lutomirski wrote:
> On Thu, Aug 20, 2020 at 3:05 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Thu, Aug 20, 2020 at 01:36:46PM -0700, Andy Lutomirski wrote:
> > >
> > >
> > > > On Aug 20, 2020, at 1:15 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> > > >
> > > > ﻿On 8/20/20 3:07 PM, Dave Hansen wrote:
> > > >> On 8/20/20 12:05 PM, Tom Lendacky wrote:
> > > >>>> I added a quick hack to save TSC_AUX to a new variable in the SVM
> > > >>>> struct and then restore it right after VMEXIT (just after where GS is
> > > >>>> restored in svm_vcpu_enter_exit()) and my guest is no longer crashing.
> > > >>>
> > > >>> Sorry, I mean my host is no longer crashing.
> > > >> Just to make sure I've got this:
> > > >> 1. Older CPUs didn't have X86_FEATURE_RDPID
> > > >> 2. FSGSBASE patches started using RDPID in the NMI entry path when
> > > >>    supported *AND* FSGSBASE was enabled
> > > >> 3. There was a latent SVM bug which did not restore the RDPID data
> > > >>    before NMIs were reenabled after VMEXIT
> > > >> 4. If an NMI comes in the window between VMEXIT and the
> > > >>    wrmsr(TSC_AUX)... boom
> > > >
> > > > Right, which means that the setting of TSC_AUX to the guest value needs to be moved, too.
> > > >
> > >
> > > Depending on how much of a perf hit this is, we could also skip using RDPID
> > > in the paranoid path on SVM-capable CPUs.
> >
> > Doesn't this affect VMX as well?  KVM+VMX doesn't restore TSC_AUX until the
> > kernel returns to userspace.  I don't see anything that prevents the NMI
> > RDPID path from affecting Intel CPUs.
> >
> > Assuming that's the case, I would strongly prefer this be handled in the
> > paranoid path.  NMIs are unblocked immediately on VMX VM-Exit, which means
> > using the MSR load lists in the VMCS, and I hate those with a vengeance.
> >
> > Perf overhead on VMX would be 8-10% for VM-Exits that would normally stay
> > in KVM's run loop, e.g. ~125 cycles for the WMRSR, ~1300-1500 cycles to
> > handle the most common VM-Exits.  It'd be even higher overhead for the
> > VMX preemption timer, which is handled without even enabling IRQs and is
> > a hot path as it's used to emulate the TSC deadline timer for the guest.
> 
> I'm fine with that -- let's get rid of RDPID unconditionally in the
> paranoid path.  Want to send a patch that also adds as comment
> explaining why we're not using RDPID?

Sure, though I won't object if Tom beats me to the punch :-)
