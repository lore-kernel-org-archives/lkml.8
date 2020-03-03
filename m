Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA70C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CA62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204127;
	bh=779UrS+LZsp9ln83dBobbCiQunNu96RYkBFUGMEeamE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7+cPjh0PfqELZfjgiarGXjaWW78XOq1m9kFer5QEBysJ9NFv1mc1NWxzmG1vKeMj
	 vGtNK5qR0QmJbhk6eXIJzSBUBnYk8YE1lOEUEqV+7qhb94zpNH2oTVO7kk/unQ6jRX
	 voq3y++NsbmwbbwkObvlujz1Ypt05bPK6igfM3jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgCCCzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgCCCtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:49:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F6824686;
        Tue,  3 Mar 2020 02:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203747;
        bh=779UrS+LZsp9ln83dBobbCiQunNu96RYkBFUGMEeamE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7erchrmM3KUTiBQ7znctioXx88at6CejBO6mPdYx/Kgjq9HhgAcK5TKeM8p2xGyh
         cBnxgptFOD62CZvFb5VKGTmrlNHr5JUDprZUYSzHOhc9cpl0GtUL9iDUCmYjZNLd8p
         bbNgUOFUVUIUm3qCmZiot5Gi115FVN7R1Utxv4i8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harigovindan P <harigovi@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 12/32] drm/msm/dsi/pll: call vco set rate explicitly
Date:   Mon,  2 Mar 2020 21:48:31 -0500
Message-Id: <20200303024851.10054-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024851.10054-1-sashal@kernel.org>
References: <20200303024851.10054-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harigovindan P <harigovi@codeaurora.org>

[ Upstream commit c6659785dfb3f8d75f1fe637e4222ff8178f5280 ]

For a given byte clock, if VCO recalc value is exactly same as
vco set rate value, vco_set_rate does not get called assuming
VCO is already set to required value. But Due to GDSC toggle,
VCO values are erased in the HW. To make sure VCO is programmed
correctly, we forcefully call set_rate from vco_prepare.

Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 31205625c7346..21a69b046625a 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -406,6 +406,12 @@ static int dsi_pll_10nm_vco_prepare(struct clk_hw *hw)
 	if (pll_10nm->slave)
 		dsi_pll_enable_pll_bias(pll_10nm->slave);
 
+	rc = dsi_pll_10nm_vco_set_rate(hw,pll_10nm->vco_current_rate, 0);
+	if (rc) {
+		pr_err("vco_set_rate failed, rc=%d\n", rc);
+		return rc;
+	}
+
 	/* Start PLL */
 	pll_write(pll_10nm->phy_cmn_mmio + REG_DSI_10nm_PHY_CMN_PLL_CNTRL,
 		  0x01);
-- 
2.20.1

