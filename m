Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B64C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD722078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660620;
	bh=t/B+Z7/pj/drMxYa0MXWdU4i0KnwS+kev2e8ibieyrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3Zf1FWhxOT0Nl7Lj7FbNSEN4F5WuetNsFbKRtVSgMVmfzxszTVGklHTNih4iz+JV
	 fh8/pbeubOcQqurFAAChFlG+dYF+o52aPQwByhFiXIn2cdFyRZ6rh0ag72tKaqSjY1
	 U4GvBFE0SlFAe//G2FT4vBbepGj4R3aqj4oPY4AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgFHXXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbgFHXS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A21420884;
        Mon,  8 Jun 2020 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658309;
        bh=t/B+Z7/pj/drMxYa0MXWdU4i0KnwS+kev2e8ibieyrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+M+pXLjTDL8jysAAQ0n64fWbKvHzU+GaD1q4eADDB1Pg++NT0qTNZhbCtukua4RK
         oUA5js1DxiFsPY0gbIViWxfuv6ZburjI7psLKQUvP7zeGHLFh6xnesc3Mr4XbPoEkT
         z+zNFyh3wLzYduOTbYSGkVU8jpbAXya8pkeeD3rg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 310/606] ARM: dts: mmp3: Use the MMP3 compatible string for /clocks
Date:   Mon,  8 Jun 2020 19:07:15 -0400
Message-Id: <20200608231211.3363633-310-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit ec7d12faf81de983efce8ff23f41c5d1bff14c41 ]

Clocks are in fact slightly different on MMP3. In particular, PLL2 is
fixed to a different frequency, there's an extra PLL3, and the GPU
clocks are configured differently.

Link: https://lore.kernel.org/r/20200419171157.672999-15-lkundrak@v3.sk
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/mmp3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 59a108e49b41..3e28f0dc9df4 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -531,7 +531,7 @@ l2: l2-cache-controller@d0020000 {
 		};
 
 		soc_clocks: clocks@d4050000 {
-			compatible = "marvell,mmp2-clock";
+			compatible = "marvell,mmp3-clock";
 			reg = <0xd4050000 0x1000>,
 			      <0xd4282800 0x400>,
 			      <0xd4015000 0x1000>;
-- 
2.25.1

