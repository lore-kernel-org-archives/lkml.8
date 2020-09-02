Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2613C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9572520773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599062798;
	bh=FjNqcIHsh7BzHOMd1Jic3POpDVsD+qe7+fq8mnsJI50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e4Wxe0h/QSVeZnKLbdMIt4HtYycMe5tORv2D89aweAEDXlz3kgO/ZiFSMYhmuIA+a
	 yErN4f/GZqV9f7YHZ/W8fG4+1qKI1D7noropkDR/vJO1Gq4kSEhVaaUiuHpUx0rivw
	 CA/VfdyaymH5YkvZvuXsiisEbI2dWRzW0iw7j6po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgIBQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:06:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39537 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgIBQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:06:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id c10so5465089edk.6;
        Wed, 02 Sep 2020 09:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/k/jl8kCbC36+2FeLOHphrZjREiZCdM+WriURHXorE=;
        b=tslD+Vj+VwfqxW/voVbBn65F0Utb4fM3Kj4pnMb9z0F6/Q+Ryy5Xu0TSaXKJ1lQntY
         JoFOj2phZYMbhzE48Y1LKge1S2x4seCBVKYIWUVjKQpRnOJs2/FgjDVy3hTBgZEAr97y
         BwtX5rtB7x+k0HQEzPwRWXkRL6bG3gnTnG5IYjfs4wARLwckRyf6jVZZsIc6v1ixK7jR
         6f9TTW1IoYn9O/c2xdw6M/b0BWYUcGjiX8dkOb7xwCqZLQomjhSTQZOjD6fkBVx/0Xob
         LMOq5CuJKymfKos9h4Q5tosCgrUDogQJLOctFsdZnhoZmh+dp87v6OD0v1/BvNObe5S8
         fWPg==
X-Gm-Message-State: AOAM532XvBwUyNq65zpZv2PAqRkvvLZnF+mcawUuT8ssjlow96478v8V
        uNaK+uka8X8nlBe/nBQyU10=
X-Google-Smtp-Source: ABdhPJwJuyNgxyGPCkUCKgxVeWeN3ahgf+XnMGbzf/ZL2QQEUetIvvJw1gbkJlFGZoRrBdx+Cq2i1g==
X-Received: by 2002:a50:d7d0:: with SMTP id m16mr772218edj.105.1599062772890;
        Wed, 02 Sep 2020 09:06:12 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id z5sm4657068ejm.111.2020.09.02.09.06.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 09:06:12 -0700 (PDT)
Date:   Wed, 2 Sep 2020 18:06:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 04/10] dt-bindings: mfd: syscon: Document Samsung Exynos
 compatibles
Message-ID: <20200902160609.GA21555@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
 <20200829142501.31478-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 04:24:55PM +0200, Krzysztof Kozlowski wrote:
> Samsung Exynos SoCs use syscon for system registers so document its
> compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

As pointed by Sylwester, I will send a follow up to remove other YAML
file. This patch could be dropped.

Best regards,
Krzysztof

