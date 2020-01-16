Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D58C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D177206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200918;
	bh=GASgO3943XMdqvSE6BOUqLZVlhdNiqCagP6RoEdfFtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJlpzrukMZLxC7Gb9NXMUXi8uO7V1Pbf8uMqT2ChcnsUHkluO/yrLjfTAB4B/RmeO
	 Bx/cT+fDOfMGbT/A95hOFyucYtRZvdQ7VfLljfXhfZ8tgeDB/NAqYjtwoatJxRir4B
	 zNOvghfnzFJBYMg68KUNpkNq7o4p62foMKZCjrzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437170AbgAPSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388697AbgAPRHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95F520663;
        Thu, 16 Jan 2020 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194460;
        bh=GASgO3943XMdqvSE6BOUqLZVlhdNiqCagP6RoEdfFtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfw/UjWCiAxM/8s2XXp2h5j5zEiM4Wz4xwwuJWIOuzD+2uWjEFotfL9nGyi6964VT
         xARNbwnvPT7FWvQCL5D1tuFK6C60KakJEqrGPjzmtm/I3Xa93FLBPlvDqDFQwbWi9K
         i3cTZc97t2PFRBS7A+98n+Zj4Ug43yk9zR3b5cmk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 368/671] arm64: dts: meson: libretech-cc: set eMMC as removable
Date:   Thu, 16 Jan 2020 12:00:06 -0500
Message-Id: <20200116170509.12787-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 9f72e321d5506fe3e162a6308a4a295d7f10bb5d ]

The eMMC on this board is add-on module which is not mandatory. Removing
'non-removable' property should prevent some errors when booting a board
w/o an eMMC module present.

Fixes: 72fb2c852188 ("ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index db293440e4ca..daad007fac1f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -256,7 +256,6 @@
 	cap-mmc-highspeed;
 	mmc-ddr-3_3v;
 	max-frequency = <50000000>;
-	non-removable;
 	disable-wp;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-- 
2.20.1

