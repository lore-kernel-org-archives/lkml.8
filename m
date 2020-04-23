Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C0C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81BE21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587641355;
	bh=GLlc36Uzd9tq03rZItAwzH28jaEo5ZcpHGyvduOR2A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IvOBealJuWH2NFLT8wzxSZyF/XHANkQ9yxkZ7RXuRTIdWIlcRs9bBfiVx3peXkK4b
	 +bpaNuikZV4Ty+vd+s+E+YjkGIOrP+Apvv3ZeHvtamKsbbtYatYl5WciWLmk6CB1yV
	 AyqEsmZqDd6j1awRmN0OrPaebKFuAPaKLYSIzecA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgDWL3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgDWL3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:29:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7120820736;
        Thu, 23 Apr 2020 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587641352;
        bh=GLlc36Uzd9tq03rZItAwzH28jaEo5ZcpHGyvduOR2A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2UfGZuQCnr47rkAUJssPrBDRMExOsOBUUr0CuLJo6mJx9nyJv6MMYUvhnKJoL+Vua
         9Wh/S1YtwuHrLDjruOSyXA344ONMBut+uKlZLIF2zhiFvO8wnKdR1hE82NG7KEuMOt
         GnbEpGteOvxHw9Aka5yptbzP0plKT0e1K0kHzKZw=
Date:   Thu, 23 Apr 2020 13:29:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Subject: Re: [PATCH] staging:r8188eu: avoid skb_clone for amsdu to msdu
 conversion
Message-ID: <20200423112910.GA3768232@kroah.com>
References: <20200418084112.3723-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418084112.3723-1-insafonov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:41:12AM +0300, Ivan Safonov wrote:
> skb clones use same data buffer, so tail of one skb is corrupted by beginning of next skb.

Please properly wrap your changelog text at the correct column (72).

Also, your subject: line does not have the correct driver name :(

> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_recv.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> index d4278361e002..a036ef104198 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> @@ -1525,21 +1525,14 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
>  
>  		/* Allocate new skb for releasing to upper layer */
>  		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
> -		if (sub_skb) {
> -			skb_reserve(sub_skb, 12);
> -			skb_put_data(sub_skb, pdata, nSubframe_Length);
> -		} else {
> -			sub_skb = skb_clone(prframe->pkt, GFP_ATOMIC);
> -			if (sub_skb) {
> -				sub_skb->data = pdata;
> -				sub_skb->len = nSubframe_Length;
> -				skb_set_tail_pointer(sub_skb, nSubframe_Length);
> -			} else {
> -				DBG_88E("skb_clone() Fail!!! , nr_subframes=%d\n", nr_subframes);
> -				break;
> -			}
> +		if (!sub_skb) {
> +			DBG_88E("dev_alloc_skb() Fail!!! , nr_subframes=%d\n", nr_subframes);
> +			break;
>  		}
>  
> +		skb_reserve(sub_skb, 12);
> +		skb_put_data(sub_skb, pdata, nSubframe_Length);
> +

Have you tested this?

thanks,

greg k-h
