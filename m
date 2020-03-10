Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF5EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7282F20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583865169;
	bh=quuHdrlhT13p1QBQupcbdb0Ul/TP78y+7Gaad2Ei5vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdmq0KPeP2ssFIA8bknVuBxRe9eATU8IAFw7WYwmYdz+LWyCvU9x4grZDxdnEjZq1
	 BJyvTna4Uk/6KNs6Qi1pw22TnYv2fM7sFbS9LEKYX67cDwSaSXdXgKa1L0qF1Ui+Uf
	 7AZ+sauONHXbIMumpfE/YK6QfmeMqRpDRDp0xfmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgCJScs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCJScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:32:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E2821D56;
        Tue, 10 Mar 2020 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583865166;
        bh=quuHdrlhT13p1QBQupcbdb0Ul/TP78y+7Gaad2Ei5vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPQmwnbpHnQiIRgGC5PMbqIMFl6cPmv72B+Ke7IYrG1drSiNR4kgQb2CKSlthAYTY
         89F+NGrAAxewUNj1eS8YFJcKWynUs+gEHZhI1BXpRzk3EZvhLTNtqCZ14wEP+5Bcfn
         FhYpeAyDwnx7d2UFvpJhAYJ7QF4wtax6bwybhem4=
Date:   Tue, 10 Mar 2020 19:32:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sladyn Nunes <sladynlinuxkernel@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: base: platform.c: Fix coding style issue.
Message-ID: <20200310183244.GA3485635@kroah.com>
References: <20200310181712.884-1-sladynlinuxkernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310181712.884-1-sladynlinuxkernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:47:12PM +0530, Sladyn Nunes wrote:
> Fixed whitespace and coding style issues in the
> document.
> 
> Signed-off-by: Sladyn Nunes <sladynlinuxkernel@gmail.com>
> ---
>  drivers/base/platform.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..0da339e14437 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -552,7 +552,8 @@ int platform_device_add(struct platform_device *pdev)
>  		if (p) {
>  			ret = insert_resource(p, r);
>  			if (ret) {
> -				dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> +				dev_err(&pdev->dev, "failed to claim resource %d: %pR\n",
> +						 i, r);
>  				goto failed;
>  			}
>  		}
> @@ -573,6 +574,7 @@ int platform_device_add(struct platform_device *pdev)
>  
>  	while (i--) {
>  		struct resource *r = &pdev->resource[i];
> +
>  		if (r->parent)
>  			release_resource(r);
>  	}
> @@ -604,6 +606,7 @@ void platform_device_del(struct platform_device *pdev)
>  
>  		for (i = 0; i < pdev->num_resources; i++) {
>  			struct resource *r = &pdev->resource[i];
> +
>  			if (r->parent)
>  				release_resource(r);
>  		}
> @@ -997,7 +1000,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
>  	if (len != -ENODEV)
>  		return len;
>  
> -	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
> +	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
>  	if (len != -ENODEV)
>  		return len;
>  
> -- 
> 2.18.0
> 

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
