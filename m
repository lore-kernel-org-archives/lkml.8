Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF297C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C926F207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882909;
	bh=cETSr3bFTjxTXnT3mw9Ska/E/hoWemtWCNufamPSaks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UyO8Sjd0QKz9Z/73TX+YJ1qGaJvm1kZ3s76qTCvXObnEF9+FOluqvRIFRZPDQ4ZW8
	 O9Q16GK6uBuUmgLptZyzOCNXqx1l8bZba/e3ByeRfS+d+YrM4Z51XEk45ghr5EMLeH
	 GyeGhzmDGmEt0iaZaNsdFeRHsRLuLWQxp9nhQEwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHTAVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgHTAVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:21:47 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539A120FC3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597882906;
        bh=cETSr3bFTjxTXnT3mw9Ska/E/hoWemtWCNufamPSaks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EMudTyieCfRx/6Ct0YruAICkh3V0ZUUj5WS42z9EtQkajoqgb4W7ht170Rr+4v6bm
         5BmmJw4OOyuVEM4KPHqFJdKv7yIxWqo0Z5FNI77F6hjmgWu26dN5FeZCBzWhzeLqfx
         4iV83lZCynxdzgQpSe3HdVMV8SOXACa03ECNDFSc=
Received: by mail-wm1-f51.google.com with SMTP id 3so123665wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:21:46 -0700 (PDT)
X-Gm-Message-State: AOAM5307fBjCOXa3ljH5RHeww6A2PEk//MvfhxSObvqMB/ZT636Iqbi0
        UNlG0cBtIlGQTgJOelmpPi10Rnu65mzNQrmJ2OMrKQ==
X-Google-Smtp-Source: ABdhPJxAurePjkLWbMwmQ/0krHpgVPg4VAFhRWsW4qr0wwa9Jjbi/fkjkphQRNdVcQhZPHELycuCvH+I7E7wO3Xoa9k=
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr731156wma.21.1597882904919;
 Wed, 19 Aug 2020 17:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com> <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
In-Reply-To: <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Aug 2020 17:21:33 -0700
X-Gmail-Original-Message-ID: <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
Message-ID: <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 8/19/20 1:07 PM, Tom Lendacky wrote:
> > > It looks like the FSGSBASE support is crashing my second generation EPYC
> > > system. I was able to bisect it to:
> > >
> > > b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
> > >
> > > The panic only happens when using KVM. Doing kernel builds or stress
> > > on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
> > > guest and do a kernel build within the guest, I get the following:
> >
> > I should clarify that this panic is on the bare-metal system, not in the
> > guest. And that specifying nofsgsbase on the bare-metal command line fixes
> > the issue.
>
> I certainly see some oddities:
>
> We have this code:
>
> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> {
>         struct vcpu_svm *svm = to_svm(vcpu);
>         int i;
>
>         avic_vcpu_put(vcpu);
>
>         ++vcpu->stat.host_state_reload;
>         kvm_load_ldt(svm->host.ldt);
> #ifdef CONFIG_X86_64
>         loadsegment(fs, svm->host.fs);
>         wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
>         load_gs_index(svm->host.gs);
>
> Surely that should do load_gs_index() *before* wrmsrl().  But that's
> not the problem at hand.
>
> There are also some open-coded rdmsr and wrmsrs of MSR_GS_BASE --
> surely these should be x86_gsbase_read_cpu() and
> x86_gsbase_write_cpu().  (Those functions don't actually exist, but
> the fsbase equivalents do, and we should add them.)  But that's also
> not the problem at hand.

Make that cpu_kernelmode_gs_base(cpu).  Perf win on all CPUs.

But I still don't see the bug.
