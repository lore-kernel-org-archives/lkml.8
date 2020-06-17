Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282D9206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592373327;
	bh=CZ5HCt+0GUicwcyUHaA/NsM5WdKI29lnhh1xbvG3IC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qSxtx/4u8UwlNgbPkbU7Df7Kw4QIJqMTvTWFJATEgKdL0KhgL7PQ7LlL8h0lYV+63
	 H2dc+boBzUP7NlBscn/8K7JUn7shHBdP8zKXqq6YZh76fXH0GtQlU3yqcVINYGrqhI
	 CKJOgR3VC9qZwt2QD4ozIP6g+r5tLYWxpos0A/Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgFQFy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgFQFy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:54:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F682073E;
        Wed, 17 Jun 2020 05:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592373298;
        bh=CZ5HCt+0GUicwcyUHaA/NsM5WdKI29lnhh1xbvG3IC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0Sb2PPmzBlg03Sx0ki76X7WpR+ZAP+lfkzqhUZwSCcUQnZABPGmwfJLNs3sZaOWJ
         Mhknm/iwa6Ga34gkVOWHQK65vwqLgocpColXC+cvLZvEW9tAqeSES2yiQlqtbdnNnB
         9XTU3uKKIIBXVSIZsKYQ61M3Ic2whfYDaEMrKX10=
Date:   Wed, 17 Jun 2020 07:54:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan love <danlovecomputing@gmail.com>
Cc:     danlove99@hotmail.co.uk, devel@driverdev.osuosl.org,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH] Fixed styling issues by adding blank line after
 definitions.
Message-ID: <20200617055455.GA25631@kroah.com>
References: <20200616202658.4844-1-danlove99@hotmail.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616202658.4844-1-danlove99@hotmail.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:26:55PM +0100, dan love wrote:
> Signed-off-by: dan love <danlove99@hotmail.co.uk>
> ---
>  drivers/staging/comedi/comedi_fops.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index e85a99b68f31..3f70e5dfac39 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -2169,6 +2169,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	case COMEDI_CHANINFO: {
>  		struct comedi_chaninfo it;
> +
>  		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
>  			rc = -EFAULT;
>  		else
> @@ -2177,6 +2178,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
>  	}
>  	case COMEDI_RANGEINFO: {
>  		struct comedi_rangeinfo it;
> +
>  		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
>  			rc = -EFAULT;
>  		else
> @@ -2249,6 +2251,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
>  	}
>  	case COMEDI_INSN: {
>  		struct comedi_insn insn;
> +
>  		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
>  			rc = -EFAULT;
>  		else
> -- 
> 2.17.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

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
