Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D47C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8B024680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="U0fYNBJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBZPLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:11:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40643 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgBZPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:11:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3513638wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igQz1W0l9NSpj6H/cHRjMubdVHwK+ov1fDsF+eJLpII=;
        b=U0fYNBJmYSmTtT7P/ZIt8VY1Pwonp/0JTIuJTsVwyEs1dEBhDcmxSx/VVJAwdzm7Vh
         apwgTsKXZNfGf5O8yNzSfFh48cXmvaa4a00dENUAWWtN78Gmbm2DhRk+Co4rZIp64Oy5
         YunVks4LvgcRQNEGQGOASc81Tl/y0zhlR5T8cLnuW/CtdoMAOQUcfwPV5sQBBOxofUj4
         CoVvuPxXo1rVAWE84O5S3d6zSNT3taIWIC7TKBCfzLdG7Nl5ywnu3WHa92vZxYcC99Y+
         KBtCqiKirwYYfLSoMxcCl6yU+akkEjyIMSs66YzLgt5bftN0JU+DvwM/erV33PCU6Hlj
         JIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igQz1W0l9NSpj6H/cHRjMubdVHwK+ov1fDsF+eJLpII=;
        b=IQowurDiE7Hi0xLCFksXEbZ0JZpfqna87LLPvvY+wKHeUWK08iJZ8dfU7Ym46m+ePy
         06wkSUwwPbm5PdTkctkUZ07qvDbHAAXQGZ20C00lMolDqUT/hQqV8xSJB9NjaNJNmOyg
         6IVLIBKJgCmi4PeV5EVncFKJWWS3eOAxPdGuAPQ1OOfxzd4DVCUSE1yH6r8egMDjmXwH
         85Mu6cVVJOASIMJCC6QE534tjagWY9KpDGHD2alBohlJwigBSsQQbO2tr/rovbYFGFVR
         52Szl9azwGhjHpUOlGz2a5UVygv6+RsiyGPDUULbD9QJZq96n08bS0H1qTWyO8sU1aOD
         dJjA==
X-Gm-Message-State: APjAAAWhmL2W8pmcm6qcgeSDKJ2uaDejbmIE+AmvI9vf7Y38LOFDKzxI
        y/UUuQmZahfgpphB+smxvCN5KMm7v4MvMtCt/nyB8Q==
X-Google-Smtp-Source: APXvYqyOZ1dbM+swXLeschkvR37I8dvG+RhzGAm+l8/m8R0p72gfL7eFv1koVcd6SYWWIlo+CkfkxFl5bkw+9j349ig=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr6141680wml.138.1582729910964;
 Wed, 26 Feb 2020 07:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20200225223321.231477305@linutronix.de> <20200225224145.444611199@linutronix.de>
 <20200226080538.GO18400@hirez.programming.kicks-ass.net> <20200226092018.GR18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200226092018.GR18400@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 26 Feb 2020 07:11:39 -0800
Message-ID: <CALCETrXYbmrVvYQzBDp8YP+-UyF3KPDgcK__HuNmpdsMBJYDVA@mail.gmail.com>
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C
 for simple idtentries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 1:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 26, 2020 at 09:05:38AM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 25, 2020 at 11:33:34PM +0100, Thomas Gleixner wrote:
> >
> > > --- a/arch/x86/include/asm/idtentry.h
> > > +++ b/arch/x86/include/asm/idtentry.h
> > > @@ -7,14 +7,31 @@
> > >
> > >  #ifndef __ASSEMBLY__
> > >
> > > +#ifdef CONFIG_CONTEXT_TRACKING
> > > +static __always_inline void enter_from_user_context(void)
> > > +{
> > > +   CT_WARN_ON(ct_state() != CONTEXT_USER);
> > > +   user_exit_irqoff();
> > > +}
> > > +#else
> > > +static __always_inline void enter_from_user_context(void) { }
> > > +#endif
> > > +
> > >  /**
> > >   * idtentry_enter - Handle state tracking on idtentry
> > >   * @regs:  Pointer to pt_regs of interrupted context
> > >   *
> > > - * Place holder for now.
> > > + * Invokes:
> > > + *  - The hardirq tracer to keep the state consistent as low level ASM
> > > + *    entry disabled interrupts.
> > > + *
> > > + *  - Context tracking if the exception hit user mode
> > >   */
> > >  static __always_inline void idtentry_enter(struct pt_regs *regs)
> > >  {
> > > +   trace_hardirqs_off();
> > > +   if (user_mode(regs))
> > > +           enter_from_user_context();
> > >  }
> >
> > So:
> >
> >       asm_exc_int3
> >         exc_int3
> >           idtentry_enter()
> >             enter_from_user_context
> >               if (context_tracking_enabled())
> >
> >           poke_int3_handler();
> >
> > Is, AFAICT, completely buggered.
> >
> > You can't have a static_branch before the poke_int3_handler that deals
> > with text_poke.
>
> Forgot to say that this isn't new with this patch, just noticed it when
> chasing after tracepoints.
>
> After my patch series we can actually fix this by moving the
> poke_int3_handler() before idtentry_enter().

In some sense, this is a weakness of the magic macro approach.  Some
of the entries just want to have code that runs before all the entry
fixups.  This is an example of it.  So are the cr2 reads.  It can all
be made to work, but it's a bit gross.
