Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B639022B39
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgGVTV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:21:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47736 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732818AbgGVTV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:21:26 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyKIr-0005Ud-SW; Wed, 22 Jul 2020 21:21:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        William Wu <william.wu@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
Date:   Wed, 22 Jul 2020 21:21:06 +0200
Message-Id: <159544564767.763387.3267110197113276761.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720105846.367776-1-jagan@amarulasolutions.com>
References: <20200720105846.367776-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 16:28:46 +0530, Jagan Teki wrote:
> rk3288 and rk3288w have a usb host0 ohci controller.
> 
> Although rk3288 ohci doesn't actually work on hardware, but
> rk3288w ohci can work well.
> 
> So add usb host0 ohci node in rk3288 dtsi and the quirk in
> ohci platform driver will disable ohci on rk3288.

Applied, thanks!

[1/1] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
      commit: 82540defdd9cfc491f564ffb8d01911966636bc7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
