Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A87B206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgGYCmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:42:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:54897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgGYCmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:42:36 -0400
IronPort-SDR: goKgeQwo2mOtQ0JcjcK5wxvYRoRlpK9oiSZ70GbJQrP8olXCdKR+wilpVtUoRCrcbgp4LWXO+A
 6eAPgcj9XHgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="212347667"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="212347667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 19:42:35 -0700
IronPort-SDR: ArZtovrTuEknoHpXF3r2UNSBsH29C8gxRtnXKA99J97c9grFiVIGXA6lSXuZzbVr3eB2unn4z3
 duHothXOFaxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="272738452"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 19:42:29 -0700
Date:   Sat, 25 Jul 2020 05:42:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20200725024227.GD17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
 <20200724102258.GB2831654@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724102258.GB2831654@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:22:58PM +0300, Mike Rapoport wrote:
> On Fri, Jul 24, 2020 at 08:05:48AM +0300, Jarkko Sakkinen wrote:
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
> 
> Any reason to convert only kprobes to the new API and leave others with
> opencoded implementation?

Not anything particular.

Lets see:

$ git --no-pager grep "mutex_lock(&module_mutex)"
arch/powerpc/platforms/powernv/pci-cxl.c:       mutex_lock(&module_mutex);
drivers/gpu/drm/drm_fb_helper.c:        mutex_lock(&module_mutex);
include/linux/module.h: mutex_lock(&module_mutex);
kernel/livepatch/core.c:        mutex_lock(&module_mutex);
kernel/livepatch/core.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);
kernel/module.c:        mutex_lock(&module_mutex);

I could refine this commit to patch these sites. Or should I split it
into multiple?

/Jarkko
