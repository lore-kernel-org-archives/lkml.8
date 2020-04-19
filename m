Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E599C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165C621841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDSMgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:36:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56442 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgDSMgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:36:13 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ9BB-0006k5-Ie; Sun, 19 Apr 2020 14:36:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308-roc-cc.dts
Date:   Sun, 19 Apr 2020 14:35:57 +0200
Message-Id: <158729964648.70529.8094316995318301220.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415131057.2366-1-jbx6244@gmail.com>
References: <20200415131057.2366-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 15:10:57 +0200, Johan Jonker wrote:
> The 'bus-width' property for mmc nodes is defined both in
> 'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
> 'bus-width' and pinctrl containing the bus-pins
> should be in the same file, so remove all entries
> from mmc nodes in 'rk3308-roc-cc.dts'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308-roc-cc
      commit: 051083dddf07a4472bc1720d5c2b1909e0865890

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
