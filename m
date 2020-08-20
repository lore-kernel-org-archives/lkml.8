Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A70C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEED2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597961249;
	bh=ttNYwH6YbdhiYjcE2D1IEfBaxfAxVirTGok7UtytaN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pqUCVXh2g/gK9Gchojqxx1rY62m5PxmgMCp/7sPDFAok6JIXX1e0ARJKDfs4ff/+o
	 8v8lPAdIceKEzs+4HghgiCUZ/abWFZwMRZ4/CG/Ni8tolPEsaDxPmihph3lhFLRLOA
	 YACfQKVjitL0QVcIXbWQLJDMIm0PU6a19jL+0478=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHTWH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgHTWHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:07:25 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C7522B49
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597961244;
        bh=ttNYwH6YbdhiYjcE2D1IEfBaxfAxVirTGok7UtytaN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E8A9sbce8kF0eaLbRUesAeQpu2EMPJrdcpPL7fv2BFq5aVseBQ634FgjPr5VQDVfH
         sTTcle/fb5XH4vEC0dh6cdepoTMX1ex3THXLO7ZXncsxMelamqPaXcDXIoiaSpS9ZJ
         LQ6EC7Xxp2R0sxs23ouLtoA9Z/zDkmFHFDnyqzAo=
Received: by mail-wm1-f54.google.com with SMTP id p14so120548wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:07:24 -0700 (PDT)
X-Gm-Message-State: AOAM531dLw2nGF34yCZpwR/caYFgLhBDOkh/mGn0H+ema9nFYq1L3mdc
        LIoSfLu2hzt3Ose6SOB3H+rC/f51iLUYo4ZZSNIZXw==
X-Google-Smtp-Source: ABdhPJzQc5Ln2xmSP6bAGeQW/9wcAIdAqfKg3QzjW3mlDKwH1v/2qaRVQ/c8QluTwfZeZ3ycv0XVJW8Khf3Zq7vDyLs=
X-Received: by 2002:a1c:de86:: with SMTP id v128mr517196wmg.36.1597961242679;
 Thu, 20 Aug 2020 15:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com> <5756198D-C8BD-4290-BFCA-04424EB230A6@amacapital.net>
 <20200820220507.GA10269@sjchrist-ice>
In-Reply-To: <20200820220507.GA10269@sjchrist-ice>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Aug 2020 15:07:10 -0700
X-Gmail-Original-Message-ID: <CALCETrXxfZtLSPx+QFMRdnvDE6+zT=Jy8CYX03Va7o8M0VvKng@mail.gmail.com>
Message-ID: <CALCETrXxfZtLSPx+QFMRdnvDE6+zT=Jy8CYX03Va7o8M0VvKng@mail.gmail.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 3:05 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Aug 20, 2020 at 01:36:46PM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Aug 20, 2020, at 1:15 PM, Tom Lendacky <thomas.lendacky@amd.com> w=
rote:
> > >
> > > =EF=BB=BFOn 8/20/20 3:07 PM, Dave Hansen wrote:
> > >> On 8/20/20 12:05 PM, Tom Lendacky wrote:
> > >>>> I added a quick hack to save TSC_AUX to a new variable in the SVM
> > >>>> struct and then restore it right after VMEXIT (just after where GS=
 is
> > >>>> restored in svm_vcpu_enter_exit()) and my guest is no longer crash=
ing.
> > >>>
> > >>> Sorry, I mean my host is no longer crashing.
> > >> Just to make sure I've got this:
> > >> 1. Older CPUs didn't have X86_FEATURE_RDPID
> > >> 2. FSGSBASE patches started using RDPID in the NMI entry path when
> > >>    supported *AND* FSGSBASE was enabled
> > >> 3. There was a latent SVM bug which did not restore the RDPID data
> > >>    before NMIs were reenabled after VMEXIT
> > >> 4. If an NMI comes in the window between VMEXIT and the
> > >>    wrmsr(TSC_AUX)... boom
> > >
> > > Right, which means that the setting of TSC_AUX to the guest value nee=
ds to be moved, too.
> > >
> >
> > Depending on how much of a perf hit this is, we could also skip using R=
DPID
> > in the paranoid path on SVM-capable CPUs.
>
> Doesn't this affect VMX as well?  KVM+VMX doesn't restore TSC_AUX until t=
he
> kernel returns to userspace.  I don't see anything that prevents the NMI
> RDPID path from affecting Intel CPUs.
>
> Assuming that's the case, I would strongly prefer this be handled in the
> paranoid path.  NMIs are unblocked immediately on VMX VM-Exit, which mean=
s
> using the MSR load lists in the VMCS, and I hate those with a vengeance.
>
> Perf overhead on VMX would be 8-10% for VM-Exits that would normally stay
> in KVM's run loop, e.g. ~125 cycles for the WMRSR, ~1300-1500 cycles to
> handle the most common VM-Exits.  It'd be even higher overhead for the
> VMX preemption timer, which is handled without even enabling IRQs and is
> a hot path as it's used to emulate the TSC deadline timer for the guest.

I'm fine with that -- let's get rid of RDPID unconditionally in the
paranoid path.  Want to send a patch that also adds as comment
explaining why we're not using RDPID?

--Andy
