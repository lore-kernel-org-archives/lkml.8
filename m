Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA13C433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B181120737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXXix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:38:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:48289 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgGXXiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:38:52 -0400
IronPort-SDR: A05C+Xmg/24AWZ8XWCC49We/KZXqTG3zxZ5R7OU3VFq4Ozu1+Fj+WoGC8eAZi3f6sq5Y1opxbU
 p4QPAu3hRiCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="148705546"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="148705546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 16:38:50 -0700
IronPort-SDR: FHY2QQkrnx0GfAGNW9L2qgado7yMVapEjpsegNmidntYGOZEDhGLPi0Y8c41n6UXiBarj0ycdG
 zyYD4SMfVQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="463392443"
Received: from assenmac-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.15])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2020 16:38:46 -0700
Date:   Sat, 25 Jul 2020 02:38:45 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-ID: <20200724233845.GB1903189@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724102748.GD2831654@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724102748.GD2831654@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:27:48PM +0300, Mike Rapoport wrote:
> On Fri, Jul 24, 2020 at 08:05:52AM +0300, Jarkko Sakkinen wrote:
> > Use text_alloc() and text_free() instead of module_alloc() and
> > module_memfree() when an arch provides them.
> > 
> > Cc: linux-mm@kvack.org
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  kernel/kprobes.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 4e46d96d4e16..611fcda9f6bf 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/errno.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #define KPROBE_HASH_BITS 6
> >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> >  
> >  void __weak *alloc_insn_page(void)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	return text_alloc(PAGE_SIZE);
> > +#else
> >  	return module_alloc(PAGE_SIZE);
> > +#endif
> >  }
> >  
> >  void __weak free_insn_page(void *page)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	text_free(page);
> > +#else
> >  	module_memfree(page);
> > +#endif
> >  }
> 
> Both alloc_insn_page() and free_insn_page() are __weak and can be simple
> overriden in arch/x86 code.

That is correct, but the override is obviously happening at linking time.
module_alloc() and module_memfree() will still leave a compile time
dependency to CONFIG_MODULES.

/Jarkko
