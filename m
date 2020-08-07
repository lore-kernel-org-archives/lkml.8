Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1689DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89B021744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TujP8TuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgHGPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:19:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F543C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:19:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so2013877wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jHwuEBD3ANfATNEay78Qrd/CFOLdfE4qFBZzKEVtZCA=;
        b=TujP8TuZR2DpKwyBOeQllZVWSln2kvXwLMBXX49z/O6xe8jGbNkhvXxcP1NQpUJylO
         UgBfvD6zY2Qu8xw9xJ2ntvw4vVgZ8nU4vFOujvRjS/L+dWCS2adTEUBik1qmKpj6hIJb
         p21G4Ojwu/Nm0P/4P6pUgmfcwPn2wx9rqnBBJc3zj4wk+hIAdczTrLW5jVEAnBfvF43N
         xRlG6WyCI5vwTQHyN4TzY60sCoieCzDaOxrwlmHeTztaztrsARkjWz4UpuBMgDGGdHUi
         e4tpzaME4K7qlDiuJMKVCwC6sDWfpGnq49jIdIe3hQpSQJNzDdt6BvRoNAELSgBepZD9
         1KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jHwuEBD3ANfATNEay78Qrd/CFOLdfE4qFBZzKEVtZCA=;
        b=h06YaB6HUJ1zLQsnG2mGT7C66RpLdZq8Pz/inMZ20xJtB8scGq8wNhCr65sj5Me5GW
         fNYHlfafxNDwYtn1oUUnp2LqJ0KVwlBx/GOT/uS1GebWXKEETC/eao5urEF4jayO74Es
         VtoWu5RDZkSJ5vk51TAY8+iZGRBXDXIRPIQBkDbJsaOmjmv9w2ebLOXmzhsZ1lncpzrj
         IrwGkcYHKILtfGJRRqZ3dCX49atZyY9yh/p8eBwG0fIsvzwneGzll1mOqbq6jaaOmpnJ
         LjbakBmQe+FL8BgOUmvgKM0r+pD79xe6IiyRXJbZdfDNCxgLCmbV1HtpPgySwPJqF9eK
         T74Q==
X-Gm-Message-State: AOAM533hDURvBWKYgRuggNPPUxt2C9o4ad5iyMQBQGv5I14YDPRTVzIS
        RXI3dsC7rXWHABv3IyZ9ZxSOQRO/Ung=
X-Google-Smtp-Source: ABdhPJyaZVsj/LF4r8nUhCFL1vL9/xRwj7Iov/A9RiYqwaHSuuOH9wQsJoBwzeuM3+8RO1bFzHasXg==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr12196021wrq.305.1596813550150;
        Fri, 07 Aug 2020 08:19:10 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 111sm10899976wrc.53.2020.08.07.08.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 08:19:08 -0700 (PDT)
Date:   Fri, 7 Aug 2020 17:19:03 +0200
From:   Marco Elver <elver@google.com>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200807151903.GA1263469@elver.google.com>
References: <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:08PM +0200, Marco Elver wrote:
> On Fri, 7 Aug 2020 at 14:04, J=FCrgen Gro=DF <jgross@suse.com> wrote:
> >
> > On 07.08.20 13:38, Marco Elver wrote:
> > > On Fri, Aug 07, 2020 at 12:35PM +0200, J=FCrgen Gro=DF wrote:
> > >> On 07.08.20 11:50, Marco Elver wrote:
> > >>> On Fri, Aug 07, 2020 at 11:24AM +0200, J=FCrgen Gro=DF wrote:
> > >>>> On 07.08.20 11:01, Marco Elver wrote:
> > >>>>> On Thu, 6 Aug 2020 at 18:06, Marco Elver <elver@google.com> wrote:
> > >>>>>> On Thu, 6 Aug 2020 at 15:17, Marco Elver <elver@google.com> wrot=
e:
> > >>>>>>> On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wro=
te:
> > >>>>>>>> On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> > >>>>>>>>> Testing my hypothesis that raw then nested non-raw
> > >>>>>>>>> local_irq_save/restore() breaks IRQ state tracking -- see the=
 reproducer
> > >>>>>>>>> below. This is at least 1 case I can think of that we're boun=
d to hit.
> > >>>>>>> ...
> > >>>>>>>>
> > >>>>>>>> /me goes ponder things...
> > >>>>>>>>
> > >>>>>>>> How's something like this then?
> > >>>>>>>>
> > >>>>>>>> ---
> > >>>>>>>>     include/linux/sched.h |  3 ---
> > >>>>>>>>     kernel/kcsan/core.c   | 62 +++++++++++++++++++++++++++++++=
+++++---------------
> > >>>>>>>>     2 files changed, 44 insertions(+), 21 deletions(-)
> > >>>>>>>
> > >>>>>>> Thank you! That approach seems to pass syzbot (also with
> > >>>>>>> CONFIG_PARAVIRT) and kcsan-test tests.
> > >>>>>>>
> > >>>>>>> I had to modify it some, so that report.c's use of the restore =
logic
> > >>>>>>> works and not mess up the IRQ trace printed on KCSAN reports (w=
ith
> > >>>>>>> CONFIG_KCSAN_VERBOSE).
> > >>>>>>>
> > >>>>>>> I still need to fully convince myself all is well now and we do=
n't end
> > >>>>>>> up with more fixes. :-) If it passes further testing, I'll send=
 it as a
