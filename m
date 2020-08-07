Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D19C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DD222C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRsQjOfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgHGLit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHGLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:38:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 04:38:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q76so1538843wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2OvNGf73HwASsIIn3dVColNmerzHMlfHRu2Q37hp8fA=;
        b=XRsQjOfjF/jdZJQeBdPMyTohXnpRCVKgc7tSZM7ojE226DzwExG7JRV2o5LQyjIpQE
         OIWfbjF1MX/R0TrbKwaJoBnTGHlkhkkIwmABm+25ISDXuxNi+98CMmhUnXEaBF4PODSL
         a1+IhaDGtL3pnU4QIGaSGni6MWKZLVIy2kx6YYlP43ZKkbXm63ZLGBqcbB5oXEMrBKTl
         We5fhSE7oxpKkXf49apFvZA0fX+N+RYiQEGshMZgRjl0KxqgR5qy4isLQvE2j//6nySE
         X0eNE3O1hVDFrZZcI9XCVQDph/01xCcaMfdSxhEJVdCN8JDmDnPVgzmTb3PjAZeBF+Xg
         eb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2OvNGf73HwASsIIn3dVColNmerzHMlfHRu2Q37hp8fA=;
        b=DliRxH21hd6C3AvsM5+CyhizOCN5suc1lNDBiyd8weL+2GzQkLbKX9P+WH55Tay2O9
         2zJMT81nS9obRb8ahP7TEMRJFDw5neGAuP2d9a06S/ddicvMDCn/9qjobQXlMuM+RNam
         eEY+Hul3an6wAidnYA7oOCpEKigstR/R/ZfhmCUAWtg4S+264TkaSI8tFIL+BAk+DYYB
         Ir21AsI2/MUA349LkbxsNNN2ZPLDPxMn9f7cSDYAQYmHwodofDi3NPGuEp9FAxSs/zHz
         c9o0C19+3/tjsbjb2ZFVly370eBp10tuh1+1nEmbM42AnoCkbtvhpjRpko82bUcE20Hc
         61Cw==
X-Gm-Message-State: AOAM530zbSE5teHuA9D/EZpWsuDj6tkc2+hGx/o+jPsFmRHLnS1msvJW
        VpDpreUPEVAtvmr2v9IwaZ5joQ==
X-Google-Smtp-Source: ABdhPJwPVgRQpJPW5tGBGYX0Uzt3l53hhFUnwetA4tIJc4edGGxc8mzGNJF8DhrMGT+O6qsBSdYsEw==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr11991182wme.14.1596800325696;
        Fri, 07 Aug 2020 04:38:45 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id g14sm9823063wmk.37.2020.08.07.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 04:38:44 -0700 (PDT)
Date:   Fri, 7 Aug 2020 13:38:38 +0200
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
Message-ID: <20200807113838.GA3547125@elver.google.com>
References: <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com>
 <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 12:35PM +0200, J=FCrgen Gro=DF wrote:
> On 07.08.20 11:50, Marco Elver wrote:
> > On Fri, Aug 07, 2020 at 11:24AM +0200, J=FCrgen Gro=DF wrote:
> > > On 07.08.20 11:01, Marco Elver wrote:
> > > > On Thu, 6 Aug 2020 at 18:06, Marco Elver <elver@google.com> wrote:
> > > > > On Thu, 6 Aug 2020 at 15:17, Marco Elver <elver@google.com> wrote:
> > > > > > On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wro=
te:
> > > > > > > On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> > > > > > > > Testing my hypothesis that raw then nested non-raw
> > > > > > > > local_irq_save/restore() breaks IRQ state tracking -- see t=
he reproducer
> > > > > > > > below. This is at least 1 case I can think of that we're bo=
und to hit.
> > > > > > ...
> > > > > > >=20
> > > > > > > /me goes ponder things...
> > > > > > >=20
> > > > > > > How's something like this then?
> > > > > > >=20
> > > > > > > ---
> > > > > > >    include/linux/sched.h |  3 ---
> > > > > > >    kernel/kcsan/core.c   | 62 +++++++++++++++++++++++++++++++=
+++++---------------
> > > > > > >    2 files changed, 44 insertions(+), 21 deletions(-)
> > > > > >=20
> > > > > > Thank you! That approach seems to pass syzbot (also with
> > > > > > CONFIG_PARAVIRT) and kcsan-test tests.
> > > > > >=20
> > > > > > I had to modify it some, so that report.c's use of the restore =
logic
> > > > > > works and not mess up the IRQ trace printed on KCSAN reports (w=
ith
> > > > > > CONFIG_KCSAN_VERBOSE).
> > > > > >=20
> > > > > > I still need to fully convince myself all is well now and we do=
n't end
> > > > > > up with more fixes. :-) If it passes further testing, I'll send=
 it as a
> > > > > > real patch (I want to add you as Co-developed-by, but would nee=
d your
> > > > > > Signed-off-by for the code you pasted, I think.)
> > > >=20
> > > > I let it run on syzbot through the night, and it's fine without
> > > > PARAVIRT (see below). I have sent the patch (need your Signed-off-by
> > > > as it's based on your code, thank you!):
> > > > https://lkml.kernel.org/r/20200807090031.3506555-1-elver@google.com
> > > >=20
> > > > > With CONFIG_PARAVIRT=3Dy (without the notrace->noinstr patch), I =
still
> > > > > get lockdep DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled()), alt=
hough
> > > > > it takes longer for syzbot to hit them. But I think that's expect=
ed
> > > > > because we can still get the recursion that I pointed out, and wi=
ll
> > > > > need that patch.
> > > >=20
> > > > Never mind, I get these warnings even if I don't turn on KCSAN
> > > > (CONFIG_KCSAN=3Dn). Something else is going on with PARAVIRT=3Dy th=
at
> > > > throws off IRQ state tracking. :-/
> > >=20
> > > What are the settings of CONFIG_PARAVIRT_XXL and
> > > CONFIG_PARAVIRT_SPINLOCKS in this case?
> >=20
> > I attached a config.
> >=20
> > 	$> grep PARAVIRT .config
> > 	CONFIG_PARAVIRT=3Dy
> > 	CONFIG_PARAVIRT_XXL=3Dy
> > 	# CONFIG_PARAVIRT_DEBUG is not set
> > 	CONFIG_PARAVIRT_SPINLOCKS=3Dy
> > 	# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > 	CONFIG_PARAVIRT_CLOCK=3Dy
>=20
> Anything special I need to do to reproduce the problem? Or would you be
> willing to do some more rounds with different config settings?

I can only test it with syzkaller, but that probably doesn't help if you
don't already have it set up. It can't seem to find a C reproducer.

I did some more rounds with different configs.

> I think CONFIG_PARAVIRT_XXL shouldn't matter, but I'm not completely
> sure about that. CONFIG_PARAVIRT_SPINLOCKS would be my primary suspect.

Yes, PARAVIRT_XXL doesn't make a different. When disabling
PARAVIRT_SPINLOCKS, however, the warnings go away.

Thanks,
-- Marco
