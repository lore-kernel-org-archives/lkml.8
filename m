Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEADC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD62071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587812239;
	bh=ahHvZa0kV6fBVPT9PiZNAdoAVU0at8XiPcIB1IJsIuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8QyVZUVfwhBwAh/ro2olLN+eWyBOYNSx2NZCDDiXyKqQN63I4+mhRHTiRio7DZSu
	 LaiSAHygMbTxb0qidaFdp9Q/HlYapVYv/WCUwB1LCUu8eMJlmqx9kyjgdhSbl3u0M5
	 /Qi0rgbASaxb9RU8PP2tfUw2SNfdL/g3BzXCpAzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDYK5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYK5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:57:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F5620714;
        Sat, 25 Apr 2020 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587812237;
        bh=ahHvZa0kV6fBVPT9PiZNAdoAVU0at8XiPcIB1IJsIuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJLWAhjpyWqkesSXczSZP4wjmmg7mjfrlnfwilcjybZ/lUZunCc3mjSw+FUXRsy2/
         zDqLD76OEKs7T1iWq9h+MHzGtb38wNq8OGnmw41NvvdhpocxnagXdWBlSR2z9tbELa
         s5jL9vxlpvjs6J4u5m41j9GHndKTtY1lkTGroQ/A=
Date:   Sat, 25 Apr 2020 12:57:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: vt6656: Add formula to the vnt_rf_addpower
 function
Message-ID: <20200425105714.GA2071664@kroah.com>
References: <20200423170557.10401-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423170557.10401-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 07:05:57PM +0200, Oscar Carter wrote:
> Use a formula to calculate the return value of the vnt_rf_addpower
> function instead of the "if" statement with literal values for every
> case.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
> Changelog v1 -> v2
> - Change the type of "base" variable from s32 to int as Dan Carpenter
>   suggested.
> - Remove the "--" postoperator and replace with (base - 1) as Dan
>   Carpenter suggested. Also, as this expression has a minus before the
>   parenthesis, remove it an apply the minus operator changing the sign of
>   "base" and literal "1".
> 
>  drivers/staging/vt6656/rf.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> index 06fa8867cfa3..612fd4a59f8a 100644
> --- a/drivers/staging/vt6656/rf.c
> +++ b/drivers/staging/vt6656/rf.c
> @@ -538,28 +538,14 @@ int vnt_rf_write_embedded(struct vnt_private *priv, u32 data)
> 
>  static u8 vnt_rf_addpower(struct vnt_private *priv)
>  {
> +	int base;
>  	s32 rssi = -priv->current_rssi;
> 
>  	if (!rssi)
>  		return 7;
> 
> -	if (priv->rf_type == RF_VT3226D0) {
> -		if (rssi < -70)
> -			return 9;
> -		else if (rssi < -65)
> -			return 7;
> -		else if (rssi < -60)
> -			return 5;
> -	} else {
> -		if (rssi < -80)
> -			return 9;
> -		else if (rssi < -75)
> -			return 7;
> -		else if (rssi < -70)
> -			return 5;
> -	}
> -
> -	return 0;
> +	base = (priv->rf_type == RF_VT3226D0) ? -60 : -70;
> +	return (rssi < base) ? ((rssi - base + 1) / -5) * 2 + 5 : 0;

I _hate_ ? : functions, just spell this out please as a real if()
statement.

thanks,

greg k-h
