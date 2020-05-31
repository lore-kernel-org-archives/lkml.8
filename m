Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6ADC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B6F20723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yoeFpNJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgEaTbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:31:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C5C03E969
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:31:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so9318674wrn.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7gaS/RyXysP8XSZO8VW4EjVKZZX26nytji80U6hsMY=;
        b=yoeFpNJ+AseffVizMDPduAqqWvYGR7BQmrl+MDzHjoDY9K2v+cLFgirieqtS0PqQ3a
         +VTIvLQAs/SVxvOr/kdurO4JmFDfV8609wIJad9ybEr7Ihc3UGy9F8znq3h6nVmtkxNh
         xCfXfyQrBkcRGkECDMCx+uwAHLBt8iVW8XwCpAPfQf77EBK6ZHchoOiLmzueaKvUSyYA
         y9TOu86u+HGIsoGdnYdCLNKnAGmhLCmOnzMD/jkfb1u5cXqQGxa9agYoi9qa21agPqWI
         x/BuLafgYeI0HFQM3inFbeXY2/f87wM4LmQyYfWgKekm+g621FpzRNucUFIs82/eOYmt
         iuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7gaS/RyXysP8XSZO8VW4EjVKZZX26nytji80U6hsMY=;
        b=uYEmjvGNCSexmhKlttFYqoPrBKhzcCFf8MRduYnD4QCdP2Vm/XUsIinhQJL6ZvbdxM
         fVUHIq86Y0cfSfukgX+bGLUNs8j0Eh674p1FfYKy7IhLxYkD8rn3w+sQCueh0SeWh+m6
         wiiieEQ1TAG88LcHS87Ien/VriSeAN59g60GKxIGeTedi2MOPmey/ROGpf6jABZB5O+O
         DjMLIq3hFiLIA2lVk6/3DQGduhXDOLpXRiRLTz1ysYToAkrdjQRZdZHMZz6t6eD7rNHz
         BbPgbcF+UuFm+qg+eDhj9r1y6auODX96QgEwau4ickhJWy/YLcm5EAWEoZbuNmKaPUFM
         KjEw==
X-Gm-Message-State: AOAM532an02Di73sxs0TTqshJGbSpkchmmPj2iQYdrxrTcCLQyV1bYKO
        GbnAXUt5Uf2Esz49R96TQqFjaA==
X-Google-Smtp-Source: ABdhPJytocb9A9TtDKbdZE0MZ2PiWgscC7HCd7dwvCd7A/ytwz5tGlXtyT8nR8tVO74J9u9xjXE06w==
X-Received: by 2002:adf:9106:: with SMTP id j6mr17964678wrj.216.1590953475177;
        Sun, 31 May 2020 12:31:15 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id o10sm18189197wrq.40.2020.05.31.12.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 12:31:14 -0700 (PDT)
Date:   Sun, 31 May 2020 21:31:11 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        pgaikwad@nvidia.com, pdeschrijver@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, axboe@kernel.dk
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
Message-ID: <20200531193111.GA15331@Red>
References: <20200319074401.GA4116@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319074401.GA4116@Red>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:44:01AM +0100, LABBE Corentin wrote:
> Hello
> 
> sata doesnt work on tegra124-jetson-tk1 on next and master and at least since 5.2 (but 5.1 works).
> [    0.492810] +5V_SATA: supplied by +5V_SYS
> [    0.493230] +12V_SATA: supplied by +VDD_MUX
> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target not found, using dummy regulator
> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI controller: -110
> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error -110
> [   35.694269] +5V_SATA: disabling
> [   35.697438] +12V_SATA: disabling
> 
> I have bisected this problem:
> git bisect start
> # bad: [22c58fd70ca48a29505922b1563826593b08cc00] Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad 22c58fd70ca48a29505922b1563826593b08cc00
> # good: [67e38f578aaebf34fc1278bbe45a78ee8c73dd33] ARM: ep93xx: move pinctrl interfaces into include/linux/soc
> git bisect good 67e38f578aaebf34fc1278bbe45a78ee8c73dd33
> # good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
> # good: [e57ccca1ba33e1d92cc3bbf8b6304a46948844b0] Merge tag 'sound-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good e57ccca1ba33e1d92cc3bbf8b6304a46948844b0
> # bad: [983dfa4b6ee556563f7963348e4e2f97fc8a15b8] Merge tag 'for-linus-5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/uml
> git bisect bad 983dfa4b6ee556563f7963348e4e2f97fc8a15b8
> # good: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
> git bisect good 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
> # bad: [b970afcfcabd63cd3832e95db096439c177c3592] Merge tag 'powerpc-5.2-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad b970afcfcabd63cd3832e95db096439c177c3592
> # bad: [601e6bcc4ef02bda2831d5ac8133947b5edf597b] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> git bisect bad 601e6bcc4ef02bda2831d5ac8133947b5edf597b
> # good: [7e9c62bdb41af76974d594da89854a6aba645e58] Merge branches 'clk-sa', 'clk-aspeed', 'clk-samsung', 'clk-ingenic' and 'clk-zynq' into clk-next
> git bisect good 7e9c62bdb41af76974d594da89854a6aba645e58
> # bad: [0caf000817353cfc5db22363ecdac63b83d3a3f9] Merge branch 'clk-ti' into clk-next
> git bisect bad 0caf000817353cfc5db22363ecdac63b83d3a3f9
> # good: [5816b74581b45cf086a84ab14e13354a65e8e22c] Merge branches 'clk-hisi', 'clk-lochnagar', 'clk-allwinner', 'clk-rockchip' and 'clk-qoriq' into clk-next
> git bisect good 5816b74581b45cf086a84ab14e13354a65e8e22c
> # good: [7b4c162e03d47e037f8ee773c3e300eefb599a83] clk: at91: Mark struct clk_range as const
> git bisect good 7b4c162e03d47e037f8ee773c3e300eefb599a83
> # bad: [e71f4d385878671991e200083c7d30eb4ca8e99a] clk: tegra: divider: Mark Memory Controller clock as read-only
> git bisect bad e71f4d385878671991e200083c7d30eb4ca8e99a
> # bad: [924ee3d551c9deb16090230b824988bd37e72aa8] clk: tegra: emc: Don't enable EMC clock manually
> git bisect bad 924ee3d551c9deb16090230b824988bd37e72aa8
> # bad: [40db569d6769ffa3864fd1b89616b1a7323568a8] clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
> git bisect bad 40db569d6769ffa3864fd1b89616b1a7323568a8
> # bad: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't enable already enabled PLLs
> git bisect bad bff1cef5f23afbe49f5ebd766980dc612f5e9d0a
> # first bad commit: [bff1cef5f23afbe49f5ebd766980dc612f5e9d0a] clk: tegra: Don't enable already enabled PLLs
> 

Hello

I have digged a bit more and with the following "patch" I have now access to sata again
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 0b212cf2e794..b4e2020051d5 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1602,7 +1603,7 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
        unsigned long input_rate;
 
        if (clk_pll_is_enabled(hw))
-               return 0;
+               pr_info("%s %s\n", __func__, clk_hw_get_name(&pll->hw));
 
        input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));

This patch lead to a probed ahci, and I can see "clk_plle_tegra114_enable pll_e" in messages.

So the bad part of bff1cef5f23afbe49f5ebd766980dc612f5e9d0a is found.
As additional information, my previous kernel has CONFIG_PHY_TEGRA_XUSB=m (since firmware is on rootfs which is on sata)
but with this sata fail the same, having CONFIG_PHY_TEGRA_XUSB=y (and so xusb firmware in kernel) seems "necessary" for having SATA working.

Regards
