Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BA4206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGYCgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:36:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:21751 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgGYCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:36:41 -0400
IronPort-SDR: RgHjhSaxZu/Svh1adiKeF96ldxA+lCiiEFCDb2QZeqvrLakvZeJwwmPj0rW3AfcDm5rFhXLdJT
 i+j/SoQCgVOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130364417"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="130364417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 19:36:40 -0700
IronPort-SDR: KUDOuRXU7WxsPpfpzLDg/dH8nvZCth3M2Ujrp7RGQEKup3WlQurm5AhhZzT75HE6n+bZP1b7PH
 xU8ocz+diU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="311607313"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2020 19:36:35 -0700
Date:   Sat, 25 Jul 2020 05:36:33 +0300
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
Message-ID: <20200725023633.GC17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
 <20200724091319.GA517988@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091319.GA517988@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:13:19AM +0200, Ingo Molnar wrote:
> 
> * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Add lock_modules() and unlock_modules() wrappers for acquiring module_mutex
> > in order to remove the compile time dependency to it.
> > 
> > Cc: linux-mm@kvack.org
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  include/linux/module.h      | 18 ++++++++++++++++++
> >  kernel/kprobes.c            |  4 ++--
> >  kernel/trace/trace_kprobe.c |  4 ++--
> >  3 files changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 2e6670860d27..8850b9692b8f 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -705,6 +705,16 @@ static inline bool is_livepatch_module(struct module *mod)
> >  bool is_module_sig_enforced(void);
> >  void set_module_sig_enforced(void);
> >  
> > +static inline void lock_modules(void)
> > +{
> > +	mutex_lock(&module_mutex);
> > +}
> > +
> > +static inline void unlock_modules(void)
> > +{
> > +	mutex_unlock(&module_mutex);
> > +}
> > +
> >  #else /* !CONFIG_MODULES... */
> >  
> >  static inline struct module *__module_address(unsigned long addr)
> > @@ -852,6 +862,14 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
> >  	return ptr;
> >  }
> >  
> > +static inline void lock_modules(void)
> > +{
> > +}
> > +
> > +static inline void unlock_modules(void)
> > +{
> > +}
> 
> Minor namespace nit: when introducing new locking wrappers please 
> standardize on the XYZ_lock()/XYZ_unlock() nomenclature, i.e.:
> 
> 	modules_lock()
> 	...
> 	modules_unlock()
> 
> Similarly to the mutex_lock/unlock(&module_mutex) API that it is 
> wrapping.
> 
> Also, JFYI, the overwhelming majority of the modules related APIs use 
> module_*(), i.e. singular - not plural, so 
> module_lock()/module_unlock() would be the more canonical choice. 
> (But both sound fine to me)

Thanks, I renamed them as module_lock() and module_unlock().

> Thanks,
> 
> 	Ingo

/Jarkko
