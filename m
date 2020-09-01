Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B4DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ADB206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598955346;
	bh=ZyI1/1iVuAKLzGnD5bs9lY6pUeVXwQkjOXtoFbjELNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jq9nuX5TR986mq3bU1g7AdPSEqDvfUXnQMemPbFQDW1yMjh9CeGLdHQGi0rpy6lCX
	 ZmsWJ9cijHyF2BCtj7FRexuVSXyst4dnV07TcJNxZuP9LiDjjmmTs9pfDDmxDCrAIy
	 b14DjA/aJTnirS4Oys4JlbZ2i3dit15NSgeXTpEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIAKPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:15:44 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:32779 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:15:39 -0400
Received: by mail-wm1-f52.google.com with SMTP id e11so632757wme.0;
        Tue, 01 Sep 2020 03:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pLH5AgoXpGhrsa52Snk5FTxJg17QsSXpFgLhDFft8A8=;
        b=G01X2LHl3AlbnjCNvRLWMX3PQNiJBXhWRXcQaOP7glOvAyb8vkmW0mHjHc0R/B939p
         OreH6NEQq0I6sZdEgBW6BLOgSlmgMWRzM8z8kkEfFiQOaZ9d5qDOcgImkdrqIkdG4jH/
         yEA2VsCoVhk8fozR04PETgH3CPsqyGTrYwAZwwqqEd5sXrgGaKi6rmO7woS9UiE3JKDV
         VTvsbLEDaRiG8XP6KehuzSzJeHTGzpy2nCIndqW2hofSl+TTxpiOkoM4pKbvWFiZS0Ro
         ptxLsadaLH1OUvz+AmZRLceK6HjKzf0gYzLZNvtnnEAHLKYZ5c7v4y5AqgMW12FCnJe6
         2WFg==
X-Gm-Message-State: AOAM530sSQjIsefrb24b9NexFDS2MxoJ7WnDvwqNopT1UmfG0cwmLgKx
        +fmo7xT9A7SCrObq6LvBs2E=
X-Google-Smtp-Source: ABdhPJwg2dcdM6+5RfvAb5uRSTytSw6wmKRiuo8vRcUAavtF9U7ySqhFZpn0KffXgkNU3dhursmPFw==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr1030648wmh.23.1598955337291;
        Tue, 01 Sep 2020 03:15:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id e18sm1792617wra.36.2020.09.01.03.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 03:15:36 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:15:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [RFT 2/4] ARM: dts: exynos: Move fixed clocks under root node in
 Exynos3250
Message-ID: <20200901101534.GE23793@kozik-lap>
References: <20200829172532.29358-1-krzk@kernel.org>
 <20200829172532.29358-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829172532.29358-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:25:30PM +0200, Krzysztof Kozlowski wrote:
> The fixed clocks are kept under dedicated node fixed-rate-clocks, thus a
> fake "reg" was added.  This is not correct with dtschema as fixed-clock
> binding does not have a "reg" property:
> 
>   arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 42 +++++++++++++------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)

Applied.

Best regards,
Krzysztof

