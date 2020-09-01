Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A142065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598947356;
	bh=1ixyDmyvcaJ6E2SVwbMiNbYKv4p2xcy+KPlAYk9T7dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZVYJim9tXMRno/weuIpTJQrrvY/KldF6Q4UcLKo88wwDNnxNimSVyXIz5lVR3iJum
	 drvynmJka8kgbOLZupTq6mDLIfmET0Zb0TsdA3gh2haMAZioc2VRwefKuEI1fFggv4
	 SfUwmrTbrqEbKkPAtrOa+uaoX2C0Qap6OAtg6oDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIAICe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgIAIC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:02:28 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDCA20684;
        Tue,  1 Sep 2020 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598947347;
        bh=1ixyDmyvcaJ6E2SVwbMiNbYKv4p2xcy+KPlAYk9T7dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KDKCTEFr23hMRnHeyr8wpDArZR3TQEJxgkrqovKuVY0MIxr0eHB51K6LV+f6YFhNM
         nQ5GHqO+KaoJFWWRxdsc+Putqp1hN/PjqxAFKpMvqbOH6I8AebBFf/xkOI9mdfyMDJ
         BqYcRcCcYTYehYgNOPglgnPr/tjulxgACGDD53TA=
Received: by mail-ed1-f49.google.com with SMTP id n22so542451edt.4;
        Tue, 01 Sep 2020 01:02:27 -0700 (PDT)
X-Gm-Message-State: AOAM532j0AjpL5dZV1OhMWQhsiWn1yABOZiu+aUY16cbfzhC/iF+ut0g
        dPMMSyXIlHETaC17BzkkPao8fAPbDZNuivI+Wb8=
X-Google-Smtp-Source: ABdhPJxzRZwLG3+aqG4PWcon7WQdTeVl3OeiA0Um4gFj1J9eQYrlyjti7W1jAmtXx8V5+WIPwX7dMnM/rCr8rI37z/E=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr668084edb.143.1598947345919;
 Tue, 01 Sep 2020 01:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200901075417.22481-1-krzk@kernel.org>
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 1 Sep 2020 10:02:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPddQNCnLWoFx__VWnhGWA4B3DGXGDe=muh0r5r0Z61dgQ@mail.gmail.com>
Message-ID: <CAJKOXPddQNCnLWoFx__VWnhGWA4B3DGXGDe=muh0r5r0Z61dgQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] ARM: dts: exynos: dtschema cleanups for Exynos5
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 09:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> This is continuation of my series of dtschema cleanup for Exynos SoCs.
>
> The previous series are here:
> https://lore.kernel.org/linux-samsung-soc/20200830135200.24304-1-krzk@kernel.org/T/#t

Except the first one, other links are wrong. Here are correct:
https://lore.kernel.org/linux-samsung-soc/20200829142948.32365-1-krzk@kernel.org/T/#t
https://lore.kernel.org/linux-samsung-soc/ec9deeb1-8599-d755-cbfa-5db9787368e1@samsung.com/T/#t
https://lore.kernel.org/linux-samsung-soc/20200829210652.GD796939@ravnborg.org/T/#t

Best regards,
Krzysztof
