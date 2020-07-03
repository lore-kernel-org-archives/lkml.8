Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF2BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F51207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593764982;
	bh=8mmFmW6cUt+EbHQpKYu02Q4WprFtOJ0ua5Nssd8Jh4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WF1q+awbVkqSrVeZwiAgPM4zK3U5vdyO+E87RUYElDSj9jaFHPQ66TTAkw4SGLpwr
	 C6hoD7nkWkJBfos0qNKED3aXW8lcSMFBpf2bLUWkLx0ZPN8X5X6eaQHewKlrbwRoLc
	 7GvmoD56r5PqgrDqwWQvy4pN3R1cYtjbMQjt8LbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGCI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:29:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135B32070C;
        Fri,  3 Jul 2020 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764980;
        bh=8mmFmW6cUt+EbHQpKYu02Q4WprFtOJ0ua5Nssd8Jh4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5z4ksxbRmk955dydovHqKknEpTfroEE8ghw9KRRrFGPMq+Wvy7YJEuu4doF0bUhm
         bGCS99vPdnfnKEuJ6tikeMWpIHU50/yIkdOLzPhL0HlgTAbZ/eMEZ3L8pSWEJoph80
         BmvfmGyJSqovHi8qRLhBL4WOGjkmQQJnMBmJeLKk=
Date:   Fri, 3 Jul 2020 10:29:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: include: rtl8188e_xmit.h: fixed
 multiple blank space coding style issues
Message-ID: <20200703082944.GA2399223@kroah.com>
References: <20200702111556.uswbq7umpigltvfk@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702111556.uswbq7umpigltvfk@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:15:56AM -0400, B K Karthik wrote:
> added blank spaces to improve code readability. (coding style issue)
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/rtl8188eu/include/rtl8188e_xmit.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
> index 49884cceb349..c115007d883d 100644
> --- a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
> +++ b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
> @@ -30,11 +30,11 @@
>  #define SET_EARLYMODE_LEN2_1(__pAddr, __Value)			\
>  	SET_BITS_TO_LE_4BYTE(__pAddr, 28, 4, __Value)
>  #define SET_EARLYMODE_LEN2_2(__pAddr, __Value)			\
> -	SET_BITS_TO_LE_4BYTE(__pAddr+4, 0, 8, __Value)
> +	SET_BITS_TO_LE_4BYTE(__pAddr + 4, 0, 8, __Value)
>  #define SET_EARLYMODE_LEN3(__pAddr, __Value)			\
> -	SET_BITS_TO_LE_4BYTE(__pAddr+4, 8, 12, __Value)
> +	SET_BITS_TO_LE_4BYTE(__pAddr + 4, 8, 12, __Value)
>  #define SET_EARLYMODE_LEN4(__pAddr, __Value)			\
> -	SET_BITS_TO_LE_4BYTE(__pAddr+4, 20, 12, __Value)
> +	SET_BITS_TO_LE_4BYTE(__pAddr + 4, 20, 12, __Value)
> 
>  /*  */
>  /* defined for TX DESC Operation */
> @@ -100,7 +100,7 @@ enum TXDESC_SC {
> 
>  #define txdesc_set_ccx_sw_88e(txdesc, value) \
>  	do { \
> -		((struct txdesc_88e *)(txdesc))->sw1 = (((value)>>8) & 0x0f); \
> +		((struct txdesc_88e *)(txdesc))->sw1 = (((value) >> 8) & 0x0f); \
>  		((struct txdesc_88e *)(txdesc))->sw0 = ((value) & 0xff); \
>  	} while (0)
> 
> @@ -138,9 +138,9 @@ struct txrpt_ccx_88e {
>  	u8 sw0;
>  };
> 
> -#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1<<8))
> +#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1 << 8))
>  #define txrpt_ccx_qtime_88e(txrpt_ccx)			\
> -	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1<<8))
> +	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1 << 8))
> 
>  void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
>  			       u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull);
> --
> 2.20.1
> 


I asked you to resend all patches as a patch series, not just resend the
patches you previously sent me in random order.  Also, this one has
changed from the first time you sent it, so it needs to be a v2 patch,
right?

Again, all patches from you are now dropped from my queue, please fix up
and resend as asked for.

thanks,

greg k-h
