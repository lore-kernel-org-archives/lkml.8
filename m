Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA60C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3EC206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588076938;
	bh=ZXNK0iV3SL2UYWy+2MfsrEnp9gwd1IqQaWS1HZpPznA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kNWFqAODcpyBZJVKhmvNUR10coYLnhjt6RZrHy/thZCGd1gw0olxjCuYmHA60blab
	 kCiyYTScGU2fk3MlnmrY3MOyWtaZMZ5ty5NUiu9s44ByePkAneKNbYajwCteRq9UqR
	 KbswCREmRgBcQ3R4PbDcghlfH5FydFFg2O/+HZOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD1M26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgD1M25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD3D206A1;
        Tue, 28 Apr 2020 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588076936;
        bh=ZXNK0iV3SL2UYWy+2MfsrEnp9gwd1IqQaWS1HZpPznA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1h8LLhNXlZuB5hYGz0JVRVr/PZMxohUt1v+1JBYBhVvTkii5mztRXmQ7kCsCO7/IA
         kPQeZNHbpEOXWXhM5ZhWtqoQBLoXOnTxhUjcLrV6IwD6Itv0BdfNDgk7cjtLuyjDMW
         wyCEuAbt6h476GM0Z5BogWcRTl6ggKiypXTFB8VY=
Date:   Tue, 28 Apr 2020 14:28:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     wambui.karugax@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 2/7] staging: rtl8723bs: os_dep: remove set but not used
 'size'
Message-ID: <20200428122853.GB1253850@kroah.com>
References: <20200427032342.27211-1-yanaijie@huawei.com>
 <20200427032342.27211-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427032342.27211-3-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:23:37AM +0800, Jason Yan wrote:
> And also remove the NULL check before kfree() because kfree() can handle
> NULL pointers correctly.
> 
> Fix the following gcc warning:
> 
> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:157:6: warning:
> variable ‘size’ set but not used [-Wunused-but-set-variable]
>   u32 size = 0;
>       ^~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 1ba85a43f05a..b037868fbf22 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -154,17 +154,6 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
>  
>  static void rtw_spt_band_free(struct ieee80211_supported_band *spt_band)
>  {
> -	u32 size = 0;
> -
> -	if (!spt_band)
> -		return;
> -
> -	if (spt_band->band == NL80211_BAND_2GHZ)
> -	{
> -		size = sizeof(struct ieee80211_supported_band)
> -			+ sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
> -			+ sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM;
> -	}
>  	kfree(spt_band);
>  }

This function can now be removed and replaced with the call to kfree(),
right?  Can you send a follow-on patch to do that?

thanks,

greg k-h
