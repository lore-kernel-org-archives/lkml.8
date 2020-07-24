Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7274C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C065120714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGXHBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:01:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:50659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgGXHBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:01:21 -0400
IronPort-SDR: pFbzpoJiBnbDzraEPMyvnqH2OFySzKHeW2Wfv2VrA/mKFYXexUVGiejZuQ20ZGlKY4aeTwEUxb
 ztCdHjmvpRCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150653763"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="150653763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 00:01:21 -0700
IronPort-SDR: B2ZkeVsNbC1TL2UgERXWT+X+mLWOrsf2xDSTHXBt3soZPstyH/CXEcPindDaacqcnldLUK9Ohs
 LSQJcxn/K02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="284845692"
Received: from cbuerkle-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.36.184])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2020 00:01:18 -0700
Date:   Fri, 24 Jul 2020 10:01:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/6] arch/x86: kprobes: Remove MODULES dependency
Message-ID: <20200724070116.GA1872085@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:05:47AM +0300, Jarkko Sakkinen wrote:
> Remove MODULES dependency by migrating from module_alloc() to the new
> text_alloc() API. Essentially these changes provide preliminaries for
> allowing to compile a static kernel with a proper tracing support.
> 
> The same API can be used later on in other sites that allocate space for
> trampolines, and trivially scaled to other arch's. An arch can inform
> with CONFIG_ARCH_HAS_TEXT_ALLOC that it's providing implementation for
> text_alloc().
> 
> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> v4:
> * Squash lock_modules() patches into one.
> * Remove fallback versions of text_alloc() and text_free(). Instead, use
>   ARCH_HAS_TEXT_ALLOC at site when required.
> * Use lockdep_assert_irqs_enabled() in text_free() instead of
>   WARN_ON(in_interrupt()).
> 
> v3:
> * Make text_alloc() API disjoint.
> * Remove all the possible extra clutter not absolutely required and
>   split into more logical pieces.
> 
> Jarkko Sakkinen (6):
>   kprobes: Remove dependency to the module_mutex
>   vmalloc: Add text_alloc() and text_free()
>   arch/x86: Implement text_alloc() and text_free()
>   arch/x86: kprobes: Use text_alloc() and text_free()
>   kprobes: Use text_alloc() and text_free()
>   kprobes: Remove CONFIG_MODULES dependency
> 
>  arch/Kconfig                   |  2 +-
>  arch/x86/Kconfig               |  3 ++
>  arch/x86/kernel/Makefile       |  1 +
>  arch/x86/kernel/kprobes/core.c |  4 +--
>  arch/x86/kernel/text_alloc.c   | 41 +++++++++++++++++++++++
>  include/linux/module.h         | 32 ++++++++++++++----
>  include/linux/vmalloc.h        | 17 ++++++++++
>  kernel/kprobes.c               | 61 +++++++++++++++++++++++-----------
>  kernel/trace/trace_kprobe.c    | 20 ++++++++---
>  9 files changed, 147 insertions(+), 34 deletions(-)
>  create mode 100644 arch/x86/kernel/text_alloc.c
> 
> -- 
> 2.25.1
> 

Duplicates were caused by Internet connection breaking up in the
middle. Apologies.

/Jarkko
