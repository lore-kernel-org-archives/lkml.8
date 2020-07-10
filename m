Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E33DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5FC2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594367281;
	bh=Czp+iUVSYddYrsMk7jxb00FNGqS6qkilhOBeFNdRf9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NgnjlpIU8h81qKSgID6H4b9qRvAQZrd+WxMN6VrOp/+3H999Z27rgARNgmVWolJxD
	 4dKd6gqj1589rK31LB3ZBuBfSuLA2QubmtLrKIaHMaCa1FIWD65YuVyagVQLgmLHJC
	 G8hEg5J+NOEc4PkfMLmU8KJVoHsijKKN+FmR4Rw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJHsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgGJHr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:47:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8133D206A5;
        Fri, 10 Jul 2020 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594367279;
        bh=Czp+iUVSYddYrsMk7jxb00FNGqS6qkilhOBeFNdRf9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjXzhynPX8+zn/6APk/ebUGfFppkLn7g19XzESmYHZA9vZmb0ul4lybT1w7Oh1Lto
         P6o9P5qvh2vaKwxSMVIDcSPsEQYWwbxLH1zkm1Q1Fm/KgDbSmpnlueVgr7dzPosnA2
         6ADH8bCs+3EDwoN7JF0c3goV9GLOuma1Dachihww=
Date:   Fri, 10 Jul 2020 09:48:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: fsl-mc: fix invalid free in fsl_mc_device_add
Message-ID: <20200710074804.GE1179998@kroah.com>
References: <20200709153119.5051-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709153119.5051-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:31:19AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this error
> 
> fsl-mc-bus.c:695:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(mc_dev);
>         ^~~~~~~~~~~~~
> 
> The problem block of code is
> 
> 		mc_bus = kzalloc(sizeof(*mc_bus), GFP_KERNEL);
> 		if (!mc_bus)
> 			return -ENOMEM;
> 
> 		mc_dev = &mc_bus->mc_dev;
> 
> mc_bus's structure contains a mc_dev element,
> freeing it later is not appropriate.
> 
> So check if mc_bus was allocated before freeing mc_dev
> 
> This is a case where checkpatch
> 
> WARNING: kfree(NULL) is safe and this check is probably not required
> +	if (mc_bus)
> +		kfree(mc_bus);
> 
> is wrong.
> 
> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  v1: add a comment to explain freeing uniqueness
>  v2: add gregkh's suggestion to comment.
>  
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 40526da5c6a6..839d96d03f0d 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -691,8 +691,16 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  
>  error_cleanup_dev:
>  	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);
> +	/*
> +	 * mc_bus allocates a private version of mc_dev
> +	 * it is not appropriate to free the private version.
> +	 * Which means we have to check the pointer before freeing it.
> +	 * Do not remove this check.
> +	 */
> +	if (mc_bus)
> +		kfree(mc_bus);
> +	else
> +		kfree(mc_dev);
>  
>  	return error;
>  }
> -- 
> 2.18.1
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Also add a cc: stable to this please when it is applied to a tree, in
the proper place, as it fixes a bug.

thanks,

greg k-h
