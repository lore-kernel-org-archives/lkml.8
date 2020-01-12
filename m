Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3948C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7622084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PHCtFhmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgALRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:16:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgALRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:16:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so6325403wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 09:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mK3n8YHUQSO4qWCfmig2OoPvmN4FELyuj1mu8Qb0Uvg=;
        b=PHCtFhmFmXpRaReOuByijRkKAlqojM2ncg25uli2v2Hj9plkD/j++7TTjVnZJZmOXG
         EpDtrceDGxxDanl8OienaHcqepb7jqkI/bGSvC7BJrJAsDMoLq+Dd1I3S5zoGymc8ZpS
         OotlGfZ8HlgyIlcuDntQBj/z4G31ryYwc/tes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mK3n8YHUQSO4qWCfmig2OoPvmN4FELyuj1mu8Qb0Uvg=;
        b=ryh1r85C9tBJh1A2I2qbpEqPejt7hyA3t7A+OnVJF80taVkeSQK/lM0z0UMQIljTxI
         sjMSjMcmxwU2b9Y3+nbFMlK/3oQFyDNYjj1rPJxxs5qsKQW7VNlIhUjCWflPELCgsqsU
         wsNyUe2tDg5OI1ILQhqhrPR1oX+0pVehGJykPn3nskZyQe38qfjWK6qyBhybpH6l8nx0
         f6N5cchf4EvnsXUSFcQsh6l5npG90uf9bh2m9xjGlJbU7md/+wR5SYOL6KLrtDjQz2D3
         pSIlpazvdj/3juMk/6OPaC5qaRuAuEWwdqcLQnZWYn/ttDTUUufqB1XHOem7fYcVtixF
         u4bA==
X-Gm-Message-State: APjAAAUkkZB0Fq1Hc/4hDPIq/pbDAYIN1msOE/KT3FEvrOCPEDpA2jCl
        abOhX3AvRuj/3ul6Rj9cUOG2ZDLW7eTmi+MTIWDutcI1APY=
X-Google-Smtp-Source: APXvYqygPwAMTqGMIy3dEtPb4hYX1AZgBOcWui/v0mFURI1IVBW/bpkZ8SrUaPG+eKFCMYhuSAZjy2ibjXgta8F+4Q0=
X-Received: by 2002:adf:f501:: with SMTP id q1mr14855561wro.263.1578849403383;
 Sun, 12 Jan 2020 09:16:43 -0800 (PST)
MIME-Version: 1.0
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sun, 12 Jan 2020 18:16:30 +0100
Message-ID: <CAOf5uwmPMRq4v9=5-Z=XLH7hATC-AhXQWthfy_uvYTXSo6V+CA@mail.gmail.com>
Subject: siimple-framebuffer rockchip persistent logo
To:     Kever Yang <kever.yang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Cc:     Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kever

Trying to have a persistent banner from uboot to linux-kernel. I'm
right now working on linux-rockchip kernel but I think that the
problem is even on mainline

+               framebuffer: framebuffer@7f800000 {
+                       compatible = "rockchip,simple-framebuffer",
+                                    "simple-framebuffer";
+                       reg = <0x7f800000 (1920 * 1080 * 4)>;
+                       width = <1920>;
+                       height = <1080>;
+                       stride = <(1920 * 4)>;
+                       format = "a8b8g8r8";
+                       clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>,
+                                <&cru SRST_LCDC0_AXI>, <&cru
SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>,
+                                <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
+                       status = "okay";
+               };

Seems that it get off before I reach the drm registration

[    2.077495] simple-framebuffer 7f800000.framebuffer: framebuffer at
0x7f800000, 0x7e9000 bytes, mapped to 0xf0900000
[    2.077519] simple-framebuffer 7f800000.framebuffer:
format=a8b8g8r8, mode=1920x1080x32, linelength=7680
[    2.161225] simple-framebuffer 7f800000.framebuffer: fb0: simplefb
registered!
[    3.433847] fb: switching to rockchip-drm-fb from simple

I don't find all the clocks and if those are the only think that I
need to stay on. Any suggestion?

Michael
