Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522B22072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jS7aQ3o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbgFWUej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391546AbgFWUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2272C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:34:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i25so25528713iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUiCHEG4ixMC5q0G/sMhdsDeiOjcEJ6AH6URjseTZ2I=;
        b=jS7aQ3o7RZ0sGf7Y6qNQMZ73+JgsgYaV6djG8um9Xh0EJx3rlZHQq9i1WM8uSYY7L7
         3UuWr3RTyQQALhaPmjJFrCRQWjiA4oyuIkj4MrE8gCT+yjWOo4+QFz6XBPeWMRkjR0B6
         S44OQf0pHhD2hYe/8iFO/qAepNbPD7AZjGmUFicmouMAuAB2eZPuMG0B5qTmXtU88viJ
         d7nXJ1B8DACEohbJSj4vQuwC1qEnZH9y84RQSEguVuQw6/GIJ169SJKIppfkb4QCpRFT
         fOLmxWuc5o4LyfCm3z6PgWlob05vqqzyCsxClnr3yIx+iOUf2zUAN9kR3ZTBtC+DN3lW
         MGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUiCHEG4ixMC5q0G/sMhdsDeiOjcEJ6AH6URjseTZ2I=;
        b=F1rgPxP8boZ5cZrtybVNjXhFO8OnELDeZxpj8FVvb+XIWYVclamIcfJwHK7uSOmj3O
         P+uB0RYULJbjcitEFp3FbZ0+PsUIvwgAP9QBQQCkrC7DQyXsQYDnwbdMsXNEly+Dhcyk
         Tv/8Gt1qebgAhv0/0UFy7E8+VRMS5t0mB/PdOrDIXAIf7B6551R25CFFrfiiHDsyGov3
         MkIXN9uFYDfpa2Sgse4sKO9oKxSMPwh8jJyaTRcpOENbtkZCY2wL7Qb8ZB/qFIkP/VLh
         zz49QXuxluM0JPCkXJqN+mCPvhO86N+btBYvme71d2RUE94i6je5ewYfJP62D0N8Bd2d
         h8pg==
X-Gm-Message-State: AOAM533jpcGdkozJRGOtRR2iujOidT7427QJUtAN1x1c4foNxJ3e2hlh
        yRWeuzEuo6sALjjpLYRxMQyQj9H0hbEUKLRBsPxbCw==
X-Google-Smtp-Source: ABdhPJwfm8XDqnBkXmZM+wEVnYTzuqs80hrvV6imIFZdo26vR5Av0UBgP+Vt1OTBs2oIXFx+rhbDdEZ6diDAEaWeESA=
X-Received: by 2002:a05:6638:979:: with SMTP id o25mr24234722jaj.24.1592944471021;
 Tue, 23 Jun 2020 13:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200623063530.81917-1-like.xu@linux.intel.com>
 <20200623182910.GA24107@linux.intel.com> <CALMp9eQPA40FWBEOiQ8T5JX2fv+uEfU_x6js8WhAguQ8TL6frA@mail.gmail.com>
 <20200623190504.GC24107@linux.intel.com>
In-Reply-To: <20200623190504.GC24107@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 23 Jun 2020 13:34:19 -0700
Message-ID: <CALMp9eTYKQ3LrWKu32mJKPzkWMcN5tGSFmj352TPCSrSp7jGxw@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Emulate APERF/MPERF to report actual VCPU frequency
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, wei.huang2@amd.com,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Li RongQing <lirongqing@baidu.com>,
        Chai Wen <chaiwen@baidu.com>, Jia Lina <jialina01@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:05 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jun 23, 2020 at 11:39:16AM -0700, Jim Mattson wrote:
> > On Tue, Jun 23, 2020 at 11:29 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Tue, Jun 23, 2020 at 02:35:30PM +0800, Like Xu wrote:
> > > > The aperf/mperf are used to report current CPU frequency after 7d5905dc14a
> > > > "x86 / CPU: Always show current CPU frequency in /proc/cpuinfo". But guest
> > > > kernel always reports a fixed VCPU frequency in the /proc/cpuinfo, which
> > > > may confuse users especially when turbo is enabled on the host.
> > > >
> > > > Emulate guest APERF/MPERF capability based their values on the host.
> > > >
> > > > Co-developed-by: Li RongQing <lirongqing@baidu.com>
> > > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > > Reviewed-by: Chai Wen <chaiwen@baidu.com>
> > > > Reviewed-by: Jia Lina <jialina01@baidu.com>
> > > > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > > > ---
> > >
> > > ...
> > >
> > > > @@ -8312,7 +8376,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> > > >               dm_request_for_irq_injection(vcpu) &&
> > > >               kvm_cpu_accept_dm_intr(vcpu);
> > > >       fastpath_t exit_fastpath;
> > > > -
> > > > +     u64 enter_mperf = 0, enter_aperf = 0, exit_mperf = 0, exit_aperf = 0;
> > > >       bool req_immediate_exit = false;
> > > >
> > > >       if (kvm_request_pending(vcpu)) {
> > > > @@ -8516,8 +8580,17 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> > > >               vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
> > > >       }
> > > >
> > > > +     if (unlikely(vcpu->arch.hwp.hw_coord_fb_cap))
> > > > +             get_host_amperf(&enter_mperf, &enter_aperf);
> > > > +
> > > >       exit_fastpath = kvm_x86_ops.run(vcpu);
> > > >
> > > > +     if (unlikely(vcpu->arch.hwp.hw_coord_fb_cap)) {
> > > > +             get_host_amperf(&exit_mperf, &exit_aperf);
> > > > +             vcpu_update_amperf(vcpu, get_amperf_delta(enter_aperf, exit_aperf),
> > > > +                     get_amperf_delta(enter_mperf, exit_mperf));
> > > > +     }
> > > > +
> > >
> > > Is there an alternative approach that doesn't require 4 RDMSRs on every VMX
> > > round trip?  That's literally more expensive than VM-Enter + VM-Exit
> > > combined.
> > >
> > > E.g. what about adding KVM_X86_DISABLE_EXITS_APERF_MPERF and exposing the
> > > MSRs for read when that capability is enabled?
> >
> > When would you load the hardware MSRs with the guest/host values?
>
> Ugh, I was thinking the MSRs were read-only.

EVen if they were read-only, they should power on to zero, and they
will most likely not be zero when a guest powers on.

> Doesn't this also interact with TSC scaling?

Yes, it should!
