Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B57FC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A18620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgD0Tmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:42:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46442 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgD0Tmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9eA-00007W-QQ; Mon, 27 Apr 2020 21:42:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: remove extra assigned-clocks property from &gmac2phy node in rk3328-evb.dts
Date:   Mon, 27 Apr 2020 21:42:24 +0200
Message-Id: <158801649141.50507.12064704129185456183.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200425122345.12902-1-jbx6244@gmail.com>
References: <20200425122345.12902-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 14:23:44 +0200, Johan Jonker wrote:
> There are 2 'assigned-clocks' properties in the '&gmac2phy'
> node in 'rk3328-evb.dts', so remove one of them.
> 
> Info from clk-rk3328.c:
> 
> MUXGRF(SCLK_MAC2PHY, "clk_mac2phy", mux_mac2phy_src_p,
> CLK_SET_RATE_NO_REPARENT,
> RK3328_GRF_MAC_CON2, 10, 1, MFLAGS),
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: remove extra assigned-clocks property from &gmac2phy node in rk3328-evb.dts
      commit: f73a28284e2a89a7ca1e10e04514aedd33290c76
[2/2] arm64: dts: rockchip: fix status for &gmac2phy in rk3328-evb.dts
      commit: c617ed88502d0b05149e7f32f3b3fd8a0663f7e2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
