Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B611C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C132054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597938941;
	bh=cK3kF60+6TKP27RpSl0Ssbs1Tv+b14rPZSX1bkpQRak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gLrJUZNbX/8CxYxb5l02GwS0RBXMniE0V2bsDUL/RFXEmw3pT9UpAEFoy4rqz58m/
	 vtsBTt+mkQFrzPjLiJcEUDCV8tuFk0DsBi4PJl8BTDH0HFeesFd337WECAme+yFI6T
	 IvfF8KyDTDBvNt4Jud7tfkO1qEtCt1ufOaRkgTUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgHTPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgHTPzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:55:35 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEEE2086A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597938935;
        bh=cK3kF60+6TKP27RpSl0Ssbs1Tv+b14rPZSX1bkpQRak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TSL7WFswph08vWCBCbZMvJx1kWZ40D9oa9ZYGlUzcyh2whzvROJh2BSLmczGlEB4J
         IvhS+jYOS10HaUpCoLzDYCBr9j/oIqwl9LfgmTW42uGs3Hw7k/8auS/LdXI6THn5ep
         dEmxCGaF//8SXPcsT6/9r9K+ob+e/Vr0gdgvFQWA=
Received: by mail-wr1-f54.google.com with SMTP id f1so2520044wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:55:35 -0700 (PDT)
X-Gm-Message-State: AOAM532G8fVYRQkuiDJeaDuGsWnV9VEU62otVXtZfPRIU+5w8D3VGOcy
        FS3i5UykAk3EHxk62mrSs5HPUVCVW0P+MJP7RwHH5Q==
X-Google-Smtp-Source: ABdhPJz+eUFuLMzu85cx19PO2UoC7Sd0golzCYmYEtgLt8X8u8CKUgFNR1zXCKrO9UoYIMjlbqu9Jm1hgB+qk3OCMP4=
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr3771565wrx.257.1597938933739;
 Thu, 20 Aug 2020 08:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com> <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice> <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
In-Reply-To: <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Aug 2020 08:55:22 -0700
X-Gmail-Original-Message-ID: <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
Message-ID: <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/20/20 10:10 AM, Sean Christopherson wrote:
> > On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
> >> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> wrote:
> >>>
> >>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>
> >>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
> >>>>> It looks like the FSGSBASE support is crashing my second generation EPYC
> >>>>> system. I was able to bisect it to:
> >>>>>
> >>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
> >>>>>
> >>>>> The panic only happens when using KVM. Doing kernel builds or stress
> >>>>> on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
> >>>>> guest and do a kernel build within the guest, I get the following:
> >>>>
> >>>> I should clarify that this panic is on the bare-metal system, not in the
> >>>> guest. And that specifying nofsgsbase on the bare-metal command line fixes
> >>>> the issue.
> >>>
> >>> I certainly see some oddities:
> >>>
> >>> We have this code:
> >>>
> >>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> >>> {
> >>>          struct vcpu_svm *svm = to_svm(vcpu);
> >>>          int i;
> >>>
> >>>          avic_vcpu_put(vcpu);
> >>>
> >>>          ++vcpu->stat.host_state_reload;
> >>>          kvm_load_ldt(svm->host.ldt);
> >>> #ifdef CONFIG_X86_64
> >>>          loadsegment(fs, svm->host.fs);
> >>>          wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> >
> > Pretty sure current->thread.gsbase can be stale, i.e. this needs:
> >
> >       current_save_fsgs();
>
> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
> current->thread.gsbase value to a new variable in the svm struct. I then
> used that variable in the wrmsrl below, but it still crashed.

Can you try bisecting all the way back to:

commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
Author: Andy Lutomirski <luto@kernel.org>
Date:   Thu May 28 16:13:48 2020 -0400

    x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE

and adding the unsafe_fsgsbase command line option while you bisect.

Also, you're crashing when you run a guest, right?  Can you try
running the x86 sefltests on a bad kernel without running any guests?

--Andy
