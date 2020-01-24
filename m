Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210E4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CBB2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876639;
	bh=yYkdvZfWRqRnTJkQxbICX9j233kcKaHvQHhe2M4H1gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arPvCEVnMQgrPrI52q2T5tLjsXc8xh/k67pA1XlSHQRIYOv5e+CJ7dif88MuksMfr
	 aPa3OdxnwBMQBtpw798kQhUClM2jph2WMJ3o6zYspm+ValnGGCYgpL0eF/0tfCbMhy
	 4aYlykmdRltSUihqXsMwuDJ+3jFEysUSSCq+vETc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbgAXOTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391195AbgAXOS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1F8222D9;
        Fri, 24 Jan 2020 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875538;
        bh=yYkdvZfWRqRnTJkQxbICX9j233kcKaHvQHhe2M4H1gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkNPJTBIPDLH4FkG8gnc++0gO+PIcNecD9RbEvMZSO650CKpvbpAi1VhN00X0fQ7I
         zpS+6Nc+rya0tvP50yC+TMrn7/OwXZv7+VehxxYncYvV7bsnPTE1TXL/BE4wxe0Ezx
         degMhqu3iJoo4GMAwcVbl8Mh4yMo7nnK5C5je7sE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 035/107] ARM: dts: imx7: Fix Toradex Colibri iMX7S 256MB NAND flash support
Date:   Fri, 24 Jan 2020 09:17:05 -0500
Message-Id: <20200124141817.28793-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit 4b0b97e651ecf29f20248420b52b6864fbd40bc2 ]

Turns out when introducing the eMMC version the gpmi node required for
NAND flash support got enabled exclusively on Colibri iMX7D 512MB.

Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s-colibri.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index 1fb1ec5d3d707..6d16e32aed899 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -49,3 +49,7 @@
 		reg = <0x80000000 0x10000000>;
 	};
 };
+
+&gpmi {
+	status = "okay";
+};
-- 
2.20.1

