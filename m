Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269FE207FC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593235281;
	bh=QBX0iOoDvH4E7eBeaNtyJFRNnTKPFd82DmfG3r/sihU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fHi4GlI6WeSTBX8bNnr2JDzP0C5QYSO+9abJyx0TAGOMGwXLthfBXwJoHurKxlTfL
	 PM9WNgMVozOpqpvHOdBdCf5Pp0HE8lNSKQIg0BQpwkpkzkG+wqpImZKqnAxOGfj3WL
	 Vmvu1MpxSGjF7av4bC6eg2CshwtfnQf5J6mZNTMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgF0FVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgF0FVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:21:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7FB207FC;
        Sat, 27 Jun 2020 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593235278;
        bh=QBX0iOoDvH4E7eBeaNtyJFRNnTKPFd82DmfG3r/sihU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q97K3rLmsJ4CwVKEesmRcvRpSFXYqE1OqKOfWMJwmkB/bwwf/QOOTNoTWX7boGgRK
         gzn5buhTErjPIocgK4OAiXdi/+xsVF9ba7bY9IQxGVJKpuKRD5SP+CypB/Ratz8ajM
         XCgkIQ9suB7OCe5SXg0dfL61aqJWXiXajaQhQvjI=
Date:   Sat, 27 Jun 2020 07:21:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brooke Basile <brookebasile@gmail.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: rtl8188eu: Replace function name with
 __func__
Message-ID: <20200627052115.GA248307@kroah.com>
References: <20200626153639.8097-1-brookebasile@gmail.com>
 <20200626153639.8097-2-brookebasile@gmail.com>
 <20200626153639.8097-3-brookebasile@gmail.com>
 <20200626153639.8097-4-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626153639.8097-4-brookebasile@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:36:42AM -0400, Brooke Basile wrote:
> Fix the following checkpatch warning:
> 	WARNING: Prefer using '"%s...", __func__' to using 'rtw_get_bcn_info', this function's name, in a string
> 
> Signed-off-by: Brooke Basile <brookebasile@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> index bf6b2fe9735f..0c43c0dcf95c 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> @@ -986,10 +986,10 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
>  		if (bencrypt)
>  			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
>  	}
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
> -		 pnetwork->BcnInfo.encryp_protocol));
> -	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
> -		 pnetwork->BcnInfo.encryp_protocol));
> +	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->encryp_protocol is %x\n",
> +		 __func__, pnetwork->BcnInfo.encryp_protocol));
> +	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->encryp_protocol is %x\n",
> +		 __func__, pnetwork->BcnInfo.encryp_protocol));
>  	rtw_get_cipher_info(pnetwork);
>  
>  	/* get bwmode and ch_offset */

This patch fails to apply to my latest branch, can you rebase it and
resend if it is still needed?

thanks,

greg k-h
