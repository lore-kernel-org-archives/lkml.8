Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D92DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AF4206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMJ8uim/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHTSjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHTSjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:39:35 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD5C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:39:35 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z11so643540oon.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzIST6D4qh/UeeyVyUIEezlajru+bQMxBh3mGwFF4Vw=;
        b=QMJ8uim/ueqZjajO84PC4xr5Mp8CmkpCPZvRRHEzqda5Q2nhsY4h8sNb2o262MTRRk
         UhHZ+t6V/SL0/ABoN5qqpQgiQd7uc1fqWM1PD7fegUVw4vSzrOCkKrGeXxovF2WKl1XE
         eEh+eKrLqSIEY482P97/OTeOlqjQTLV2QcKPR+ighTa29DkiW9nvFFJf4djIQz4H4xd8
         ln7Sn5CJNP0Xne7RPPGXo8KXTCgj7XTe+HVI2KGAtWDB7LwnQ+eKswY2AiyThYGleFrH
         hovW33Tj7GLLJv5SD44rMR0PJJlgIO+gZ7zdbq/w+edfBkuF3vrglZoKN+iWenyb91B6
         LNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzIST6D4qh/UeeyVyUIEezlajru+bQMxBh3mGwFF4Vw=;
        b=Hp7xGcOCBT/ldbO6VvFq4m5sm+iHgYjTBIknx/rZ9Mc50G/djdlYS/NK7OlsTDKj+m
         TlRG9H+wHdHTHzqGAxxXNbsZ+kRDG25I6qIQ/UXZ+KL3jyky7fk7v0+qLSnctBV1KDya
         P6TUcy821+hdVDFkQnx4BFSAPD7JuRuvBukNzyz+d4OtwMVzJBDh/1LzpX2ilta7jn66
         2jrHHvnxePEzBWn1wr4dcvpzmArcTBps0b9S6qBsTIF8Wv5ugwkGHRsWNo94Ae1fZewu
         5MoxwqcRu6PYRPfRLQj1cjqyC/f2IVUszQSTXdcWZtBQY1SdsoEeSRPwJTME4wLyNnES
         BaUg==
X-Gm-Message-State: AOAM533m+3Mi6tq5oEy7DJBVU84eBln9wNqy4p6SjqVFRmqBJ9JcW+Xb
        p+VkD7zthM2CQuJjmk0x4iImtBCoQZZ/Lh5Z4daHuHuVoDE=
X-Google-Smtp-Source: ABdhPJwCrzf2ZRawnl3poKgJdO2zF3UgnW6AaOtvLvLGlH/XAfOc3298eV6oiSUXOwlM2UrLmN8djBjXT2NT2oA7Yf0=
X-Received: by 2002:a4a:d2d8:: with SMTP id j24mr3498459oos.82.1597948774387;
 Thu, 20 Aug 2020 11:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com> <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice> <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
 <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
 <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com> <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
 <68478297-ff21-fa38-a37b-2e1e515fdc5e@amd.com> <CALMp9eQDuwzxdLXndnq9FZfDXaNS7U36WDW7CqixjVBareYAwQ@mail.gmail.com>
In-Reply-To: <CALMp9eQDuwzxdLXndnq9FZfDXaNS7U36WDW7CqixjVBareYAwQ@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Aug 2020 11:39:23 -0700
Message-ID: <CALMp9eRXvM9un1LVsuMZqE6aKSzdxp+UXAMrZS1RD-jxEdZqZg@mail.gmail.com>
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

On Thu, Aug 20, 2020 at 11:38 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Thu, Aug 20, 2020 at 11:34 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 8/20/20 11:30 AM, Tom Lendacky wrote:
> > > On 8/20/20 11:17 AM, Tom Lendacky wrote:
> > >> On 8/20/20 10:55 AM, Andy Lutomirski wrote:
> > >>> On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com>
> > >>> wrote:
> > >>>>
> > >>>> On 8/20/20 10:10 AM, Sean Christopherson wrote:
> > >>>>> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
> > >>>>>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org>
> > >>>>>> wrote:
> > >>>>>>>
> > >>>>>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky
> > >>>>>>> <thomas.lendacky@amd.com> wrote:
> > >>>>>>>>
> > >>>>>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
> > >>>>>>>>> It looks like the FSGSBASE support is crashing my second
> > >>>>>>>>> generation EPYC
> > >>>>>>>>> system. I was able to bisect it to:
> > >>>>>>>>>
> > >>>>>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and
> > >>>>>>>>> add a chicken bit")
> > >>>>>>>>>
> > >>>>>>>>> The panic only happens when using KVM. Doing kernel builds or stress
> > >>>>>>>>> on bare-metal appears fine. But if I fire up, in this case, a
> > >>>>>>>>> 64-vCPU
> > >>>>>>>>> guest and do a kernel build within the guest, I get the following:
> > >>>>>>>>
> > >>>>>>>> I should clarify that this panic is on the bare-metal system, not
> > >>>>>>>> in the
> > >>>>>>>> guest. And that specifying nofsgsbase on the bare-metal command
> > >>>>>>>> line fixes
> > >>>>>>>> the issue.
> > >>>>>>>
> > >>>>>>> I certainly see some oddities:
> > >>>>>>>
> > >>>>>>> We have this code:
> > >>>>>>>
> > >>>>>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> > >>>>>>> {
> > >>>>>>>           struct vcpu_svm *svm = to_svm(vcpu);
> > >>>>>>>           int i;
> > >>>>>>>
> > >>>>>>>           avic_vcpu_put(vcpu);
> > >>>>>>>
> > >>>>>>>           ++vcpu->stat.host_state_reload;
> > >>>>>>>           kvm_load_ldt(svm->host.ldt);
> > >>>>>>> #ifdef CONFIG_X86_64
> > >>>>>>>           loadsegment(fs, svm->host.fs);
> > >>>>>>>           wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> > >>>>>
> > >>>>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
> > >>>>>
> > >>>>>        current_save_fsgs();
> > >>>>
> > >>>> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
> > >>>> current->thread.gsbase value to a new variable in the svm struct. I then
> > >>>> used that variable in the wrmsrl below, but it still crashed.
> > >>>
> > >>> Can you try bisecting all the way back to:
> > >>>
> > >>> commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
> > >>> Author: Andy Lutomirski <luto@kernel.org>
> > >>> Date:   Thu May 28 16:13:48 2020 -0400
> > >>>
> > >>>      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
> > >>>
> > >>> and adding the unsafe_fsgsbase command line option while you bisect.
> > >>
> > >> I'll give that a try.
> >
> > Bisecting with unsafe_fsgsbase identified:
> >
> > c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
> >
> > But I'm thinking that could be because it starts using GET_PERCPU_BASE,
> > which on Rome would use RDPID. So is SVM restoring TSC_AUX_MSR too late?
> > That would explain why I don't see the issue on Naples, which doesn't
> > support RDPID.
>
> It looks to me like SVM loads the guest TSC_AUX from vcpu_load to
> vcpu_put, with this comment:
>
> /* This assumes that the kernel never uses MSR_TSC_AUX */
> if (static_cpu_has(X86_FEATURE_RDTSCP))
>         wrmsrl(MSR_TSC_AUX, svm->tsc_aux);

Correction: It never restores TSC_AUX, AFAICT.
