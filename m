Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930FB2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597872325;
	bh=29gaIAhdf/a0EPBadbMUPY0OWcKjqoIog1Z9TAi24LA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C6pU+tuS8fkZLLmnyZ06bJVo7rvnVF1moLBWcZLu3R9MNGqCrao0qkelLUMNzCEJ7
	 ToyCkOhHk9Xz5uZrxLv/3ofgqAKMet97M60FiwfebnQBV/maboPYOEkpC2ubmkxpHP
	 30GclCv49EKLqDxcZyQGj+pI+2aqKocVO+0f9Dgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHSVZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgHSVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:25:23 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55EED21741
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597872322;
        bh=29gaIAhdf/a0EPBadbMUPY0OWcKjqoIog1Z9TAi24LA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a5F+qyGspdHjnA7RLj9YFPAbKT7iI5iRUROOn/LYb/LPypw9i7gVlCFZhyZ8CVlah
         LE3StroBw4g62DbjBgbPm1tm12TE5ay1GoGIpD87bklMX1ttYq3zGnhuagcMwXsGX/
         I23v//6oXnbrBFmHQdq5l2+5eHCmoLnpD8yEq+Yw=
Received: by mail-wr1-f47.google.com with SMTP id z18so86380wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:25:22 -0700 (PDT)
X-Gm-Message-State: AOAM533vOWOP03eiWUOs7IWw7RETZu9a8Qh5H/1HRaQvQcFOjX0//vYF
        R/qdApKGDPjCfE5SbO6G6+OkTIVm64FvpM/TL925zQ==
X-Google-Smtp-Source: ABdhPJyHaKQhiHnkv3oGELqfZw8n3z40U3pQE6soc72225O943zJWakFsu1/QNWo47zGQfG6NL+LHC+ki6lIkikAe3M=
X-Received: by 2002:adf:e90f:: with SMTP id f15mr23603wrm.18.1597872320735;
 Wed, 19 Aug 2020 14:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com> <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
In-Reply-To: <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Aug 2020 14:25:09 -0700
X-Gmail-Original-Message-ID: <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
Message-ID: <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/19/20 1:07 PM, Tom Lendacky wrote:
> > It looks like the FSGSBASE support is crashing my second generation EPYC
> > system. I was able to bisect it to:
> >
> > b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
> >
> > The panic only happens when using KVM. Doing kernel builds or stress
> > on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
> > guest and do a kernel build within the guest, I get the following:
>
> I should clarify that this panic is on the bare-metal system, not in the
> guest. And that specifying nofsgsbase on the bare-metal command line fixes
> the issue.

I certainly see some oddities:

We have this code:

static void svm_vcpu_put(struct kvm_vcpu *vcpu)
{
        struct vcpu_svm *svm = to_svm(vcpu);
        int i;

        avic_vcpu_put(vcpu);

        ++vcpu->stat.host_state_reload;
        kvm_load_ldt(svm->host.ldt);
#ifdef CONFIG_X86_64
        loadsegment(fs, svm->host.fs);
        wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
        load_gs_index(svm->host.gs);

Surely that should do load_gs_index() *before* wrmsrl().  But that's
not the problem at hand.

There are also some open-coded rdmsr and wrmsrs of MSR_GS_BASE --
surely these should be x86_gsbase_read_cpu() and
x86_gsbase_write_cpu().  (Those functions don't actually exist, but
the fsbase equivalents do, and we should add them.)  But that's also
not the problem at hand.

I haven't actually spotted the bug yet...

--Andy
