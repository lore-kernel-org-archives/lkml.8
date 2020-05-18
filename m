Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC2C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E1120829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgERW2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:28:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52636 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgERW2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:28:11 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoEu-00005F-UX; Tue, 19 May 2020 00:28:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, aballier@gentoo.org
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: fix phy nodename for rk3328
Date:   Tue, 19 May 2020 00:27:57 +0200
Message-Id: <158984064169.2259329.11702578814361765317.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Mar 2020 22:54:18 +0100, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: phy@0:
> '#phy-cells' is a required property
> 
> The phy nodename is used by a phy-handle.
> The parent node is compatible with "snps,dwmac-mdio",
> so change nodename to 'ethernet-phy', for which '#phy-cells'
> is not a required property
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: rockchip: fix phy nodename for rk3328
      commit: 8370cc5533b3baa5e0f18075ae638b050458aabd
[2/6] arm64: dts: rockchip: fix rtl8211f nodename for rk3328 Beelink A1
      commit: 63834d1edb96e2016191e53444934299bbc06bb1
[3/6] arm64: dts: rockchip: fix rtl8211e nodename for rk3399-nanopi4
      commit: b450d1c566bd726f93bc72a3cf3155cecebc1b75
[4/6] arm64: dts: rockchip: fix &pinctrl phy sub nodename for rk3399-nanopi4
      commit: 737157f9618b40c7147cf697aec431ce9dd178a0
[5/6] arm64: dts: rockchip: fix rtl8211e nodename for rk3399-orangepi
      commit: b2bb769100d49c6acbfb2756cc4748aac09209c9
[6/6] arm64: dts: rockchip: fix &pinctrl phy sub nodename for rk3399-orangepi
      commit: 302a729c84b59c835f7857ec378efecbda58b9b3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
