Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D4C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FCB21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDSMgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:36:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56454 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgDSMgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:36:16 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ9BB-0006k5-AZ; Sun, 19 Apr 2020 14:36:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     christoph.muellner@theobroma-systems.com,
        kever.yang@rock-chips.com, robh+dt@kernel.org,
        mark.rutland@arm.com, robin.murphy@arm.com,
        devicetree@vger.kernel.org, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: rockchip: add core devicetree for rk3326
Date:   Sun, 19 Apr 2020 14:35:56 +0200
Message-Id: <158729964648.70529.10290347754936450590.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414082938.2977572-1-heiko@sntech.de>
References: <20200414082938.2977572-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 10:29:36 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The rk3326 is basically a px30 without the second display controller.
> So add a dtsi based on that, that just removes the affected nodes.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: add core devicetree for rk3326
      commit: df07f7df7e5a61d06b21f89c4ab744fb4e4c2222
[2/3] dt-bindings: Add binding for Hardkernel Odroid Go Advance
      commit: 98412e1e57ea776b4581077a68fe6ed598bfba99
[3/3] arm64: dts: rockchip: add Odroid Advance Go
      commit: ce33988fb69828dfcb5825f9086d9dc2b37a9282

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
