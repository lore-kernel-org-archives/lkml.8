Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613EC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14E820775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGRPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:08:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39218 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:08:07 -0400
Received: from x2f7f83e.dyn.telefonica.de ([2.247.248.62] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jwoRY-0007el-C9; Sat, 18 Jul 2020 17:08:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] ARM: dts: rockchip: Radxa Rock Pi N8 initial support
Date:   Sat, 18 Jul 2020 17:08:02 +0200
Message-Id: <159508486383.16292.5716289936157540708.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715083418.112003-1-jagan@amarulasolutions.com>
References: <20200715083418.112003-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 14:04:11 +0530, Jagan Teki wrote:
> Rock Pi N8 is a Rockchip RK3288 based SBC, which has
> - VMARC RK3288 SOM (as per SMARC standard) from Vamrs.
> - Compatible carrier board from Radxa.
> 
> VMARC RK3288 SOM need to mount on top of dalang carrier
> board for making Rock PI N8 SBC.
> 
> [...]

Applied, thanks!

[1/7] ARM: dts: rockchip: dalang-carrier: Move i2c nodes into SOM
      commit: c2f343510d99ab53b46bdfeb184cb48f622e6943
[2/7] arm64: dts: rk3399pro: vmarc-som: Fix sorting nodes, properties
      commit: 3047b384a74090f09b994298eb5c40986275233a
[3/7] arm64: dts: rk3399pro: vmarc-som: Move supply regulators into Carrier
      commit: 4a3ca113c0f3a2ce33e51fc6a48a121b2d707d4f
[4/7] arm64: dts: rk3399pro: vmarc-som: Move common properties into Carrier
      commit: a66bd94d0eac017e4846658750acaca2937555bb
[5/7] dt-bindings: arm: rockchip: Add Rock Pi N8 binding
      commit: 09ee4794270f0010c6397163f033f883f5bff1aa
[6/7] ARM: dts: rockchip: Add VMARC RK3288 SOM initial support
      commit: b8c564d4fa76b1314a10585eea8e97b8c621a77a
[7/7] ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support
      commit: afd9eb88041409e0f311730f23e8fe6921e74cb8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
