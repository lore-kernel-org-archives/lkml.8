Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BAC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CAF22CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281055;
	bh=iwmpauxY7ye7TKgOjmLPiQNamZ32rwVmIfVlNHkDXnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M8Sz1SHoHwuneS7T6Otpi8G8AyhNQPkGm6phGkWS5KAre2gmNiRDyR/G+18k6YXxU
	 RYxHd5T2rCY54orF6ItEfewsHI8LA2Ra56fEBowJEZUuIxJiwcWdxts8t0k62iu3/H
	 MZsdRS8NDk+2edHVBazbDt3U6FoXa+VSSuMul378=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGTVhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgGTVh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA48207FC;
        Mon, 20 Jul 2020 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281048;
        bh=iwmpauxY7ye7TKgOjmLPiQNamZ32rwVmIfVlNHkDXnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAZX/G7k4YG3ujL80kyLtvCW38isZ0JZ8HFoBypubi9Z5vOqO6zBfzhStCK251k4J
         MLfVlTp7pRuHwPNcbeP+F+R6GlWw1cDBBuxJV+yzF2ZVG28931ej3DRT62WbZEucMq
         b/xZM0fBUaz8uQfRbm0zZIDnWDPbQm1yJKV3BhtA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 10/40] soc: amlogic: meson-gx-socinfo: Fix S905X3 and S905D3 ID's
Date:   Mon, 20 Jul 2020 17:36:45 -0400
Message-Id: <20200720213715.406997-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit d16d0481e6bab5a916450e4ef0e1c958b550880c ]

Correct the SoC revision and package bits/mask values for S905D3/X3 to detect
a wider range of observed SoC IDs, and tweak sort order for A311D/S922X.

S905X3 05 0000 0101  (SEI610 initial devices)
S905X3 10 0001 0000  (ODROID-C4 and recent Android boxes)
S905X3 50 0101 0000  (SEI610 later revisions)
S905D3 04 0000 0100  (VIM3L devices in kernelci)
S905D3 b0 1011 0000  (VIM3L initial production)

Fixes commit c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs")

Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200609081318.28023-1-christianshewitt@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 01fc0d20a70db..6f54bd832c8b8 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -66,10 +66,12 @@ static const struct meson_gx_package_id {
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
-	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
-	{ "S905X3", 0x2b, 0x5, 0xf },
-	{ "S905D3", 0x2b, 0xb0, 0xf0 },
+	{ "S922X", 0x29, 0x40, 0xf0 },
+	{ "S905D3", 0x2b, 0x4, 0xf5 },
+	{ "S905X3", 0x2b, 0x5, 0xf5 },
+	{ "S905X3", 0x2b, 0x10, 0x3f },
+	{ "S905D3", 0x2b, 0x30, 0x3f },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
-- 
2.25.1

