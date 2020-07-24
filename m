Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F4DC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1CD2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrRpNFDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGXLWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgGXLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:22:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01AC0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:22:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so285542wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GazPbHUQLsK8S7tpuO7AvOa0IiPz4pR+J44UaDqobHk=;
        b=KrRpNFDpBZHHWPx0ETVhUqNHKnHacZ6r/gaay6WB7CS6mzqX5jorQsoiNCm9OqQcBl
         vn7wpZGL/D2B4UwfH2LgfbjDEIh7Foz8/z7K/TCE6wAMpanMQOmDw+QkdhqmRS4bzNle
         397s4Y+2q+fZhfj4/arSsxnViNt3HFGoVURr7YnynB++Exs/V9T5Tek+q7K/nfV3Uo0F
         Y8m5px4KvbjmZVv3FS+mpGRsSnyoDcg3r4eBpmGyTV5SqGYyNS8Lfg3vaQf+D+6KAS3f
         buZh9+8VeBnzqjOX9hyKTU/xIRqpDcsGFzwik6zJAJ/Vj27bgN2Fy/SOHZMyxzNnmtDq
         82dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GazPbHUQLsK8S7tpuO7AvOa0IiPz4pR+J44UaDqobHk=;
        b=Qzw0QmxkQ/euf4Z0Cja7URqZ7hf2+TPs9RkycL+tDeRkwMBAnNdeYKC/zLc1u4wWNL
         rxrCXIDT80m372xs8fLz5etpzs8THGtpgC5/nngP95zOwHqjR022ZdmSEJY7NcrNegy9
         e+hW0c5IT24otkThSKN69ua1/k1uww6maqTtNT329D5RQaAKCtJeVJke6oGCEhFZaPx/
         Vbj9wEXGWXouhR71ZendXQ7WAMWcy/6NTQsWpM9N7K/Kw8tI4hJiscSmUD5nhSf8BWQU
         skdQMZyYkVqrkeRIgxlRo6JiMKocJ0pJG8tj4D9kWSNdU2UEcJ7Ct9NqgJxZWhWQPubV
         yxmw==
X-Gm-Message-State: AOAM531THhFzJo5qivhhE5TUD80Bmx1KUqlvIuA5tFI1bw0ZfMxVkV8x
        m+iraPgkp4yumQegc/GDfoIkQhm68Ns=
X-Google-Smtp-Source: ABdhPJzuISAaEC6wI6jIFPRKdMJneQLwLQbmOnvS88iKf9FErm/LSyy4iq1BlJvn6CgSM6jT0oW0fA==
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr7724232wmi.120.1595589728701;
        Fri, 24 Jul 2020 04:22:08 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y20sm6394145wmi.8.2020.07.24.04.22.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 04:22:08 -0700 (PDT)
Subject: Re: [PATCH v4 10/12] ASoC: qcom: lpass-cpu: Use platform_get_resource
To:     Rohit kumar <rohitkr@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
 <1595413915-17867-11-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c0789d98-599a-6b67-ac42-9083a6c251f3@linaro.org>
Date:   Fri, 24 Jul 2020 12:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1595413915-17867-11-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2020 11:31, Rohit kumar wrote:
> platform_get_resource_byname() is used when there
> is list of reg entries. As lpass-cpu node has only
> one reg entry, use platform_get_resource() instead.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 5d84f63..1ee6d8b 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -575,7 +575,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   
>   	of_lpass_cpu_parse_dai_data(dev, drvdata);
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
>   	drvdata->lpaif = devm_ioremap_resource(dev, res);
>   	if (IS_ERR((void const __force *)drvdata->lpaif)) {
> 
