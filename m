Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A630722BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283587;
	bh=sMfctC3P5KdSZ2XaCO8R7779EBr40u/tc3yXalKVxjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sIT46O+zcQN6d8shrhl90HC2DCkASfwmlXxji2rMIFv5aTRrU3KPCTSDypkWTYUi5
	 f8s+PUP3dtInQWs0YX5PHklov7jmsy6gJlhK/fdU8fqrfgSJ161gItOStQfzS0BCMt
	 nFqeS4G3DyWf4na6Dgs3+5ebgfsZl8X9JUpHRfJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGTWTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:19:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37723 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:19:45 -0400
Received: by mail-io1-f65.google.com with SMTP id v6so19309699iob.4;
        Mon, 20 Jul 2020 15:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M4cwyczqmm6o5ywsFWkrwMWhtFlofjIJw/3mf6jpg1s=;
        b=pqsMsD9LYEsb3M8sO1oSV31k0LrzQc4WWG+sPIbbOxoWnSDPnFmS/L4J6Dl2dk5NKm
         nBmexbGMLOXYMl6SOuLgphS277UVcwDZqaQE9iYVeZTiXStXHbeqdir67+PWVdUVGw+H
         YCoQyXoptAh9dguimMkLl1EwdjTWD22vEWkws+n4toSANAJCLYfwM1DErS12lGGqy1bj
         hoREu580JmwsLwkTfuGkk43FoIdS1IWJ7mVnYdKU8eEqfJpxoXQQq4XbZJ2Fo8XhF6cq
         RLKSEImX19jK7oak99aAUlGmqWRud+/cD7XLA+2+NOXNZRHPhCyD+SIMnvWlJGarYNqU
         TvxQ==
X-Gm-Message-State: AOAM530YmUWh8A+FrXSGhoGE/lFAdcKrGcITYbDVc40scnUDXSUb7Z54
        mkLeP7D0S1mIM3soHdT3Be9HrAfd9w==
X-Google-Smtp-Source: ABdhPJzzg0HbQaPAYTJWTomX7BOFZTV9tgKx8LY+r01ttCiKb5lNVgJydB/jcSDX4l2onnhZeHKg4g==
X-Received: by 2002:a05:6638:2401:: with SMTP id z1mr3812863jat.97.1595283584600;
        Mon, 20 Jul 2020 15:19:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s11sm9737265ili.79.2020.07.20.15.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:19:43 -0700 (PDT)
Received: (nullmailer pid 3052698 invoked by uid 1000);
        Mon, 20 Jul 2020 22:19:41 -0000
Date:   Mon, 20 Jul 2020 16:19:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: CLOCKSOURCE,
 CLOCKEVENT DRIVERS
Message-ID: <20200720221941.GA3052652@bogus>
References: <20200708165856.15322-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708165856.15322-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020 18:58:56 +0200, Alexander A. Klimov wrote:
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
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  Documentation/devicetree/bindings/timer/ti,keystone-timer.txt | 2 +-
>  drivers/clocksource/timer-ti-32k.c                            | 2 +-
>  drivers/clocksource/timer-ti-dm.c                             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
