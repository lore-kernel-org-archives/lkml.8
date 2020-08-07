Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50172086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cuta9FDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHGMI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHGMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:08:24 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8577C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 05:08:24 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so1711515oid.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ay16CW272QYTKkAOwUiRs236ospoi7GV3k++PHOMjNM=;
        b=Cuta9FDJbicH7ciZGUJOHWchBBbaLqjwqa0uPBtbSTLSxIyX/sx7nXURWR+O73KTVZ
         /I/eGITHvvT326sPFg6eATE+mfgY9SdUDTsZgbpZa2RdLfKr5fWpR4Dp7JRJ5BByC8J4
         WC7GxBqSciBBf4tPsSWNsdWfmvn73GoUj9Kp4okfExPkQL0PXhSAz30AEDs5CNeU8bDT
         LIPE7BIFbHF/lJZ7EJi1iblRRKYFMu4H3/r6QeQ9n8GrzsGrD9P0JcIxTo+l33ktORWy
         UoXXTK5TKopRw/biRd9PfLpI8F+2vdRQrdpB+iA6/F06qOzkzpNUsStbBprQag30FK7h
         e1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ay16CW272QYTKkAOwUiRs236ospoi7GV3k++PHOMjNM=;
        b=hEvjTne743DCQC4oHlCmSwNYBCKg6G0mVDsTjU5wzHgnfQCsyt/950Otq23Zf8yoKQ
         Rxm7DMuNr98qZNaGfSHB51JfPNSF3YbNqlm+7a7LLzKUvdV3nwYXmMOuoel7RSvyQxiE
         wKfpONTbk8Dyr/DBHYQH9RWKCz+6gUa6xrTVyBLOef6R9k+fRm0mQ2WNHLDjNkDPFwLn
         m0LA0GhwL7XqLZXX8+LB+a4juzirifSWndKPOQQ4rfdCzsiugJvnzFQt9g1bKlZIAnxX
         tIBwqSRhTa/4C87EInz9VZkS+HYPEmkAaPXTuZo9fSWSb7S+eF5++1dhrjOOZNd4SFD+
         hvsw==
X-Gm-Message-State: AOAM533se0N6SE5MjAQDApfyDgKnYWqbgP7E1doIhkyWlm9hnQNn9XGF
        WUdmK07B1oyrIIzo6qhq3h6M19lgnVY4/5uCx5mC+g==
X-Google-Smtp-Source: ABdhPJyRdcFmIssEsapW4/CLzNwi/Y/cKSJJGB/i43zf3rjk+ahPgoq1BYX0ZRbxh3JmHf3qEpFRsZunBdCj2xkmaAc=
X-Received: by 2002:aca:b8c4:: with SMTP id i187mr11210808oif.121.1596802103701;
 Fri, 07 Aug 2020 05:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com> <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com> <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com> <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com> <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
In-Reply-To: <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Aug 2020 14:08:11 +0200
Message-ID: <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
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

