Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE937C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FBF2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590706498;
	bh=v+iJcwsoYY5Rh6A6wbiLBdbYD+8naok+oM2a4WgIJyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vrmfJ8GXPY8nfCfPwpwvdcFYXGjmukpnLgfOmDDF6uI3GWKAocmg8UNlp7tggpzPv
	 AX+nJECL1mkmC/7jXzQ+m7pZeDb0EKA3Kd7t/t1lfRa9cVrvLd/3A3N1nghpPFIPEB
	 TLilfq+FAh1PENkz2D4yUxjUMnAlm/tU7qYk3sVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437438AbgE1Wy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:54:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39503 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437426AbgE1Wyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:54:47 -0400
Received: by mail-il1-f193.google.com with SMTP id c20so636432ilk.6;
        Thu, 28 May 2020 15:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHTcd6mWpJbJXhPxK/FEpQ2LRlSdDHwTREj7/ugkb8o=;
        b=J+eKmhTmAQOtphNGVTR5rw9u6ML83gdgb8MQla1lFfcP68kajqYn46drXHb94+8yyR
         yMlCegvJ1CB2EQo3MzG1caWanHzTKfbGiZa3d8LGvfK2xe9LqZyH1dVpGe37fxhMQWKo
         pXn1K7p8t4QLo9d1AJNrtMGmmB7q4/nWxTCOInQkfM3n7p3p9PhNt5z3jfQZah0r0wWm
         xpTI6rVR/G+PFkhluVlzk8q/bK+JCVTCgcd5PvWbs2LUx9ktM1Q+zdpU3KnBga5WTTfR
         OTpswGCOJ838PKf7b1eaRA4OYHhJ1c72vt71dz13ccNA0y/V8rezVcchlSrcDkAxFUxr
         FYvw==
X-Gm-Message-State: AOAM531TLNQVaxradgxxcGmHgBeYrzzOZRc7lUx/32OnhhL1tU4DoqeY
        ZGJsIThos/Odkcyryz7BLQ==
X-Google-Smtp-Source: ABdhPJzhfQ0MMJipRgtSPxtaAn3yPH1kW6NrGMRNpCd+X5e+SOVycOllyPQEgLEwN36Ol5zaHVHGKA==
X-Received: by 2002:a92:8b13:: with SMTP id i19mr5129875ild.46.1590706486779;
        Thu, 28 May 2020 15:54:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f10sm3739295ilj.85.2020.05.28.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:54:46 -0700 (PDT)
Received: (nullmailer pid 830413 invoked by uid 1000);
        Thu, 28 May 2020 22:54:45 -0000
Date:   Thu, 28 May 2020 16:54:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: mmc: Convert sdhci-pxa to json-schema
Message-ID: <20200528225445.GB815881@bogus>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
 <20200521091356.2211020-2-lkundrak@v3.sk>
 <CAPDyKFogpp+9d44Dgc8gXmeULj2CxoUzo4EhnLp+=_1YcvXT-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFogpp+9d44Dgc8gXmeULj2CxoUzo4EhnLp+=_1YcvXT-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:59:10AM +0200, Ulf Hansson wrote:
> On Thu, 21 May 2020 at 11:14, Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > Convert the sdhci-pxa binding to DT schema format using json-schema.
> >
> > At the same time, fix a couple of issues with the examples discovered by
> > the validation tool -- a semicolon instead of a comma and wrong node names.
> >
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> Rob, are you fine with this v2? I am intending to queue it up via my
> mmc tree, unless you want to pick it?

You can take it if you drop my name from 'maintainers'. Ideally, it 
shouldn't be your name either (should have called it 'owners' 
instead...).

Reviewed-by: Rob Herring <robh@kernel.org>
