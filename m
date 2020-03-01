Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAEBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B92A24672
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgCAAZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:25:29 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55690 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgCAAZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:25:28 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8CQ1-0004xy-6B; Sun, 01 Mar 2020 01:25:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Carlos de Paula <me@carlosedp.com>
Cc:     papadakospan@gmail.com, jose.abreu@synopsys.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Peter Geis <pgwipeout@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add txpbl node for RK3399/RK3328
Date:   Sun, 01 Mar 2020 01:25:16 +0100
Message-ID: <6132615.msM8OCcsVu@phil>
In-Reply-To: <20200218221040.10955-1-me@carlosedp.com>
References: <20200218221040.10955-1-me@carlosedp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 18. Februar 2020, 23:10:37 CET schrieb Carlos de Paula:
> Some rockchip SoCs like the RK3399 and RK3328 exhibit an issue
> where tx checksumming does not work with packets larger than 1498.
> 
> The default Programmable Buffer Length for TX in these GMAC's is
> not suitable for MTUs higher than 1498. The workaround is to disable
> TX offloading with 'ethtool -K eth0 tx off rx off' causing performance
> impacts as it disables hardware checksumming.
> 
> This patch sets snps,txpbl to 0x4 which is a safe number tested ok for
> the most popular MTU value of 1500.
> 
> For reference, see https://lkml.org/lkml/2019/4/1/1382.
> 
> Signed-off-by: Carlos de Paula <me@carlosedp.com>

applied for 5.7

Thanks
Heiko


