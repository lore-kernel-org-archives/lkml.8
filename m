Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41799C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F7522314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579620239;
	bh=SPh9mzwvhAdkUs6vC0kUWXdfIIlM4+eJLXXJUm9Egv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n4HttLeIPwLqmfuSns8GwWILk2RmsuzV/fNaUpoW0V1u9fPKsTkfZsBBnbejK6bnA
	 2oET0XBzdYxhXoi9UJLhlM8VZQL4xnNvBzpGMPSdhJoxvN9ZvHPsbjzNzCmAS/qQRn
	 mQQwMhUUGMKCKwO/ZOvS9TPXttxNTbG08Z8SEi/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAUPX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUPX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:23:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2516217F4;
        Tue, 21 Jan 2020 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579620237;
        bh=SPh9mzwvhAdkUs6vC0kUWXdfIIlM4+eJLXXJUm9Egv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAEI4U3SGvRtfioj899ov7S10ysziOtVUxEcw3jlCpLyG7LVWy/xExHC9Vxlin9s2
         vbejJPuMBoxi2D/6GTwXEOhNsd8EiQ8q/RRAX920lIjv1B4PDWrrvOUzl5US6VABXk
         bRXoGZUYWbrMIJw5+PlHp+kLqXerqaP4sNJudB8w=
Date:   Tue, 21 Jan 2020 16:23:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: mt7621-pinctrl: Align to fix warnings of line
 over 80 characters
Message-ID: <20200121152355.GB572414@kroah.com>
References: <20200121134705.GA28240@SandeshPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121134705.GA28240@SandeshPC>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:47:05PM +0100, Sandesh Kenjana Ashok wrote:
> Issue found by checkpatch.
> 
> Signed-off-by: Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index d0f06790d38f..df5da5fce630 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -159,7 +159,8 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
>  }
>  
>  static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
> -						struct pinctrl_gpio_range *range,
> +						struct pinctrl_gpio_range
> +						*range,

Ick, that looks worse now, right?  checkpatch is a guideline, not a
hard-and-fast rule here.

>  						unsigned int pin)
>  {
>  	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
> @@ -218,10 +219,10 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
>  	p->func_count++;
>  
>  	/* allocate our function and group mapping index buffers */
> -	f = p->func = devm_kcalloc(p->dev,
> -				   p->func_count,
> -				   sizeof(struct rt2880_pmx_func),
> -				   GFP_KERNEL);
> +	f = p->func;
> +	p->func =  devm_kcalloc(p->dev, p->func_count,
> +				sizeof(struct rt2880_pmx_func), GFP_KERNEL);
> +

You broke the code here :(

Please learn a bit more about how C works before attempting to work on
kernel code.

thanks,

greg k-h
