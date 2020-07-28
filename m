Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EAEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97A7207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595921648;
	bh=4CctEpqXsw2X+EjiNA/gb/+djSwvwlkPMoJAMblIkKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UJjrGxZnCG33CxaZPCyy0okCjvkTYkFqxY2s1Uq3WnQni2JDN21tDgPSfGQKJniRm
	 L5bGF9cV6bHpC8niKuJi2fc3Bf5n/gzW6FSLWVEmGdPLyuMABTDtJQjHp6XT1IEbmQ
	 sOIYMCwmamlBB4dpaimB+PnyEBSFhAA/KkXuLOlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgG1HeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG1HeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:34:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F342070B;
        Tue, 28 Jul 2020 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595921646;
        bh=4CctEpqXsw2X+EjiNA/gb/+djSwvwlkPMoJAMblIkKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ai+28Ik68vLxiJUscY/lUed8N+B4bpestmgqJb+Y188jeEcl/ULmEZNiUbbLRHcnL
         FpljcWZVuNziex5ab5DM4RlpXDXdv/GtI/VRstcF2Y6qkkM029uPwxkFnrvf1JBqZA
         sh3gtZfs7ncSrVqEIBHPyAHtkDoVBw5CtOGSj96w=
Date:   Tue, 28 Jul 2020 16:34:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Message-Id: <20200728163400.e00b09c594763349f99ce6cb@kernel.org>
In-Reply-To: <20200725102110.GA757173@gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
        <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
        <20200724091711.GB517988@gmail.com>
        <20200725030107.GF17052@linux.intel.com>
        <20200725102110.GA757173@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 12:21:10 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > On Fri, Jul 24, 2020 at 11:17:11AM +0200, Ingo Molnar wrote:
> > > 
> > > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > > 
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > > >  	cpus_read_lock();
> > > >  	mutex_lock(&text_mutex);
> > > >  	/* Lock modules while optimizing kprobes */
> > > > -	mutex_lock(&module_mutex);
> > > > +	lock_modules();
> > > >  
> > > >  	/*
> > > >  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> > > > @@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > > >  	/* Step 4: Free cleaned kprobes after quiesence period */
> > > >  	do_free_cleaned_kprobes();
> > > >  
> > > > -	mutex_unlock(&module_mutex);
> > > > +	unlock_modules();
> > > >  	mutex_unlock(&text_mutex);
> > > >  	cpus_read_unlock();
> > > 
> > > BTW., it would be nice to expand on the comments above - exactly which 
> > > parts of the modules code is being serialized against and why?
> > > 
> > > We already hold the text_mutex here, which should protect against most 
> > > kprobes related activities interfering - and it's unclear (to me) 
> > > which part of the modules code is being serialized with here, and the 
> > > 'lock modules while optimizing kprobes' comments is unhelpful. :-)
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> > 
> > AFAIK, only if you need to call find_module(), you ever need to acquire
> > this mutex. 99% of time it is internally taken care by kernel/module.c.
> > 
> > I cannot make up any obvious reason to acquire it here.
> 
> If it's unnecessary, then it needs to be removed.
> 
> If it's necessary, then it needs to be documented better.

Good catch! This is not needed anymore.
It has been introduced to avoid conflict with text modification, at that
point we didn't get text_mutex. But after commit f1c6ece23729 ("kprobes: Fix 
potential deadlock in kprobe_optimizer()") moved the text_mutex in the current
position, we don't need it. (and anyway, keeping kprobe_mutex locked means
any module unloading will be stopped inside kprobes_module_callback())

This may help?

From 2355ecd941c3234b12a6de7443592848ed4e2087 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Tue, 28 Jul 2020 16:32:34 +0900
Subject: [PATCH] kprobes: Remove unneeded module_mutex lock from the optimizer

Remove unneeded module_mutex locking from the optimizer. Since
we already locks both kprobe_mutex and text_mutex in the optimizer,
text will not be changed and the module unloading will be stopped
inside kprobes_module_callback().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4a904cc56d68..d1b02e890793 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -563,8 +563,6 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_lock(&kprobe_mutex);
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
-	/* Lock modules while optimizing kprobes */
-	mutex_lock(&module_mutex);
 
 	/*
 	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
@@ -589,7 +587,6 @@ static void kprobe_optimizer(struct work_struct *work)
 	/* Step 4: Free cleaned kprobes after quiesence period */
 	do_free_cleaned_kprobes();
 
-	mutex_unlock(&module_mutex);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
-- 
2.25.1
-- 
Masami Hiramatsu <mhiramat@kernel.org>
