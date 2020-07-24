Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA84D206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="NiuKrFL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXTh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgGXTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:37:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB629C0619E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:37:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i80so5769827lfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=anre9lcJof6187CbKzrw5qizyC3m4lA555ZA9TP3qEc=;
        b=NiuKrFL+hCZQ/5s3aFc1IxO3Tv/X/oM2SW3jpsF9kw7dKCcB+SPFaqr1FCwR9Nrt2x
         Z3TeScoiar4gyVLvb1t5LSenXDbiZ0PEQOpqTgsMEC/TZZo5QOxr+hYTlZNrD7uJU5X2
         ePDkfVd9bDSZICuMGZGa4WSbaBsP6xgzEVErw13brTNkFqx0wes5JsyGiAwv5f4xyZFs
         8yTKeCpXRA1ZfUgs+6y/UkdCvpDErfmD3a3sig2rJEBXRHSSOmhKIwUrCOwRqCdqnz1L
         vVn58JWoy5IyfS5vGKVKC68qD0Xhpsl/NkMt0GZmQJupvKF91X3IGP3REzBP3Xn0z7PW
         8iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=anre9lcJof6187CbKzrw5qizyC3m4lA555ZA9TP3qEc=;
        b=EqGjo+LPuWOCL0mxtycVzWjm7B2NjGYRlIbu9gqxzaHBUocvQY0XwQcRmwJM4jE9Us
         c3T9EJa+gXig5vYO7UgNE+O00IwNTfv9wNUsc8WwEiuGbUiMgpuxe7jWJJHuaDS5KTV3
         0A7TK7/u4Bu18/Hp1OIbnDSJP5JlZrvBzz7uBd7j6DjMOSaOmhA2rOxK7qR5c+D+nMgH
         eDGvQ1xBMvAnzxkEjVCYbR1aO51nFC/xJL19hmQN0GMgtrtcPoHtBFCE6rxpKsXcF9+u
         t/MlPHeyfpzflKGNqBHs999T1EoZq2uB5iqK5TT7ODx9fOOmEQIFRSh8Ec2BbkpLjGCI
         FE0g==
X-Gm-Message-State: AOAM532yP+kGM84Aip5espYc5SjSqSwCwxFt1ZoamOksy/a1E5yKr+q1
        hU1xOrhhYuj7R0EhS/v+ORBYlQ==
X-Google-Smtp-Source: ABdhPJwBtPnJGVYlPrGHrR5aqgZMiuVvpx8x3z+sVh22q8qvDyRybL2id/F9lVjZNk7hnl7OHeIE2w==
X-Received: by 2002:a19:c3d0:: with SMTP id t199mr5811130lff.56.1595619474080;
        Fri, 24 Jul 2020 12:37:54 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id y24sm443386ljy.91.2020.07.24.12.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:37:53 -0700 (PDT)
Date:   Fri, 24 Jul 2020 21:37:52 +0200
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: media: renesas,vin: Document
 renesas-vin-ycbcr-8b-g property
Message-ID: <20200724193752.GE2729799@oden.dyn.berto.se>
References: <1595602732-25582-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1595602732-25582-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595602732-25582-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Thanks for your patch.

On 2020-07-24 15:58:51 +0100, Lad Prabhakar wrote:
> Add a DT property "renesas-vin-ycbcr-8b-g" to select YCbCr422 8-bit data
> input pins.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/media/renesas,vin.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,vin.yaml b/Documentation/devicetree/bindings/media/renesas,vin.yaml
> index 53c0a72..7dfb781 100644
> --- a/Documentation/devicetree/bindings/media/renesas,vin.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,vin.yaml
> @@ -106,6 +106,12 @@ properties:
>  
>            remote-endpoint: true
>  
> +          renesas-vin-ycbcr-8b-g:

I think the preferred format for vendor specific properties are 
"<vendor>,<property>".

This nit apart I'm not sure a property is the right way here. Could it 
not be possible on some designs to have two different sensors one wired 
to DATA[7:0] and the other to DATA[15:8] and by controlling the 
VNDRM2_YDS register at runtime switch between the two? If so adding a DT 
property to hard-code one of the two options would prevent this. I fear 
we need to think of a runtime way to deal with this.

The best way to do that I think is to extend the port@0 node to allow 
for two endpoints, one for each of the two possible parallel sensors.  
This would then have to be expressed in the media graph and selection if 
YDS should be set or not depend on which media links are enabled.

> +            type: boolean
> +            description:
> +              If present this property specifies to selects VIN_G[7:0] as data pins for YCbCr422 8-bit data.
> +            default: false
> +
>          required:
>            - remote-endpoint
>  
> @@ -168,6 +174,13 @@ properties:
>  
>                remote-endpoint: true
>  
> +              renesas-vin-ycbcr-8b-g:
> +                type: boolean
> +                description:
> +                  If present this property specifies to selects VIN_G[7:0] as data pins for
> +                  YCbCr422 8-bit data.
> +                default: false
> +
>              required:
>                - remote-endpoint
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
