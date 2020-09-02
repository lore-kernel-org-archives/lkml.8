Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A548CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DE42067C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSW58hqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIBRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:02:20 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B932C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:02:19 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u126so6511716iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xYcoL6IB0Wq6/qeVTU/n5lnOlUSrCMA6TFnZUgAyGsE=;
        b=dSW58hqu76qgwVPU3bA+u5m6uUoMYTaMSISCeNMZijC0E/BRbjoLIFnWiV9GKxGejJ
         1uZ7r5kcVM7ddnfrNnVjI94iOPgjMtUX+Z/H1svxvnBct646Ukya0wm+E7Zx9iGy+7Ez
         6LYzcixO7WEcQY4+/Iu8VQLw10Fx2tK/1ZqqnKAl7zT980iodfPlTS8Fub3xc30/aLO1
         QsQqkRyB065CW1u3f0CCnUsj5xnrjIJ75UVIrWGI0b05RCM7K5ONP6eubMZGWRJWclXK
         Q2LSVhFzMECHyI/FltfQmijEWApqa2H0cJXGlxLpAkqV29ap9APkUEI2awS/E47QWD9b
         2NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xYcoL6IB0Wq6/qeVTU/n5lnOlUSrCMA6TFnZUgAyGsE=;
        b=VnLn2SIm3xTwMLRmWxY72uqbbr40N0tojAj9TnEamxIf+q/4a9lhePj26QC4242NGo
         ffMX2qnkDpP0MN7Sx0IEF15H9Wwnbd+grPAVBvZ9SOoOoB1wmJSzieeanfNbKPVhUzJh
         0/EJbRMbilZa8Q35VwITxTqt5qSdn9XKFMHGXbHpCUQ+D6a21aWKaNA+r1qKk3xgZimz
         9CYig4W1tQScdAxDN88YGOAOIZYm0ry31cVBkTFlDAhswu6tPYj0E+R5oBGK6XK0VNr7
         WRNEaY4dYGaRLI92w/WDfzb8SopdJqm83lf98mUtGCwqcR+ATEL3pLJUo9eQ8mXkrrIG
         4B9A==
X-Gm-Message-State: AOAM531qtDet9Z1/XLOvzvBTK3sHK3RiHle8G9UN0rPTztALTy017+mS
        HgWg/erLgczzNabuU3jTvzsiVfrhFxE/ngh9vw==
X-Google-Smtp-Source: ABdhPJyKqo74mGtwvw1L3zfRTdgO/00hoqv9t2Vf627AexQNQkSArDkNadSAw/tkgR5LTW6uunvQ/Y8UMw001QLvARg=
X-Received: by 2002:a5d:841a:: with SMTP id i26mr4167807ion.144.1599066138555;
 Wed, 02 Sep 2020 10:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200902132549.496605622@infradead.org> <20200902133200.666781610@infradead.org>
 <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
 <c6915915-1c94-70cf-453d-861a4ca2da4c@suse.com> <20200902163115.GM1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200902163115.GM1362448@hirez.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 2 Sep 2020 13:02:07 -0400
Message-ID: <CAMzpN2hRrx2R_wLT4imB3w9RApL1XK5SYcyXk5Cbp9fkY_s-Dg@mail.gmail.com>
Subject: Re: [PATCH 01/13] x86/entry: Fix AC assertion
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 12:31 PM <peterz@infradead.org> wrote:
>
> On Wed, Sep 02, 2020 at 06:24:27PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> > On 02.09.20 17:58, Brian Gerst wrote:
> > > On Wed, Sep 2, 2020 at 9:38 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
> > > >
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Furth=
er
> > > > improve user entry sanity checks") unconditionally triggers on my I=
VB
> > > > machine because it does not support SMAP.
> > > >
> > > > For !SMAP hardware we patch out CLAC/STAC instructions and thus if
> > > > userspace sets AC, we'll still have it set after entry.
> > > >
> > > > Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user en=
try sanity checks")
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Acked-by: Andy Lutomirski <luto@kernel.org>
> > > > ---
> > > >   arch/x86/include/asm/entry-common.h |   11 +++++++++--
> > > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > >
> > > > --- a/arch/x86/include/asm/entry-common.h
> > > > +++ b/arch/x86/include/asm/entry-common.h
> > > > @@ -18,8 +18,16 @@ static __always_inline void arch_check_u
> > > >                   * state, not the interrupt state as imagined by X=
en.
> > > >                   */
> > > >                  unsigned long flags =3D native_save_fl();
> > > > -               WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF=
 |
> > > > -                                     X86_EFLAGS_NT));
> > > > +               unsigned long mask =3D X86_EFLAGS_DF | X86_EFLAGS_N=
T;
> > > > +
> > > > +               /*
> > > > +                * For !SMAP hardware we patch out CLAC on entry.
> > > > +                */
> > > > +               if (boot_cpu_has(X86_FEATURE_SMAP) ||
> > > > +                   (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_=
FEATURE_XENPV)))
> > > > +                       mask |=3D X86_EFLAGS_AC;
> > >
> > > Is the explicit Xen check necessary?  IIRC the Xen hypervisor will
> > > filter out the SMAP bit in the cpuid pvop.
> >
> > Right, and this test will nevertheless result in setting AC in the mask=
.
> > IIRC this was the main objective here.
>
> Correct, this asserts that 64bit Xen-PV will never have AC set; it had
> better not have it set since it runs in ring 3.

Ok.  That should be added to the comment to avoid confusion.

--
Brian Gerst
