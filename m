Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F255C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469B520772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wrc1qF1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHKHBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgHKHAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:00:54 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522ECC061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:00:45 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q9so9322744oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F1s+Ab0YJ1nRhabDcWGJ1wJlu8nr2OTHTQ8v81zx/uE=;
        b=Wrc1qF1AQOvTNmFWYlD5IE1ogh61vHRHEXQ/B0lLUhn9IzByX4qyvYlGEHEzvIH44s
         Q9AJP3rfMH3F4O2pQZWdUdl9ZouuW+xsM7nxqvJSZ2K4nKZsGFCOmO5zYQ9B0UpCknlb
         CeKptQ0HQNEtz1XO4+IJKGQoxOt1lv8Ht/rtcvrj8E2tajKajvmk/iwbzwa73Z68Aw1p
         5n1/q1DqlHPj2MdTYHiyRRVAwDk8rhZpdBEZQmETT50ABfjOwaeob/3K5TTvbM+q6hiO
         efXrkKaWkUv7EtMW44sGD3iMvq4ChGJ1dlgLLA3vGmnIvs+00KCczQvRaAGJGMPCu5o4
         YbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F1s+Ab0YJ1nRhabDcWGJ1wJlu8nr2OTHTQ8v81zx/uE=;
        b=m8pU3jgt5FmIgdkS9G9tEiRMlZIH3Zrfw90HeuhaW7JislQoL2U07TIS9szPYNjzfK
         bHM8CTRCvXcnR0QtSv5dzvZeTkm1ga4CL5/vKVr/SNfyPWaTfTbFvkrm3NlM56qbjInF
         yh0pZQuWg0WH0xiJe6FQoDpvaqGMcfWODMi2toIGr3HTuFWleT/z14QZsggSoBwQ9IUQ
         u1JiObRoOyW3naAOPkOZI7DaBH0BAXZqG+YbitinqdXQ8OyQdPlnnJfdVVXen4l6bEzN
         vpeSqtvskWQp1zpgcFL1pm3Rn24wtZffqPS13ejp7YAwJxRFQlUKrxlqg37GWWtU6j8e
         SM+Q==
X-Gm-Message-State: AOAM532P1r+OxR8TDChq9F7tI+xU2h2VRW8GycYUFS6qpKx/sUCVSJBm
        SwqgtaasHyX45Fe24gWjKEYwQrrflrlzJGWOAbhj6A==
X-Google-Smtp-Source: ABdhPJyw0ORqzqz1wN04C1DgUN5w3KliTPyqnR0su4kIK2XLa3HLEhT43HAO33CyzVK60DqMZizXKWSrtrKa82yjebw=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr3522264otr.251.1597129244426;
 Tue, 11 Aug 2020 00:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com> <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com> <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com> <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com> <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
In-Reply-To: <20200807151903.GA1263469@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 11 Aug 2020 09:00:32 +0200
Message-ID: <CANpmjNM1jASqCFYZpteVrZCa2V2D_DbXaqvoCV_Ac2boYfDXnQ@mail.gmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, yu-cheng.yu@intel.com,
        sdeep@vmware.com, virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 at 17:19, Marco Elver <elver@google.com> wrote:
> On Fri, Aug 07, 2020 at 02:08PM +0200, Marco Elver wrote:
> > On Fri, 7 Aug 2020 at 14:04, J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wr=
ote:
> > >
> > > On 07.08.20 13:38, Marco Elver wrote:
> > > > On Fri, Aug 07, 2020 at 12:35PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
...
> > > >> I think CONFIG_PARAVIRT_XXL shouldn't matter, but I'm not complete=
ly
> > > >> sure about that. CONFIG_PARAVIRT_SPINLOCKS would be my primary sus=
pect.
> > > >
> > > > Yes, PARAVIRT_XXL doesn't make a different. When disabling
> > > > PARAVIRT_SPINLOCKS, however, the warnings go away.
> > >
> > > Thanks for testing!
> > >
> > > I take it you are doing the tests in a KVM guest?
> >
> > Yes, correct.
> >
> > > If so I have a gut feeling that the use of local_irq_save() and
> > > local_irq_restore() in kvm_wait() might be fishy. I might be complete=
ly
> > > wrong here, though.
> >
> > Happy to help debug more, although I might need patches or pointers
> > what to play with.
> >
> > > BTW, I think Xen's variant of pv spinlocks is fine (no playing with I=
RQ
> > > on/off).
> > >
> > > Hyper-V seems to do the same as KVM, and kicking another vcpu could b=
e
> > > problematic as well, as it is just using IPI.
>
> I experimented a bit more, and the below patch seems to solve the
> warnings. However, that was based on your pointer about kvm_wait(), and
> I can't quite tell if it is the right solution.
>
> My hypothesis here is simply that kvm_wait() may be called in a place
> where we get the same case I mentioned to Peter,
>
>         raw_local_irq_save(); /* or other IRQs off without tracing */
>         ...
>         kvm_wait() /* IRQ state tracing gets confused */
>         ...
>         raw_local_irq_restore();
>
> and therefore, using raw variants in kvm_wait() works. It's also safe
> because it doesn't call any other libraries that would result in corrupt
> IRQ state AFAIK.

Just to follow-up, it'd still be nice to fix this. Suggestions?

I could send the below as a patch, but can only go off my above
hypothesis and the fact that syzbot is happier, so not entirely
convincing.

Thanks,
-- Marco

> ------ >8 ------
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 233c77d056c9..1d412d1466f0 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -797,7 +797,7 @@ static void kvm_wait(u8 *ptr, u8 val)
>         if (in_nmi())
>                 return;
>
> -       local_irq_save(flags);
> +       raw_local_irq_save(flags);
>
>         if (READ_ONCE(*ptr) !=3D val)
>                 goto out;
> @@ -810,10 +810,10 @@ static void kvm_wait(u8 *ptr, u8 val)
>         if (arch_irqs_disabled_flags(flags))
>                 halt();
>         else
> -               safe_halt();
> +               raw_safe_halt();
>
>  out:
> -       local_irq_restore(flags);
> +       raw_local_irq_restore(flags);
>  }
>
>  #ifdef CONFIG_X86_32
