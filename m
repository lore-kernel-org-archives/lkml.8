Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8ABC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5762078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgH3Tmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:42:52 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48002 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgH3Tmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:42:36 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTDl-0002KX-2E; Sun, 30 Aug 2020 21:42:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        devicetree@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: rockchip: Update ROCKPi 4 binding
Date:   Sun, 30 Aug 2020 21:42:27 +0200
Message-Id: <159881654154.22245.2247081403353499005.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807094826.12019-1-jagan@amarulasolutions.com>
References: <20200807094826.12019-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 15:18:23 +0530, Jagan Teki wrote:
> ROCKPi 4 has 3 variants of hardware platforms called
> ROCKPi 4A, 4B, and 4C.
> 
> - ROCKPi 4A has no Wif/BT.
> - ROCKPi 4B has AP6256 Wifi/BT, PoE.
> - ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
>   GPIO pin change compared to 4B, 4C
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: rockchip: Update ROCKPi 4 binding
      commit: 75a0a65a301f557bf0306d7983f8cf31ac91de56
[2/4] arm64: dts: rockchip: Mark rock-pi-4 as rock-pi-4a dts
      commit: b5edb04673700125bfd1d13e6c14747b1ecba522
[3/4] arm64: dts: rockchip: Add Radxa ROCK Pi 4B support
      commit: c1075b7fcca81f58ebc5d723f07b23f84ae93daa
[4/4] arm64: dts: rockchip: Add Radxa ROCK Pi 4C support
      commit: 93e0e8ce5fdf549f1715dad00bfbb21b2f69ba8e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
