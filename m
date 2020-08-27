Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C17C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77C420848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgH0WpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:45:23 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:36066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgH0WpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:45:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DB2FD180339CD;
        Thu, 27 Aug 2020 22:45:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pies81_1b16d5127070
X-Filterd-Recvd-Size: 3013
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 22:45:19 +0000 (UTC)
Message-ID: <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Denis Efremov <efremov@linux.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Thu, 27 Aug 2020 15:45:17 -0700
In-Reply-To: <202008271517.ECC1F1F8F@keescook>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
         <202008271517.ECC1F1F8F@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 15:20 -0700, Kees Cook wrote:
> On Fri, Aug 28, 2020 at 12:01:34AM +0300, Denis Efremov wrote:
> > Just FYI, I've send an addition to the device_attr_show.cocci script[1] to turn
> > simple cases of snprintf (e.g. "%i") to sprintf. Looks like many developers would
> > like it more than changing snprintf to scnprintf. As for me, I don't like the idea
> > of automated altering of the original logic from bounded snprint to unbouded one
> > with sprintf.
> 
> Agreed. This just makes me cringe. If the API design declares that when
> a show() callback starts, buf has been allocated with PAGE_SIZE bytes,
> then that's how the logic should proceed, and it should be using
> scnprintf...
> 
> show(...) {
> 	size_t remaining = PAGE_SIZE;
> 
> 	...
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 
> 	return PAGE_SIZE - remaining;
> }

It seems likely that coccinelle could do those transform
with any of sprintf/snprintf/scnprint too.

Though my bikeshed would use a single function and have
that function know the maximum output size

Something like:

With single line use:

	return sysfs_emit(buf, buf, fmt, ...) - buf;

and multi-line use:

	char *pos = buf;

	pos = sysfs_emit(buf, pos, fmt1, ...);
	pos = sysfs_emit(buf, pos, fmt2, ...);
	...

	return pos - buf;