> > >>>>>>> real patch (I want to add you as Co-developed-by, but would nee=
d your
> > >>>>>>> Signed-off-by for the code you pasted, I think.)
> > >>>>>
> > >>>>> I let it run on syzbot through the night, and it's fine without
> > >>>>> PARAVIRT (see below). I have sent the patch (need your Signed-off=
-by
> > >>>>> as it's based on your code, thank you!):
> > >>>>> https://lkml.kernel.org/r/20200807090031.3506555-1-elver@google.c=
om
> > >>>>>
> > >>>>>> With CONFIG_PARAVIRT=3Dy (without the notrace->noinstr patch), I=
 still
> > >>>>>> get lockdep DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled()), al=
though
> > >>>>>> it takes longer for syzbot to hit them. But I think that's expec=
ted
> > >>>>>> because we can still get the recursion that I pointed out, and w=
ill
> > >>>>>> need that patch.
> > >>>>>
> > >>>>> Never mind, I get these warnings even if I don't turn on KCSAN
> > >>>>> (CONFIG_KCSAN=3Dn). Something else is going on with PARAVIRT=3Dy =
that
> > >>>>> throws off IRQ state tracking. :-/
> > >>>>
> > >>>> What are the settings of CONFIG_PARAVIRT_XXL and
> > >>>> CONFIG_PARAVIRT_SPINLOCKS in this case?
> > >>>
> > >>> I attached a config.
> > >>>
> > >>>     $> grep PARAVIRT .config
> > >>>     CONFIG_PARAVIRT=3Dy
> > >>>     CONFIG_PARAVIRT_XXL=3Dy
> > >>>     # CONFIG_PARAVIRT_DEBUG is not set
> > >>>     CONFIG_PARAVIRT_SPINLOCKS=3Dy
> > >>>     # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > >>>     CONFIG_PARAVIRT_CLOCK=3Dy
> > >>
> > >> Anything special I need to do to reproduce the problem? Or would you=
 be
> > >> willing to do some more rounds with different config settings?
> > >
> > > I can only test it with syzkaller, but that probably doesn't help if =
you
> > > don't already have it set up. It can't seem to find a C reproducer.
> > >
> > > I did some more rounds with different configs.
> > >
> > >> I think CONFIG_PARAVIRT_XXL shouldn't matter, but I'm not completely
> > >> sure about that. CONFIG_PARAVIRT_SPINLOCKS would be my primary suspe=
ct.
> > >
> > > Yes, PARAVIRT_XXL doesn't make a different. When disabling
> > > PARAVIRT_SPINLOCKS, however, the warnings go away.
> >
> > Thanks for testing!
> >
> > I take it you are doing the tests in a KVM guest?
>=20
> Yes, correct.
>=20
> > If so I have a gut feeling that the use of local_irq_save() and
> > local_irq_restore() in kvm_wait() might be fishy. I might be completely
> > wrong here, though.
>=20
> Happy to help debug more, although I might need patches or pointers
> what to play with.
>=20
> > BTW, I think Xen's variant of pv spinlocks is fine (no playing with IRQ
> > on/off).
> >
> > Hyper-V seems to do the same as KVM, and kicking another vcpu could be
> > problematic as well, as it is just using IPI.

I experimented a bit more, and the below patch seems to solve the
warnings. However, that was based on your pointer about kvm_wait(), and
I can't quite tell if it is the right solution.

My hypothesis here is simply that kvm_wait() may be called in a place
where we get the same case I mentioned to Peter,

	raw_local_irq_save(); /* or other IRQs off without tracing */
	...
	kvm_wait() /* IRQ state tracing gets confused */
	...
	raw_local_irq_restore();

and therefore, using raw variants in kvm_wait() works. It's also safe
because it doesn't call any other libraries that would result in corrupt
IRQ state AFAIK.

Thanks,
-- Marco

------ >8 ------

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 233c77d056c9..1d412d1466f0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -797,7 +797,7 @@ static void kvm_wait(u8 *ptr, u8 val)
 	if (in_nmi())
 		return;
=20
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
=20
 	if (READ_ONCE(*ptr) !=3D val)
 		goto out;
@@ -810,10 +810,10 @@ static void kvm_wait(u8 *ptr, u8 val)
 	if (arch_irqs_disabled_flags(flags))
 		halt();
 	else
-		safe_halt();
+		raw_safe_halt();
=20
 out:
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
=20
 #ifdef CONFIG_X86_32
