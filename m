Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7127A206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5dy0y+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHTSiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgHTSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:38:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA26C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:38:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o21so2720361oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzm21wX1TryLHBz2IGA6qLAF3YJJDXDtGnxmVIQM7tE=;
        b=E5dy0y+QwBggSrnnIS3XfALTvYo2Rsbzl2n7WnrV4awTNkTQQ273A+QCAIqUhg2Vpc
         HBQRAxiKiIb6gvsDb93oCc722Aay3oHNGufXRaI4W8fPZCQTFizgek8dy+hLjzwllqHx
         qNmcpcMpsnSF0ivVPD7KvBjT205+ScqWYdjV5KOFQlT4EoIW1bE4MiT+zkJO+8eh2ckC
         lywuKVO43JB4RR9I/kYsI9f7GUHMi6RGngN8I39byEP7MbN6aCky7FuU/ddof848rt2O
         7dGdwwkZTQa3h/Nzms77G9uc+a2MCzl/9OaS1rOxTX1ptBJjVyZo8vVePumAIgNsn0ts
         zGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzm21wX1TryLHBz2IGA6qLAF3YJJDXDtGnxmVIQM7tE=;
        b=ho6KqAzq03lcwaAGGVbpZGIorNlOorWuZGMrAe4nxsMnSungphnYcMxCNgz91HOg42
         I6TLTX9kwmYreFl0VmoSwVtPeSxuJdTYbwa6sPw+QRnJ5aCkY9BdWqR3O+YAhSM/wMRw
         sbtbN6jMZLBX4WsuvT2DQLQKxHdfLlu4Kv6vWTkgcmV8ZS/l8eHIC6sHEwyvBy64NJqH
         ipnVbhFh9mHXpbQ631U4qJXcWoO+W0y3orGCxDKrcg0L/GO1Nt0C075k/Oax+pty54Yb
         huSgHGWvbloXCtunGQ6WwXpotkdGGlegMYsjWKGqrbdFcM4msWlJOlPFK1vDWUodKTwI
         XXDg==
X-Gm-Message-State: AOAM533Db3TTnCY/p3UnKqoKxkuS8804/+EUt6leTUWqP2H6NSw47FIz
        HGFkQ/E1RqlwG6ZBuBwu/dD/UM7fgWEJAWBYOSHwzw==
X-Google-Smtp-Source: ABdhPJzvjEL6juC4BvsGSslBlQzblP3A6kWhA31QCt8/EKB3hTLxRgO6iZf5l1DbyN5is7xzhB6GbqC/8lqS4KtLTEE=
X-Received: by 2002:aca:670b:: with SMTP id z11mr38788oix.6.1597948693928;
 Thu, 20 Aug 2020 11:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com> <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice> <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
 <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
 <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com> <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
 <68478297-ff21-fa38-a37b-2e1e515fdc5e@amd.com>
In-Reply-To: <68478297-ff21-fa38-a37b-2e1e515fdc5e@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Aug 2020 11:38:02 -0700
Message-ID: <CALMp9eQDuwzxdLXndnq9FZfDXaNS7U36WDW7CqixjVBareYAwQ@mail.gmail.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:34 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/20/20 11:30 AM, Tom Lendacky wrote:
> > On 8/20/20 11:17 AM, Tom Lendacky wrote:
> >> On 8/20/20 10:55 AM, Andy Lutomirski wrote:
> >>> On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com>
> >>> wrote:
> >>>>
> >>>> On 8/20/20 10:10 AM, Sean Christopherson wrote:
> >>>>> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
> >>>>>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky
> >>>>>>> <thomas.lendacky@amd.com> wrote:
> >>>>>>>>
> >>>>>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
> >>>>>>>>> It looks like the FSGSBASE support is crashing my second
> >>>>>>>>> generation EPYC
> >>>>>>>>> system. I was able to bisect it to:
> >>>>>>>>>
> >>>>>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and
> >>>>>>>>> add a chicken bit")
> >>>>>>>>>
> >>>>>>>>> The panic only happens when using KVM. Doing kernel builds or stress
> >>>>>>>>> on bare-metal appears fine. But if I fire up, in this case, a
> >>>>>>>>> 64-vCPU
> >>>>>>>>> guest and do a kernel build within the guest, I get the following:
> >>>>>>>>
> >>>>>>>> I should clarify that this panic is on the bare-metal system, not
> >>>>>>>> in the
> >>>>>>>> guest. And that specifying nofsgsbase on the bare-metal command
> >>>>>>>> line fixes
> >>>>>>>> the issue.
> >>>>>>>
> >>>>>>> I certainly see some oddities:
> >>>>>>>
> >>>>>>> We have this code:
> >>>>>>>
> >>>>>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> >>>>>>> {
> >>>>>>>           struct vcpu_svm *svm = to_svm(vcpu);
> >>>>>>>           int i;
> >>>>>>>
> >>>>>>>           avic_vcpu_put(vcpu);
> >>>>>>>
> >>>>>>>           ++vcpu->stat.host_state_reload;
> >>>>>>>           kvm_load_ldt(svm->host.ldt);
> >>>>>>> #ifdef CONFIG_X86_64
> >>>>>>>           loadsegment(fs, svm->host.fs);
> >>>>>>>           wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> >>>>>
> >>>>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
> >>>>>
> >>>>>        current_save_fsgs();
> >>>>
> >>>> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
> >>>> current->thread.gsbase value to a new variable in the svm struct. I then
> >>>> used that variable in the wrmsrl below, but it still crashed.
> >>>
> >>> Can you try bisecting all the way back to:
> >>>
> >>> commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
> >>> Author: Andy Lutomirski <luto@kernel.org>
> >>> Date:   Thu May 28 16:13:48 2020 -0400
> >>>
> >>>      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
> >>>
> >>> and adding the unsafe_fsgsbase command line option while you bisect.
> >>
> >> I'll give that a try.
>
> Bisecting with unsafe_fsgsbase identified:
>
> c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
>
> But I'm thinking that could be because it starts using GET_PERCPU_BASE,
> which on Rome would use RDPID. So is SVM restoring TSC_AUX_MSR too late?
> That would explain why I don't see the issue on Naples, which doesn't
> support RDPID.

It looks to me like SVM loads the guest TSC_AUX from vcpu_load to
vcpu_put, with this comment:

/* This assumes that the kernel never uses MSR_TSC_AUX */
if (static_cpu_has(X86_FEATURE_RDTSCP))
        wrmsrl(MSR_TSC_AUX, svm->tsc_aux);

We are talking about mainline here, right?
