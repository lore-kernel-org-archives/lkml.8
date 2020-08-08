Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A90C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9536F20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930625;
	bh=8INbqVHcC//Bj7jsi7PEmcghl29Dn+dGUL9hboMj/8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGPH/ycmj8mm9V6ADvGtYZbhv+JfaG08cgBzUf/tqGEQvhNHKNHf/VL4vfMoXAS0p
	 01OxZIoU+TgVnV+T9L3HZ+PemgvvOWwi4jb3lv19oL5p5ooxQH5Pi42jAGPzhqZp1W
	 19Hx4WtPHDE04HofMERq5COjlTb3XeGy3pes9tZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHHXuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgHHXgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:36:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29246206D8;
        Sat,  8 Aug 2020 23:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929799;
        bh=8INbqVHcC//Bj7jsi7PEmcghl29Dn+dGUL9hboMj/8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwE92NZQCRNbm7qLbeh5luOwj1xaszQxnwoR/8bRlXnS+E5mcuB7ocIcTU3O5HPrN
         MKKBzaCRZK3+DwRE/tlj4oUOIuDRFVVA8mwaR94Bs1xY9VEZdUinjZ7m6bum92SwJ0
         hdsjP9jf8KAyqPrTIil3a9/dsfTLlp95H550bFDw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 38/72] ARM: dts: at91: sama5d3_xplained: change phy-mode
Date:   Sat,  8 Aug 2020 19:35:07 -0400
Message-Id: <20200808233542.3617339-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 7dbf4bbf1c320d82058878bd44805724d171e1e8 ]

Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
KSZ9031 PHY"), networking is broken on sama5d3 xplained.

The device tree has phy-mode = "rgmii" and this worked before, because
KSZ9031 PHY started with default RGMII internal delays configuration (TX
off, RX on 1.2 ns) and MAC provided TX delay. After above commit, the
KSZ9031 PHY starts handling phy mode properly and disables RX delay, as
result networking is become broken.

Fix it by switching to phy-mode = "rgmii-rxid" to reflect previous
behavior.

Fixes: bcf3440c6dd78bfe ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20200717233644.841080-1-alexandre.belloni@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 61f068a7b362a..7abf555cd2fe3 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -128,7 +128,7 @@ vddana_reg: LDO_REG2 {
 			};
 
 			macb0: ethernet@f0028000 {
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-rxid";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "okay";
-- 
2.25.1

