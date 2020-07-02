Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F454C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68450206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExH6F2q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGBEwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:52:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EEAC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:52:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so11965720pfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uEiRLNKt69M+Lip9AktsDp/u6gg05rPhzB8bmhjA7A4=;
        b=ExH6F2q454wJ41b2BXCt/7X7WIXluk6VAKALxUU5tFpTjbkOtGbsmX0+nPyTZocMem
         KjpQl2U7z7K/EeOzS3tSvLYOOrNwXHoNTkgtXuyjrCQPNV2A/Ebi8bTfIusaFV5ni/S2
         n6rgbnQpdQuBcz11zE7y4VCx9wa6m4S48uvGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uEiRLNKt69M+Lip9AktsDp/u6gg05rPhzB8bmhjA7A4=;
        b=i4mPa+iBBamLv67aef+w8VjB40/YvFWEjVKVPY0EKn5XppewZWv3dANk2A8/EneXbm
         QXxq3stwf02ETKlPbpvQVduuGn89GhHmcK8m3mCerPF5N9MThjF4xJ51n9Z9RG7vXWsO
         eqoNWKYEOiFhq/8a1vztPZ/19JiPrrKH62+Dl3b8Jvt7hCs4NKnSpoJ0qFROAKQaemSw
         jh0eU5aexOu2ciciQjVwYGgSIa2K+fhodtq0dzvjfdsEHBRCrHQgKyfrvjy28KFCbSyZ
         upTA0JAe7mbORVF5KueERemmaxa4fiRRxhreiOmvBR3frbT4pEO/vd7ktlXSznyq0gx8
         EkkQ==
X-Gm-Message-State: AOAM531xnby3bn3aM+UFawlOrI9egneydFmxJdEBh905WPdJA5pw+zu1
        M8PBju3yZbVcb3GRnkeFlAc7Ww==
X-Google-Smtp-Source: ABdhPJxY9ullqFsM6GLHzjRtrLbGtIuq/OrFmyjpR5DEajP/BpW38p3Yc6gX4kiSlGzCA1+ccg2QXw==
X-Received: by 2002:a65:6415:: with SMTP id a21mr22407549pgv.129.1593665559676;
        Wed, 01 Jul 2020 21:52:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c132sm6912538pfb.112.2020.07.01.21.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:52:38 -0700 (PDT)
Date:   Wed, 1 Jul 2020 21:52:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: include: rtl8188e_xmit.h: fixed
 multiple blank space coding style issues
Message-ID: <202007012152.4F5B41C14@keescook>
References: <20200702044842.fbafuffk7zercbi7@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702044842.fbafuffk7zercbi7@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:48:42AM -0400, B K Karthik wrote:
> added blank spaces to improve code readability.
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
> +	SET_BITS_TO_LE_4BYTE(__pAdd r +4, 0, 8, __Value)
                                   ^

did this get compile tested? :)

-Kees

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



-- 
Kees Cook
