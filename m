Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95860C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5342076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597759464;
	bh=c2D1W1WAEbnGki8pgGD1y2UNuufiUemfW628epYqJmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hl7uccoX4jNjj9Jwawu1ShgxkAoy/zmrmqR/xKOeQtna6nUeA6+CYgx+SuW38DjNN
	 derha5shi/m9y+X97xRAaEyKSjt4I9UCJoJIMWjrxjSialOhNLUTUe7B5p1QZ2E66O
	 heFFDkOR2wdA7x34VNmzq29bd5eQpCaJ2LeS+ebY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHROEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:04:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CEC20706;
        Tue, 18 Aug 2020 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759461;
        bh=c2D1W1WAEbnGki8pgGD1y2UNuufiUemfW628epYqJmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNjeCFJ3lSN2VUfcrhFTKSoHTWgGiIgACL4ok9EUkYxzTVOcuYs9uL2f8k8odLdd2
         WDSEbLT++gGGz5m0InOXnPSK+9te4aYNJ6o39+26RLuxKj1yUfia9hg/++/DDirX/V
         FonqkKSf8yOXMtAQcAuNB1IDxP34GBx+5tYn3WyE=
Date:   Tue, 18 Aug 2020 16:04:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mohammed Rushad <mohammedrushad@gmail.com>
Cc:     vkor@vkten.in, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        john.oldman@polehill.co.uk, yanaijie@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: fix coding style issue in
 xmit_linux.c
Message-ID: <20200818140444.GB547677@kroah.com>
References: <20200802185644.19674-1-mohammedrushad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802185644.19674-1-mohammedrushad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 12:26:44AM +0530, Mohammed Rushad wrote:
> This is a patch to the xmit_linux.c file that fixes brace and missing
> line warning found by checkpatch.pl tool
> 
> Signed-off-by: Mohammed Rushad <mohammedrushad@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> index fec8a8caaa46..b199d355e568 100644
> --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> @@ -148,13 +148,13 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
>  	/* free sta asoc_queue */
>  	while (phead != plist) {
>  		int stainfo_offset;
> +
>  		psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
>  		plist = get_next(plist);
>  
>  		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
> -		if (stainfo_offset_valid(stainfo_offset)) {
> +		if (stainfo_offset_valid(stainfo_offset))
>  			chk_alive_list[chk_alive_num++] = stainfo_offset;
> -		}
>  	}
>  	spin_unlock_bh(&pstapriv->asoc_list_lock);
>  

As trivial as it is, this is still two different things in a single
patch :(

If this was the last remaining issue in this file, I might consider it,
but it isn't, so please break up your changes into
one-type-of-change-per-patch.

thanks,

greg k-h
