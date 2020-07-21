Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C05C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B450920658
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595296382;
	bh=FDQZHy6V3YUHFMFMEikTPZZ1y5I2rcxlA3uomsiyjm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YMKXK9+HosfzXC5I59b5okkaXZxix7Eem/bQvVIPjID/Y16iHpAWekzynhWP1n0lX
	 onNeD/oxQnaWS2PyhHa0snghBBnUCkKQbuzf/zIlwunatSnBK+lP3jWf3JQP/K6wgr
	 k+I/HOijfnwJQxeEXkHbv+8zad57nsi7LQ2XC6G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGUBxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:53:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40348 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUBxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:53:01 -0400
Received: by mail-io1-f65.google.com with SMTP id l17so19667814iok.7;
        Mon, 20 Jul 2020 18:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9KP0Rc8u4bVobD9Gj1dIehnk+YvHsu8cH9wSojjS1pw=;
        b=b2EBRWcj3Knf3dshdCzhCSAi2J0/ruFrCLKZNwVsw5GJGtfz+PQHjzpMZicZZkEQoc
         tgNDScbN5QSe1RMsS0vkSCxoPis0snDDCd6dcYeIXHytocSP/kc6UKMsNYPMwZCtLiVE
         av2Zxt1p+nkfNTqy4iltZYiH5Wn9CxqNZw24vHTysSChsV92nRIAZnU9aFXKNVE1Me4s
         j2lq3bHMMl2P/DpJpI2v36ByH1dlDwViClB5SatSlguy0J7ed2uWwMZOL0ZKwUabW93p
         zsk+8+Ef3Irn/ap1ZrHM7kzmuJGMpYPQpi3dWNDEdwf1jRuLiuF2VgrhksRVMe8ZM9sB
         qkLA==
X-Gm-Message-State: AOAM530eXzq5Jx0c3/u4b38JOODsTf4HX2uXYWpg8Cqqz8b4iTaxygNe
        2A9fnhTIksiexflE9/+EIw==
X-Google-Smtp-Source: ABdhPJzaNK68W25st0exLMoy7RKom9FavgqN/p9iQOTVKMA8AHlp6hlZqOPW4z86KxVY7tE/qv2QBA==
X-Received: by 2002:a02:9109:: with SMTP id a9mr30142492jag.130.1595296380320;
        Mon, 20 Jul 2020 18:53:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x71sm9924564ilk.43.2020.07.20.18.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 18:52:59 -0700 (PDT)
Received: (nullmailer pid 3362142 invoked by uid 1000);
        Tue, 21 Jul 2020 01:52:58 -0000
Date:   Mon, 20 Jul 2020 19:52:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     robh+dt@kernel.org, arnd@arndb.de, miquel.raynal@bootlin.com,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, richard@nod.at
Subject: Re: [PATCH] mtd: Replace HTTP links with HTTPS ones
Message-ID: <20200721015258.GA3362089@bogus>
References: <20200713165408.36229-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713165408.36229-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 18:54:08 +0200, Alexander A. Klimov wrote:
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
>  If there are any URLs to be removed completely or at least not just HTTPSified:
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
>  Documentation/devicetree/bindings/mtd/davinci-nand.txt | 4 ++--
>  drivers/mtd/chips/Kconfig                              | 2 +-
>  drivers/mtd/maps/Kconfig                               | 2 +-
>  drivers/mtd/maps/sc520cdp.c                            | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
