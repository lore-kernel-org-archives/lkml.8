Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC6CC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E462078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgH3Tmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:42:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48000 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgH3Tmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:42:36 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTDk-0002KX-MM; Sun, 30 Aug 2020 21:42:32 +0200
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
Subject: Re: [PATCH] arm64: dts: rockchip: Fix power routing to support POE
Date:   Sun, 30 Aug 2020 21:42:26 +0200
Message-Id: <159881654154.22245.1792882618820762854.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818184505.30064-1-jagan@amarulasolutions.com>
References: <20200818184505.30064-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 00:15:05 +0530, Jagan Teki wrote:
> When POE used, the current power routing is failing to power-up
> the PMIC regulators which cause Linux boot hangs.
> 
> This patch is trying to update the power routing in order to
> support Type C0 and POE powering methods.
> 
> As per the schematics, sys_12v is a common output power regulator
> when type c and POE power being used. sys_12v is supplied by dc_12v
> which is supplied from MP8859 in type c0 power routing and sys_12v
> is supplied by MP8009 PoE PD in POE power supply routing.

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix power routing to support POE on rk3399-roc-pc
      commit: bd77d0ad7a698f5e04edf02328d11e808a71d87c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
