Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEFAC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54412073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m8aseD4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2Lo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2Lo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:44:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC275C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:44:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so2111242wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ycL/xol5LXc1oCnHf2lKepLV8YI7R5oU0gAskKNmHEg=;
        b=m8aseD4BGSL2eeyIyCCtWjiVzInZjA9AOhfIWWHODJqtsZn3u8IiZm78LhL6xbNLXZ
         egBMXWzyS5tpOXxLihcfxqD+Lb2ikPScf8qTirnKlsO3Iw4So/70aOvCDL9XG3pDLZTD
         MFyA6G+W+2lloNKnkwXdiIl78GUA8HPcqZgVV6JmrVySRDyfhw/Oe1KUPW2mVSo671o2
         l6HNwZkudieQaqswTiPD0p3wq/2WHsKUqLgcnLjh5W7gLr1QAfVXaBUGD/iSvK7doL33
         o3T/OEEmwDHnVzQKZod20K0v7oHIk64Ihl2XPtOQ7zkmzeHlpneKKQu2dNVhRie6qCsd
         0rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ycL/xol5LXc1oCnHf2lKepLV8YI7R5oU0gAskKNmHEg=;
        b=kt/C4I8gzwGdqbOmbTfyIHtr6ZxsybhqwH4bFJJLxoXjF1uMnH7WJW+qI2nngUC16x
         0rRxashMQkDfW0G2s5mbBcxuvq+LJp8UAJ+qE387YvAukHIM8rPYfLX/+1s9XxJQVYX3
         5U3XzX4zjhhsqlwOwvipTiXgX69LPLy0xpPuVIeOPIkd6BBVcEQ2NzldAFdqxOe86Kdy
         OaS/yHX45BzleBFdx8g1jvlLsqGHoww4IUhL2deV65j9cYx7F+PicRIkU9fl6XzW2fKo
         xwFfoMHa+E8Ur8k7MrHxp/WVRiSvGzU9L4XKpo5VoPfqlItRGVZQbL1PceqQToUD9LHs
         m18w==
X-Gm-Message-State: AGi0PuYyuI2BRGmQ87oryOA9tId4psQJizzHAw0Hs5h2hHmsWbm+6/Zz
        Zqwl/z6gWm+oPa6MLYC/ofb4nQ==
X-Google-Smtp-Source: APiQypJh67PJZJCKLabOQpyBwAm1TEQoQ/CjhAvqt2E5lBGcLL5HQluaH1NaN2U1R8Ksxp+nn0C5Xg==
X-Received: by 2002:adf:f1c5:: with SMTP id z5mr38733111wro.100.1588160693203;
        Wed, 29 Apr 2020 04:44:53 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id z8sm28289847wrr.40.2020.04.29.04.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:44:52 -0700 (PDT)
References: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] clk: meson8b: updates for video clocks / resets
In-reply-to: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
Date:   Wed, 29 Apr 2020 13:44:51 +0200
Message-ID: <1jr1w6iki4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 17 Apr 2020 at 20:41, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This is the first batch of fixes and updates for the Meson8/8b/8m2
> clock controller driver.
>
> The first patch fixes the video clock hierarchy. Special thanks to
> Neil for providing a lot of details about the video clock tree!
>
> The second and third came up while testing video output on my EC-100
> (Endless Mini). This board is special because u-boot does not enable
> the video outputs like most other u-boot versions do. However, this
> is very useful for development because it shows (the hard way ;))
> where the existing code is buggy.
>
> The last patch is a small improvement for the VPU clock so we
> utilize the glitch-free mux (on SoCs which support it) and avoid
> problems by changing the "live" clock tree at runtime (with the mali
> clock this resulted in system hangs/freezes).
>
> In my opinion all of these patches - including the fixes - can go to
> "next" because the relevant clock trees are still read-only.
>
>
> Changes since v1 at [0]:
> - updated the description in patch #1 to clarify that (it seems that)
>   there is no fixed pre-multiplier for the HDMI PLL (like on GXL for
>   example). Spotted by Jerome - thanks!
> - simplified the logic for the active_low resets in patch #2 by
>   shortening the if ... else. Thanks to Jerome for the suggestion.
>
>
> [0] https://patchwork.kernel.org/cover/11489079/
>
>
> Martin Blumenstingl (4):
>   clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
>   clk: meson: meson8b: Fix the polarity of the RESET_N lines
>   clk: meson: meson8b: Fix the vclk_div{1,2,4,6,12}_en gate bits
>   clk: meson: meson8b: Make the CCF use the glitch-free VPU mux

Applied, Thx

>
>  drivers/clk/meson/meson8b.c | 105 +++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 32 deletions(-)

