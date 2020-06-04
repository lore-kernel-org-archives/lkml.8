Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D6FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9C8206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591252218;
	bh=KoOz797ANkmPPN74sAtFrplGJex1BX8AxtksGwF5na8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EAm+uR5LVURoZ/DlQ7XAaJMuz30V4XPAw8B1FLBOp5A5/EVxOEkYgtqVsxB0bTUtL
	 r9UmHLoMovN+fUqFLtgNW/6MdsIjfcT8hjpFUfRNYuIcCKyNwXb6M07iL8Rfuok/ls
	 q0DDYgzyExIeHctWVsm+6tfTl+GS8vPjryyCSrHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgFDGaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgFDGaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:30:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A03206DC;
        Thu,  4 Jun 2020 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591252215;
        bh=KoOz797ANkmPPN74sAtFrplGJex1BX8AxtksGwF5na8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2XqBLC1Uzdgsai3RwTEKym/XABfJRl3ZlVp2k5mGazBYDIPUC1vPBuAd35TPaQth
         VvQ+AON5bVsW3efwFRGQS+KzO9nIyMFoGoZ0ciYzdBT8f/LYUYddMEdxuhOhBzUfO2
         VaqmdSe1yg+hqWTP44e4SQeqmHNYMVvoiFaG8dFo=
Date:   Thu, 4 Jun 2020 08:30:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gaurav singh <gaurav1086@gmail.com>
Cc:     tytso@mit.edu, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char_driver_warn_unseeded_randomness: Add null check
Message-ID: <20200604063013.GA322507@kroah.com>
References: <CAFAFadBsL6OKW7e76OvFQuiih_o6iUjoj6QB=RW40gPsEZ17HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAFadBsL6OKW7e76OvFQuiih_o6iUjoj6QB=RW40gPsEZ17HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:29:07PM -0400, gaurav singh wrote:
> File: drivers/char/random.c
> Function: _warn_unseeded_randomness
> 
> There is a check for previous(ptr) before dereferencing:
> 
>     if (print_once ||
>         crng_ready() ||
>         (previous && (caller == READ_ONCE(*previous))))
>         return;
> 
> However, after this, it is dereferenced without checking:
> WRITE_ONCE(*previous, caller);
> 
> To fix this, add a null check
> 
> Please find the patch below. Let me know if there's any issue.
> 
> Thanks,
> Gaurav.
> 
> 
> >From 5e53cbce018c4d57753a6740c22d826bae0aab3f Mon Sep 17 00:00:00 2001
> From: Gaurav Singh <gaurav1086@gmail.com>
> Date: Wed, 3 Jun 2020 22:23:47 -0400
> Subject: [PATCH] char_driver_warn_unseeded_randomness: Add null check for
>  previous
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  drivers/char/random.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 0d10e31fd342..4f1975e7f201 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1526,7 +1526,9 @@ static void _warn_unseeded_randomness(const char
> *func_name, void *caller,
>      crng_ready() ||
>      (previous && (caller == READ_ONCE(*previous))))
>   return;
> - WRITE_ONCE(*previous, caller);
> +
> + if (previous)
> + WRITE_ONCE(*previous, caller);
>  #ifndef CONFIG_WARN_ALL_UNSEEDED_RANDOM
>   print_once = true;
>  #endif
> -- 
> 2.17.1


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
