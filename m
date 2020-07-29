Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C33C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623F1206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKCVxkjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG2Tb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgG2Tb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:31:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F973C0619D5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:31:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so3349705pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=heIh5b42q1abQ+Nw5f1N785+1Eca4zOLDnob5GQDx/E=;
        b=yKCVxkjUW77JjQhu2NZdAHJQEAoKRqgV2ihMnaeidQRtXVu2UI0HGxIOgtgCrdUEfr
         Ncp2xQ0KBSHxWsZ60dLgpxiKZ5mrncfB7rlCnIPjAGNIl7vtRJgU8Ztrr7hM5gdoKvh4
         csvao3HStnm4CSIfhM+i/wnxfQRrHHlFbKut3sld+WYj7UcbFRO+F/uXWVq7riMlcO8w
         VdT6D6BZlirTkVb9n/3LfyvNmw9IQBt3N6aBGazQpyYR54zLwWurzxh9G5ICqNAS44yY
         Y9z3PbDrHtuXtROHXb4sVO9rH+YljqzsiEf4zExbitSNSbIkH4nSaBZbQiyZQZjVnva0
         pnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=heIh5b42q1abQ+Nw5f1N785+1Eca4zOLDnob5GQDx/E=;
        b=i6niIsiArL1l1kaUDAskVBGvzgXNioGDPy4YF5Scj5/oiCEqiZKPO9Dq74SzHGZbjQ
         81SJCsc0bEEfH4jk+x0dAqAdUcGzHndXop5BOWvkR+BGkSScHVhkIUhL5O4OIfPPvc9a
         acFBvXxNNd6st2jWiWc0P2qhGq8pHm4z3l+IwqutPAW+sNitMPGLvkCHBiFtEygpda19
         SqRMqiC3LORu20Jm8zcIF1tMEF59ujTf5kdaMOFP07D+b/MQsgYReMMCJKn51HthSIMk
         y4OoXEwj6eDVQlZJm7OWJ9jskn87T1InDLAAdJNWXB02C5yJ2ENGDGwDfgR+JNec2CGy
         aOHw==
X-Gm-Message-State: AOAM533/HQKmvxeW6XjmH/UNjHWEh3QbNCGgT/zK0olWz683502zxzur
        d+TwWFAFO0pFuMpnbTkyM9hirQ==
X-Google-Smtp-Source: ABdhPJxx2F5Ceyd7KGPk6bhpkvl6yqGP29s/+ClNuIC+H3z3NPqe1qyJ8bSIppNFM4tFB9tltY3Axg==
X-Received: by 2002:aa7:9419:: with SMTP id x25mr31556391pfo.67.1596051117785;
        Wed, 29 Jul 2020 12:31:57 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b22sm2907600pju.26.2020.07.29.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:31:57 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:28:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org
Subject: Re: [PATCH v5 1/5] dt-bindings: media: venus: Add an optional power
 domain for perf voting
Message-ID: <20200729192828.GH229995@builder.lan>
References: <1596007005-30425-1-git-send-email-rnayak@codeaurora.org>
 <1596007005-30425-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596007005-30425-2-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Jul 00:16 PDT 2020, Rajendra Nayak wrote:

> Venus needs to vote for the performance state of a power domain (cx)
> to be able to support DVFS. This 'cx' power domain is controlled by
> rpmh and is a common power domain (scalable) not specific to
> venus alone. This is optional in the sense that, leaving this power
> domain out does not really impact the functionality but just makes
> the platform a little less power efficient.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml    | 6 +++++-
>  Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> index 55f2d67..04e303b 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> @@ -25,12 +25,16 @@ properties:
>      maxItems: 1
>  
>    power-domains:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    power-domain-names:
> +    minItems: 2
> +    maxItems: 3
>      items:
>        - const: venus
>        - const: vcodec0
> +      - const: cx
>  
>    clocks:
>      maxItems: 5
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> index 157dff8..90013d4 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> @@ -25,13 +25,17 @@ properties:
>      maxItems: 1
>  
>    power-domains:
> -    maxItems: 3
> +    minItems: 3
> +    maxItems: 4
>  
>    power-domain-names:
> +    minItems: 3
> +    maxItems: 4
>      items:
>        - const: venus
>        - const: vcodec0
>        - const: vcodec1
> +      - const: cx
>  
>    clocks:
>      maxItems: 7
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
