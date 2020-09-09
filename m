Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C69C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B28921941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iye7sLmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIIMQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgIIMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:02:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D1C061796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:53:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so1393599ilp.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h/sZ1uzeumtgrunqJv1IilUpq0Y//RwPDbB/FiznfE0=;
        b=Iye7sLmYs1YKbtPfsmtNSE1fjp6xINJmasUJH2zx9suBZsXlfOBHf/Bau1OaTqNi43
         T0F/0rP1ja69j0HYugXe3pWU9+nyezMEvekO66eKg6thZprVfYUx9XAkv2K+eBfu9hsb
         r0hVctbXYRYcM93Nto+GmCMd7KB2rH2c3dZmeg4fMrPhHMcp6NQ8i7h3JxtNg823rTOJ
         1lpsG2xxXMu/0/m5tDd5K8LLJDqzbSEENdj57dOvtGmNQ+Gifx7/OqXFoprCUR5jW6+p
         W3ZM/ytJZw3Il+2RjwOgrzEevA12vyHEtZMVxBq6q5RSsngnUtk1YJKPIgRaxHHGKpVX
         dXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/sZ1uzeumtgrunqJv1IilUpq0Y//RwPDbB/FiznfE0=;
        b=ANUb2Lznnm2uXv5eO33y7/SjvwQX2KQhXgIE32IMwrFqlLLHdHNkPUKwm8jt48Tu9J
         jiHTy8aH5IdGQV/Min8jJAwjHX3sJloEeOMmReitVLCblVV7n6lCFocAQsxvHzDt5Nzj
         t9DBnKtSWzC+Z7xDhFrpfrldsAvcfTrE8cD7HVB2eFC6U1NxFa9clFVP9iG4x+VOBRHe
         A0A+ljBKntfjNIG64UyAPHFUpRGb0XKtd7+FLfvkGfzLA57CWQ2iHBV0iaa5xGeATbHW
         beeJrbEcBXY6+W1eC6Rj7XBzJzwrABLzXe017jUWEKtUrQBlnluQzdcSx5RApMzasyr6
         25Gw==
X-Gm-Message-State: AOAM533s5hvwre9tt0rY3CZvOWaZdthFD2Rx9YrNsDbrI6Wgq8f/LpSB
        BgkPiEXFdNtA3LQHSDaRcQnSneaGEe2sJw==
X-Google-Smtp-Source: ABdhPJxVUSxkjm3sEQPqlYfwGwgS6iRmfqRvKD4Ebfn2d4E9I8C2b/F+2ldjVsBk6//GAq6f57E1sg==
X-Received: by 2002:a92:bf0a:: with SMTP id z10mr3517882ilh.39.1599652399048;
        Wed, 09 Sep 2020 04:53:19 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b8sm1095647ioa.33.2020.09.09.04.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:53:18 -0700 (PDT)
Subject: Re: [RFT net] net: ipa: fix u32_replace_bits by u32p_xxx version
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200908143237.8816-1-vadym.kochan@plvision.eu>
From:   Alex Elder <elder@linaro.org>
Message-ID: <030185d3-8401-dd2f-8981-9dfe2239866a@linaro.org>
Date:   Wed, 9 Sep 2020 06:53:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908143237.8816-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 9:32 AM, Vadym Kochan wrote:
> Looks like u32p_replace_bits() should be used instead of
> u32_replace_bits() which does not modifies the value but returns the
> modified version.
> 
> Fixes: 2b9feef2b6c2 ("soc: qcom: ipa: filter and routing tables")
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>

You are correct!  Thank you for finding this.

Your fix is good, and I have now tested it and verified it
works as desired.

FYI, this is currently used only for the SDM845 platform.  It turns
out the register values (route and filter hash config) that are read
and intended to be updated always have value 0, so (fortunately) your
change has no effect there.

Nevertheless, you have fixed this bug and I appreciate it.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
> Found it while grepping of u32_replace_bits() usage and
> replaced it w/o testing.
> 
>  drivers/net/ipa/ipa_table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
> index 2098ca2f2c90..b3790aa952a1 100644
> --- a/drivers/net/ipa/ipa_table.c
> +++ b/drivers/net/ipa/ipa_table.c
> @@ -521,7 +521,7 @@ static void ipa_filter_tuple_zero(struct ipa_endpoint *endpoint)
>  	val = ioread32(endpoint->ipa->reg_virt + offset);
>  
>  	/* Zero all filter-related fields, preserving the rest */
> -	u32_replace_bits(val, 0, IPA_REG_ENDP_FILTER_HASH_MSK_ALL);
> +	u32p_replace_bits(&val, 0, IPA_REG_ENDP_FILTER_HASH_MSK_ALL);
>  
>  	iowrite32(val, endpoint->ipa->reg_virt + offset);
>  }
> @@ -573,7 +573,7 @@ static void ipa_route_tuple_zero(struct ipa *ipa, u32 route_id)
>  	val = ioread32(ipa->reg_virt + offset);
>  
>  	/* Zero all route-related fields, preserving the rest */
> -	u32_replace_bits(val, 0, IPA_REG_ENDP_ROUTER_HASH_MSK_ALL);
> +	u32p_replace_bits(&val, 0, IPA_REG_ENDP_ROUTER_HASH_MSK_ALL);
>  
>  	iowrite32(val, ipa->reg_virt + offset);
>  }
> 

