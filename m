Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE6BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B960420781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5nOfASC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgFWSj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733291AbgFWSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:39:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3073C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:39:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l9so5651700ilq.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMSXyImcuZBfchMfbTmyyDTCpqvru9kfQ2n1P5epXmU=;
        b=E5nOfASCg0KLZfYJnx0RJBrvw0hgcvN7agf/yEALoOKoOyqGyeo3GlF7vqZCUrEiIG
         jRd0GMymTl2YWbQTClWJejZ5GGd///O97/aV/0gtqbPe5RnmLLIOkGdYXAVQuNqHCqs7
         ZvH1YD9BnuVTb5ug86OCQpg7SBm54T6Cy9VdyUdQu8MMK7RQeBSIIkt2eXu7hp136ZOI
         ilAkCuJ85pz6Wuh+oiozpw0Pz0+MgkDbQw1UsJjqUeHepSjJyrvwKSUUYGggdNv17iCe
         iHkPhSEhV5F8Z1v96uSmRoU0pvlttTsVgI7o/GnpsV1WTeIeJRue/PFkFMQoaMJ8VIf7
         ErLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMSXyImcuZBfchMfbTmyyDTCpqvru9kfQ2n1P5epXmU=;
        b=slsuTTd8I4NsQqqmHYl/Jazsk9bJnDrr1Ls219Ztm8D68qbwv06WAZPd/M3QA8zm8U
         eUOyhkSUj8yUG2W0A6JJqs5Gp+Ml66o8S+JijQRnD7LSLADV9BZ8mkakaT+dz8Z8z8xF
         ACev/YcFXI7So5Zs0IWbKoByuiRMA89P145zy8/VIEyaBmBxEN1CMQQT3fwmMWW//5YV
         1yhEitY8PZd2yc+55qE7KQo8x23ZX0Kh3r3eNEJlBqz0KYwzlCzi4P/EJ3UspmSXHqel
         eHOjkO4zBO+o9aKSoKowzeE22IhjFGcCAQOMfKC7E3bh/UeswA94OIBlv4xhPfNgMLBU
         wpyg==
X-Gm-Message-State: AOAM530bykmNjsjrY6uYCj7Smz+pnDClLBE7I8uiMR1iH+Od8O6EEDTH
        9pwg1yZVEd7Ho7GbiPAvm/sgS4utpuwV+FTKYH5BSg==
X-Google-Smtp-Source: ABdhPJzaVCgxNpWBznUqrKseKsAXasxfjsVvnbxT8NFZdObtFa5g4xVCLJ/cORy0Q5LOHjGD4eSddehMr0u4RWuZigw=
X-Received: by 2002:a05:6e02:cd:: with SMTP id r13mr18549799ilq.119.1592937567599;
 Tue, 23 Jun 2020 11:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200623063530.81917-1-like.xu@linux.intel.com> <20200623182910.GA24107@linux.intel.com>
In-Reply-To: <20200623182910.GA24107@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 23 Jun 2020 11:39:16 -0700
Message-ID: <CALMp9eQPA40FWBEOiQ8T5JX2fv+uEfU_x6js8WhAguQ8TL6frA@mail.gmail.com>
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

On Tue, Jun 23, 2020 at 11:29 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jun 23, 2020 at 02:35:30PM +0800, Like Xu wrote:
> > The aperf/mperf are used to report current CPU frequency after 7d5905dc14a
> > "x86 / CPU: Always show current CPU frequency in /proc/cpuinfo". But guest
> > kernel always reports a fixed VCPU frequency in the /proc/cpuinfo, which
> > may confuse users especially when turbo is enabled on the host.
> >
> > Emulate guest APERF/MPERF capability based their values on the host.
> >
> > Co-developed-by: Li RongQing <lirongqing@baidu.com>
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > Reviewed-by: Chai Wen <chaiwen@baidu.com>
> > Reviewed-by: Jia Lina <jialina01@baidu.com>
> > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > ---
>
> ...
>
> > @@ -8312,7 +8376,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >               dm_request_for_irq_injection(vcpu) &&
> >               kvm_cpu_accept_dm_intr(vcpu);
> >       fastpath_t exit_fastpath;
> > -
> > +     u64 enter_mperf = 0, enter_aperf = 0, exit_mperf = 0, exit_aperf = 0;
> >       bool req_immediate_exit = false;
> >
> >       if (kvm_request_pending(vcpu)) {
> > @@ -8516,8 +8580,17 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >               vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
> >       }
> >
> > +     if (unlikely(vcpu->arch.hwp.hw_coord_fb_cap))
> > +             get_host_amperf(&enter_mperf, &enter_aperf);
> > +
> >       exit_fastpath = kvm_x86_ops.run(vcpu);
> >
> > +     if (unlikely(vcpu->arch.hwp.hw_coord_fb_cap)) {
> > +             get_host_amperf(&exit_mperf, &exit_aperf);
> > +             vcpu_update_amperf(vcpu, get_amperf_delta(enter_aperf, exit_aperf),
> > +                     get_amperf_delta(enter_mperf, exit_mperf));
> > +     }
> > +
>
> Is there an alternative approach that doesn't require 4 RDMSRs on every VMX
> round trip?  That's literally more expensive than VM-Enter + VM-Exit
> combined.
>
> E.g. what about adding KVM_X86_DISABLE_EXITS_APERF_MPERF and exposing the
> MSRs for read when that capability is enabled?

When would you load the hardware MSRs with the guest/host values?
