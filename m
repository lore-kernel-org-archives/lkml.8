Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9846CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711A0206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DquI3KoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgA2U6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:58:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36809 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgA2U6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:58:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id 185so285380pfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 12:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UoMAzn/099CvNvcShTE0fqakA9YvEbTZbA/yOdNPeow=;
        b=DquI3KoXfcdwBJ3y7b80B31FvtkFeKlD1KIQaJ2I79W1Os4hdnhEFGXWl0HK9kPGhJ
         LsORtAnSvWwEXshGIH/dAoH9VMRgrJ6LxINyGGrpB1IC7rT84Ig6sYmN/XPt96k9hq0l
         HoZUtz+lLd+TGSEU11nBcpCVypQCqLpDTmqr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UoMAzn/099CvNvcShTE0fqakA9YvEbTZbA/yOdNPeow=;
        b=luzgUto2qvWMD7QIIUK4Qik0awYAZKEfCaBHvB0OkI+43qrNZACtq8WYegtfFVBibT
         mydeFiRqf5nHrpsF6Dto0vXH/GvHfiLw2WsPe9YdL6gpXX189OEXmunycO6MK2cC5KdX
         1TLlZKurkVAFi/SOwAtKuBjYGYYWw+/SV/U/hDvOQDMcbv17aYERVny/p6qZXb8Gw7Oi
         OogORAHnxClgMxoA1xWMX0YNuqNs38jvTd2aec+FZUKFYWxjaWcmf9T7eFtCD9dQjlGV
         j+xXpDnu/gg5cvtYhjF1/CminknY3nyzqAelVEUrTRAPUoxhjp71mUgan1zAqDxll7cu
         bKKQ==
X-Gm-Message-State: APjAAAVjzLsHNAyXmVscN46KU6u0eyXioHy6QUsaXOtE7Pb87FytVG9r
        ngtYJChIjQN7o9N+pnolbIG3tQ==
X-Google-Smtp-Source: APXvYqwjnqHvrvMkWU2n+NRKl9k2drCHiF4vLcBdGx+Z7bM/W2rp1iRPMu9xJw3rFRmv7O7yIBxJ1g==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr1469295pfg.224.1580331533751;
        Wed, 29 Jan 2020 12:58:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id e6sm3748856pfh.32.2020.01.29.12.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:58:53 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:58:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/8] dt-bindings: phy: qcom,qusb2: Add compatibles for
 QUSB2 V2 phy and SC7180
Message-ID: <20200129205852.GH71044@google.com>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-3-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580305919-30946-3-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:21:53PM +0530, Sandeep Maheswaram wrote:
> Add compatibles for generic QUSB2 V2 phy which can be used for
> sdm845 and sc7180.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> index 90b3cc6..43082c8 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> @@ -15,10 +15,17 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,msm8996-qusb2-phy
> -      - qcom,msm8998-qusb2-phy
> -      - qcom,sdm845-qusb2-phy
> +    oneOf:
> +      - items:
> +        - enum:
> +          - qcom,msm8996-qusb2-phy
> +          - qcom,msm8998-qusb2-phy
> +          - qcom,qusb2-v2-phy
> +      - items:
> +        - enum:
> +          - qcom,sc7180-qusb2-phy
> +          - qcom,sdm845-qusb2-phy
> +        - const: qcom,qusb2-v2-phy
>    reg:
>      maxItems: 1

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
