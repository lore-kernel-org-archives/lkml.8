Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E54204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgHTPK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:10:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:28338 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgHTPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:10:52 -0400
IronPort-SDR: woeuSBlpk3QMd7oy4u2yleh0UfeWnu6M9UpBRNbQEDUIjQobBcC8tszAdF7PNgxkFwV4aCg3Dc
 qhFT+7NZhK5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="173359450"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="173359450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 08:10:51 -0700
IronPort-SDR: UShScWwahsajGm/COqKzOkq2UGVevLxll6rnwhUkImZTCKKbkyY37oiYO8m18VEiAjk3r2ldOr
 uHh+W7e2AAXQ==
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="497647253"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 08:10:51 -0700
Date:   Thu, 20 Aug 2020 08:10:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
Message-ID: <20200820151049.GA26595@sjchrist-ice>
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
 <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> > >
> > > On 8/19/20 1:07 PM, Tom Lendacky wrote:
> > > > It looks like the FSGSBASE support is crashing my second generation EPYC
> > > > system. I was able to bisect it to:
> > > >
> > > > b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
> > > >
> > > > The panic only happens when using KVM. Doing kernel builds or stress
> > > > on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
> > > > guest and do a kernel build within the guest, I get the following:
> > >
> > > I should clarify that this panic is on the bare-metal system, not in the
> > > guest. And that specifying nofsgsbase on the bare-metal command line fixes
> > > the issue.
> >
> > I certainly see some oddities:
> >
> > We have this code:
> >
> > static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> > {
> >         struct vcpu_svm *svm = to_svm(vcpu);
> >         int i;
> >
> >         avic_vcpu_put(vcpu);
> >
> >         ++vcpu->stat.host_state_reload;
> >         kvm_load_ldt(svm->host.ldt);
> > #ifdef CONFIG_X86_64
> >         loadsegment(fs, svm->host.fs);
> >         wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);

Pretty sure current->thread.gsbase can be stale, i.e. this needs:

	current_save_fsgs();
	wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);

On a related topic, we really should consolidate the VMX and SVM code for
these flows, they're both ugly.

> >         load_gs_index(svm->host.gs);
> >
> > Surely that should do load_gs_index() *before* wrmsrl().  But that's
> > not the problem at hand.
> >
> > There are also some open-coded rdmsr and wrmsrs of MSR_GS_BASE --
> > surely these should be x86_gsbase_read_cpu() and
> > x86_gsbase_write_cpu().  (Those functions don't actually exist, but
> > the fsbase equivalents do, and we should add them.)  But that's also
> > not the problem at hand.
> 
> Make that cpu_kernelmode_gs_base(cpu).  Perf win on all CPUs.
> 
> But I still don't see the bug.


