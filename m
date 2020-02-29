Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D089C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 10:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D3D246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUhmg5FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgB2KoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 05:44:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34624 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgB2KoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 05:44:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so2887433pgn.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SB2zgIhiQZxj/QhdSznnFhbcqQLT0zn4L9QUBfDgryE=;
        b=MUhmg5FGS1EBD6jMzsKu3KwSU6WQCv0D8ZRh11klKyG6dGEGM1Z5GQ9AY85EelgZQc
         I8c02hcXUC+6D3Dtzj9MBOsP01nryezSHBMJjdKNGqpStoRaPqpq6/ggg6KCEJ11mgKe
         mpisWb5fjhgqshqwDMWfxj+sq9i7CJeg+fmAnXr55V5v9DHOZBS/JozfMhfAgS6z/vNn
         cv8Lve04mAAuFXguSIS/ssXFQGFpqB52gfzM2+2X4DAk98Nj+Zske27klr+1Razu9KFm
         LxQCIffqAp7f3V4aYF14gsmbrw2vDxQitXzQ/sghYC7etT9+7g5s7akJB+cCUQi+c83Q
         yl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SB2zgIhiQZxj/QhdSznnFhbcqQLT0zn4L9QUBfDgryE=;
        b=B+E/dcnenZ1sTC8KbOKNNtodZ3mlhK70y0kiz+SnNDA0VuuY5l0LL5KaN1CKt//Zv7
         Ky0RLUflc0jeSPvw+09m63sZYgnIxAeBES0sqbD1vbooMdyP92OmppxtfDgFwQSzTcIu
         hTTekuHaOLHCZ6zxKDykXu6oN8ueH7nJbKT+59UEN/pwv8u1DOKaPQuB34db/Lqyas5h
         tWPYdumvcdp2LZl0dYdatgUdysJ8FoeR+dgFNbI3lbTvbGD9qoNaPIcN7XU9bbIcsbzU
         QS32GAr93Wu6+ewOTVIEMb2Rju647Qyp1oYefjvVdWIoIrpvoDILtL9pmaOdcnGFlPBG
         PXqg==
X-Gm-Message-State: APjAAAXF3wVoZoZ3D1xDyOC6mnDh/vLznKHgWAvwHtNLMnRBKdie1zVU
        4ABGywM60AdH+h4H6Mk8f0f1
X-Google-Smtp-Source: APXvYqwV8CNh7pfjbCdPlz5eowb4Zc8P0T47nldacmIYks5MMdlgteVAxEM6vUQRGb+e4d44Nl4K2g==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr8940121pfi.105.1582973046778;
        Sat, 29 Feb 2020 02:44:06 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id c2sm5396676pjo.28.2020.02.29.02.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 02:44:06 -0800 (PST)
Date:   Sat, 29 Feb 2020 16:13:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: actions: Document Caninos
 Loucos Labrador
Message-ID: <20200229104358.GB19610@mani>
References: <20200227201557.368533-1-matheus@castello.eng.br>
 <20200227201557.368533-2-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227201557.368533-2-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:15:56PM -0300, Matheus Castello wrote:
> Update the documentation to add the Caninos Loucos Labrador
> vendor-prefix and items that were included in the device tree files.
> 

These two should be splitted into separate patches.

Thanks,
Mani

> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  Documentation/devicetree/bindings/arm/actions.yaml     | 5 +++++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> index ace3fdaa8396..1b131ceb884a 100644
> --- a/Documentation/devicetree/bindings/arm/actions.yaml
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -24,6 +24,11 @@ properties:
>                - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
>            - const: lemaker,guitar
>            - const: actions,s500
> +      - items:
> +          - enum:
> +              - caninos,labrador-bb # Caninos Loucos Labrador Base Board
> +          - const: caninos,labrador
> +          - const: actions,s500
> 
>        # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
>        - items:
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9e67944bec9c..3e974dd563cf 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -167,6 +167,8 @@ patternProperties:
>      description: Calxeda
>    "^capella,.*":
>      description: Capella Microsystems, Inc
> +  "^caninos,.*":
> +    description: Caninos Loucos LSI-TEC NPO
>    "^cascoda,.*":
>      description: Cascoda, Ltd.
>    "^catalyst,.*":
> --
> 2.25.0
> 
