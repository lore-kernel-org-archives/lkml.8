Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2BBC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103FB2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmn+xkIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEKItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgEKItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:49:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC482C061A0C;
        Mon, 11 May 2020 01:49:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a7so7468034pju.2;
        Mon, 11 May 2020 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sq8Mq/OxjyWpcL62/IYV8B3/GJi76SpQCwAh+NrsgKo=;
        b=Fmn+xkIuoCtLzZ9L5niujL1ia1KizwnLoxdeKcLivh3+US4248sEtcamEd57cYtLP1
         gUsQc6guW04sLRO/ehfKtLLkHye1haA0ghJdXE5o1vhgr5C4ikudX9MoELY5Z61vs1QI
         cc/vFFZNY3iYllbOPBnlwGPdraCbxp6ABjfx7s5lZNJ/ivFcOaZJh91S8BR7hwBgE8cN
         QhK/RbAgiIfOK/lN3gnEThCF5fRaG+bmp65xg4R2UBDF/vQjh7J+TDAYC57+FX+QNKW5
         iSxl29E6ubfN3d2Xv/9jM25XUpF9pHNGk5Psj1PGcOlL6YclDOEAvG/Rui93O6dPiScW
         4hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sq8Mq/OxjyWpcL62/IYV8B3/GJi76SpQCwAh+NrsgKo=;
        b=TzFmryzfQbqMZ8DsSc6G4i3ifG5XZ1qziJb4wg+sn8XY5UkUcVP5HNmkLNoS/iPjPo
         f5xhnpjLln69O0sSsxQBumwe5Gxx8tc0/LgzCLaAj6j+Z/qYMAWhgb04A4rQvLd2xTAw
         YCzYNxRWi3vFvBnFgPtR1zdrGsjq4i3Bz2X5meOLQZBqvNtlYuRSY3K+poWznJPMgxzP
         QSUFyTjmD5rczriXj9J56b0UpAVxs0nIK6qXxjaIcXEnmU3MeWfxsssJtcUbI8Sx9xaJ
         X7WpQTEbcXwzCUzKjnGG9KM6e30RNvb9iJWyAawvdJjidHLi5ovpjurBlbVgCI/caJsy
         /Czg==
X-Gm-Message-State: AGi0Pua2sIncEzASVaom8U29G4a/G/I7KBYR1HGQbi2MioIDPABoNXEu
        s549PiA91bei0jI4044s/HHFYaAGCa4=
X-Google-Smtp-Source: APiQypJJODO+DqnvGW6pvwrpID7bxuUbBP7xXA9dC/Py7n0F2eUbS3woXmIuBbA3IzkJTAyrjd5Rzg==
X-Received: by 2002:a17:90a:f418:: with SMTP id ch24mr20848992pjb.68.1589186959766;
        Mon, 11 May 2020 01:49:19 -0700 (PDT)
Received: from [192.168.1.5] ([110.77.154.194])
        by smtp.googlemail.com with ESMTPSA id y8sm8890315pfg.216.2020.05.11.01.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:49:19 -0700 (PDT)
From:   Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH v2] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
References: <20200510213934.146631-1-pmalani@chromium.org>
Message-ID: <6921cb24-091b-1de3-5348-a1dd8a6803f5@gmail.com>
Date:   Mon, 11 May 2020 15:49:17 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200510213934.146631-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2020 04:39, Prashant Malani wrote:
> According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> 0.6, the PMC HPD request LVL bit field is bit 4.
> Fix the definition here to match the programming guide.
> 
> Since this bit field is changing, explicitly define a field for the
> HPD_HIGH mode data bit.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
> Reviewed-by: Benson Leung <bleung@chromium.org>
> ---
> 
> Changes in v2:
> - Fixed bit error in commit message.
> 
>   drivers/usb/typec/mux/intel_pmc_mux.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 67c5139cfa0d..15074aec94eb 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -63,6 +63,7 @@ enum {
>   #define PMC_USB_ALTMODE_DP_MODE_SHIFT	8
>   
>   /* TBT specific Mode Data bits */
> +#define PMC_USB_ALTMODE_HPD_HIGH	BIT(14)
>   #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
>   #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
>   #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
> @@ -75,7 +76,7 @@ enum {
>   
>   /* Display HPD Request bits */
>   #define PMC_USB_DP_HPD_IRQ		BIT(5)
> -#define PMC_USB_DP_HPD_LVL		BIT(6)
> +#define PMC_USB_DP_HPD_LVL		BIT(4)
>   
Please keep the bits sorted

>   struct pmc_usb;
>   
> @@ -158,8 +159,7 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
>   			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
>   
>   	if (data->status & DP_STATUS_HPD_STATE)
> -		req.mode_data |= PMC_USB_DP_HPD_LVL <<
> -				 PMC_USB_ALTMODE_DP_MODE_SHIFT;
> +		req.mode_data |= PMC_USB_ALTMODE_HPD_HIGH;
>   
>   	return pmc_usb_command(port, (void *)&req, sizeof(req));
>   }
> 

Thanks
Lars
