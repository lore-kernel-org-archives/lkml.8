Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB36FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DE020657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684912;
	bh=bt8auQMASs61Uors6Csh903y3WqUBEQ+mJDO41OeRX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R27BHdYELAnCpQG01TAadJ5vUiC9su/eTgtsFt5D3tF+t8pDpfzdD29KGWIDfGjKR
	 m6LUC3Qk3Wk1wBg3pl3M8fwOJe4VKYK+yE8kuZBC7hUlQFRl7tE8ptkkbMKadrDAJo
	 WSEDQ9L3BOZTqn1WaMdIYxtANkwRlqFQq5QP3DxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbgHQRVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbgHQQWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6C02063A;
        Mon, 17 Aug 2020 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597681371;
        bh=bt8auQMASs61Uors6Csh903y3WqUBEQ+mJDO41OeRX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsdV5+swurJnpwiMu+96tzx7cgZ4BuNmSQ0jSLzhF5k5sFvj2UFTAW2e7hSy2t4dp
         6ZnLQ28n8Oc+gFoEgZJXnPpxKvo+cxYIS+cj3SQVPmv2E7St+8JYqs1Jw/t35cKehI
         +Fx7MPQYVzw/BiClKvdjnymBgmdKF/7rb77mED34=
Date:   Mon, 17 Aug 2020 17:48:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        h.peter.anvin@intel.com, tglx@linutronix.de, corbet@lwn.net,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] [v2] Documentation: clarify driver licensing rules
Message-ID: <20200817154831.GF699147@kroah.com>
References: <20200814145625.8B708079@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814145625.8B708079@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:56:25AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Greg has challenged some recent driver submitters on their license
> choices. He was correct to do so, as the choices in these instances
> did not always advance the aims of the submitters.
> 
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
> 
> As written, these appear a _bit_ more laissez faire than we've been in
> practice lately. It sounds like we at least expect submitters to make
> a well-reasoned license choice and to explain their rationale. It does
> not appear that we blindly accept anything that is simply
> GPLv2-compatible.
> 
> Drivers appear to be the most acute source of misunderstanding, so fix
> the driver documentation first. Update it to clarify expectations.
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
> 
> --
> 
> Changes from v1:
>  * Remove mention of maintainers enforcing particular license
>    choices.
>  * Change the wording to ensure that folks understand that the
>    trigger that requires an explanation is not multiple
>    licenses per se, but non-GPL licenses.  You could argue that
>    GPLv2-or-later is multiple liceses, for instance.
> ---
> 
>  b/Documentation/process/submitting-drivers.rst |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff -puN Documentation/process/submitting-drivers.rst~clarify-dual-licensing Documentation/process/submitting-drivers.rst
> --- a/Documentation/process/submitting-drivers.rst~clarify-dual-licensing	2020-08-14 07:42:06.300480229 -0700
> +++ b/Documentation/process/submitting-drivers.rst	2020-08-14 07:53:10.373478573 -0700
> @@ -60,10 +60,11 @@ What Criteria Determine Acceptance
>  
>  Licensing:
>  		The code must be released to us under the
> -		GNU General Public License. We don't insist on any kind
> -		of exclusive GPL licensing, and if you wish the driver
> -		to be useful to other communities such as BSD you may well
> -		wish to release under multiple licenses.
> +		GNU General Public License. If you wish the driver to be
> +		useful to other communities such as BSD you may release
> +		under multiple licenses. If you choose to release under
> +		licenses other than the GPL, you should include your
> +		rationale for your license choices in your cover letter.
>  		See accepted licenses at include/linux/module.h
>  
>  Copyright:
> _

Looks good, thanks for the modifications:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
