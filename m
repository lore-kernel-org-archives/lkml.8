Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4257C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBB208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie1r4O/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:28:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60DC061383;
        Wed, 12 Aug 2020 08:28:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so1256970plr.7;
        Wed, 12 Aug 2020 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=exCYF+BFVr49+0e4vI9nXtzhkROY69+KBDe6jKBDjko=;
        b=ie1r4O/4nholn6vMf0Q5TfqLfDMHwsb2Mw1S/u0eVc4m8qLQY4k8x21roEupcME8Vw
         DH8jZc/mhynzLQWcAu9FLu/siNgFgOqfqkQvR6J/RqSM9tPbO2cDsM9Rnmm2xEutLK6N
         4zAs9TLOUdoU5Wvt5JGXy2yT8l6jdvpoF6pyBQFdQhLkbTDU8HDTul5N0iw+Vuggv65g
         tKM2oC2CAVa/L+v0e4wknnpCIbP21ajePLo88a+sQ5GCOLc5y/S7VHeV8Np6ebJt9uQ3
         m6piEVUt47xe0aVQTXl5eC2KURR3jUKrjdQtjfth0iRwFoFdfBv1p2IQYduvudICCH/a
         mKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=exCYF+BFVr49+0e4vI9nXtzhkROY69+KBDe6jKBDjko=;
        b=Fj7aBB4tKXQuEcC5ndmXXbcNLDdRAqxTz5ne+qMImFHn58qiY3cgztkbniUtwmTDNg
         8oALuxk/VwK8Gpi52Uy5DThZkPhAUNtk6EVjT1qqAEQpsojmXVIJ6mJR27S7D7w4qJEZ
         OwUYbjVCB9ZUzV7HcLdR34Ru61F6owIjf7dAfz6dRDFsNBAp3HChgigHwzxD0MMjrcJC
         a+QXa6Wx78HDCT3G61AoQSnraOT6ZR2J2irD3P+Mx3zjD0U71KxHw1HhD3dnhNpyReVb
         +oGHs8M9zaLPIxY16OUixEnnSUp7hWQ8mOKcnkO6BwTlri4d+G9hUF+PSCBIjrzoIADG
         qcAA==
X-Gm-Message-State: AOAM533ylnuU0DZFxkjmKZdLdwDV7GaGPQ/kQ7VmAS8xAUl0+nqwvQw0
        LgoLXOzW2DjYUJQxZFRp/zI=
X-Google-Smtp-Source: ABdhPJzb2jI63F9rw57t5vBf7005kNnk7/Tf1aivQiBV3xgseHansGR1Xp8qutjUG4eTkSdOlXLkOw==
X-Received: by 2002:a17:902:523:: with SMTP id 32mr13343plf.176.1597246097331;
        Wed, 12 Aug 2020 08:28:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm2651822pjb.20.2020.08.12.08.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 08:28:16 -0700 (PDT)
Date:   Wed, 12 Aug 2020 08:28:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] usb: typec: pd: Fix formatting in pd.h header
Message-ID: <20200812152815.GA46168@roeck-us.net>
References: <20200812022934.568134-1-badhri@google.com>
 <20200812022934.568134-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812022934.568134-2-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:29:34PM -0700, Badhri Jagan Sridharan wrote:
> Replacing spaces with tabs for PD_T_* constants.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Change history:
> First version. Keeping the version number same as the parent.
> 
> ---
>  include/linux/usb/pd.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 1df895e4680b..f842e4589bd2 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -471,9 +471,10 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_VCONN_SOURCE_ON	100
>  #define PD_T_SINK_REQUEST	100	/* 100 ms minimum */
>  #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
> -#define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
> -#define PD_T_NEWSRC            250     /* Maximum of 275ms */
> +#define PD_T_SRCSWAPSTDBY	625	/* Maximum of 650ms */
> +#define PD_T_NEWSRC		250	/* Maximum of 275ms */
>  #define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
> +#define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
>  
>  #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
>  #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
> @@ -484,5 +485,4 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
>  
> -#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
>  #endif /* __LINUX_USB_PD_H */
> -- 
> 2.28.0.236.gb10cc79966-goog
> 
