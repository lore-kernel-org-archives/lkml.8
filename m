Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5992FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352BC2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594282815;
	bh=VtHVBinjqBicZx+s/LTjVloKtWGkZ45x8b0MfyrXuzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qAl2R3KHkMdJbIeqGCXgITqSu+d3+DjyiuC9Fqimvl2CAVkBsy8tYH3sNWQI5SJgz
	 RGer7tWv9YTc61+sQOvxeTvKeZ6KylUekzfHnt/dJWfJbV65NAU6L+2WZdSFzjMhmK
	 q1Oc5PgB0vNOOMHwUOt6dSm1POh1nvK36n6sYs+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGIIUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgGIIUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:20:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C23E206A1;
        Thu,  9 Jul 2020 08:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594282813;
        bh=VtHVBinjqBicZx+s/LTjVloKtWGkZ45x8b0MfyrXuzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mg/YDJ1wWG/tP5tfoDOdEP3yFEMJHA3Yw3MgORau9YzDxMg2VleuJkyt4gz5LPbjm
         C7wws5vFK+QWvbxhRO4rEybSSfp2bV8Zppo1MhIr3BSZ17hmFpU8ZZuKetEq1sa0nd
         oU0pLWzpZ7uaugCSbMlrKfphHrQZTEnp3h3sjDy0=
Date:   Thu, 9 Jul 2020 10:20:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: fix invalid free in fsl_mc_device_add
Message-ID: <20200709082020.GC13487@kroah.com>
References: <20200708184524.1809-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708184524.1809-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:45:24AM -0700, trix@redhat.com wrote:
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
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 40526da5c6a6..7390e56661a0 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -691,8 +691,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  
>  error_cleanup_dev:
>  	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);
> +	if (mc_bus)
> +		kfree(mc_bus);
> +	else
> +		kfree(mc_dev);

You should really put a comment on this saying why you need to do it
this way, otherwise someone will come along and "clean it up" again the
same way in the future.

thanks,

greg k-h
