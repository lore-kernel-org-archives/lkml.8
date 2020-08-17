Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14C9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B48B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693546;
	bh=AFRY6qmw8k/Fvb4oECFHqM2opKMoQZO1D/wIYL5UJEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cgm7W5bqIDINXe4jRcD4F/WUu30U+7ZQamvVUC6Y4PVLYJJytr72J2tyoXioND0m1
	 UykrVhlE3cK5/yj8ldMMJQrbtyAz6g9pigHlruiN400sikvpAovIJ0mlfH+kYrUUnZ
	 rETgp3DgtF1N99qvgBW6LJLfFlEa9Jl5EAW5nASo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbgHQTpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:45:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41421 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404369AbgHQTpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:45:41 -0400
Received: by mail-io1-f65.google.com with SMTP id g19so18833500ioh.8;
        Mon, 17 Aug 2020 12:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9167b1zAfSDWY5dpby+m+hSASEzloHe7rPOI9rnQvoI=;
        b=iDp1FWAT2kCePFOeuPKe/VOs1RYNiZbsPeCm4Ny83PCcKvx3Y1sdmf3M0MMGrMLPvm
         vKxk9zACd6R+ZxJ8Di9PXyHiQc+feEJ1ay2Mbe4fa6+86joPUzezdNoCG/m899aqkisL
         9AlKoE1nV/tcnfc28yLerb6IET6TILWcDQtGVyIONBtPgdQ5PvcHT7rTHlyhphgt3Ola
         fk2Vxv0XndjRur6/JuZwvlxb2bCb/QhMAwSpC6jiORR+deSz311+QtqpitlEGc2sWD3M
         ZptV78BRRpkqVJJiPueVuUamSRKzD3U7qcykNESCe0K9iPt1S4/MclHpyUiv+IIJ9usk
         O7OQ==
X-Gm-Message-State: AOAM533G9HSKgAa3VHZcZrz6v3FTwQCJCPJk2zxZ53k2JP0pJMZwivPZ
        a2NMyBkpWStrZ1LRD4YCgoTOEelSeg==
X-Google-Smtp-Source: ABdhPJy/Kg9h4YQFjm3/QHraZGHGwQWqnX/EVeFFvEUcAqfRDNDEvMiIk7cblt87y9uIOl6p98xH8Q==
X-Received: by 2002:a5e:d514:: with SMTP id e20mr13493344iom.183.1597693540798;
        Mon, 17 Aug 2020 12:45:40 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w13sm10186284ilj.70.2020.08.17.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:45:40 -0700 (PDT)
Received: (nullmailer pid 1431277 invoked by uid 1000);
        Mon, 17 Aug 2020 19:45:39 -0000
Date:   Mon, 17 Aug 2020 13:45:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, cy_huang@richtek.com,
        gene_chen@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: rt4801: Fix the dt-binding document for
 dtc check.
Message-ID: <20200817194539.GA1429240@bogus>
References: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
 <1597461262-25878-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597461262-25878-3-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 11:14:22AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix the dt-binding document for dtc check.

This should be squashed into the prior patch.

> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../devicetree/bindings/regulator/richtek,rt4801-regulator.yaml        | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> index 28d30e2..fa075c6 100644
> --- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> @@ -49,9 +49,6 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties:
> -  - enable-gpios
> -

This should be:

additionalProperties: false

>  examples:
>    - |
>      i2c {
> -- 
> 2.7.4
> 
