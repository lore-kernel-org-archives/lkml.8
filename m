Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9206C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CAD2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594301868;
	bh=2vuZwHJp3mjOxu8143EGZCnWFkodnfxtQtk5snUjqqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IUoJVv6cSjoUw0AMNVOEvCiskj5RAeBjy6xJYcDac8B37whkx1QRCs4xnei33WSfM
	 u2zNqHLJxQKcsd1XLdo7T892ZtF4AsFx0OLRAkkbvZb83zMqWA2WQKOcQYoh1bjGiI
	 3KDQPQwwhFGt/BOgc1Bm4mnSlRDciIOPdsC+APso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGINhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgGINhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:37:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B2D206DF;
        Thu,  9 Jul 2020 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594301866;
        bh=2vuZwHJp3mjOxu8143EGZCnWFkodnfxtQtk5snUjqqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KX0hie2/yuamyzxw873zrQ3qC2YPjmba20fFJAjKwYVO4bBV87P9S6QDF6wlZTR4+
         nSGdOidAmPL3NZ7yfDpdl3+RPyHbLECnNhtWG81V58RhhHNLEzhHQLKAqPy/9Gbcv+
         hRTZfguSCce3UmKo0p3vhXJoKowZcV2k9PJrYxfs=
Date:   Thu, 9 Jul 2020 15:37:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: fsl-mc: fix invalid free in fsl_mc_device_add
Message-ID: <20200709133752.GA415380@kroah.com>
References: <20200709124115.5708-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709124115.5708-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 05:41:15AM -0700, trix@redhat.com wrote:
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
>  
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 40526da5c6a6..df10ed430baa 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -691,8 +691,14 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  
>  error_cleanup_dev:
>  	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);

Close, but that still doesn't help with anyone coming along later, how
about adding:

> +	/*
> +	 * mc_bus allocates a private version of mc_dev
> +	 * it is not appropriate to free the private version.

	 * which means we have to check the pointer before freeing it.
	 * Do not remove this check.

thanks,

greg k-h
