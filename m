Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3DC55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A072C20776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gve4+ZOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDWCXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgDWCXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:23:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0473C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 19:23:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so1720427plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 19:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eqFUKGkgi/7711Wd38R/oVpsnZqk153pOxex7VFlhKU=;
        b=Gve4+ZOSbBsFD7X0/46iWM+Blcp+bEInJawIuG4DDAMMxWQXY8av0kd1/fY24V6zdT
         ELy8Vh8MTreWostHMbb8auwZwm66HdtXBA9EKl7wRW+v112NjfOXIZ2ArntK/RJVlh1Z
         uhalFEqrBscwkRCDYvmvaRkXL5CoGQuM1dCeRK6LXsqoSA2yJZYAvr5JGWPkH09U1AsT
         mkavbEi4lPMDXu+O2riYe908bm3/sPNsuq+8gmWdMhYSB0QRf6rHMHyRdBKqrmhEqiE7
         jXTP4pjwsGNm9HnsQTCJVv/ExMF1I5EFbjDGZYM2iHNqbh01gwuoll9vNLavKQkwmPyT
         8fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqFUKGkgi/7711Wd38R/oVpsnZqk153pOxex7VFlhKU=;
        b=AhDW0eHbI6reoO6QMYWOQDiBeauBI4A/Dejhqm9zUDKHvnJKSE+WaAL89tVt6nYbqk
         cl0Bi/GS6F8KKBWjmbrIkQMRkBjVdWqqrgrc2JospuADK6kFU9VBQ0NRWHiId5CsyxIR
         NYMjyEN9CelY4vVomPhhZXOB/3oYNLmcA1asoyEFcukRn6CeFpqIboW7MJrw6OcRbeyQ
         dqM2eZu/c1nMKI6lrpZDQY2jGp04hnzs816udTpK/9BnovW8ZeXdZTCD5l2fbBC1uegu
         sJCKqQMxWg2lF0abQmTdn1OMePnDRCO6YtQgkj1TIID1ZSE066nscQilVqUsWnFy+NCu
         IYCA==
X-Gm-Message-State: AGi0PubO0PZlsVUMAUuMv3/EQ1z67bzjtk7RLdh1q34yn7xz++W1DWM2
        7zYSh+sNLp9ceIKLHCaUn28HKQ==
X-Google-Smtp-Source: APiQypK1wUBVfNamJOHbWROPygChJ+zXEaD4hi3JQ65lkp1FVEmTMJ3Mzo7b2yTja1eNX2IbCHqx5A==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr1627192plt.177.1587608631391;
        Wed, 22 Apr 2020 19:23:51 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x26sm854034pfo.218.2020.04.22.19.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 19:23:50 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:24:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: qcom: c630: fix asm dai setup
Message-ID: <20200423022417.GT20625@builder.lan>
References: <20200422102044.8995-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422102044.8995-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Apr 03:20 PDT 2020, Srinivas Kandagatla wrote:

> "direction" property is only valid for asm compressed dais,
> so remove it for non compressed dais
> 
> Fixes: 45021d35fcb2 ("arm64: dts: qcom: c630: Enable audio support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 3b617a75fafa..51a670ad15b2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -359,12 +359,10 @@
>  &q6asmdai {
>  	dai@0 {
>  		reg = <0>;
> -		direction = <2>;
>  	};
>  
>  	dai@1 {
>  		reg = <1>;
> -		direction = <1>;
>  	};
>  };
>  
> -- 
> 2.21.0
> 
