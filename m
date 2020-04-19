Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D656C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048F120753
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDSMNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:13:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56186 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgDSMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:13:25 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ8p9-0006f3-5Q; Sun, 19 Apr 2020 14:13:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: fix phy nodename for rk3228-evb
Date:   Sun, 19 Apr 2020 14:13:06 +0200
Message-Id: <158729833730.67563.9205424674473235719.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416170321.4216-1-jbx6244@gmail.com>
References: <20200416170321.4216-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 19:03:20 +0200, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> arch/arm/boot/dts/rk3228-evb.dt.yaml: phy@0:
> '#phy-cells' is a required property
> 
> The phy nodename is normally used by a phy-handle.
> This node is however compatible with
> "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
> which is just been added to 'ethernet-phy.yaml'.
> So change nodename to 'ethernet-phy' for which '#phy-cells'
> is not a required property
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: rockchip: fix phy nodename for rk3228-evb
      commit: 806bceeea63f58bde45dbd633092bd9d14da02b0
[2/2] ARM: dts: rockchip: fix phy nodename for rk3229-xms6
      commit: 5c5555f7efed273c61152da03cd395a0d06e054c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
