Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27BFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D6A221FC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glRGH8Of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGNLGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:06:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7jndsVP9Agsh8Uleq86Hg05NfnxHBPcz1QZjPDkyQeY=; b=glRGH8OfBplt8LdPh0C09MXBox
        9QMDN8dcRfKdyzkWiCer/cLemNCt9biis8i10hyLiiQ50KqcQrG7nFcgfddyjodcRma0NkyHjIhcy
        108bwPXkG938piF+WDxiwmWcIUgTmt97wHkpGUvao81c1RjC0cWrRkjy3fa34k6oeGoKjjeNG6yIT
        BrOBFxLtvXTwtjOHDifYsaXNGi+X6rhs1FgxV7aoGZThTJQzpG6tpajK9eG9SbupY55nqmx29be9m
        2txdp+eUAxq3xzaCw7KYH+29NNLsV4nsOhUjEAphiv+PWRhEFwhuRQd/fK/U4G/T/w3ww7zYSNlct
        Dn7/k6Cg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvIkv-0006HL-TA; Tue, 14 Jul 2020 11:05:49 +0000
Date:   Tue, 14 Jul 2020 12:05:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Uwe Kleine-K??nig <uwe@kleine-koenig.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        Petr Mladek <pmladek@suse.com>, zaslonko@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Gow <davidgow@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] lib: Add a generic copy_oldmem_page()
Message-ID: <20200714110549.GA22613@infradead.org>
References: <20200711035544.2832154-1-palmer@dabbelt.com>
 <20200711035544.2832154-2-palmer@dabbelt.com>
 <20200713130632.GA29945@infradead.org>
 <CAK8P3a0F4JSBAG5B=GRFF9Aw0kJaNd=cph86sHqjAtiONUA-Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0F4JSBAG5B=GRFF9Aw0kJaNd=cph86sHqjAtiONUA-Bw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:39:17PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 13, 2020 at 3:07 PM Christoph Hellwig <hch@infradead.org> wrote:
> > On Fri, Jul 10, 2020 at 08:55:42PM -0700, Palmer Dabbelt wrote:
> > > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > > +                      size_t csize, unsigned long offset,
> > > +                      int userbuf)
> > > +{
> > > +     void *vaddr;
> > > +
> > > +     if (!csize)
> > > +             return 0;
> > > +
> > > +     vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> > > +     if (!vaddr)
> > > +             return -ENOMEM;
> >
> > Doing a memremap for every page is very inefficient.  Also I don't see
> > why you'd want to even do that.  All memory is in the direct mapping
> > for RISC-V.  For other architecture that support highmem kmap_atomic_pfn
> > would do the job, which is what I'd use in a generic version.
> 
> I would expect the 'oldmem' data to not have a 'struct page', which would
> be a problem at least for the generic implementation of kmap_atomic_pfn()

Why do you expect it to not have a struct page?
