Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1972CC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18AB20768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGWWQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:16:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:10832 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgGWWQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:16:47 -0400
IronPort-SDR: nHUY36t2DcBT1yQrOzqVynsjkKZG21Z/LzoT3piXL3m+M0m9JHx79WE5Ml05hs4DY1EGSBzXdp
 hkX5RW0aSLRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138128464"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="138128464"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 15:16:46 -0700
IronPort-SDR: V939IbIU7jgZMLRY5uUc3S7pa7nRtDFDXiaNUpI1sa39DjRWaFPV99BrskLU1+H7OriLgMPxCV
 SMAaJ/BbYxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="432889200"
Received: from abdelh1x-mobl.amr.corp.intel.com (HELO localhost) ([10.249.38.107])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2020 15:16:42 -0700
Date:   Fri, 24 Jul 2020 01:16:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 5/7] arch/x86: kprobes: Use text_alloc() in
 alloc_insn_page()
Message-ID: <20200723221641.GA12405@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
 <20200717030422.679972-6-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717030422.679972-6-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:04:19AM +0300, Jarkko Sakkinen wrote:
> Use text_alloc() as part of the arch specific implementation for
> alloc_insn_page().
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>Im
> ---
>  arch/x86/kernel/kprobes/core.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index ada39ddbc922..0f20a3e52a06 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -423,7 +423,7 @@ void *alloc_insn_page(void)
>  {
>  	void *page;
>  
> -	page = module_alloc(PAGE_SIZE);
> +	page = text_alloc(PAGE_SIZE);
>  	if (!page)
>  		return NULL;
>  
> @@ -443,12 +443,6 @@ void *alloc_insn_page(void)
>  	return page;
>  }
>  
> -/* Recover page to RW mode before releasing it */
> -void free_insn_page(void *page)
> -{
> -	module_memfree(page);

This must be a mistake. Should be just changed to call text_memfree().

Probably just my clumsiness when refactoring the series.

> -}
> -
>  static int arch_copy_kprobe(struct kprobe *p)
>  {
>  	struct insn insn;
> -- 
> 2.25.1
> 

/Jarkko
