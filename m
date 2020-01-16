Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68830C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414D424739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196432;
	bh=ug7JTEi3OX6ZC0mTbUTh8dwpu1d6r0WXRfaBeAOuUSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wH548yNCgV4fNdpz2vk5RfgE20UlE7is6wYwsOaHC7GmbcxM55MuSf6OE3ElgeLdm
	 S7oab61fVkZd9cSGumEYwlnuxAhQOr+gsQDmjJ0Y3GCK0a/CZwLSXEuzGTyUB7j6py
	 GeWtBXJs66Nz9YSrHgw5B1vIlqcxPrMln6rQt7b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393633AbgAPRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732417AbgAPRjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7494B246EC;
        Thu, 16 Jan 2020 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196371;
        bh=ug7JTEi3OX6ZC0mTbUTh8dwpu1d6r0WXRfaBeAOuUSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ik14lywlmPQ7hXQjKoujwgTHZxQogETVqGED0mJqulabVMMt0CuPg7LISYvmDhdkg
         DW5CCEmDPf+JVdq0SdworfYL0EVLWvpoIUtoNNzh1kxgxNch4XVs3ZLK99TpLvpGur
         ZZeLJUQgAG9uiQDRrGGP5eXNSEG3KB2VIJIJCU0Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 158/251] drm/msm/a3xx: remove TPL1 regs from snapshot
Date:   Thu, 16 Jan 2020 12:35:07 -0500
Message-Id: <20200116173641.22137-118-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit f47bee2ba447bebc304111c16ef1e1a73a9744dd ]

These regs are write-only, and the hw throws a hissy-fit (ie. reboots)
when we try to read them for GPU state snapshot, in response to a GPU
hang.  It is rather impolite when GPU recovery triggers an insta-
reboot, so lets remove the TPL1 registers from the snapshot.

Fixes: 7198e6b03155 drm/msm: add a3xx gpu support
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index fd266ed963b6..25a0e7d13340 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -383,19 +383,17 @@ static const unsigned int a3xx_registers[] = {
 	0x2200, 0x2212, 0x2214, 0x2217, 0x221a, 0x221a, 0x2240, 0x227e,
 	0x2280, 0x228b, 0x22c0, 0x22c0, 0x22c4, 0x22ce, 0x22d0, 0x22d8,
 	0x22df, 0x22e6, 0x22e8, 0x22e9, 0x22ec, 0x22ec, 0x22f0, 0x22f7,
-	0x22ff, 0x22ff, 0x2340, 0x2343, 0x2348, 0x2349, 0x2350, 0x2356,
-	0x2360, 0x2360, 0x2440, 0x2440, 0x2444, 0x2444, 0x2448, 0x244d,
-	0x2468, 0x2469, 0x246c, 0x246d, 0x2470, 0x2470, 0x2472, 0x2472,
-	0x2474, 0x2475, 0x2479, 0x247a, 0x24c0, 0x24d3, 0x24e4, 0x24ef,
-	0x2500, 0x2509, 0x250c, 0x250c, 0x250e, 0x250e, 0x2510, 0x2511,
-	0x2514, 0x2515, 0x25e4, 0x25e4, 0x25ea, 0x25ea, 0x25ec, 0x25ed,
-	0x25f0, 0x25f0, 0x2600, 0x2612, 0x2614, 0x2617, 0x261a, 0x261a,
-	0x2640, 0x267e, 0x2680, 0x268b, 0x26c0, 0x26c0, 0x26c4, 0x26ce,
-	0x26d0, 0x26d8, 0x26df, 0x26e6, 0x26e8, 0x26e9, 0x26ec, 0x26ec,
-	0x26f0, 0x26f7, 0x26ff, 0x26ff, 0x2740, 0x2743, 0x2748, 0x2749,
-	0x2750, 0x2756, 0x2760, 0x2760, 0x300c, 0x300e, 0x301c, 0x301d,
-	0x302a, 0x302a, 0x302c, 0x302d, 0x3030, 0x3031, 0x3034, 0x3036,
-	0x303c, 0x303c, 0x305e, 0x305f,
+	0x22ff, 0x22ff, 0x2340, 0x2343, 0x2440, 0x2440, 0x2444, 0x2444,
+	0x2448, 0x244d, 0x2468, 0x2469, 0x246c, 0x246d, 0x2470, 0x2470,
+	0x2472, 0x2472, 0x2474, 0x2475, 0x2479, 0x247a, 0x24c0, 0x24d3,
+	0x24e4, 0x24ef, 0x2500, 0x2509, 0x250c, 0x250c, 0x250e, 0x250e,
+	0x2510, 0x2511, 0x2514, 0x2515, 0x25e4, 0x25e4, 0x25ea, 0x25ea,
+	0x25ec, 0x25ed, 0x25f0, 0x25f0, 0x2600, 0x2612, 0x2614, 0x2617,
+	0x261a, 0x261a, 0x2640, 0x267e, 0x2680, 0x268b, 0x26c0, 0x26c0,
+	0x26c4, 0x26ce, 0x26d0, 0x26d8, 0x26df, 0x26e6, 0x26e8, 0x26e9,
+	0x26ec, 0x26ec, 0x26f0, 0x26f7, 0x26ff, 0x26ff, 0x2740, 0x2743,
+	0x300c, 0x300e, 0x301c, 0x301d, 0x302a, 0x302a, 0x302c, 0x302d,
+	0x3030, 0x3031, 0x3034, 0x3036, 0x303c, 0x303c, 0x305e, 0x305f,
 	~0   /* sentinel */
 };
 
-- 
2.20.1

