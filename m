Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5689EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B39220748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGYDBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:01:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:1363 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgGYDBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:01:15 -0400
IronPort-SDR: 2WFHRbUfifyDb0LFVipTnlThgRhZ4C44Zzw2TeObdPSzO2DYE3+/iEX/5QqP8+ix07Mxsq6oKK
 d+0HLcMhvOFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="148715924"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="148715924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:01:15 -0700
IronPort-SDR: Zb1abh/qM98LiRVzVkmiiDoP7rGOSDUXza0TOyRuPkDFnnvZt/7ajicbDb/7B1D/7SWcoRNjF5
 0l5d4ObrS97A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="311611969"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2020 20:01:09 -0700
Date:   Sat, 25 Jul 2020 06:01:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Message-ID: <20200725030107.GF17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
 <20200724091711.GB517988@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091711.GB517988@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:17:11AM +0200, Ingo Molnar wrote:
> 
> * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
> >  	cpus_read_lock();
> >  	mutex_lock(&text_mutex);
> >  	/* Lock modules while optimizing kprobes */
> > -	mutex_lock(&module_mutex);
> > +	lock_modules();
> >  
> >  	/*
> >  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> > @@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
> >  	/* Step 4: Free cleaned kprobes after quiesence period */
> >  	do_free_cleaned_kprobes();
> >  
> > -	mutex_unlock(&module_mutex);
> > +	unlock_modules();
> >  	mutex_unlock(&text_mutex);
> >  	cpus_read_unlock();
> 
> BTW., it would be nice to expand on the comments above - exactly which 
> parts of the modules code is being serialized against and why?
> 
> We already hold the text_mutex here, which should protect against most 
> kprobes related activities interfering - and it's unclear (to me) 
> which part of the modules code is being serialized with here, and the 
> 'lock modules while optimizing kprobes' comments is unhelpful. :-)
> 
> Thanks,
> 
> 	Ingo

AFAIK, only if you need to call find_module(), you ever need to acquire
this mutex. 99% of time it is internally taken care by kernel/module.c.

I cannot make up any obvious reason to acquire it here.

/Jarkko
