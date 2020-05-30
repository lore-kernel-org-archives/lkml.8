Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB90C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED182081A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590825007;
	bh=odIQ9XYXXYLEraahEyDwcgoixt83SXMPbzv9b4r2xn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wacrVoDuqbUvUwqGxfzt4Fn5fgtKeWQfg3HJU/cfUSNs9cE9j6cAZbB2rYc30mwAF
	 ykqtX8wp9HEOI1uQ4qe8YrClsr9Ag4odvnPlakOtn97ZIotNfIlerHOqvtfcCdsoKz
	 RVXQy89G7l4n1R3oQSnADXrax3tNPT7iXX6jmmRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3HuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgE3HuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:50:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1337B20723;
        Sat, 30 May 2020 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590825005;
        bh=odIQ9XYXXYLEraahEyDwcgoixt83SXMPbzv9b4r2xn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX3bvRcVikk/Bh6DY6AwRWhJ6fXSIEGClCh2vHaKxG3YFaFMLC+wj1IIFeyjAGu9s
         bSRHj3qZM1pkw6mBMB5JRDknK4Rfsrth4txBm3h4y5uA4HjohsnY8PODQv7IvP8RbU
         vP8kx1VHoAe2tHjN/wgmAvInennmTdQG9AzjX3gc=
Date:   Sat, 30 May 2020 09:50:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        alexios.zavras@intel.com, tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH v2] misc: mic: Remove the error message as the call will
 print it
Message-ID: <20200530075001.GA3596685@kroah.com>
References: <1590824041-36500-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590824041-36500-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 03:34:01PM +0800, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> The message should just be dropped as the call will print the failure
> message anyway.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
> changes in v2: remove the message instead of changing it.
> 
>  drivers/misc/mic/host/mic_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
> index be0784f..ea46085 100644
> --- a/drivers/misc/mic/host/mic_main.c
> +++ b/drivers/misc/mic/host/mic_main.c
> @@ -164,7 +164,6 @@ static int mic_probe(struct pci_dev *pdev,
>  	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
>  	if (!mdev) {
>  		rc = -ENOMEM;
> -		dev_err(&pdev->dev, "mdev kmalloc failed rc %d\n", rc);
>  		goto mdev_alloc_fail;
>  	}
>  	mdev->id = ida_simple_get(&g_mic_ida, 0, MIC_MAX_NUM_DEVS, GFP_KERNEL);
> -- 
> 2.9.5
> 




Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot
