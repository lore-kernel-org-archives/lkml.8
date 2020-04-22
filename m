Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC6C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7731B20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552347;
	bh=oooFEStGUZHNuhXxGFvK4GTwAIxHao8rhtCGvyKcdGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2WnHEB1nXMCClkEdZ9hbFhZrXTZrIdXRnDUpOqDBWA0L1u/hvdQELKDLEpisI+P8
	 IGy22+RMtPJ3TZrm3BsT+J2YyKtlCpQqySBPLOWijgPdNT1v06O2XB2qzOJNpbjDlA
	 qxjnxmDXDirOmOUF3Z9iDWpGv8tXtGIj37cK0R2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgDVKpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgDVKRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80E22076B;
        Wed, 22 Apr 2020 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550670;
        bh=oooFEStGUZHNuhXxGFvK4GTwAIxHao8rhtCGvyKcdGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWQ1/6DBw/4DFvh9GauDMLZpHoWdrQ8aQHy4+TUiRk5m26Q/LgOFSJPLUSIYTik63
         eRC2saUGJ1u0Hy1KpZkpbHL4abqybF4d2n4L1ps0LJV/2/kl6sorRlrIQREAERkKc1
         2BLHhhGeH9YRQSXgtdY7PplofIafjiqF3qo4P0fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 046/118] arm64: dts: clearfog-gt-8k: set gigabit PHY reset deassert delay
Date:   Wed, 22 Apr 2020 11:56:47 +0200
Message-Id: <20200422095039.517795504@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 46f94c7818e7ab82758fca74935ef3d454340b4e ]

If the mv88e6xxx DSA driver is built as a module, it causes the
ethernet driver to re-probe when it's loaded. This in turn causes
the gigabit PHY to be momentarily reset and reprogrammed. However,
we attempt to reprogram the PHY immediately after deasserting reset,
and the PHY ignores the writes.

This results in the PHY operating in the wrong mode, and the copper
link states down.

Set a reset deassert delay of 10ms for the gigabit PHY to avoid this.

Fixes: babc5544c293 ("arm64: dts: clearfog-gt-8k: 1G eth PHY reset signal")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index a211a046b2f2f..b90d78a5724b2 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -367,6 +367,7 @@
 		pinctrl-0 = <&cp0_copper_eth_phy_reset>;
 		reset-gpios = <&cp0_gpio2 11 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <10000>;
+		reset-deassert-us = <10000>;
 	};
 
 	switch0: switch0@4 {
-- 
2.20.1