On Fri, 7 Aug 2020 at 14:04, J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote:
>
> On 07.08.20 13:38, Marco Elver wrote:
> > On Fri, Aug 07, 2020 at 12:35PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> >> On 07.08.20 11:50, Marco Elver wrote:
> >>> On Fri, Aug 07, 2020 at 11:24AM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> >>>> On 07.08.20 11:01, Marco Elver wrote:
> >>>>> On Thu, 6 Aug 2020 at 18:06, Marco Elver <elver@google.com> wrote:
> >>>>>> On Thu, 6 Aug 2020 at 15:17, Marco Elver <elver@google.com> wrote:
> >>>>>>> On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wrote=
:
> >>>>>>>> On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> >>>>>>>>> Testing my hypothesis that raw then nested non-raw
> >>>>>>>>> local_irq_save/restore() breaks IRQ state tracking -- see the r=
eproducer
> >>>>>>>>> below. This is at least 1 case I can think of that we're bound =
to hit.
> >>>>>>> ...
> >>>>>>>>
> >>>>>>>> /me goes ponder things...
> >>>>>>>>
> >>>>>>>> How's something like this then?
> >>>>>>>>
> >>>>>>>> ---
> >>>>>>>>     include/linux/sched.h |  3 ---
> >>>>>>>>     kernel/kcsan/core.c   | 62 +++++++++++++++++++++++++++++++++=
+++---------------
> >>>>>>>>     2 files changed, 44 insertions(+), 21 deletions(-)
> >>>>>>>
> >>>>>>> Thank you! That approach seems to pass syzbot (also with
> >>>>>>> CONFIG_PARAVIRT) and kcsan-test tests.
> >>>>>>>
> >>>>>>> I had to modify it some, so that report.c's use of the restore lo=
gic
> >>>>>>> works and not mess up the IRQ trace printed on KCSAN reports (wit=
h
> >>>>>>> CONFIG_KCSAN_VERBOSE).
> >>>>>>>
> >>>>>>> I still need to fully convince myself all is well now and we don'=
t end
> >>>>>>> up with more fixes. :-) If it passes further testing, I'll send i=
t as a
> >>>>>>> real patch (I want to add you as Co-developed-by, but would need =
your
> >>>>>>> Signed-off-by for the code you pasted, I think.)
> >>>>>
> >>>>> I let it run on syzbot through the night, and it's fine without
> >>>>> PARAVIRT (see below). I have sent the patch (need your Signed-off-b=
y
> >>>>> as it's based on your code, thank you!):
> >>>>> https://lkml.kernel.org/r/20200807090031.3506555-1-elver@google.com
> >>>>>
> >>>>>> With CONFIG_PARAVIRT=3Dy (without the notrace->noinstr patch), I s=
till
> >>>>>> get lockdep DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled()), alth=
ough
> >>>>>> it takes longer for syzbot to hit them. But I think that's expecte=
d
> >>>>>> because we can still get the recursion that I pointed out, and wil=
l
> >>>>>> need that patch.
> >>>>>
> >>>>> Never mind, I get these warnings even if I don't turn on KCSAN
> >>>>> (CONFIG_KCSAN=3Dn). Something else is going on with PARAVIRT=3Dy th=
at
> >>>>> throws off IRQ state tracking. :-/
> >>>>
> >>>> What are the settings of CONFIG_PARAVIRT_XXL and
> >>>> CONFIG_PARAVIRT_SPINLOCKS in this case?
> >>>
> >>> I attached a config.
> >>>
> >>>     $> grep PARAVIRT .config
> >>>     CONFIG_PARAVIRT=3Dy
> >>>     CONFIG_PARAVIRT_XXL=3Dy
> >>>     # CONFIG_PARAVIRT_DEBUG is not set
> >>>     CONFIG_PARAVIRT_SPINLOCKS=3Dy
> >>>     # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> >>>     CONFIG_PARAVIRT_CLOCK=3Dy
> >>
> >> Anything special I need to do to reproduce the problem? Or would you b=
e
> >> willing to do some more rounds with different config settings?
> >
> > I can only test it with syzkaller, but that probably doesn't help if yo=
u
> > don't already have it set up. It can't seem to find a C reproducer.
> >
> > I did some more rounds with different configs.
> >
> >> I think CONFIG_PARAVIRT_XXL shouldn't matter, but I'm not completely
> >> sure about that. CONFIG_PARAVIRT_SPINLOCKS would be my primary suspect=
.
> >
> > Yes, PARAVIRT_XXL doesn't make a different. When disabling
> > PARAVIRT_SPINLOCKS, however, the warnings go away.
>
> Thanks for testing!
>
> I take it you are doing the tests in a KVM guest?

Yes, correct.

> If so I have a gut feeling that the use of local_irq_save() and
> local_irq_restore() in kvm_wait() might be fishy. I might be completely
> wrong here, though.

Happy to help debug more, although I might need patches or pointers
what to play with.

> BTW, I think Xen's variant of pv spinlocks is fine (no playing with IRQ
> on/off).
>
> Hyper-V seems to do the same as KVM, and kicking another vcpu could be
> problematic as well, as it is just using IPI.
>
>
> Juergen
