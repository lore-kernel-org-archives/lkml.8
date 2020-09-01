Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F418C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A30A206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598955102;
	bh=grH8FnFlGwBGFET0uwnxhIcVCo9NOWmmAKpSLVO8aig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L/xufTk4TdpgBHKz6kFtS0MkwHq1kz4huv/jOce/+HYIZorgxx8uovr6TY/nHra+k
	 rsYBJPIqhefmJPM+u4IqCMSJa0Qa7hYkShGkf1EkbwdmoZLFEu2EZbUfMBt7t1fdhu
	 xETbeTk9Ze2fusuf+jxEYWAU9Qyie6l4oBQ1ZKmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIAKLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:11:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIAKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:11:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5so847403wrp.8;
        Tue, 01 Sep 2020 03:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1v6htJY2C4gvkXRIZ2JmwZNQ3YQ4RL1hEFI5vq7g+8=;
        b=dEZeZT/nWYjn0/fiIZO4ojT6txon3VqrXS0H+yVB8QcRDjPlAdu96qVe0J1xepAYM/
         xRz8P22CLd4/QNqmMjjvBKK34waQnmn7Z9qasb44MR0JygBpk+ZEbOSosNlFYhCT5g7n
         lIyOu0SuocdCZT1PVteW5f/kyo7T6TSTMvUbMWCnv01ImrdKeSuCdfj7dbtmsnrE9NW3
         lgs9b1FaCecNjy2QSfdr9J7jPrALJZmbbPvOTCVQ2ZLhX/phZXti4UHyy+eqanIWEm7m
         11n1q3J4mTzkmIBlt2/hZt0ZFz+/7Ae+SRmwSgzTtTfyNtdMjlhGA0B9KWMWuwJ2y6nS
         prXw==
X-Gm-Message-State: AOAM530Xv2FTiV+P9Q5jdmTVZTReCbcaihord+8TyWqbIszWEM4tnv2w
        dIBDqlOd95yuQ9dTTHSNyiM3vyO2SiY=
X-Google-Smtp-Source: ABdhPJxg01k871o5GFupOXE7beNlZjBYGb1IghFWAqOoAnPRnvevcgE/10DHc6ya9jyFK9jTfOM1ag==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr1037991wrp.265.1598955064678;
        Tue, 01 Sep 2020 03:11:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id p16sm1468478wro.71.2020.09.01.03.11.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 03:11:04 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:11:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, David Airlie <airlied@linux.ie>,
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
        alsa-devel@alsa-project.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 01/10] dt-bindings: arm: samsung: pmu: Use
 unevaluatedProperties
Message-ID: <20200901101101.GB23793@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 04:24:52PM +0200, Krzysztof Kozlowski wrote:
> Additional properties actually might appear (e.g. assigned-clocks) so
> use unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: system-controller@105c0000:
>     'assigned-clock-parents', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Rob,

Could you pick all of my dt-bindings schema patches if they are ok? From
this and other series. You already have few of them in your tree so it
will help to avoid conflicts.

I am afraid that subsystem maintainers can leave them to you and vice
versa :)

Best regards,
Krzysztof

