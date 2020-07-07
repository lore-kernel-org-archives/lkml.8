Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F13C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B6120702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TO49Rncx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGGLN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:13:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15299C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:13:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t74so24508779lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DonQkpNAjPvHVAy79oehvm61+vwAXrm714g+O9PzNZA=;
        b=TO49RncxH1IHsqYy4SyeMCPtM239Wd3esWklEchNM7cIvvWU8d22p9X+tt275U1fRS
         QqEEj2tGMso79rUK8yQboBeqO7EOEDIn+AJP6k4nNnwlXsiYqtzfhbrl3kHQPTy/Yg2g
         BdKs03I3DUY1Wu9v63xIkJx6xZK9ao09gx1KMJokoYvlekJIDtjeHgr9dG6UIXla7Gsl
         1qM/+lnWDQRPxNzzSitTNYUDJyokjMxbg5R7oC9Hj0K2aB3oCYilUnuLygGZfB7853lR
         i75e5Pi0QsdbsXzNMqijd5nrzs3k0iaH4atcp+LQy3p3kkBZ8X+jUEYy/7jb9cAt16Ew
         BiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DonQkpNAjPvHVAy79oehvm61+vwAXrm714g+O9PzNZA=;
        b=eVMpm+jQgQtZP+xWknP4Qb1qzHrhPATuoB0OspsgG7q+jtJzhs2ZjJiLxF1DGQdHIA
         AdJcBJAlh+P5FGcYgyL1LZ4ULkVs2E8G3RU+vMME+ocsXiHLhRgPT0P3R5LYsXIlOo/5
         nL7w1Y32oRmU5ntQdZQKD9tn1iwhmYO8/9d3mjAsSJgsoYeEz8O6p2drceDsLTTLxmr+
         /MRRrV01qXdT3bAIFrq6WUjS97nIMV2SVtI99kFOdJdF6G9vmlZXslboWRxjv7EEjNAq
         5vEjkKmzCLJVSZ0CoL4t9mU5KCEMOn75Y0pO7uniHNzLq1LGpX4rY0PbeeEOV0Ds9GSr
         lpWw==
X-Gm-Message-State: AOAM530CeJlVYBDVVGK7Emj48dne4WYP7cmRkDy4f6EisN4EAaZzr3x6
        HT1oWikJCVgMJYDhH6sIMwY1gAeZ8HFcO4kP06MtuA==
X-Google-Smtp-Source: ABdhPJzwS5f0cvxfzHQbNMbpX81A+XQqU02t1sjlsXR6wKo7CCNC6u99RIC3QWt6g9P+mZRBN/2h2q03IPJWnOOnYNU=
X-Received: by 2002:a19:f20a:: with SMTP id q10mr33042436lfh.89.1594120404530;
 Tue, 07 Jul 2020 04:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200617180543.GA4186054@x1>
In-Reply-To: <20200617180543.GA4186054@x1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:13:13 +0200
Message-ID: <CACRpkdYN+N8cuFtgqeqk_L4QR0ZMUObYehEBTfnGGe1aR9srBA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: fix function name in documentation
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Jiri Kosina <trivial@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:05 PM Drew Fustini <drew@beagleboard.org> wrote:

> Use the correct the function name in the documentation for
> "pcs_parse_one_pinctrl_entry()".
>
> "smux_parse_one_pinctrl_entry()" appears to be an artifact from the
> development of a prior patch series ("simple pinmux driver") which
> transformed into pinctrl-single.
>
> Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v2:
> - add trivial@kernel.org
> - add Fixes: tag

Patch applied as non-critical fix (v5.9).

Yours,
Linus Walleij
