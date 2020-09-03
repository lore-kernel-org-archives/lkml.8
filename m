Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4004C206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qd/m4uFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgICUZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:25:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B696C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:25:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d190so4831186iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+Lo4pDWBduKOWAd6TxKaXXrRizzdPhL7MhHpaQ40qE=;
        b=qd/m4uFRAZANSMjr34L/yVzO09x3QJkHMBlxSLXBYQNuSUiNJHmPsNOPgEzZIV/rjf
         fmKHaM7crh1WLOJZtCUbQTO1rrFzo1B00jIlF91D8WY6tpwYprRR6llClWtVb5etc6Ez
         YnbSf4uQhFz+1bVjSYJzCX3+KraKpy2B/5E8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+Lo4pDWBduKOWAd6TxKaXXrRizzdPhL7MhHpaQ40qE=;
        b=SzN2yu7F5W101CcqekGr5PsAnVPMbdMS938VYJwAGPMPF8nmTns2JOSdCCpXb09nqs
         /6b9aPDyd89LOqqokQh4NFD9t0Nh5+/wMqJFk+6sBMzZmqhI5rup+9T7BafQ1FRMHQHe
         BIGg2gTzVyulx9Vun3US9WtTAcp/U4bTG1nYeLG9HQ1CNE1SpMPzDglNjv36yqgqlJhg
         E3otfLEpkmQWvKoLFoUKy0hwnoWbYVbywMB20XBbYxzI9d2D1lo1nsrU7LZyi5bKtHMW
         t0KvjCk31dFfgKbRdJNU5mnUcoELEI06VKHk5cKbyekINLj5qUjSZSduvRT/Ge+puZuj
         1kow==
X-Gm-Message-State: AOAM530b3FZ/Oc0ppk5fkhgHfj8pYFnf1hCK2xBW6CDpFuisuvPMCWs7
        RDE+yN1X5LM0iWTHwi86ii+97jNAkXUA1ZqjHQCZjw==
X-Google-Smtp-Source: ABdhPJyp3VTX7lgoSZmeb81Lik23HV2mFXc1tCZ6FCKa05zMzN5cRg/96/QszdYN9G3cpEIi/d+dv5/QsmqVAhvPacw=
X-Received: by 2002:a02:cd0e:: with SMTP id g14mr5206360jaq.74.1599164718454;
 Thu, 03 Sep 2020 13:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de> <20200901165052.GA1662854@google.com>
 <875z8xl0zh.fsf@nanos.tec.linutronix.de> <20200902012905.GB1703315@google.com>
 <87h7sgk41y.fsf@nanos.tec.linutronix.de> <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
 <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com> <561110efffc3f6bf57894bf39861b39e1ec87845.camel@suse.com>
In-Reply-To: <561110efffc3f6bf57894bf39861b39e1ec87845.camel@suse.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Sep 2020 16:25:05 -0400
Message-ID: <CAEXW_YS-ozG2RnyUJ=OLi5cKJMDXRG+m5kY97d5rd-ubCfSD5A@mail.gmail.com>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 9:43 AM Dario Faggioli <dfaggioli@suse.com> wrote:
>
> On Thu, 2020-09-03 at 00:34 -0400, Joel Fernandes wrote:
> > On Wed, Sep 2, 2020 at 12:57 PM Dario Faggioli <dfaggioli@suse.com>
> > wrote:
> > > 2) protection of the kernel from the other thread running in
> > > userspace
> > > may be achieved in different ways. This is one, sure. ASI will
> > > probably
> > > be another. Hence if/when we'll have both, this and ASI, it would
> > > be
> > > cool to be able to configure the system in such a way that there is
> > > only one active, to avoid paying the price of both! :-)
> >
> > Actually, no. Part of ASI will involve exactly what this patch does -
> > IPI-pausing siblings but ASI does so when they have no choice but to
> > switch away from the "limited kernel" mapping, into the full host
> > kernel mapping. I am not sure if they have yet implemented that part
> > but they do talk of it in [1] and in their pretty LPC slides.  It is
> > just that ASI tries to avoid that scenario of kicking all siblings
> > out
> > of guest mode.  So, maybe this patch can be a stepping stone to ASI.
> >
> Ah, sure! I mean, it of course depends on how things get mixed
> together, which we still don't know. :-)
>
> I know that ASI wants to do this very same thing some times. I just
> wanted to say that we need/want only one mechanism for doing that, in
> place at any given time.
>
> If that mechanism will be this one, and ASI then uses it (e.g., in a
> scenario where for whatever reason one wants ASI with the kicking but
> not Core Scheduling), then great, I agree, and everything does makes
> sense.

Agreed, with some minor modifications, it should be possible.

> > Why do you feel that ASI on its own offers some magical protection
> > that eliminates the need for this patch?
> >
> I don't. I was just trying to think of different use cases, how they
> mix and match, etc. But as you're suggesting (and as Thomas has shown
> very clearly in another reply to this email), the thing that makes the
> most sense is to have one mechanism for the kicking, used by anyone
> that needs it. :-)

Makes sense. Thanks,

 - Joel
