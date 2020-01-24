Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F889C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2592075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876063;
	bh=etC/B8dEpS/6lnY1kBW+7QBYg5mcAEoucXW2nGYOFC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mu0EkbbAJHZ9Md5Ydf4ZwbR0XVmsGdJ8Xzu/7MhKdHTYgjnhM5WxsOq+ZhOlgrzuN
	 CVUg2a5VP7P740uHh0fYYNGS2W9IbDgCCvHAhkdSUff2YBz4SnxPgMVsCuBLKt9wib
	 H51IdHSmqimsrRuxBxyoxvYSsqg99cOvmy6kaQZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbgAXO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392192AbgAXOVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7DF2077C;
        Fri, 24 Jan 2020 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875683;
        bh=etC/B8dEpS/6lnY1kBW+7QBYg5mcAEoucXW2nGYOFC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBml1Gpp/Bq05ntQw/u/H5G8BanqFIQJdPhau+wJAQq1Dul/UzrykX0s+EWgtoW/a
         boOpthPkBEf6hurHP6uS0W/c2vM7xl+xo9FbUOh7fneiqNuXV1Zd49/MJDbhoF/T+0
         5U8Q0RUA7nnJCLtCayhdHwUULp1KVXCwjL7RT5uo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 03/32] ARM: dts: sun8i: a83t: Correct USB3503 GPIOs polarity
Date:   Fri, 24 Jan 2020 09:20:50 -0500
Message-Id: <20200124142119.30484-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 1c226017d3ec93547b58082bdf778d9db7401c95 ]

Current USB3503 driver ignores GPIO polarity and always operates as if the
GPIO lines were flagged as ACTIVE_HIGH. Fix the polarity for the existing
USB3503 chip applications to match the chip specification and common
convention for naming the pins. The only pin, which has to be ACTIVE_LOW
is the reset pin. The remaining are ACTIVE_HIGH. This change allows later
to fix the USB3503 driver to properly use generic GPIO bindings and read
polarity from DT.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 716a205c6dbbe..1fed3231f5c18 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -90,7 +90,7 @@
 		initial-mode = <1>; /* initialize in HUB mode */
 		disabled-ports = <1>;
 		intn-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
-		reset-gpios = <&pio 4 16 GPIO_ACTIVE_HIGH>; /* PE16 */
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
 		connect-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
 		refclk-frequency = <19200000>;
 	};
-- 
2.20.1

