Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D71B2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347762;
	bh=j3OL6uml46nIXpf1TK9WGFnvbhZupq+kt5REI1TS3OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dnejz9ho0J/q+sxdwpNXFcc8W+mZR3Znhs+yNiBDMF+Wn0AksNhgNa6a4ZGi9ZucF
	 L/BYLwspiDSKOgG7bdTF6ztASl/aMoH1dsb4YcHvzg5m7f9T/vGkOMnzSChbE/FcgW
	 n8wI7Rn9JAMvbsmOJVh/C/02UZApcE16TrvIt5Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgGUQJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:09:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36248 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGUQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:09:20 -0400
Received: by mail-io1-f66.google.com with SMTP id y2so22007336ioy.3;
        Tue, 21 Jul 2020 09:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7SKGdsuV2Lu9rv7tAf0+85g7Dfyi1SjWCVPk0H7xuI=;
        b=ffxuyvUYG5aN0mr903Zk+nsaSTgBs80f7wJTyOVPYqjQJ97qcQNWXHqis13oZOJ2Yq
         kIIgU/oMWW6BlXhH38hb5exqDtvNQzoYfz0lYqC5cx8qJk4vp4HZB36yNHPxHcZLJuQt
         gNCEhdtZ1S/PP9anWxt9fnrriUNksNb/2YsssX60G2R318Q6roo5yD9EfpxmpnF9GR1r
         g1fu1aAEL8L+pZPcuYaieeKoZ0IGdxF+r5OdC3065jO1oNEc5dL1ckmbLT/Aw+w13fh7
         Ip7p1DeS+5tkrc1vNv/d1VRufnJWDTe5CucrqAIP/GPivdnYfYfrWBaaTx3DnK05eINr
         LRAQ==
X-Gm-Message-State: AOAM533EFnTmZy2UhI2QbgOPmSA4IEmPOStbnjXpeipSb3gUqffQQWWK
        gALlBykOgJTv9lKnUD6pCw==
X-Google-Smtp-Source: ABdhPJzBawMxgCSX0AUQwfBS8OL1XXe8O8X04c1o3zkG/+VwBdElqh52sabgY3AaXrOc8zdZ1zwEhw==
X-Received: by 2002:a5e:c30f:: with SMTP id a15mr29017311iok.184.1595347759305;
        Tue, 21 Jul 2020 09:09:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l5sm10360248ios.3.2020.07.21.09.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:09:17 -0700 (PDT)
Received: (nullmailer pid 387113 invoked by uid 1000);
        Tue, 21 Jul 2020 16:09:13 -0000
Date:   Tue, 21 Jul 2020 10:09:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     pankaj.laxminarayan.bharadiya@intel.com, shifu0704@thundersoft.com,
        alsa-devel@alsa-project.org, tzungbi@google.com,
        dinghao.liu@zju.edu.cn, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
        robh+dt@kernel.org, dmurphy@ti.com, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com, jbrunet@baylibre.com,
        broonie@kernel.org, colin.king@canonical.com,
        cychiang@chromium.org, keescook@chromium.org, tiwai@suse.com,
        nikita.yoush@cogentembedded.com, corbet@lwn.net, lkp@intel.com,
        linux-doc@vger.kernel.org, rikard.falkeborn@gmail.com, afd@ti.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH for v5.9] ASoC: Replace HTTP links with HTTPS ones
Message-ID: <20200721160913.GA387081@bogus>
References: <20200719153822.59788-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719153822.59788-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 17:38:22 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/devicetree/bindings/sound/adi,adau1977.txt   | 6 +++---
>  Documentation/devicetree/bindings/sound/tas2552.txt        | 2 +-
>  Documentation/devicetree/bindings/sound/tas5720.txt        | 6 +++---
>  Documentation/devicetree/bindings/sound/ti,tas6424.txt     | 2 +-
>  Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 6 +++---
>  Documentation/sound/soc/dai.rst                            | 2 +-
>  sound/soc/cirrus/ep93xx-ac97.c                             | 2 +-
>  sound/soc/codecs/hdmi-codec.c                              | 2 +-
>  sound/soc/codecs/max9850.c                                 | 2 +-
>  sound/soc/codecs/mc13783.c                                 | 2 +-
>  sound/soc/codecs/pcm186x-i2c.c                             | 2 +-
>  sound/soc/codecs/pcm186x-spi.c                             | 2 +-
>  sound/soc/codecs/pcm186x.c                                 | 2 +-
>  sound/soc/codecs/pcm186x.h                                 | 2 +-
>  sound/soc/codecs/tas2552.c                                 | 2 +-
>  sound/soc/codecs/tas2552.h                                 | 2 +-
>  sound/soc/codecs/tas2562.h                                 | 2 +-
>  sound/soc/codecs/tas2770.c                                 | 2 +-
>  sound/soc/codecs/tas2770.h                                 | 2 +-
>  sound/soc/codecs/tas5720.c                                 | 2 +-
>  sound/soc/codecs/tas5720.h                                 | 2 +-
>  sound/soc/codecs/tas6424.c                                 | 2 +-
>  sound/soc/codecs/tas6424.h                                 | 2 +-
>  sound/soc/codecs/tlv320adcx140.c                           | 2 +-
>  sound/soc/codecs/tlv320adcx140.h                           | 2 +-
>  sound/soc/codecs/tlv320aic31xx.c                           | 4 ++--
>  sound/soc/codecs/tlv320aic31xx.h                           | 2 +-
>  27 files changed, 34 insertions(+), 34 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
