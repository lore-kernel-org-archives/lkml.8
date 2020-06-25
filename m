Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C37C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5220724
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593095208;
	bh=OLLnHySUy0BM1cVv/LC0dnyHLT7FW+gZqcpkz6E+X34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TK+suYw+mOyoSlPDbziheLgK8q2ZfWISmk7HEWadVuzbc7sJMw/84O/+qJVSEQnte
	 oJwHQbUFT+pOTjrBMVzr90C2be9qQ1BRWOp5TCP6/+eYlh6/uuIgg9PmYijZftLF1+
	 bjl8v4HIeg/Ea+hGo3jH70xeQ7B/Y+HnHtbJeb4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405379AbgFYO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405189AbgFYO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:26:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086EB20702;
        Thu, 25 Jun 2020 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593095205;
        bh=OLLnHySUy0BM1cVv/LC0dnyHLT7FW+gZqcpkz6E+X34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Lu/wh0cSuAUjB4Ks210wmCD+zAXCtg6qS4F85+7L2advLpnJCckW5v1tnVofugU/
         hPFt1k2+Y3geYz3e9oh/nvtu6179kWVjlTx4Wpz0+ll6I15M9tJzas0hEKRYndz1qe
         JGWRDj6EPUr8tf1y6RFprc+oHzxpuqJxw0EqxNVI=
Date:   Thu, 25 Jun 2020 16:26:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Marc Dietrich <marvin24@gmx.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: changed coding style, line should not end
 with a (
Message-ID: <20200625142641.GA3836036@kroah.com>
References: <20200625135051.msl37vuz5fbgiuz4@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625135051.msl37vuz5fbgiuz4@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 09:50:51AM -0400, B K Karthik wrote:
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 360ec0407740..16afbe1dfdeb 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -382,8 +382,8 @@ static void nvec_request_master(struct work_struct *work)
>  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
>  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
>  		nvec_gpio_set_value(nvec, 0);
> -		err = wait_for_completion_interruptible_timeout(
> -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> +		err = wait_for_completion_interruptible_timeout(&nvec->ec_transfer,
> +						msecs_to_jiffies(5000));
>  
>  		if (err == 0) {
>  			dev_warn(nvec->dev, "timeout waiting for ec transfer\n");
> -- 
> 2.20.1
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
