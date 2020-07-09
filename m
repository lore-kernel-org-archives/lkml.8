Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40710C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA392076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="th/+uK9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGIJ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgGIJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:27:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66009C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:27:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so1081455wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IUWPqNTyupX2OfJokS7Cyg6szXXlNV4uQSRKuBbr+Nk=;
        b=th/+uK9dwrxSw1xSQDtZLXE93rsinY7TIBR5hcrowU8HCYEo+RR5AQxCCEJOI1NwAE
         RF8Wl4q6A998sRt0mKbrYLRppA7usgYnsIa8tAeN458OgIpojMVBP+ImgJmm0TOGrvRC
         lJOeDXjUNFXYSkfzZcjbGrmhlw6B8K7d7nTceNSz7N4Kbg4Fz1yoLPVCSlNEruYN8nuw
         sqPNJQY12V5+Lox4FiLNTOPiBseRbsjXgF2o2mzA3y94RVcZBBzW101AtTjEnfhfMsgN
         uIQmwhcXhDFfbX/wW01yt3fp6D8weEUoIgs3cTino+4KBshiJiS8YGgJUD5s12S2Gu1z
         YVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUWPqNTyupX2OfJokS7Cyg6szXXlNV4uQSRKuBbr+Nk=;
        b=ma3JPsQsn9Kw6VBmeg0VDpHw7o5SEyrI2Vj58J1am3fqwWaRnHvRsUp8UWdJ0XRMop
         Kk7+lN6xTaSgw1LuzdyrBhRPNZSK37uv3wA63grme7+0WRcu5fedQwoHC/0nW/seRlVy
         hKrnasqnWwjrwsucPH4DfmK49lE8iuZhG9nxqOJb5tN84axr5QHWoAk+F5p7ue4a5CeP
         LEzuuaIQJnuN7Va2pqFg7gBMOuCRQ76mKZvlYaUTqG5U9roon/a569Iy12nPjcZmOQJv
         ANze0eo3zkmW94HaDVdVOU6RlSTtpH52axAUa2wmhcFTJ+gjzHnlrYK4HfUWDdfdxnjm
         P5HA==
X-Gm-Message-State: AOAM532zmXbocm2TuU2mpMcW2yrt3JEeY3ClRnCnaElDk112HU7mDxbH
        7fFo/FhNqdsJcftxJdcGXvyl/ooGj7Q=
X-Google-Smtp-Source: ABdhPJz4oppYHDMOr7cWktwBN00kT6be7JvWf8qKYCDNjlSQ2uUZu9nCNLwF+xq1vN5a0vn60fBs0w==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr13844105wmk.170.1594286835202;
        Thu, 09 Jul 2020 02:27:15 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 65sm4082233wmd.20.2020.07.09.02.27.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 02:27:14 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] ASoC: qcom: lpass-sc7180: Add platform driver for
 lpass audio
To:     Rohit kumar <rohitkr@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohkumar@qti.qualcomm.com>
References: <1594184896-10629-1-git-send-email-rohitkr@codeaurora.org>
 <1594184896-10629-8-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2d39e123-4b97-787a-7d6c-7d9fdfaa8f56@linaro.org>
Date:   Thu, 9 Jul 2020 10:27:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1594184896-10629-8-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2020 06:08, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
> 
> Add platform driver for configuring sc7180 lpass core I2S and
> DMA configuration to support playback & capture to external codecs
> connected over primary & secondary MI2S interfaces.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: Rohit kumar <rohkumar@qti.qualcomm.com>
> ---
LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



>   sound/soc/qcom/Kconfig        |   5 +
>   sound/soc/qcom/Makefile       |   2 +
>   sound/soc/qcom/lpass-sc7180.c | 216 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 223 insertions(+)
>   create mode 100644 sound/soc/qcom/lpass-sc7180.c
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 0ea4cde..87bec7f 100644
