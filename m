Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F4C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2609A2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598949769;
	bh=BapteVP8tE+4r4nW5BxhF7ZHdNQsLqYAF+RC1XokMIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uw9ngWNiiMy9jzHBWOdRWKGiVrqIgKRhGYC2BHix/Fv1vQdPcbPy1aW/W45vKhyLo
	 W/Q1Y0QgknMjCdR1yUWWMAJ4GtsSYSa5MQgx8RIEHuvWJvrLIxJsOJ+cFOzVktedkp
	 ZaZsOE98z8qTsFYoewfIHQ9CLMjSre5Ceti79ppQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgIAImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAImq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:42:46 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E448D2071B;
        Tue,  1 Sep 2020 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598949766;
        bh=BapteVP8tE+4r4nW5BxhF7ZHdNQsLqYAF+RC1XokMIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0nyRHeoqCNiiBFP6QF7Vu8TKPFCF/ZRSGmdVMD7HeLiHvOg67mL4E03ckk6IhSwRP
         VK5WjfXuB9wd54tvydBoGx0/97L3E7PBtfpJBq9Rxcxenq5GnOcPQxW+iV0GLJM31g
         epLZ5NQBJVu/9MBBTz3pSKRcShnXIM0d5WVcXcWo=
Received: by mail-ed1-f44.google.com with SMTP id w14so649973eds.0;
        Tue, 01 Sep 2020 01:42:45 -0700 (PDT)
X-Gm-Message-State: AOAM532farUAxaZ5Xyv3QkwmdXlmy+ePshAljLuScQk2PveWz9yaMMMb
        XKzJM8bV2wbNl/1KtYZZLU9/qPoyTkEo1FKikCw=
X-Google-Smtp-Source: ABdhPJyBJ2bEFjwMxy7tdkMWyLN4O9t/L+1SErRbMO8hnZ3DI56BaUruK44RZr/8zIeyeWpaxM3wT0lH/YX9S/NSYp4=
X-Received: by 2002:a50:fd0b:: with SMTP id i11mr785806eds.298.1598949764527;
 Tue, 01 Sep 2020 01:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200901075417.22481-1-krzk@kernel.org> <CGME20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196@eucas1p2.samsung.com>
 <20200901075417.22481-12-krzk@kernel.org> <800d8fa8-7fd4-6221-f8be-ef422e5642d9@samsung.com>
 <CAJKOXPd+Mr0c7ype1KTseBc2=qx0NNKKj5Ku0w0HBOgjEsGvKg@mail.gmail.com>
 <CAJKOXPfKnzsRA3D8b3z=iG4oD6P+M7Q7YMVbrOAmLTiNgZ5mXA@mail.gmail.com> <4836dc12-df88-5936-c208-8f6ff2a6bdc1@samsung.com>
In-Reply-To: <4836dc12-df88-5936-c208-8f6ff2a6bdc1@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 1 Sep 2020 10:42:33 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf9rFVbMnEYURw-QTzJPvVu56BBoThsWq=teHggrRDAGw@mail.gmail.com>
Message-ID: <CAJKOXPf9rFVbMnEYURw-QTzJPvVu56BBoThsWq=teHggrRDAGw@mail.gmail.com>
Subject: Re: [PATCH 11/13] ARM: dts: exynos: Silence SATA PHY warning in
 Exynos5250 Arndale
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 10:36, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> >>> I'm not against the rename, but frankly, the above node and all i2c
> >>> parameters should be moved to exynos5250.dtsi. This is a SoC internal
> >>> things (the same way as hdmiphy in exynos4.dtsi), so the board dts
> >>> should only contain information like status = "enabled" for i2c_8 and
> >>> hdmi_i2c_phy nodes. No need to duplicate it here and in smdk5250.dts.
> >> Good point, the I2C bus used here is an internal part of SoC.
> >>
> >> I will squash these two changes into a new one. Thanks for the review!
> > While at it, I wonder about the samsung,i2c-slave-addr property. Is it
> > really needed? Are there multiple masters on this bus?
>
> This might be some cargo-cult, probably copied from HDMI DDC (I'm not
> sure if it is needed there). I've removed it and SATA still works fine
> on Exynos5250 Arndale board.

Cool, thanks!

Best regards,
Krzysztof
