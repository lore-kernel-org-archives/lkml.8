Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E922B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255322;
	bh=/wCPO+RxEUg5GHn27K8TZ9uYjJZw8ve0uKFgWyr8HOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KovMsr9mpE69GN2ygaD3Fq8Bm/eZeI4XLSiCd/kFaRTNASirOszjWfi6WJdGVjSgI
	 tWSXtOVeKFWfB4/UIzKfQmA7EHy77vprlPukFyN/CqJsN9AhN4aXNNPkGoQbsURci5
	 vPBAadtwVezx8k/s5AXrsduj8nQ8Vczor4cVm78Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgGTO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:28:41 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36552 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:28:40 -0400
Received: by mail-ej1-f68.google.com with SMTP id n22so15338004ejy.3;
        Mon, 20 Jul 2020 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SeaqU5G031bHVDt4KFy7kS32MN6Q002FM98/cYMKeHc=;
        b=N8LvJGyAhjC++p8whF5GNolg5Lx6FEVJLlr+6SsRcv81URFXp/MehQO/ceFVRvx7fp
         JSG2gCZBDFSM5h8c7loIgkNnqeuQBy6ywj+gkhjPMiJH4NEiaijYB/tFThSV8cO7yZZZ
         kN2IxX/xnb3o4goSX10Cl+IsvPFGXvoMvHEbXTlXFxpIL65vio9qWw2BTaFkrcxBd5AA
         /tP6B53T/i4njRx15NkjOlUkcDgrtA2XRSHmzbNwgmDTbptkA+3ufy/N6Vw0kZpGb/oa
         H1oCM5CZdoEP0abfzFiOPXKyL2n+uAPkMAo1REeuIf31W173nszxyrYtLQTnVSXatp4v
         A1PA==
X-Gm-Message-State: AOAM531wjoP+KJjSqr6BUkK02DhpTTnTVyk6qfJoFa/rKUMH610RNbZa
        dcea0F3Bmhj/uVhjsefZwQ7dtqtXfSOscg==
X-Google-Smtp-Source: ABdhPJxsdhRBnuy3MvZuyuTFjx9Guq/jZKtozQr72PAipOGZFxeZN4k3KwT7WxjyWsASpngfAg77LQ==
X-Received: by 2002:a17:906:e215:: with SMTP id gf21mr20239169ejb.310.1595255319516;
        Mon, 20 Jul 2020 07:28:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.200])
        by smtp.googlemail.com with ESMTPSA id u5sm14725853ejz.15.2020.07.20.07.28.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 07:28:38 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:28:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 08/25] pinctrl: samsung: pinctrl-s3c64xx: Fix formatting
 issues
Message-ID: <20200720142836.GC6747@kozik-lap>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713144930.1034632-9-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:49:13PM +0100, Lee Jones wrote:
> Kerneldoc struct titles must be followed by whitespace else the
> checker gets confused.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c:212: warning: cannot understand function prototype: 'struct s3c64xx_eint0_domain_data '
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c | 6 +++---

Thanks, squashed with s3c24xx since these are similar issues and only
documentation is affected.

Best regards,
Krzysztof

