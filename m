Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C24C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCE820771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGEKTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:19:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50514 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgGEKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 06:19:06 -0400
Received: from p57b773cb.dip0.t-ipconnect.de ([87.183.115.203] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1js1jb-0001qi-Ap; Sun, 05 Jul 2020 12:18:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     ezequiel@collabora.com, mturquette@baylibre.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-clk@vger.kernel.org, jagan@amarulasolutions.com,
        mylene.josserand@collabora.com, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: Re: [PATCH v2] clk: rockchip: use separate compatibles for rk3288w-cru
Date:   Sun,  5 Jul 2020 12:18:54 +0200
Message-Id: <159394432444.305208.6716969954746405813.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703154948.260369-1-heiko@sntech.de>
References: <20200703154948.260369-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 17:49:48 +0200, Heiko Stuebner wrote:
> Commit 1627f683636d ("clk: rockchip: Handle clock tree for rk3288w variant")
> added the check for rk3288w-specific clock-tree changes but in turn would
> require a double-compatible due to re-using the main rockchip,rk3288-cru
> compatible as entry point.
> 
> The binding change actually describes the compatibles as one or the other
> so adapt the code accordingly and add a real second entry-point for the
> clock controller.

Applied, thanks!

[1/1] clk: rockchip: use separate compatibles for rk3288w-cru
      commit: 0a7f99aad259d223ce69c03e792c7e2bfcf8c2c6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
