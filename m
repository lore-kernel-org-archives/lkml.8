Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D86CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BF22065F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGROqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:46:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38998 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:46:16 -0400
Received: from x2f7f83e.dyn.telefonica.de ([2.247.248.62] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jwo6P-0007Kd-Ng; Sat, 18 Jul 2020 16:46:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in px30 dts files
Date:   Sat, 18 Jul 2020 16:46:11 +0200
Message-Id: <159508352745.11968.2223741912292679297.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715070954.1992-1-jbx6244@gmail.com>
References: <20200715070954.1992-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 09:09:54 +0200, Johan Jonker wrote:
> 'bus-width' has been added to px30.dtsi mmc nodes, so now it can be
> removed from the dts files that include it.

Applied, thanks!

[1/1] arm64: dts: rockchip: remove bus-width from mmc nodes in px30 dts files
      (no commit info)

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
