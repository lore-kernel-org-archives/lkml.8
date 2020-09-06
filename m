Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F6C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 13:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960BD20796
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599397908;
	bh=RwvoKmkqXFzSWzO8EuJyeGXXoNMCcZe3Wdf5nzC6Sng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xZK0bmzr/6a1q5pyjeRn6WCfaXRig0/EJLVkIe0UTYACw9yxhcQdrGY8cNWNekbX3
	 6SkGfQB3LNAeyp7IHfzK7DwFnoX61EonO0VT6oWj6TyOWFdh215ktSByPLANmcYVoO
	 QPfUutFjkmIGF/gLiMeTFCqoh3iWwF6L5RKqNF7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgIFNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 09:11:34 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34575 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 09:11:01 -0400
Received: by mail-ej1-f68.google.com with SMTP id gr14so13261336ejb.1;
        Sun, 06 Sep 2020 06:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBl9UMlY1oWNy/GCwLn7tQTZrUz9EDW9e61eAlkzz9s=;
        b=Mc6KJ8gYmLC8mUFWbxctHqS43aZlTIIAFCrWMyyslT1vrs2z+L6JyRywj7y/XpZGvj
         t4W5ZStfOtXLFbFo7qvUrpMR9haOD3oSp+xSQnQBhT7pBcwoASs9i2jDoNfb8m2RywVt
         PqUOnp3/UAr3cd6TXsl/aH3jpYSJ+K0xWF5vApv2g18TwUvdvTSi2TcPPi88VUBdvXxs
         tdhZO00A88ZnpwviYTh0AktDkFnwh6v92w0kaNvCnkpsJXC4HMQyJHAOJ0vLtezjA8rj
         kTltBXrKxCaVVOLa/xNWpkC0Oes8EzhnRVbUgF1xjfnuuznqRWbNy/H7wH0tFMlbJ8tH
         Orrw==
X-Gm-Message-State: AOAM5303ROZVkZKH9WazRR6pIhke3VWh1plcA19/Jz3ziDDBHTHh6zf4
        ixsoBp9n3l/3xSm8YumiFkfIzMGOxIs=
X-Google-Smtp-Source: ABdhPJwZpwu8aMycqUKtCNZy10jlArz9SO9TZiCFOz4zSvKdisadZYItdzaDjgXG8etlrzDUL+bNmg==
X-Received: by 2002:a17:906:d9da:: with SMTP id qk26mr16261105ejb.435.1599397859698;
        Sun, 06 Sep 2020 06:10:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id v18sm11710019edb.26.2020.09.06.06.10.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Sep 2020 06:10:58 -0700 (PDT)
Date:   Sun, 6 Sep 2020 15:10:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos: Remove I2C9
 samsung,i2c-slave-addr from Exynos5250 boards
Message-ID: <20200906131056.GA12691@kozik-lap>
References: <20200902155733.20271-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902155733.20271-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:57:32PM +0200, Krzysztof Kozlowski wrote:
> The property samsung,i2c-slave-addr in I2C9 controller on Exynos5250
> Arndale and SMDK5250 boards, is not actually needed.  There is only one
> master on this bus.  It's not clear why this property was added at first
> place.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch, Marek already tested the removal so I am adding his tag.
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts  | 1 -

Applied both.

Best regards,
Krzysztof

