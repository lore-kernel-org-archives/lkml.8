Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B06EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31314206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGYCDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:03:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:10563 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgGYCDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:03:43 -0400
IronPort-SDR: VzSoTRReWexKrK5DSxpvJJmxsAteO4rdQiyw1c2p1pIKs6YSEbXUDGxIXn7LTkv4e1poN9k+NZ
 Cb5LZHBST79Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138860358"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="138860358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 19:03:42 -0700
IronPort-SDR: Mus7QtFxGc5I+01QQ6/9guu60jC/CwrKdo9XN2xgRYSOGv+i4qwsf+k8+c/xa5dhIrwPpu+QeU
 a+nojoj5j7Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="311601525"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2020 19:03:34 -0700
Date:   Sat, 25 Jul 2020 05:03:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Brian Gerst <brgerst@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v5 3/6] arch/x86: Implement text_alloc() and text_free()
Message-ID: <20200725020332.GA17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-4-jarkko.sakkinen@linux.intel.com>
 <20200724092258.GC517988@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724092258.GC517988@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:22:58AM +0200, Ingo Molnar wrote:
> 
> * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > +void text_free(void *region)
> > +{
> > +	/*
> > +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> > +	 * supported by vmalloc.
> > +	 */
> > +	lockdep_assert_irqs_enabled();
> > +
> > +	vfree(region);
> 
> Had to dig around a bit to find the source of this restriction. Might 
> make sense to clarify this comment to:
> 
> 	/*
> 	 * This memory may be read-only, and freeing VM_FLUSH_RESET_PERMS memory
> 	 * in an interrupt is not supported by vmalloc.
> 	 */

This definitely clarifies and is a better explanation. I updated the
commit accordingly. Thank you.

> 
> Thanks,
> 
> 	Ingo

/Jarkko
