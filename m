Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F38C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5D120857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDhJ/nf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbgDODrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733225AbgDODrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:47:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC42C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 20:47:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id x11so2058946otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wERzDe7tATVzriZTxnBR4nHZ60TDhiwZrL9xlX9mHs=;
        b=HDhJ/nf4Up5M9CCU7JjmE304j+3W8NeaC6jtzDoPx6NEYqkP2DIslze8nxUDffVPJp
         a2foi7GtIijOSXfGrwx9zau7WJ0tiHA3SUfodElxVTj3C3ZL0SB/rNnTo2I0AXsXHjGl
         wCQo6KqHQl2+K9yelicZTRCQe/lKZwcehZX1NgVI9fsa19F4LVS2bA4WAhP9HF/91LN+
         UscuIzifN5TQTICFsURIjThyK/y56+Dgg+dmBvC+f2m9QFkdXiZpI8ti7SqbGlv8MgRQ
         ScEacQiI5/NGZcQLDqj0uL83mqgDVgmTxoK1YmhUnARTEEnA1LVmfvLZIXbJ+iIIuinL
         lHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wERzDe7tATVzriZTxnBR4nHZ60TDhiwZrL9xlX9mHs=;
        b=lWyOvxpfquFVYNIzv0jh3keB+Np/Ful2uWx3AYIVNUf2LoHIyhWFKjXwWNU4Fho+IX
         mhd8x9/8IGbmVN1NY/4W+1GTb9NrJpQpa4KcGBauOFPssdSvOMtJik4bouEt5RTNVLN+
         ZEwkpvJwZlsrUuuQnzrjrqgflNVZD4LBTnRTgmtXv2+FM1b2k2wd7v5/iHBb2iwyii9G
         A2l3MeZoQXPfYLLt8ciYStx7eiZuqPlwIrKz4Cnl0DYwFzDlRO0pAlqnYT0UGVic76ra
         3zh7bppf6tpMOyV9tio5SJakgwLM1iZCkSEGfSeaPb2hVZ3nCsBdMUe1GeYA3gJO9ugR
         cHjQ==
X-Gm-Message-State: AGi0PuYdeAQUCnKBk74vSLYNd1+PjwC7DIdVyOpk/Q2SE6dlcYY/aH2b
        CG7YoMA4a6XQ6cpwMu+d9gL1ToTcqV6h9Ig90mvqRA==
X-Google-Smtp-Source: APiQypLBqkH/k+r0Q+P5XNNT728lPCjEj5EOjBDRWHqwzMc/XrznT4MoI59oI4gyP6knbyxsIiRIqt59dcHKgpsAbFQ=
X-Received: by 2002:a4a:df05:: with SMTP id i5mr21515417oou.9.1586922450019;
 Tue, 14 Apr 2020 20:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415025748.GV17661@paulmck-ThinkPad-P72>
In-Reply-To: <20200415025748.GV17661@paulmck-ThinkPad-P72>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 14 Apr 2020 20:47:18 -0700
Message-ID: <CALAqxLVsRboF+ABFttCj-kv6yNoAGLw9BaFkggSiGC+Me08gHQ@mail.gmail.com>
Subject: Re: On trace_*_rcuidle functions in modules
To:     paulmck@kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 7:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Apr 14, 2020 at 07:20:01PM -0700, John Stultz wrote:
> > Hey folks,
> >   So recently I was looking at converting some drivers to be loadable
> > modules instead of built-in only, and one of my patches just landed in
> > -next and started getting build error reports.
> >
> > It ends up, recently in the merge window, the driver I was converting
> > to module switched a trace_*() function to trace_*_rcuidle() to fix a
> > bug.  Now when building as a module, if tracing is configured on, it
> > can't seem to find the trace_*_rcuidle() symbol.
> >
> > This is because, as you are aware, we don't declare trace_*_rcuidle
> > functions in modules - and haven't for quite some time:
> >   https://lore.kernel.org/lkml/20120905062306.GA14756@leaf/
> >
> > I wanted to better understand the background rationale for that patch,
> > to understand if not exporting the rcu_idle_exit and rcu_idle_enter,
> > calls was because they weren't used or if it was a more intentional
> > decision to avoid allowing modules to use them.
> >
> > Would it be reasonable to revisit that patch? Or is there some
> > recommended alternative solution?
>
> I will defer to Steven and Josh on the rationale.  (Cowardly of me,
> I know!)
>
> What I do is to maintain a wrapper for tracepoints within a built-in
> portion of RCU, export the wrapper, and invoke the wrapper from the
> rcutorture module.  Maybe you can do something similar?

That feels a little hackish, but I guess if there isn't a better option...

> But why would a module be invoked from the idle loop?  Is the module
> supplying an idle driver or some such?

The driver (qcom rpmh driver) registers a cpu_pm notifier callback,
which gets called when entering idle.

thanks
-john
