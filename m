Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B243BC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AEB207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598863148;
	bh=/mTBwH0H2XS7YSaOFVh9wZUjDwDeG33keE7ZBUOqWL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kbFyf1IfS0OTFYwQ6TiJmqcNsa+sSKNYpP48zHqTHuNnXwYRuHSwodVhVihaUb1Ek
	 wtxjjfu+3J9ZC9onZa12kUK6Ik9YcBYR6nEmzZHDiqVD6z8c71r0V4anoGS7TxcYX5
	 WiCTrLg2bUpVC3l25f46i7e1ODBB35oLVTPLefLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHaIjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgHaIjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:39:06 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E822137B;
        Mon, 31 Aug 2020 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598863145;
        bh=/mTBwH0H2XS7YSaOFVh9wZUjDwDeG33keE7ZBUOqWL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0DNDIqwVYE/LHMPUqsSOdHXnx3H56mMT3qGKhC9s3QEwOGKmmxQnu97kkJhw1RJaq
         2GHqCupyOkmXsanizUsBDchdhqQPHXVlqMjtCKuydcx0+o6XIFHrHSKhUpFtyvlrsx
         xWZNqcvQMZs05rusutSFTe7ho3t4z/XQZbUThdD4=
Received: by mail-ej1-f42.google.com with SMTP id b17so7346564ejq.8;
        Mon, 31 Aug 2020 01:39:05 -0700 (PDT)
X-Gm-Message-State: AOAM532BFfH7Zek1BT1BKrmCo5g3F6qew6CzevyUkF9QOcPVoFh7gDpm
        FBb6jEWOnAmO0x70xHbVDP4LDVsuaksKehvnhhY=
X-Google-Smtp-Source: ABdhPJyowpEQH5t1dzDoER28m99xK7ss6Z0pLGH7Bkoqwr+INsBLkRiqyVs2tsVykl3vYYCRQYzfp7ZyLf/kAhBS5HA=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr111095ejx.215.1598863144013;
 Mon, 31 Aug 2020 01:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200830135200.24304-1-krzk@kernel.org> <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
 <20200830135200.24304-23-krzk@kernel.org> <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
In-Reply-To: <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Aug 2020 10:38:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
Message-ID: <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 10:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> > The camera's pinctrl configuration is simply empty and not effective.
> > Remove it to fix dtbs_check warning:
> >
> >    arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> I think that this was intentional to properly enable support for
> mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the
> default values if no pinctrl properties are provided. Sylwester, could
> you comment?

Indeed it could be intentional... I see now errors:
[   33.752203] s5p-fimc-md soc:camera: Failed to get pinctrl: -19

I wonder why getting an empty pinctrl is needed... maybe the driver
should accept missing pinctrl?

Best regards,
Krzysztof
