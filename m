Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF3E207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598861957;
	bh=gs2KV8fmJRAS8fO2XzodFn9j02lDZ/NLqHlPjxAm9ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o5H9qWNJ0lwDmby0zACsadYAhnjJQ/9De5hWmH6yISUxbX8xqn8YNMXZMH7I4AC01
	 Y/mXASrQVcEEzank8v9RqQlOgAnkUO+U+OOI/pN/ogsqRaCY4ZaxEfyrhVcRjLr+Ot
	 wXR/0YdQtgdZ3WbFsbLiulorFdSFUklTehGOuouI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgHaITO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:19:14 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:36354 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:19:12 -0400
Received: by mail-ej1-f67.google.com with SMTP id e23so1809440eja.3;
        Mon, 31 Aug 2020 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cqrk1bBlfTS3BPtOTE3s4vilkxanbVUMadQ6BMq95XQ=;
        b=bzfjvLzlIiONuVg+R5UoCfdMYf9OiP7YcOcxvQlm3fcekQW3fKxUOqM8RCDlYU0Wd+
         yh6KoMlP2nrC+ls91gJpErP/8WfOhsgb9s3OQmdSc7QifcsTnQXrb9CPQFtIFRA46ZEW
         oGKA+1iUzobLAXea03dxDusmAOB8fVGapMy5sHWFSqRBjfgJh5ioFgCslrFroJqRnp7l
         scWh1eno+dHW8jF6A0vY2y36aVKEuyDl14XVSBViwOixX1RqStCBixg9+1xipYSwa37x
         P4yawGK3GPN/sNk36tQvs11odOrXq43QartPuxhB5WnIo2A6dGSdTinRwcSEukvGAtQm
         v7Gg==
X-Gm-Message-State: AOAM532R7UcVkPYHmjUW7qGhLbSTkROi6pqLazmLR9xntFmzBJptwGGH
        jBUvNflbpzbEzdsFL+vgU+I=
X-Google-Smtp-Source: ABdhPJwZmYA5QBVdQf3hNtCbKsFlHcp5sGv8ZbmLIZ97Vr6lwstZRZcAMaFR7D7zA37ZpKOOmXJ5ug==
X-Received: by 2002:a17:906:180b:: with SMTP id v11mr47877eje.427.1598861949932;
        Mon, 31 Aug 2020 01:19:09 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id d2sm7482261ejm.19.2020.08.31.01.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 01:19:09 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:19:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [RFT 3/4] ARM: dts: exynos: Move CMU assigned ISP clocks to
 buses in Exynos3250
Message-ID: <20200831081906.GA11513@kozik-lap>
References: <20200829172532.29358-1-krzk@kernel.org>
 <CGME20200829172553eucas1p1b62ad1cac6e0eea1dbb4669f09949419@eucas1p1.samsung.com>
 <20200829172532.29358-3-krzk@kernel.org>
 <6ed67a82-0f29-7384-203d-dcb2e58c5a8d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ed67a82-0f29-7384-203d-dcb2e58c5a8d@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:11:02AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 29.08.2020 19:25, Krzysztof Kozlowski wrote:
> > Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
> > for exynos3250") added assigned clocks under Clock Management Unit to
> > fix hangs when accessing ISP registers.
> >
> > This is not the place for it as CMU does not have a required "clocks"
> > property:
> >
> >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Not tested and I wonder whether actually correct. For example, what will
> > happen if devfreq (exynos-bus) is not built in?
> >
> > Could someone verify it?
> 
> Sorry, but this patch is not correct. Those clocks has noting with 
> bus-freq. The assigned clocks property should stay where it is. Maybe 
> one need to fix the schemas for dts verification. Those clocks has to be 
> set (and so generic clock framework does) according to the assigned 
> clocks properties once the clock controller is instantiated.
> 
> The only alternative would be to add exynos-subcmu variant to properly 
> link CMU with the ISP power domain, but assuming that there is no Exynos 
> 3250 ISP driver in mainline (and probably never will be), it is safe to 
> keep those clocks sourced from 24MHz crystal.

Thanks for the clarification.  Another solution to silence the warning
could be to add a "clocks" property for FIN_PLL, although the driver
actually does not take it.

This is the only remaining dtschema check warning on Exynos3250 so it
would be nice to at least silence it. My goal is to have all them
schema-correct, or as close as possible (for Exynos4 the camera node is
a trouble).

Best regards,
Krzysztof

