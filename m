Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE09C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C61120787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drv2mSAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgERJWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgERJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:22:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD911C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:22:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z4so7352055wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Z3XlctpSAnbYdb2+5Z7TFNZPigSvZMxY4yX670//TBU=;
        b=drv2mSAuvezl8uk9ZvXfGTMENTCqHqLeB5OLJuBjylbY9VEyWGnJcxSWFwJQdlPu/F
         MI0sf0aLcYB3VSz8CAh7zmlYeci5h117eeqYjrXYOCC+4FZogJ+cfjXmN/uxIvzq9fol
         cFdzZiynTzFtdgY8iDZ6t1CIO4hPrPc3bmZcC9ULjdAW1X/nOAWsI+Yfsh4inCax8R6+
         ZRcB3gZly/uFkn57tKqXLWK3t3WVpmcdf23zUg1kdMP3INamQ3kTEj4REZR1te4YaMYm
         sXICAkHLFkf1OhzgL2/WBxfPrH9iJGAAg8735Xtf4myhO321CZ1v7azvSTBhhkrADJZw
         gnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=Z3XlctpSAnbYdb2+5Z7TFNZPigSvZMxY4yX670//TBU=;
        b=fYM8VApe+SuVuDtmpfyloF1PnvT7tSZB9lei04iV31SB40Mdd0g1HFQbOhl6mw0Zr4
         YekejUvN7jDas0OQ9rf62smg9Gf3PRXIMvp9IdaNK3zKGhZZdAcfwcnu+a0CJ7If5hg/
         VxMpWhyupBdrK/EMhg1esS0P6vLH7JhdrexSCErLj/W2hCZNTw9i46l51k969c3pq4i9
         XXSSJDqOHsPgOGOKiyLd2wbkq3uyv50csct1GLqmvNIdpNGr/FVwMmfhJapSQLM+FEyk
         mk1frmEQDLNDFkw2Qm6tVMiW+sGIUbukLrHOOXiiyX9mAEp1GRvhRHTu3awQh/7VB886
         kyKw==
X-Gm-Message-State: AOAM531h+hT+0K/zTLkeE+wyGTJw98H2zthPJVAREWCjfn7FJCG9Xg+a
        FaX98ZTWun2/6rXL4cI2Pi71e/phb6o=
X-Google-Smtp-Source: ABdhPJy8I8LDsz/5SOI07W1BDAQYcizOum1eE7aOvMk3UKlv2qSI1RLiOS6YkMJ6LmH6Vrszb+qMJg==
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr18126796wmh.58.1589793772297;
        Mon, 18 May 2020 02:22:52 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h133sm16392525wmf.25.2020.05.18.02.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:22:51 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] include: dt-bindings: sound: Add sc7180-lpass
 bindings header
To:     Ajit Pandey <ajitp@codeaurora.org>, broonie@kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: =?UTF-8?Q?=3c=1c1586592171-31644-1-git-send-email-ajitp=40codeau?=
 =?UTF-8?Q?rora=2eorg=1d=3e_=3c1589474298-29437-1-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e_=3c1589474298-29437-6-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e?=
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e8859fcf-fc00-01fc-b64e-dba086c8155b@linaro.org>
Date:   Mon, 18 May 2020 10:22:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2020 17:38, Ajit Pandey wrote:
> Add header defining dai-id and mclk id for SC7180 lpass soc.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> ---
>   include/dt-bindings/sound/sc7180-lpass.h | 10 ++++++++++

Why not reuse or rename include/dt-bindings/sound/apq8016-lpass.h to 
include/dt-bindings/sound/lpass.h and reuse across all the LPASS variants?

--srini

>   1 file changed, 10 insertions(+)
>   create mode 100644 include/dt-bindings/sound/sc7180-lpass.h
> 
> diff --git a/include/dt-bindings/sound/sc7180-lpass.h b/include/dt-bindings/sound/sc7180-lpass.h
> new file mode 100644
> index 0000000..7d988f6
> --- /dev/null
> +++ b/include/dt-bindings/sound/sc7180-lpass.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_SC7180_LPASS_H
> +#define __DT_SC7180_LPASS_H
> +
> +#define MI2S_PRIMARY	0
> +#define MI2S_SECONDARY	1
> +
> +#define LPASS_MCLK0	0
> +
> +#endif /* __DT_APQ8016_LPASS_H */
> 
