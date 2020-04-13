Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB807C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83E9206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cOXAiD8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgDMVQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:16:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34936 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388795AbgDMVQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=idZP78QLfRjhluguquTHPSQeRBXMkj6qqFAj2rwGa5w=; b=cOXAiD8Z/xYKoms96+wgVqIB23
        M6eSFqZbbD7Lcbr7Iy9lPSGpmY+zjW1RGpWYDh5z7H7xnxizf6McwVPLyGt6bcJI1dOYWkTChf31P
        nQbZp+BPnlKBjaUGQdbAjrDxq2f3JIL6L6mgeYUC/ISqV2z+tzJDTXoJU97JWRggxV6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jO6Q8-002W4d-Hz; Mon, 13 Apr 2020 23:15:08 +0200
Date:   Mon, 13 Apr 2020 23:15:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jian Cai <caij2003@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200413211508.GE436020@lunn.ch>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAKwvOdnpW0VSRdD6958xyWh-tDbuVTti265aqOpvfhvh6iQEXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnpW0VSRdD6958xyWh-tDbuVTti265aqOpvfhvh6iQEXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:20:57PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 10, 2020 at 2:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Apr 10, 2020 at 1:28 AM Jian Cai <caij2003@gmail.com> wrote:
> > >
> > > iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> > > Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> > > kernel.
> > >
> > > Signed-off-by: Jian Cai <caij2003@gmail.com>
> >
> > It clearly makes sense to limit the Kconfig option to compilers that
> > can actually build it.
> > A few questions though:
> >
> > - Given that Armada XP with its PJ4B was still marketed until fairly
> > recently[1],
> >   wouldn't it make sense to still add support for it? Is it a lot of work?
> 
> Sorry, can you help me verify from that link that PJ4B uses XSCALE?

I think you missed my email. iwmmxt is not Xscale. iwmmxt is an
instruction set of its own, which any ARM processor could implement.

> I
> didn't see references to either in the link provided.  Also, given the
> history of XSCALE as noted by Russell, I'm surprised to see Marvell in
> the mix.

https://en.wikipedia.org/wiki/XScale

	XScale comprises several distinct families: IXP, IXC, IOP, PXA
	and CE.

	Intel sold the PXA family to Marvell Technology Group
	in June 2006.[1] Marvell then extended the brand to include
	processors with other microarchitectures, like ARM's Cortex.

	Andrew
