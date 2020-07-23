Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A000C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40782065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCKk9hOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgGWKKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:10:50 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA85C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 03:10:49 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g4so1614120uaq.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yoJQz6lc93ZFuC1vSh5aTw5SRyF7ZD50XPwFhu/krQ=;
        b=XCKk9hOqO0p5OWBU7kP/quBONyMD7A9N/NDx4dZesyLHCwi2Ujzv1+piwUlOI64CyA
         NCUIU6xdnEDK0mKCCEPOLd7ehUPoq1Q0e2udZf/ZTrXxNOL0BQj5UnmvhPom8yiANGaV
         kAMRAdu4YzM9tt1D2WRPKTpGCbjNTwTWEdLkok9I2O2mk/Ytx30jI1Y+UwQNEaIxcAJM
         AZzWRLvS0J/nTOQc2co0+wkWhXLzjWZZ+NpgbgVZGFqcnbBpIecpenwYZMfmLjt7FSdP
         c8h3VGbqmmoWIL54h1rS/XqozcfJljW7oM6ODqpZ90nsm16tGf6C9t/912+nio0BWIBH
         PA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yoJQz6lc93ZFuC1vSh5aTw5SRyF7ZD50XPwFhu/krQ=;
        b=MRjIZV1y9jN7EBZU8MhqMjW+9a4I64w8xehhleodU4B0jRVY18mItPUQm1X8VhBg0I
         iapuC6bSx3l9Ol3msFi77cRQtvxUOFPT2onQcxDBaeC0iSG3DX9zkm2ZMOHM+em7eOU3
         lK9KYUj89FEeIEQsx4gESAwE5Lsf8b1I8ZKBqzT0bsZ7DRn310L4NhPxmF9jIqrtlF1J
         DFFLu0AILgOwqjLKagv0EuVc32cTdGCd6HTJ7KlF0dwkdyVBZhIUvEvnKrB+qItGETtX
         1uoWfBun0DKhmlVduy4fpdIcWsYSz2yJCU9MAaoTA87WsYATD/LJlyTy3MCQHt14gaMr
         Wzyg==
X-Gm-Message-State: AOAM532LhUrjZDr1hG9lNJkyh81z0uwo4IeXdXuHe5iCeQYry9n74C10
        DT4T37+YbtA0FgPvzqtWL4GOKbDrdmjl6weUSwSr0w==
X-Google-Smtp-Source: ABdhPJxxlPWeM9mTT10PFLdHevZKA9RcowuhyqKZiYf5pxjOTON0R9TbU9qezUZcD9P6HDAOYt8ORXwcxVMOt6xhnjU=
X-Received: by 2002:a9f:236c:: with SMTP id 99mr3553006uae.14.1595499048751;
 Thu, 23 Jul 2020 03:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvGXOcsF=70FVwOxqVYOeGTUuzhUzh5od1cKV1hshsW_g@mail.gmail.com>
 <CAK8P3a1ReCDR8REM7AWMisiEJ_D45pC8dXaoYFFVG3aZj91e7Q@mail.gmail.com> <159549159798.3847286.18202724980881020289@swboyd.mtv.corp.google.com>
In-Reply-To: <159549159798.3847286.18202724980881020289@swboyd.mtv.corp.google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Jul 2020 15:40:37 +0530
Message-ID: <CA+G9fYte5U-D7fqps2qJga_LSuGrb6t9Y1rOvPCPzz46BwchyA@mail.gmail.com>
Subject: Re: stable-rc 4.14: arm64: Internal error: Oops: clk_reparent
 __clk_set_parent_before on db410c
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux- stable <stable@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 at 13:36, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Arnd Bergmann (2020-07-21 02:51:32)
> >                         __clk_set_parent_before(orphan, parent);
> >
> > None of the above have changed in stable kernels.
> >
> > > [    5.633668]  pll_28nm_register+0xa4/0x340 [msm]
> > > [    5.637492]  msm_dsi_pll_28nm_init+0xc8/0x1d8 [msm]
> > > [    5.642007]  msm_dsi_pll_init+0x34/0xe0 [msm]
> > > [    5.646870]  dsi_phy_driver_probe+0x1cc/0x310 [msm]
> >
> > The only changes to the dsi driver in v4.14-stable were:
> >
> > 89e30bb46074 drm/msm/dsi: save pll state before dsi host is powered off
> > 892afde0f4a1 drm: msm: Fix return type of dsi_mgr_connector_mode_valid for kCFI
> > 35ff594b0da2 drm/msm/dsi: Implement reset correctly
> > 5151a0c8d730 drm/msm/dsi: use correct enum in dsi_get_cmd_fmt
> > e6bc3a4b0c23 clk: divider: fix incorrect usage of container_of
> >
> > None of these look suspicious to me.
> >
>
> It sounds like maybe you need this patch?
>
> bdcf1dc25324 ("clk: Evict unregistered clks from parent caches")

Cherry-pick did not work on stable-rc 4.14
this patch might need backporting.
I am not sure.

>
> or
>
> 4368a1539c6b ("drm/msm: Depopulate platform on probe failure")

This commit already is in stable-rc 4.14 branch.
    drm/msm: Depopulate platform on probe failure

    [ Upstream commit 4368a1539c6b41ac3cddc06f5a5117952998804c ]

> I vaguelly recall that the display driver wasn't removing clks becaues
> it wasn't removing devices when probe defer happened and then we had
> dangling clks in the parent cache confusing things.

Thanks for your email.

- Naresh
