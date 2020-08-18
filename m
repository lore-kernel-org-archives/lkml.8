Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0EA20855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597732063;
	bh=6sam980i8nu2tM59pReLKjc8Vd78afzBLEkduMMs5Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pmyqYCgFF0GHznw6B+GPVEBKe7z+4XZcocHg1I7V8HspghcSw0+JeQPqhWkyCbOcb
	 c8EOTRyvHF1V071qrN9wVB0MA8Z0oLRba9i7akRhc7V4qw0trTYsTuej2j60vKOWVw
	 cFDbQaxhE5fU8oo1WrUrpLMY0rgUzprqzHgfS92E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgHRG1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgHRG1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:27:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95FE20829;
        Tue, 18 Aug 2020 06:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597732060;
        bh=6sam980i8nu2tM59pReLKjc8Vd78afzBLEkduMMs5Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQMzmJqMKAa/Q6GxxrH0+XkN6TZlv//VGpLUEmUtSUjDnuqpR0j1T4LYqbXzwMv5+
         HzmM+kZtwVlSJFq2jbFzpHcTckaAUVnOUk7eBNxZQ4RHN43yUTgewxLj6YQv+5NvcT
         QtCLtIyHvOFB/yS2uTmzSMm2/kEYhojin+3MPMAw=
Date:   Tue, 18 Aug 2020 09:27:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     dsterba@suse.cz, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] overflow: Add __must_check attribute to check_*()
 helpers
Message-ID: <20200818062736.GL7555@unreal>
References: <202008151007.EF679DF@keescook>
 <20200817090854.GA2026@twin.jikos.cz>
 <202008171235.816B3AD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008171235.816B3AD@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:36:51PM -0700, Kees Cook wrote:
> On Mon, Aug 17, 2020 at 11:08:54AM +0200, David Sterba wrote:
> > On Sat, Aug 15, 2020 at 10:09:24AM -0700, Kees Cook wrote:
> > > +static inline bool __must_check __must_check_overflow(bool overflow)
> > > +{
> > > +	return unlikely(overflow);
> >
> > How does the 'unlikely' hint propagate through return? It is in a static
> > inline so compiler has complete information in order to use it, but I'm
> > curious if it actually does.
>
> It may not -- it depends on how the compiler decides to deal with it. :)

In theory yes, in practice, the compilers will ignore this macro.

And if you success to force compiler to use this macro, it won't give
any real performance advantage.

We (RDMA) tried very hard to see any performance gain by instrumenting
code with likely/unlikely in our performance critical data path both in
user space and kernel. The performance results were statistically equal.

If you are interested, we had a very intense discussion about it when
likely/unlikely can still be usable (hint random input).
https://lore.kernel.org/linux-rdma/20200807160956.GO4432@unreal

Thanks

>
> > In case the hint gets dropped, the fix would probably be
> >
> > #define check_add_overflow(a, b, d) unlikely(__must_check_overflow(({	\
> >  	typeof(a) __a = (a);			\
> >  	typeof(b) __b = (b);			\
> >  	typeof(d) __d = (d);			\
> >  	(void) (&__a == &__b);			\
> >  	(void) (&__a == __d);			\
> >  	__builtin_add_overflow(__a, __b, __d);	\
> > })))
>
> Unfortunately not, as the unlikely() ends up eating the __must_check
> attribute. :(
>
> --
> Kees Cook
