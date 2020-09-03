Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB14C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8204C20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151528;
	bh=+RN+tred1kejqXIdlddVwHGuj/QRKXoNuX9WzHzJ6+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7jF/LniL992RSNILFO4wbO4b3TXcnO5pBnuLAJNm+C88zjxpNIY83h4MarRXDXiY
	 /KASMLZFn/dF3lgPa0p5J5OgsWb0Rmoj0PfPOomK3SQRtyxKwqjcTYewOZAN91E0YO
	 FK0CQH03apjaswyzSIKpNJTJ43SjkPn3toxhIdFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgICQp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:45:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41535 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgICQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:45:21 -0400
Received: by mail-io1-f67.google.com with SMTP id m23so3623844iol.8;
        Thu, 03 Sep 2020 09:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZP59A809vUXPKAmKCl/+/Toy2Yc+dTL7EkzSdpcrdXA=;
        b=JmQlumHyxHCdAITw1RXbti28uuoFttAt5onCUNYTJ8YD/cnK4ULSN7IKJ/KNM0TfY/
         xf8+ehMIXIO73R+p3/+bIR/oNNe0h7GhSn2y85IrCtOnM9UwgfOGFDjv2BVf5/Ios1pr
         3fdFMDD4atn9JSQmVq+qK7laFFd59KN0J6xnreG2rlNo+0qRrEV2k9y/qtk2CfKN73zp
         EOZByji7QFVS4Ii0EF7O8D1yZBZyAJkE+o5b9xEjtK6BwCx1hXQrsCgEiGs4q033+sFN
         HpW/2o8SXqKzkQ8h/gE1zSkQb7HoZdNGkV9fbkQF5v7KJEZgQETK1jl/eFDZjILRJ1Eb
         1spQ==
X-Gm-Message-State: AOAM5331RsOfPYi4hRWHmTSg+ya+y60vWdLHLzo7Cfor+cRdvRFV+QCr
        070PY+2hQm8PVnKkkqgUjA==
X-Google-Smtp-Source: ABdhPJz3QtFdJj9xf68T2MjYHLUlRhw4wqkk0yrCjfmHkP7HHKrqIxRy5KYmadUP48rBi4sy6gDkig==
X-Received: by 2002:a05:6638:d4f:: with SMTP id d15mr4016623jak.119.1599151518184;
        Thu, 03 Sep 2020 09:45:18 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p78sm1582218iod.0.2020.09.03.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:45:17 -0700 (PDT)
Received: (nullmailer pid 2928036 invoked by uid 1000);
        Thu, 03 Sep 2020 16:45:13 -0000
Date:   Thu, 3 Sep 2020 10:45:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: arm: samsung: pmu: Use
 unevaluatedProperties
Message-ID: <20200903164513.GB2925151@bogus>
References: <20200829142501.31478-1-krzk@kernel.org>
 <159897179515.47719.9922715760129781914.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159897179515.47719.9922715760129781914.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:50:00PM +0100, Mark Brown wrote:
> On Sat, 29 Aug 2020 16:24:52 +0200, Krzysztof Kozlowski wrote:
> > Additional properties actually might appear (e.g. assigned-clocks) so
> > use unevaluatedProperties to fix dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: system-controller@105c0000:
> >     'assigned-clock-parents', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: samsung-i2s: Use unevaluatedProperties
>       commit: 8187d8300251a99e40e288be80bef6a15b7b22e4

Please revert or drop. All these 'unevaluatedProperties' changes are 
wrong.

Rob
