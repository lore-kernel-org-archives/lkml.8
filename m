Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E3B20714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595761198;
	bh=BlWNHRx81BkVjfiVPZH2lP4OPiWIUw2bTOwNTT+SBNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zqM5NomCCnGv2Y2ekXRi9q93cD3Rg5tcilbjyduWdWBUyinXJMv4ew/Jr/Qhz9ZuI
	 Wu9xIveqfVX5V6a9PyZsPEtZhMsgPleXm8wSzCO1ALqvEHT4DP3Qp6fvCuXW5xU+1A
	 uyhnN5zHZU/0rUVo9adHzIgxiiU8pQyu+TyEa8q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGZK75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZK74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:59:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45071206E3;
        Sun, 26 Jul 2020 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595761195;
        bh=BlWNHRx81BkVjfiVPZH2lP4OPiWIUw2bTOwNTT+SBNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5J1N8320A2lXEGDUBMQ9QLS/rNDPxDuntxRrLJwbyME6byZ7HmDYpa1XgCR+vOIv
         olt8YyQKpYVhahn09WHv4arWGIMp8hqm430g0Ih6lbrEhvClU2IqBGJmScRSVz2qz0
         +x8Qd/MkwYW9NCUeHu+uuxffb+CEpQlh5RkiMsSs=
Date:   Sun, 26 Jul 2020 12:59:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH v2] staging: rtl8723bs: include: Fix coding style issues
Message-ID: <20200726105952.GA1280500@kroah.com>
References: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
 <20200726105302.52188-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726105302.52188-1-aditya.jainadityajain.jain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 04:23:02PM +0530, Aditya Jain wrote:
> Cleaning messy function declartions and fixing code style
> errors in hal_phy_cfg.h as reported by checkpatch.pl
> 
> Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
> ---
>  .../staging/rtl8723bs/include/hal_phy_cfg.h   | 118 +++++-------------
>  1 file changed, 33 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> index 419ddb0733aa..2f123903279c 100644
> --- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> @@ -8,54 +8,31 @@
>  #define __INC_HAL8723BPHYCFG_H__
>  
>  /*--------------------------Define Parameters-------------------------------*/
> -#define LOOP_LIMIT				5
> -#define MAX_STALL_TIME			50		/* us */
> +#define LOOP_LIMIT		5
> +#define MAX_STALL_TIME		50	/* us */
>  #define AntennaDiversityValue	0x80	/* Adapter->bSoftwareAntennaDiversity ? 0x00:0x80) */
>  #define MAX_TXPWR_IDX_NMODE_92S	63
> -#define Reset_Cnt_Limit			3
> -
> -#define MAX_AGGR_NUM	0x07
> +#define Reset_Cnt_Limit		3
>  
> +#define MAX_AGGR_NUM 0x07
>  
>  /*--------------------------Define Parameters End-------------------------------*/
>  
> -
>  /*------------------------------Define structure----------------------------*/
>  
>  /*------------------------------Define structure End----------------------------*/
>  
>  /*--------------------------Exported Function prototype---------------------*/
> -u32
> -PHY_QueryBBReg_8723B(
> -struct adapter *Adapter,
> -u32 	RegAddr,
> -u32 	BitMask
> -	);
> -
> -void
> -PHY_SetBBReg_8723B(
> -struct adapter *Adapter,
> -u32 	RegAddr,
> -u32 	BitMask,
> -u32 	Data
> -	);
> -
> -u32
> -PHY_QueryRFReg_8723B(
> -struct adapter *		Adapter,
> -u8 		eRFPath,
> -u32 			RegAddr,
> -u32 			BitMask
> -	);
> -
> -void
> -PHY_SetRFReg_8723B(
> -struct adapter *		Adapter,
> -u8 		eRFPath,
> -u32 			RegAddr,
> -u32 			BitMask,
> -u32 			Data
> -	);
> +u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask);
> +
> +void PHY_SetBBReg_8723B(struct adapter *Adapter, u32 RegAddr,
> +			u32 BitMask, u32 Data);
> +
> +u32 PHY_QueryRFReg_8723B(struct adapter *Adapter, u8 eRFPath,
> +			 u32 RegAddr, u32 BitMask);
> +
> +void PHY_SetRFReg_8723B(struct adapter *Adapter, u8 eRFPath,
> +			u32 RegAddr, u32 BitMask, u32 Data);
>  
>  /* MAC/BB/RF HAL config */
>  int PHY_BBConfig8723B(struct adapter *Adapter);
> @@ -64,57 +41,28 @@ int PHY_RFConfig8723B(struct adapter *Adapter);
>  
>  s32 PHY_MACConfig8723B(struct adapter *padapter);
>  
> -void
> -PHY_SetTxPowerIndex(
> -struct adapter *		Adapter,
> -u32 				PowerIndex,
> -u8 			RFPath,
> -u8 			Rate
> -	);
> -
> -u8
> -PHY_GetTxPowerIndex(
> -struct adapter *		padapter,
> -u8 			RFPath,
> -u8 			Rate,
> -enum CHANNEL_WIDTH		BandWidth,
> -u8 			Channel
> -	);
> -
> -void
> -PHY_GetTxPowerLevel8723B(
> -struct adapter *	Adapter,
> -	s32*			powerlevel
> -	);
> -
> -void
> -PHY_SetTxPowerLevel8723B(
> -struct adapter *	Adapter,
> -u8 	channel
> -	);
> -
> -void
> -PHY_SetBWMode8723B(
> -struct adapter *			Adapter,
> -enum CHANNEL_WIDTH			Bandwidth,	/*  20M or 40M */
> -unsigned char 			Offset		/*  Upper, Lower, or Don't care */
> -);
> +void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
> +			 u8 RFPath, u8 Rate);
>  
> -void
> -PHY_SwChnl8723B(/*  Call after initialization */
> -struct adapter *Adapter,
> -u8 channel
> -	);
> -
> -void
> -PHY_SetSwChnlBWMode8723B(
> -struct adapter *		Adapter,
> -u8 			channel,
> -enum CHANNEL_WIDTH		Bandwidth,
> -u8 			Offset40,
> -u8 			Offset80
> +u8 PHY_GetTxPowerIndex(struct adapter *padapter, u8 RFPath, u8 Rate,
> +			enum CHANNEL_WIDTH BandWidth, u8 Channel);
> +
> +void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
> +
> +void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
> +
> +void PHY_SetBWMode8723B(struct adapter *Adapter,
> +			enum CHANNEL_WIDTH Bandwidth,	/*  20M or 40M */
> +			unsigned char Offset	/*  Upper, Lower, or Don't care */
>  );
>  
> +/*  Call after initialization */
> +void PHY_SwChnl8723B(struct adapter *Adapter, u8 channel);
> +
> +void PHY_SetSwChnlBWMode8723B(struct adapter *Adapter, u8 channel,
> +				enum CHANNEL_WIDTH Bandwidth,
> +				u8 Offset40, u8 Offset80);
> +
>  /*--------------------------Exported Function prototype End---------------------*/
>  
>  #endif
> -- 
> 2.25.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
