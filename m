Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E87C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2447D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M5uPLARN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgGMNH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgGMNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:07:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5913FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OqcpgdOdGZwi6J+uiLg6n6Rw5mDd47NeVWUGd6LWGdM=; b=M5uPLARN24iL+ApD0GZi56Vlc5
        Dty5/OdSlJsVN1jTIxk4HQKJcGhGAwSgX07MSHpP47Nv7DlaTsbWyKf3gzYEeCAwF1vbcZkuJfGdc
        f52z2EO3vdO+OwPRfr2ozmWZc5NJ/ZrbF+jnXj10Jz90RfTaECMWPg8XFOuX/sfllFaQgRiRIDjZS
        6V4JbqvNpNzaH7aPXz2UgJ5LeqHuZ+ZvchIw72KSHDzStVqlaaxgK3jACmrFmrwmwjPl4siGjHH9x
        YCACeU6TrwZh5N6FncIFiQbO6BM62nmCh8pkBhSRaEu64gnTWoMolXtgUIb/7t9isChq1DT29vM1c
        aLYz6yZw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juyAC-0000PB-3U; Mon, 13 Jul 2020 13:06:32 +0000
Date:   Mon, 13 Jul 2020 14:06:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, mark.rutland@arm.com, gregory.0xf0@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        linus.walleij@linaro.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        brendanhiggins@google.com, elver@google.com, glider@google.com,
        krzk@kernel.org, mchehab+samsung@kernel.org, will@kernel.org,
        mingo@kernel.org, uwe@kleine-koenig.org,
        takahiro.akashi@linaro.org, paulmck@kernel.org,
        masahiroy@kernel.org, linux@armlinux.org.uk, willy@infradead.org,
        rppt@linux.ibm.com, bgolaszewski@baylibre.com,
        kernel-team@android.com, pmladek@suse.com, zaslonko@linux.ibm.com,
        keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>,
        broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        ben-linux@fluff.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, davidgow@google.com,
        rdunlap@infradead.org, Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org, ardb@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [PATCH 1/3] lib: Add a generic copy_oldmem_page()
Message-ID: <20200713130632.GA29945@infradead.org>
References: <20200711035544.2832154-1-palmer@dabbelt.com>
 <20200711035544.2832154-2-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711035544.2832154-2-palmer@dabbelt.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:55:42PM -0700, Palmer Dabbelt wrote:
> +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> +			 size_t csize, unsigned long offset,
> +			 int userbuf)
> +{
> +	void *vaddr;
> +
> +	if (!csize)
> +		return 0;
> +
> +	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> +	if (!vaddr)
> +		return -ENOMEM;

Doing a memremap for every page is very inefficient.  Also I don't see
why you'd want to even do that.  All memory is in the direct mapping
for RISC-V.  For other architecture that support highmem kmap_atomic_pfn
would do the job, which is what I'd use in a generic version.
