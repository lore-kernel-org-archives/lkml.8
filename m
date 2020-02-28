Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F49BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D682469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582904890;
	bh=Oy2ldJn4Mh6A6U9cW0jozVZjlJ2RPb9dnTRhitgLVgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iJbXkKEtETNA9PnW9HPs9a0eTGjInTmyy9v0guRXIfoIUC0LrPmUfoRrued9YDZ1+
	 bxnQHBe+QNxmuNbbQXB8hKQwDHKOSIVFDmtUW7RXCb/4WDnuXWeh8YuLcrflVGo91d
	 RfNIKI/3sZDpTyHPp7tDpEH/is9Igy4sA96PQqtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgB1PsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:48:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37496 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgB1PsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:48:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so2986391otp.4;
        Fri, 28 Feb 2020 07:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=04LO6bJs9Ua8w0YW0IQRrzZktCzF8p2YIFQW4LHwyB0=;
        b=A+q3NPlcyL0Gl/LfkaB7KuBNTqR8XuixsuKUsyaYc3Cm1z7gkFEsiy1XTyf2No0PkQ
         95IQ4RAtaGAsUouVpJGAdDvaUlfvObXRow1ltms9q82UE+I5jFFj52+8oMH2o1Uo8d/3
         dkuA72CD3pVxuvvXYOdQTXFVQLD2lD0PFSab3i/pidG/y25f0uIapQfsJxHGH+uqQsnc
         s4jhP9bKOOrVf5F7RKa8JH049b/SgOpxJRtvPSnEfYKrPxRpZEr/6KXnglYU36gVOUwI
         fwVsiOHCfwe0cwhFwfmEhro2zWq2EprPLcqON089jEEqWDpNTxN9SzR+TimXqaDf1275
         QtOQ==
X-Gm-Message-State: APjAAAVXo5XEpNerIDUHL5aqaxKo2hP5VE6DlIILPqLJjND5GHJLf1eV
        R0UtX9e54JjEpMUX9LO0aQ==
X-Google-Smtp-Source: APXvYqwV+P2KDc8CtB9VtadeSMw2dPxupLHtu2jRnsumBHTjh6d8J/zLIoII9iqRfrM9E79eDylpmg==
X-Received: by 2002:a05:6830:150:: with SMTP id j16mr3791728otp.301.1582904887823;
        Fri, 28 Feb 2020 07:48:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k201sm3273559oih.43.2020.02.28.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:48:07 -0800 (PST)
Received: (nullmailer pid 24254 invoked by uid 1000);
        Fri, 28 Feb 2020 15:48:06 -0000
Date:   Fri, 28 Feb 2020 09:48:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/9] ASoC: meson: gx-card: fix sound-dai dt schema
Message-ID: <20200228154806.GA19636@bogus>
References: <20200224145821.262873-1-jbrunet@baylibre.com>
 <20200224145821.262873-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224145821.262873-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:58:13PM +0100, Jerome Brunet wrote:
> There is a fair amount of warnings when running 'make dtbs_check' with
> amlogic,gx-sound-card.yaml.
> 
> Ex:
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:1: missing phandle tag in 0
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:2: missing phandle tag in 0
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0: [66, 0, 0] is too long
> 
> The reason is that the sound-dai phandle provided has cells, and in such
> case the schema should use 'phandle-array' instead of 'phandle', even if
> the property expects a single phandle.
> 
> Fixes: fd00366b8e41 ("ASoC: meson: gx: add sound card dt-binding documentation")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Hi Mark,
> 
>  The statement above is based on this LKML discussion I found:
>  https://lkml.org/lkml/2019/9/30/382
> 
>  To be honest, I don't really get why the consumer should know whether
>  the phandle will have cells or not. AFAIK, the consumer does not care
>  about this ...

Yeah, I think another type definition is needed here to distinguish 
between a single phandle+args and an array of phandle+args.

In any case,

Acked-by: Rob Herring <robh@kernel.org>

> 
>  .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
