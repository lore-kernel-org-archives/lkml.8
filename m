Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB2F2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596226831;
	bh=b6Kd7W7qIcd9HCB+grl80x+iMKiqdTkxM3biZ3nm8mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7FT4Vo44cWWEhoIkhpThSSomeMQyN14FLjJCabXrVF9d+a3zJAcWVe6nE/svyOEz
	 S+4lcfG2Mou+0ppBxonQ/EcW4VyhtHJnzNE2hx9CBxYqdAM4oP3iBuqI807TUW7MCu
	 ar6b2sKEFYj8SwBaoho++iFh9w4bflKFjk2LDtoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgGaUUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:20:30 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35196 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:20:30 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so26403656ilh.2;
        Fri, 31 Jul 2020 13:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=14cFHIH+5pcNnYf7nGiGjtZ3STT/BgFgufhbpVb8w2E=;
        b=p87KS+8lFIt7T+ZIFHj99eSaAWB5V/nI+3S3xMfRDoieiiStW+mM12zG3CR8X2BuCa
         ZILx7qR7DmVSKXm7u1C9BmYk1U3rcQcB8ULrGDMI0wxdHNHbofq6JMlCCkz6dGMwds9e
         ++lhqVjLxSNfeMt4MoBncwDOGjy7nHS2xZPpI+NOVs3CTmBvvny30vabgAwJym6FXeyJ
         4aaBS5G6rwnqMPQLz84gpdQfY94OvpuHmjdAZyViIiXTjg9A2qjVkZBYo9H4UxAYjanB
         UgfwY6gjLplP3fSQvxlM509V4ProIyLeWSgUECJqkHBlqWBacyB1ErahpdaLlSOPT/Qa
         q5mg==
X-Gm-Message-State: AOAM532J7C9nOnhuy34bLq3WYusyeaK4VJoxba9xozS/8Hsg15pPKnPR
        qBt1AqgBf9/FidrnP9zhrg==
X-Google-Smtp-Source: ABdhPJwH+8TRsy44CdLoDhMeudbSS0ZxxndP4/x3ZTsHVWfrjyI+20UP81e+sp4iuHC9D9Xz17JjSw==
X-Received: by 2002:a05:6e02:134e:: with SMTP id k14mr2532291ilr.152.1596226829165;
        Fri, 31 Jul 2020 13:20:29 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a18sm4415112ilp.52.2020.07.31.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:20:28 -0700 (PDT)
Received: (nullmailer pid 713904 invoked by uid 1000);
        Fri, 31 Jul 2020 20:20:25 -0000
Date:   Fri, 31 Jul 2020 14:20:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: dt-bindings: Add a new compatible for the A64
 codec
Message-ID: <20200731202025.GA713768@bogus>
References: <20200726012557.38282-1-samuel@sholland.org>
 <20200726012557.38282-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726012557.38282-2-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 20:25:51 -0500, Samuel Holland wrote:
> The audio codecs in the A33 and A64 are both integrated variants of the
> X-Powers AC100 codec. However, there are some differences between them
> that merit having a separate compatible:
>  - The A64 has a second DRC block, not present in the AC100 or A33.
>  - The A33 has some extra muxing options for AIF1/2/3 in the
>    AIF3_SGP_CTRL register, which are not present in the AC100 or A64.
>  - The A33 is missing registers providing jack detection functionality.
>  - The A33 is claimed to invert LRCK, but this is not seen on A64.
> 
> Since the driver will continue to work on the A64 using the A33
> compatible, albeit without jack detection functionality and with
> possibly inverted channels, as it does now, allow the A33 compatible
> to be used as a fallback.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../bindings/sound/allwinner,sun8i-a33-codec.yaml           | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
