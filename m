Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D73C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FF420776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgH1IW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:22:28 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:54576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727971AbgH1IW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:22:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 358A4180154A4;
        Fri, 28 Aug 2020 08:22:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: head10_2f0dd8327074
X-Filterd-Recvd-Size: 3029
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 08:22:24 +0000 (UTC)
Message-ID: <a98b0a411abdaf6b58c73322511087f57353fb22.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Fri, 28 Aug 2020 01:22:23 -0700
In-Reply-To: <526af204ddf95f94012c6132d12693852bfe7442.camel@perches.com>
References: <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
         <202008271517.ECC1F1F8F@keescook>
         <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
         <d99c613aa70617f440c51d9413372b858a4ae826.camel@perches.com>
         <202008280056.6442BCC@keescook>
         <526af204ddf95f94012c6132d12693852bfe7442.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-28 at 01:10 -0700, Joe Perches wrote:
> On Fri, 2020-08-28 at 00:58 -0700, Kees Cook wrote:
> > On Thu, Aug 27, 2020 at 09:12:06PM -0700, Joe Perches wrote:
> > > Perhaps something like the below with a sample conversion
> > > that uses single and multiple sysfs_emit uses.
> > 
> > On quick review, I like it. :)
> > 
> > > [...]
> > > +int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
> > > +{
> > > +	int len;
> > > +	va_list args;
> > > +
> > > +	WARN(pos < buf, "pos < buf\n");
> > > +	WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
> > > +	     pos - buf, PAGE_SIZE);
> > > +	if (pos < buf || pos - buf >= PAGE_SIZE)
> > > +		return 0;
> > 
> > This can be:
> > 
> > 	if (WARN(pos < buf, "pos < buf\n") ||
> > 	    WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
> > 		 pos - buf, PAGE_SIZE))
> > 		return 0;
> 
> I have some vague recollection that WARN could be compiled
> away to nothing somehow.  True or false?
> 
> If false, sure, of course, it'd be faster too.

I can't find an instance where WARN doesn't return the
condition.

And likely even faster would be to just show "invalid pos"
instead of specific messages.

	if (WARN(pos < buf || (pos - buf) >= PAGE_SIZE,
		 "Invalid pos\n");
		return 0;

or maybe use WARN_ONCE or no WARN at all.

