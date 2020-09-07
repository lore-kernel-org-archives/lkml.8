Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60502C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAC5207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1NqE+sdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgIGKGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgIGKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:06:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF04C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:06:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u6so3504385iow.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0OvTuxE+/iMswMQTjQb/bjlIs084TlMlRT8WNmVF+Y=;
        b=1NqE+sdR4ONCLnZ5XhFqnlHSfQVFov4iy/cT+yyxmAzy5+YCr/Ul9KigmS858zeHof
         veerpBJ8XhqPoT84DSedPKvLdYY3GqAGqRsEkjV+NU9bChBpBNA1NZNkxENzA7KPM1cJ
         YbNZSDGYeZOwNGjxpWRPNef161HXLK7nWTU8e4wLNPz62F/si1Y2ll6mGdGWppAmk1hR
         XDf6BujzOkpGItyYi/ysU1ESNG0WrA8+8+xAtGfGZlmB8cW9STc/iJZZuljVuRxIfSg+
         PhJx7H8iMDclSVWwaOTyu7KmLReNaaaD0MY9P/+s2Gt3YrLzIKH9AUN2tCQZJViElB9G
         Vc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0OvTuxE+/iMswMQTjQb/bjlIs084TlMlRT8WNmVF+Y=;
        b=bFCMmbyKSNxkZl2MMGQUd9tYYUMIDPrtlhjH07b04IPwJYA8MfIEi0j8qtGllFqcoJ
         dRkTGNkrlk0CfCpwzH7ZtRpMBoJD6PAMEuOJN+a09YJVVQjyeyUKtTz1YdwhL5vpE/4y
         W1FBG8PJUZ+RV1/ynWYiv5MvK4L04YC7hXmMJj0dZXqqn2Hy+s+5E3/V+Wbo4/tMlRS5
         fMIax3b7zdW9EhI7+4vWhGq9iLJFRks2uFFdVxtIjV5LIgvUSm1PWLdyyHQa2VhsHXHg
         v/Se6P+/8b6DRW2ALg3+kfvtQe8T/Ho8AaRpnEhchQ32of5L87pY+WZdPUKJxovRJcXh
         A4+g==
X-Gm-Message-State: AOAM531OLdJyhAgmxv/oHOBKc2bX1/T0GCeZn82EbxbNud4njzUSIigr
        TbttPb3ebNgfk9fpYpHTow4CiqVX1qEGGSjp+6vp4Q==
X-Google-Smtp-Source: ABdhPJw52QuX8XyBkW5w5YSCJbnGbo22v3h5joTjE50AnRXJMICHttb6i5OzXghJCZwUuJmPrBvIE2wQCbUxcbTWSzI=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr2869058ior.154.1599473174144;
 Mon, 07 Sep 2020 03:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200906151928.881209-1-fparent@baylibre.com> <20200906151928.881209-3-fparent@baylibre.com>
 <1599450232.27773.13.camel@mhfsdcap03>
In-Reply-To: <1599450232.27773.13.camel@mhfsdcap03>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Mon, 7 Sep 2020 12:06:03 +0200
Message-ID: <CAOwMV_wXM9Tt-NhKQ05juvj06reD70AXUNzqWTEMeAgqcmnO0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joro@8bytes.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        miles.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static const struct mtk_iommu_plat_data mt8167_data = {
> > +     .m4u_plat     = M4U_MT8167,
> > +     .flags        = HAS_4GB_MODE | RESET_AXI | HAS_LEGACY_IVRP_PADDR,
>
> The 4GB mode flow was improved at[1] which has just been applied.
>
> If you add 4gb_mode flag but don't have "mt8167-infracfg", the probe may
> be failed.

Looking back at the datasheet I don't think HAS_4GB_MODE should have
been enabled for MT8167 anyway. I just removed it and retested the
patch. I will fix it in v4. Thanks

> [1]
> https://lore.kernel.org/linux-iommu/20200904112117.GC16609@8bytes.org/T/#m613e9926735d07ad004fddbbcedaa50b5afacca1
