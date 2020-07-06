Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B73C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB2B20656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OogYHfjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgGFRhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgGFRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:37:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B6C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 10:37:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so35549348qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHso7SWMwN4J0w0Dwo/o81zIG5vPbLVlNqcFK0oE1vA=;
        b=OogYHfjppQOeRGIAo5n46dhTfjIM0d2iHF3wu43h6qAGD/hqkveAKhdeOqv3uHQfBq
         lv3mqfwzu3RioBe4ccI7mm9+sGj/LEatXLFLn5QxlsbB80dBFf0ntKgNEXmAGUc8Y34o
         2KBw+1OfDuV7VwScWhP6ZfsRIWtmYMzVdf34c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHso7SWMwN4J0w0Dwo/o81zIG5vPbLVlNqcFK0oE1vA=;
        b=ATB0l74unGmeumM/A4E+uhTQuWvvbb5hPyphp34KIlXHweQgE/G+CeMOu74xQx3GtH
         z54vO4ae1XOd1BdIyEQpu3bTRtkxJONyDTxqzKk9975jujNKfHXrU5v9h5/L1DVinSdz
         oULn5dwVQTmu+/xX9xVtR8dp0QVLtOehmCyynBK+CHszzaqSfBgIHUHjOCGchcZqVPZT
         wvZF+O17l7J4chc4UO8gtW4hstYHQATMJqo3LVLdIsLyQ/7MtZrMdjPojQZqMrMeeXt3
         DtCjGMkWI6ixnAqfiOqafPYdwn/rViX4X7AH62xPvSP9Bu+/Xv0XE1w+bU9kagC7/GTz
         y2iA==
X-Gm-Message-State: AOAM531T0ZdLcM7wYLrN1h0XA5V8tESl81l8EvZxJyjYjBJ/oGykku7k
        eK9QzDeZwPmrWzPPK/T6xnPuPQ==
X-Google-Smtp-Source: ABdhPJwVz7wTnkHfhD50EFatQtxaBM77TExwNaevVuP7WEiQhRjJWsy8RjURJB+I220dmOVbXUluiw==
X-Received: by 2002:a37:4592:: with SMTP id s140mr46717607qka.245.1594057030231;
        Mon, 06 Jul 2020 10:37:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z68sm20551102qke.113.2020.07.06.10.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:37:09 -0700 (PDT)
Date:   Mon, 6 Jul 2020 13:37:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200706173709.GA190133@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com>
 <CANaguZDtZrXbjmot2crLM0ComgY=NfqxWYs7GzUEY8aLeaUVrg@mail.gmail.com>
 <20200706140928.GA170866@google.com>
 <CANaguZAJk=yCGiiSh1y1gYYh_9ZfO94VT4vNjYjR_SY=_0ao-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZAJk=yCGiiSh1y1gYYh_9ZfO94VT4vNjYjR_SY=_0ao-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On Mon, Jul 06, 2020 at 10:38:27AM -0400, Vineeth Remanan Pillai wrote:
> On Mon, Jul 6, 2020 at 10:09 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > I am not sure if this can happen. If the other sibling sets core_pick, it
> > > will be under the core wide lock and it should set the core_sched_seq also
> > > before releasing the lock. So when this cpu tries, it would see the core_pick
> > > before resetting it. Is this the same case you were mentioning? Sorry if I
> > > misunderstood the case you mentioned..
> >
> > If you have a case where you have 3 siblings all trying to enter the schedule
> > loop. Call them A, B and C.
> >
> > A picks something for B in core_pick. Now C comes and resets B's core_pick
> > before running the mega-loop, hoping to select something for it shortly.
> > However, C then does an unconstrained pick and forgets to set B's pick to
> > something.
> >
> > I don't know if this can really happen - but this is why I added the warning
> > in the end of the patch. I think we should make the code more robust and
> > handle these kind of cases.
> >
> I don't think this can happen. Each of the sibling takes the core wide
> lock before calling into pick_next _task. So this should not happen.

So my patch is correct but the warnings I added were probably overkill.

About the warnings, Vineeth explained to me on IRC that the design was
intially done to set ->core_pick to NULL if nothing is being picked for a
sibling rq, and the fact that we don't increment that rq's core_sched_seq
means it would the rq it is being set for would not go read core_pick.

And that resetting ->core_pick should be ok, since a sibling will go select a
task for itself if its core_pick was NULL anyway.

The only requirement is that the selection code definitely select something
for the current CPU, or idle. NULL is not an option,

So I guess we can drop the additional warnings I added, I was likely too
paranoid.

> > Again, it is about making the code more robust. Why should not set
> > rq->core_pick when we pick something? As we discussed in the private
> > discussion - we should make the code robust and consistent. Correctness is
> > not enough, the code has to be robust and maintainable.
> >
> > I think in our private discussion, you agreed with me that there is no harm
> > in setting core_pick in this case.
> >
> I agreed there was no harm, because we wanted to use that in the last
> check after 'done' label. But now I see that adding that check after
> done label cause the WARN_ON to fire even in valid case. Firing the
> WARN_ON in valid case is not good. So, if that WARN_ON check can be
> removed, adding this is not necessary IMHO.

Makes sense.

> > > cpumask_copy(&select_mask, cpu_smt_mask(cpu));
> > > if (unlikely(cpumask_test_cpu(cpu, &select_mask))) {
> > >     cpumask_set_cpu(cpu, &select_mask);
> > >     need_sync = false;
> > > }
> >
> > Nah, more lines of code for no good no reason, plus another branch right? I'd
> > like to leave my one liner alone than adding 4 more lines :-)
> >
> Remember, this is the fast path. Every schedule() except for our sync
> IPI reaches here. And we are sure that smt_cpumask will not have cpu
> only on hotplug cases which is very rare. I feel adding more code to
> make it clear that this setting is not needed always and also optimizing for
> the fast path is what I was looking for.

It occurs to us that may we want to optimize this a bit more, because we have
to copy cpumask every schedule() with my patch which may be unnecessarily
expensive for large CPU systems.  I think we can do better -- probably by
unconditionally running the selection code on the current CPU without first
preparing an intermediate mask..

> > As discussed above, > 2 SMT case, we don't really know if the warning will
> > fire or not. I would rather keep the warning just in case for the future.
> >
> I think I was not clear last time. This WARN_ON will fire on valid cases
> if you have this check here. As I mentioned unconstrained pick, picks only
> for that cpu and not to any other siblings. This is by design. So for
> unconstrained pick, core_pick of all siblings will be NULL. We jump to done
> label on unconstrained pick and this for loop goes through all the siblings
> and finds that its core_pick is not set. Then thei WARN_ON will fire. I have
> reproduced this. We do not want it to fire as it is the correct logic not to
> set core_pick for unconstrained pick. Please let me know if this is not clear.

Agreed, I think my patch can be used as a starting point and we optimize it
further.

Me/Vineeth will continue to work on this and come up with a final patch, thanks!

 - Joel

