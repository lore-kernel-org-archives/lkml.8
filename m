Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C3820674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgHQVXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:23:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:35087 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbgHQVXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:23:04 -0400
IronPort-SDR: W3flPG1+0k8WcFNbgeYEaXclQ56g8lkx9idnzmNJDKNzZB/q3GrGP1riAgKhF7jiqZaEsEPIN9
 trAmjoZDdG+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152201291"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="152201291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 14:23:02 -0700
IronPort-SDR: bNgMPOd0bydM3J0KCY8Xabznvg129yOoxk2IAxZVPZUY24Y7HV5WW6eocNjxK2I47PAk1scGq6
 KefseTSFyr0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="471561454"
Received: from bbartede-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.24])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2020 14:22:59 -0700
Date:   Tue, 18 Aug 2020 00:22:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Message-ID: <20200817212258.GD44714@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
 <20200724091711.GB517988@gmail.com>
 <20200725030107.GF17052@linux.intel.com>
 <20200725102110.GA757173@gmail.com>
 <20200728163400.e00b09c594763349f99ce6cb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728163400.e00b09c594763349f99ce6cb@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:34:00PM +0900, Masami Hiramatsu wrote:
> On Sat, 25 Jul 2020 12:21:10 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > > On Fri, Jul 24, 2020 at 11:17:11AM +0200, Ingo Molnar wrote:
> > > > 
> > > > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > > > 
> > > > > --- a/kernel/kprobes.c
> > > > > +++ b/kernel/kprobes.c
> > > > > @@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > > > >  	cpus_read_lock();
> > > > >  	mutex_lock(&text_mutex);
> > > > >  	/* Lock modules while optimizing kprobes */
> > > > > -	mutex_lock(&module_mutex);
> > > > > +	lock_modules();
> > > > >  
> > > > >  	/*
> > > > >  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> > > > > @@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > > > >  	/* Step 4: Free cleaned kprobes after quiesence period */
> > > > >  	do_free_cleaned_kprobes();
> > > > >  
> > > > > -	mutex_unlock(&module_mutex);
> > > > > +	unlock_modules();
> > > > >  	mutex_unlock(&text_mutex);
> > > > >  	cpus_read_unlock();
> > > > 
> > > > BTW., it would be nice to expand on the comments above - exactly which 
> > > > parts of the modules code is being serialized against and why?
> > > > 
> > > > We already hold the text_mutex here, which should protect against most 
> > > > kprobes related activities interfering - and it's unclear (to me) 
> > > > which part of the modules code is being serialized with here, and the 
> > > > 'lock modules while optimizing kprobes' comments is unhelpful. :-)
> > > > 
> > > > Thanks,
> > > > 
> > > > 	Ingo
> > > 
> > > AFAIK, only if you need to call find_module(), you ever need to acquire
> > > this mutex. 99% of time it is internally taken care by kernel/module.c.
> > > 
> > > I cannot make up any obvious reason to acquire it here.
> > 
> > If it's unnecessary, then it needs to be removed.
> > 
> > If it's necessary, then it needs to be documented better.
> 
> Good catch! This is not needed anymore.
> It has been introduced to avoid conflict with text modification, at that
> point we didn't get text_mutex. But after commit f1c6ece23729 ("kprobes: Fix 
> potential deadlock in kprobe_optimizer()") moved the text_mutex in the current
> position, we don't need it. (and anyway, keeping kprobe_mutex locked means
> any module unloading will be stopped inside kprobes_module_callback())
> 
> This may help?

Hey, thanks a lot. This will help to clean my patch set. I'll send a
follow up version as soon I'm on track with my work.  I have to recall
my set of changes and backtrack some of the discussion.

I was two weeks in vacation and last week had bunch of network
connectivity issues last week. Anyway, enough time for details to fade
away :-)

/Jarkko

> 
> From 2355ecd941c3234b12a6de7443592848ed4e2087 Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Tue, 28 Jul 2020 16:32:34 +0900
> Subject: [PATCH] kprobes: Remove unneeded module_mutex lock from the optimizer
> 
> Remove unneeded module_mutex locking from the optimizer. Since
> we already locks both kprobe_mutex and text_mutex in the optimizer,
> text will not be changed and the module unloading will be stopped
> inside kprobes_module_callback().
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4a904cc56d68..d1b02e890793 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -563,8 +563,6 @@ static void kprobe_optimizer(struct work_struct *work)
>  	mutex_lock(&kprobe_mutex);
>  	cpus_read_lock();
>  	mutex_lock(&text_mutex);
> -	/* Lock modules while optimizing kprobes */
> -	mutex_lock(&module_mutex);
>  
>  	/*
>  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> @@ -589,7 +587,6 @@ static void kprobe_optimizer(struct work_struct *work)
>  	/* Step 4: Free cleaned kprobes after quiesence period */
>  	do_free_cleaned_kprobes();
>  
> -	mutex_unlock(&module_mutex);
>  	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();
>  
> -- 
> 2.25.1
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
