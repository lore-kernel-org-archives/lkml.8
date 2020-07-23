Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B30C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BD92071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595519433;
	bh=O9k8YbGM8sTH2wq0nwGE9MsoCkW0mbfBcN3U9l6jy+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WnB2uPd2OTI2kalBJbeDW7PSoLIMLwn5JwqLW25XRbc7iUg9N26kTF7OQDOA+YRjN
	 c2VtMcWW5iRFUWoaoFiVZV2eWyXOd4l3NSKbegiKirtd3d0uonoTOTB7Dgf6KIu+I3
	 7pm4nggX8xAbXkHok0wmheXcyWVzmLf0ohM1RQAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgGWPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:50:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33833 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:50:31 -0400
Received: by mail-io1-f65.google.com with SMTP id q74so6759852iod.1;
        Thu, 23 Jul 2020 08:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fl2ka9nuUa2SJkSyRR1vF0gTmehADr0HvHCO5Jzmn5U=;
        b=NML5/RN1pnVRcrN0sTyrFGgF+KOOvgi2+uvno4zFvFvHaamSnPuqtEck4SgOsB9HGQ
         X5YUqBgbaExqLEkb7Jm3xqB25B3pjt9UwMQIqSVxex9xaLoXTPgiWB5tn++1MXGPtfRn
         XOTAxhstE0oahuF2wPXnMS/h4+OvY7ZPkFpPc+QpCESujEtX/HJDRpsG/V0ZskAKBFAr
         PdCVQKuUQOdiLrV3Npy1nIyupxlHby0QE/9JPOSvu4RugD8Wj4509au16xUnteohnOEx
         bJKNEOBOv0/QhftvIgrsXAPAZEkSD628LcEQksH3/hza0nnq1pK74mZwOlzKk1NJUTaF
         /zIw==
X-Gm-Message-State: AOAM531chrd0CINidCKsP20UMTAeZZeF1TuQurbd467wAKz5gw+x+rTH
        KbKrfrZMVnGuRt/OTbvMWQ3676qMhg==
X-Google-Smtp-Source: ABdhPJzPPDcWqfpQgBQbjNBsc9IEoz9TJucBz+NpyZYMuHEgMCE2vtozhhrLxjbBv746yY3RWvDeHQ==
X-Received: by 2002:a6b:5c0a:: with SMTP id z10mr5518781ioh.131.1595519430836;
        Thu, 23 Jul 2020 08:50:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p20sm1159991iod.27.2020.07.23.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:50:30 -0700 (PDT)
Received: (nullmailer pid 435445 invoked by uid 1000);
        Thu, 23 Jul 2020 15:50:28 -0000
Date:   Thu, 23 Jul 2020 09:50:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: rockchip: Update ROCKPi 4
 binding
Message-ID: <20200723155028.GA427258@bogus>
References: <20200723090210.41201-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723090210.41201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:32:07PM +0530, Jagan Teki wrote:
> ROCKPi 4 has 3 variants of hardware platforms called
> ROCKPi 4A, 4B, and 4C.
> 
> - ROCKPi 4A has no Wif/BT.
> - ROCKPi 4B has AP6256 Wifi/BT, PoE.
> - ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
>   GPIO pin change compared to 4B, 4C
> 
> So, update the existing ROCKPi 4 binding to support
> ROCKPi 4A/B/C hardware platforms.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index db2e35796795..e6f656b0bd56 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -430,8 +430,12 @@ properties:
>            - const: radxa,rock
>            - const: rockchip,rk3188
>  
> -      - description: Radxa ROCK Pi 4
> +      - description: Radxa ROCK Pi 4A/B/C
>          items:
> +          - enum:
> +              - const: radxa,rockpi4a
> +              - const: radxa,rockpi4b
> +              - const: radxa,rockpi4c
>            - const: radxa,rockpi4

radxa,rockpi4 already meant 'ROCKPi 4A' and should continue to do so. 
Just add 4B and 4C strings. It's up to you if they should be backwards 
compatible with 'radxa,rockpi4' (meaning 4A), but I'd guess not unless 
it's just a board pop option.

>            - const: rockchip,rk3399
>  
> -- 
> 2.25.1
> 
