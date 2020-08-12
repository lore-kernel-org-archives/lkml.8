Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7756CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C3720781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597220622;
	bh=lhDThOiTPgNSzgKF/RniQ33GxO+fED7sAL99/NmPs8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CW3bk6c8VV9IGfbOEck1u39zyTOGn6DDD5xVjYP3j9HVQPgg0xyBCi+7+SZBKjoPc
	 E0ezYhAWrGAL6xoK98MYFp1SV3r7zMDUIZDPN2kHPFbrHnxXJpL1dgR54BarMG6suG
	 oymNZ4rtergVVbeAeru9jGo7+hXe3sesud8tGLtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgHLIXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgHLIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:23:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FCA20774;
        Wed, 12 Aug 2020 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597220620;
        bh=lhDThOiTPgNSzgKF/RniQ33GxO+fED7sAL99/NmPs8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfjurPkIr5/wydgdszFImpHYw+XPJVWVAWTFCkJUp/tv8wDQN+Pf7NvkX3zQPXDp/
         g76KEGSqfgC3oHrMpV0ceK2yWBhSm2opIHOtAEAqLexNIEB3Dpd053WozyfoBZKR5N
         hTPOsjrM/lXBASQ+U+TSS9Wjds+pnovw6lFJ4Yu0=
Date:   Wed, 12 Aug 2020 10:23:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        h.peter.anvin@intel.com, tglx@linutronix.de, corbet@lwn.net,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: clarify driver licensing rules
Message-ID: <20200812082350.GB851575@kroah.com>
References: <20200811171748.F22CD85A@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811171748.F22CD85A@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:17:48AM -0700, Dave Hansen wrote:
> 
> Resend. Something appears to have eaten this on the way to LKML
> (at least) the last time.
> 
> --
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Greg has challenged some recent driver submitters on their license
> choices. He was correct to do so, as the choices in these instances
> did not always advance the aims of the submitters.

And, to be honest, they were totally dumb attempts at doing things that
ended up not doing what they thought they were doing.

> But, this left submitters (and the folks who help them pick licenses)
> a bit confused. They have read things like
> Documentation/process/license-rules.rst which says:
> 
> 	individual source files can have a different license
> 	which is required to be compatible with the GPL-2.0
> 
> and Documentation/process/submitting-drivers.rst:
> 
> 	We don't insist on any kind of exclusive GPL licensing,
> 	and if you wish ... you may well wish to release under
> 	multiple licenses.

Both of these are find, but maybe you need to put:
	"don't try to do stupid things just because you can!"
somewhere in here instead?

> As written, these appear a _bit_ more laissez faire than we've been in
> practice lately. It sounds like we at least expect submitters to make
> a well-reasoned license choice and to explain their rationale. It does
> not appear that we blindly accept anything that is simply
> GPLv2-compatible.

That is correct, we shouldn't.

> Drivers appear to be the most acute source of misunderstanding, so fix
> the driver documentation first. Update it to clarify maintainer
> expectations.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: H. Peter Anvin <h.peter.anvin@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-spdx@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
>  b/Documentation/process/submitting-drivers.rst |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff -puN Documentation/process/submitting-drivers.rst~clarify-dual-licensing Documentation/process/submitting-drivers.rst
> --- a/Documentation/process/submitting-drivers.rst~clarify-dual-licensing	2020-08-11 09:35:55.493109636 -0700
> +++ b/Documentation/process/submitting-drivers.rst	2020-08-11 09:35:55.496109636 -0700
> @@ -59,11 +59,13 @@ What Criteria Determine Acceptance
>  ----------------------------------
>  
>  Licensing:
> -		The code must be released to us under the
> -		GNU General Public License. We don't insist on any kind
> -		of exclusive GPL licensing, and if you wish the driver
> -		to be useful to other communities such as BSD you may well
> -		wish to release under multiple licenses.
> +		The code must be released to us under the GNU General Public
> +		License. While there are no kernel-wide rules, some maintainers
> +		may insist on exclusive GPL licensing by default.

Maintainers should not do that, it is not their place to do so.  They
_can_ push back on, again, stupid things, but in the end, they should
accept anything that is a compatible license with the kernel as it is
really up to the copyright owner as to what license they wish to use.

So while I like the intent here, I don't think this wording change is
good as-is.

As it stands, the text makes sense, but as always, if you have legal
questions, you should be talking to a lawyer, not a kernel developer :)

thanks,

greg k-h
