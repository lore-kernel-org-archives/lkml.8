Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0525C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF37224655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dSb9onEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBSBOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:14:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42654 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgBSBOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:14:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so20211037qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 17:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FueUbpfaJleVgrWbIqlQd/K1jYreMkWjgKE2CWPFamU=;
        b=dSb9onEkcXLUw4lFWFgkjPdu4LbRE1emVcRyCEtD4HvJBgi6jngz4AzoofZO6CXdqF
         cBsHrW2XruTj+3NJw+ekdrvKtyDFRQqmdg51wDDLOa/SSG3Wa+dNgBVhy3e/nCMYUHDo
         D4lIzVn0NBqesp21eemO7vJIJAgQzkyL4TP2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FueUbpfaJleVgrWbIqlQd/K1jYreMkWjgKE2CWPFamU=;
        b=h5YC70CHbEcW5J6iCvRUFWQ7rS3eDjUwbh3fElqsJEYB4jAEddPIFBLbuuM7hxb8mO
         egVhAMAXfWeXfYxGEJCADYjPc/FshUIfAfoNYH38tn8jqg4fhuASLm7M6b2i5JAJytoh
         3ibQIxXoucVOGJwAn1bQFZw23tAqiTfNWp39ERrvx0lJkNbD7t5+UIiN4BjO6yycHA21
         Cf1I24gIZ8CFd1NzUPhEQk1/Ziydn194u8hPWU2WD9yZ2Kbi9qGbpQOpyEdoc/RqBONe
         59plbpdfF9r1h/zSb3ShsJndPPVlp5yt2b88HU8wdWuaoe4V6jkkai+tt8jWVL9lb4IV
         X7qA==
X-Gm-Message-State: APjAAAWSEZ7ZV2mMKRtGqzQFJsQYAyXRIo9P3dtNko3rjCCCWwu/clCo
        b3BprISDmwi34Pwm4BiSBg6zeQ==
X-Google-Smtp-Source: APXvYqwMlAtoCgS9AxWcd0p3Cm+8A6M3l/bgCI6wmQ/mDWnZJ9GZhDT6DBxY0i6N84CepzYm1rvfMQ==
X-Received: by 2002:a37:c49:: with SMTP id 70mr21872105qkm.12.1582074840813;
        Tue, 18 Feb 2020 17:14:00 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r3sm126593qtc.85.2020.02.18.17.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:14:00 -0800 (PST)
Date:   Tue, 18 Feb 2020 20:13:59 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200219011359.GA29762@google.com>
References: <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
 <20200218202226.GJ2935@paulmck-ThinkPad-P72>
 <20200218174503.3d4e4750@gandalf.local.home>
 <20200218225455.GN2935@paulmck-ThinkPad-P72>
 <20200219000144.GA26663@google.com>
 <20200219001640.GP2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219001640.GP2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:16:40PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 18, 2020 at 07:01:44PM -0500, Joel Fernandes wrote:
> > On Tue, Feb 18, 2020 at 02:54:55PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 18, 2020 at 05:45:03PM -0500, Steven Rostedt wrote:
> > > > On Tue, 18 Feb 2020 12:22:26 -0800
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > > On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> > > > > > On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:  
> > > > > > > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:  
> > > > > >   
> > > > > > > > I just took offence at the Changelog wording. It seems to suggest there
> > > > > > > > actually is a problem, there is not.  
> > > > > > > 
> > > > > > > Quoting the changelog: "Not appropriate for backporting due to failure
> > > > > > > being unlikely."  
> > > > > > 
> > > > > > That implies there is failure, however unlikely.
> > > > > > 
> > > > > > In this particular case there is absolutely no failure, except perhaps
> > > > > > in KCSAN. This patch is a pure annotation such that KCSAN can understand
> > > > > > the code.
> > > > > > 
> > > > > > Like said, I don't object to the actual patch, but I do think it is
> > > > > > important to call out false negatives or to describe the actual problem
> > > > > > found.  
> > > > > 
> > > > > I don't feel at all comfortable declaring that there is absolutely
> > > > > no possibility of failure.
> > > > 
> > > > Perhaps wording it like so:
> > > > 
> > > > "There's know known issue with the current code, but the *_ONCE()
> > > > annotations here makes KCSAN happy, allowing us to focus on KCSAN
> > > > warnings that can help bring about known issues in other code that we
> > > > can fix, without being distracted by KCSAN warnings that we do not see
> > > > a problem with."
> > > > 
> > > > ?
> > > 
> > > That sounds more like something I might put in rcutodo.html as a statement
> > > of the RCU approach to KCSAN reports.
> > > 
> > > But switching to a different situation (for variety, if nothing else),
> > > what about the commit shown below?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit 35bc02b04a041f32470ae6d959c549bcce8483db
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Feb 18 13:41:02 2020 -0800
> > > 
> > >     rcutorture: Mark data-race potential for rcu_barrier() test statistics
> > >     
> > >     The n_barrier_successes, n_barrier_attempts, and
> > >     n_rcu_torture_barrier_error variables are updated (without access
> > >     markings) by the main rcu_barrier() test kthread, and accessed (also
> > >     without access markings) by the rcu_torture_stats() kthread.  This of
> > >     course can result in KCSAN complaints.
> > >     
> > >     Because the accesses are in diagnostic prints, this commit uses
> > >     data_race() to excuse the diagnostic prints from the data race.  If this
> > >     were to ever cause bogus statistics prints (for example, due to store
> > >     tearing), any misleading information would be disambiguated by the
> > >     presence or absence of an rcutorture splat.
> > >     
> > >     This data race was reported by KCSAN.  Not appropriate for backporting
> > >     due to failure being unlikely and due to the mild consequences of the
> > >     failure, namely a confusing rcutorture console message.
> > >     
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 5453bd5..b3301f3 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -1444,9 +1444,9 @@ rcu_torture_stats_print(void)
> > >  		atomic_long_read(&n_rcu_torture_timers));
> > >  	torture_onoff_stats();
> > >  	pr_cont("barrier: %ld/%ld:%ld\n",
> > > -		n_barrier_successes,
> > > -		n_barrier_attempts,
> > > -		n_rcu_torture_barrier_error);
> > > +		data_race(n_barrier_successes),
> > > +		data_race(n_barrier_attempts),
> > > +		data_race(n_rcu_torture_barrier_error));
> > 
> > Would it be not worth just fixing the data-race within rcutorture itself?
> 
> I could use WRITE_ONCE() for updates and READ_ONCE() for statistics.
> However, my current rule is that diagnostic code that is not participating
> in the core synchronization uses data_race().  That way, if I do a typo
> and write to (say) n_barrier_attempts in some other thread, KCSAN will
> know to yell at me.

Oh, ok. That makes sense.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

