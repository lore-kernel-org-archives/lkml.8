Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333DAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD802080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZPe5JG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgH0Txt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgH0Txs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:53:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654CBC061264;
        Thu, 27 Aug 2020 12:53:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so4327804pfh.3;
        Thu, 27 Aug 2020 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+YO5oaAaN/nFy8Dq2BwhiFhtK4+f/IbMC6cHVQ5yrQ=;
        b=vZPe5JG2aBgbj7WzCmPswKk+xkcfYyv4IAki+HI2oko39UNId2SwLD1sl6doO3brRH
         RPACrQmGP6Un30CGrBU1tpxHFWST6ZBk6d3MMTFPjmClrWvP9J3Jjk3xYYrtT3w4BEgD
         wXGOSfpxWycsoSpFiNR4xtUooUV5Nn+n9eLXaVR3/T1bvfXxO233vMzHF1+wleol4Yi/
         sWZB1lkP5YagBoQohviTXjhFVpf9SHGKHYGzEZFYL/gb4P2JmqthLbg9Ipx805JWsBMG
         qGGHsQg+7er/jG2dSjDq+EgB1/GMOyTaGK0jLNPQ77QTCsD4JN5ubSELUEI6kJrhR9uI
         oxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+YO5oaAaN/nFy8Dq2BwhiFhtK4+f/IbMC6cHVQ5yrQ=;
        b=aGc5gdk6UEskq9lERvXiNtC0lrN3DPXZCr9KvBXt4eJzyCh+vELC3xuCXc3a2YuiPj
         agz5vnT+bH+50XNyTRiwNVibYrDrvLAKseup6ucMeXXWnyq41STCyNCg9ObliQ22Azf0
         pf8swzeGwwQ5U9TX4DqQud/YAiynJ8IhL+f8IoYW5RzXmvY527/hpDATT4RM1KEidvQw
         dcApdydYXsuEdCZDSATBVMeRIhJ1Pxr/B0QNMuRjN/JJk4vc16I6c0Dsw115/2sL/WDF
         Qqpi1+GMrXHqbaLTlwa9AkMjV9Ym76uA8o+Q7vR86+V7D6l43F5OaI890gJNmi7DH4Rb
         DO3g==
X-Gm-Message-State: AOAM533Jdr/gC+2qoqDRS7nh2tIzGMCs8g4MEJ0rWkNAnHeQKFk82TW0
        fLlDFWpTIJXYXaPXes6Qe/OEbqPrMKw=
X-Google-Smtp-Source: ABdhPJyJ4u7vecQ8Lc9TJlhwBLvYANdmUMQbofBDHltIW5fLqV0Tg56qU7gOLvvKYfDo65fF5/lpDA==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr3552552pll.74.1598558028020;
        Thu, 27 Aug 2020 12:53:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u14sm3674834pfm.103.2020.08.27.12.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 12:53:47 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:53:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     lemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (k10temp) Define SVI telemetry and current
 factors for Zen2 CPUs
Message-ID: <20200827195346.GA233990@roeck-us.net>
References: <20200827054242.2347-1-wei.huang2@amd.com>
 <20200827054242.2347-2-wei.huang2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827054242.2347-2-wei.huang2@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:42:42AM -0500, Wei Huang wrote:
> The voltage telemetry registers for Zen2 are different from Zen1. Also
> the factors of CPU current values are changed on Zen2. Add new definitions
> for these register.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index f3addb97b021..de9f68570a4f 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -88,9 +88,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  /* F17h thermal registers through SMN */
>  #define F17H_M01H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0xc)
>  #define F17H_M01H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
> +#define F17H_M31H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0x14)
> +#define F17H_M31H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
>  
> -#define F17H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> -#define F17H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
> +#define F17H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> +#define F17H_M01H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
> +#define F17H_M31H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> +#define F17H_M31H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
>  
>  struct k10temp_data {
>  	struct pci_dev *pdev;
> @@ -580,17 +584,17 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			data->show_current = !is_threadripper() && !is_epyc();
>  			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
>  			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
> -			data->cfactor[0] = F17H_CFACTOR_ICORE;
> -			data->cfactor[1] = F17H_CFACTOR_ISOC;
> +			data->cfactor[0] = F17H_M01H_CFACTOR_ICORE;
> +			data->cfactor[1] = F17H_M01H_CFACTOR_ISOC;
>  			k10temp_get_ccd_support(pdev, data, 4);
>  			break;
>  		case 0x31:	/* Zen2 Threadripper */
>  		case 0x71:	/* Zen2 */
>  			data->show_current = !is_threadripper() && !is_epyc();
> -			data->cfactor[0] = F17H_CFACTOR_ICORE;
> -			data->cfactor[1] = F17H_CFACTOR_ISOC;
> -			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
> -			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
> +			data->cfactor[0] = F17H_M31H_CFACTOR_ICORE;
> +			data->cfactor[1] = F17H_M31H_CFACTOR_ISOC;
> +			data->svi_addr[0] = F17H_M31H_SVI_TEL_PLANE0;
> +			data->svi_addr[1] = F17H_M31H_SVI_TEL_PLANE1;
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
>  		}
