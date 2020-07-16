Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EF22074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWTmzh05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgGPJDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgGPJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:03:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B60C061755;
        Thu, 16 Jul 2020 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e61STVzmvtcU26/gTnsoAUvU2jG9R5G2Meed7diTLDI=; b=lWTmzh055UUr2BQQyP1bzO+OPL
        6PZShHzLC3ec1bA+WQlbevXX+P/XBH+g29WI5sve0+YnzGPofonq0rfSYbZd+PtG2WtIKmxgQ2JrR
        GfXu+YHPj3ii/vyxCXnoUPjhMDUhdmKRsUJmQIh2I2OsS0nh7+eW//wx9EOlhK9pnAYKqoZljXcL4
        u+nnuaAfjotC6rxL5/VdGbUQOzFLU0O6cjwNIDxlmd86xZvvECX+KtfdPrAUCtb79dr/56vvxVIv2
        TubtAdOwJofAtoqXJRYU3wHAAaFi7eGHzVW5/pOUs/HkVfHqtqykMO7XAhQJVqSbXsabY85Z4edI+
        AVtsaVmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvzn5-0001xz-FC; Thu, 16 Jul 2020 09:02:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D049305E21;
        Thu, 16 Jul 2020 11:02:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33849207A6644; Thu, 16 Jul 2020 11:02:53 +0200 (CEST)
Date:   Thu, 16 Jul 2020 11:02:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Babu Moger <Babu.Moger@amd.com>,
        Omar Sandoval <osandov@fb.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] kprobes: Add text_alloc() and text_free()
Message-ID: <20200716090253.GP10769@hirez.programming.kicks-ass.net>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:32:27AM +0300, Jarkko Sakkinen wrote:
> +void *text_alloc(unsigned long size)
> +{
> +	void *p;
> +
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +
> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> +				    MODULES_VADDR + get_module_load_offset(),
> +				    MODULES_END, GFP_KERNEL,
> +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +	if (p && (kasan_module_alloc(p, size) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	return p;
> +}
> +
> +void text_free(void *region)
> +{
> +	/*
> +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> +	 * supported by vmalloc.
> +	 */
> +	WARN_ON(in_interrupt());

I think that wants to be:

	lockdep_assert_irqs_enabled();

in_interrupt() isn't sufficient, interrupts must also not be disabled
when issuesing TLB invalidations.

> +
> +	vfree(region);
> +}
