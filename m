Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DC1C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88313238E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586182066;
	bh=wDxIRPMlhMe/o1pXdj51xgZSnzW2C4Zp3pSFgaaLnsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DVjt02eABI6dYon0OuShGOyJFHpO02KdSQ78KbprEGxMTH4PyyocIZobDX+st6bDw
	 xycbTSbnsXcvp0LV74b8POH2TIekUkRAuZIWlgsATbjL9v6OrBSfviX1WmbiWKDQ2D
	 tcLEt93l+//8qV73rLjhN4+c/htTPE9B2vfwojiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgDFOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDFOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B81F23741;
        Mon,  6 Apr 2020 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586182063;
        bh=wDxIRPMlhMe/o1pXdj51xgZSnzW2C4Zp3pSFgaaLnsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdjajAAUE4J3O7+IVXlo5tfLqdCO8wTdoKXGvy5lx2O7gihzAT7uf/bOGEuk0lIrj
         NYSt5h8JaO2Xqa2xRnqtr1vhbdg+krp7nuAPBNVNuo14ZTWmhzFAZ3lPoVI31VZJF8
         7WxHZNBCSW4IiMkw2uJwxMZimg8dN4FZjPB9++44=
Date:   Mon, 6 Apr 2020 16:07:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     sylphrenadin@gmail.com, c.cantanheide@gmail.com,
        navid.emamdoost@gmail.com, nishkadg.linux@gmail.com,
        mst@redhat.com, stephen@brennan.io, mchehab@kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Remove some set but not used variables
Message-ID: <20200406140735.GA26701@kroah.com>
References: <1586261264-37576-1-git-send-email-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586261264-37576-1-git-send-email-wanghai38@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:07:44AM -0400, Wang Hai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/rtl8192u/r8192U_core.c: In function rtl8192_hard_data_xmit:
> drivers/staging/rtl8192u/r8192U_core.c:905:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> drivers/staging/rtl8192u/r8192U_core.c: In function rtl8192_commit:
> drivers/staging/rtl8192u/r8192U_core.c:3418:6: warning: variable ‘reset_status’ set but not used [-Wunused-but-set-variable]
> 
> Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index fcfb902..bb28670 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
>  				   int rate)
>  {
>  	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> -	int ret;
>  	unsigned long flags;
>  	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
>  	u8 queue_index = tcb_desc->queue_index;
> @@ -915,7 +914,7 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
>  	*(struct net_device **)(skb->cb) = dev;
>  	tcb_desc->bTxEnableFwCalcDur = 1;
>  	skb_push(skb, priv->ieee80211->tx_headroom);
> -	ret = rtl8192_tx(dev, skb);
> +	rtl8192_tx(dev, skb);

Shouldn't we do something about an error if that function returns an
error?  Why are we ignoring it?

>  
>  	spin_unlock_irqrestore(&priv->tx_lock, flags);
>  }
> @@ -3415,7 +3414,6 @@ int rtl8192_down(struct net_device *dev)
>  void rtl8192_commit(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> -	int reset_status = 0;
>  
>  	if (priv->up == 0)
>  		return;
> @@ -3427,7 +3425,7 @@ void rtl8192_commit(struct net_device *dev)
>  	ieee80211_softmac_stop_protocol(priv->ieee80211);
>  
>  	rtl8192_rtx_disable(dev);
> -	reset_status = _rtl8192_up(dev);
> +	_rtl8192_up(dev);

Same here, should that really be ignored?

thanks,

greg k-h
