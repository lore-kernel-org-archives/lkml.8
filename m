Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E040C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60297206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447777;
	bh=URc4789k/5yNLxNApylXOdyYnfGKoDQJ73exVVOeipg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqHaNjhoP7JCf//x6xuFmu1Ps+uQfp89S8I5KwLHe7Mbcrp4trl2DRXqmVmroHYpf
	 srrZ4enRmMvXzMLfvIIhhQEL/mKgqYx044tvt28xdwRlngkAEwOc9cb10CYBs0lcej
	 e58Cj6W9AzPV36936MAkxA1Kdgd1KiIL1hR8nu6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgFRCgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgFRBOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223FD20EDD;
        Thu, 18 Jun 2020 01:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442839;
        bh=URc4789k/5yNLxNApylXOdyYnfGKoDQJ73exVVOeipg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSDQeYDYBFBCuBZ/cOGU4Smv8XdIxIgV2D7BYLdeNtoR2jivQLPE1TnCyTPUaYlen
         BA8V4L0TQwsvK0MP4P6WXwCSMzoLElJk4+9TB49k7JO4eltVOVZnWo8nGOtekY8/G/
         hpOSiuJTz7EI0MPi3BviGS0qGEyyinit78TToNck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 273/388] mfd: stmfx: Reset chip on resume as supply was disabled
Date:   Wed, 17 Jun 2020 21:06:10 -0400
Message-Id: <20200618010805.600873-273-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

[ Upstream commit e583649d87ec090444aa5347af0927cd6e8581ae ]

STMFX supply is disabled during suspend. To avoid a too early access to
the STMFX firmware on resume, reset the chip and wait for its firmware to
be loaded.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 857991cb3cbb..fde6541e347c 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -501,6 +501,13 @@ static int stmfx_resume(struct device *dev)
 		}
 	}
 
+	/* Reset STMFX - supply has been stopped during suspend */
+	ret = stmfx_chip_reset(stmfx);
+	if (ret) {
+		dev_err(stmfx->dev, "Failed to reset chip: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_raw_write(stmfx->map, STMFX_REG_SYS_CTRL,
 			       &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
 	if (ret)
-- 
2.25.1

