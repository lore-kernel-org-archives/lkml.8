Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D744AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4996221F8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445739;
	bh=URc4789k/5yNLxNApylXOdyYnfGKoDQJ73exVVOeipg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mthFwWnZLNb3p02Kh/OsfOWKxAdvoVjlVG/dEvE7x1OC+6LgUjSqiiSc1hLlIS6ii
	 J+7MI89o2200eX9nqZN2cu9cG+7R+yu4ib30WDGcPSsThwG8s8YHKa5GGkkDilqTti
	 TPUb+wwoYZB0wnkImdofkgl2ot95NWJdu8xKK230=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgFRBXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbgFRBUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7D720CC7;
        Thu, 18 Jun 2020 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443233;
        bh=URc4789k/5yNLxNApylXOdyYnfGKoDQJ73exVVOeipg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6BRTPGJoDFLFemKW65fpcDaOzdAKzHU7h/5zTeDa5g+mtVbfD5/ZYSeqZsWwouyK
         DTuzm4O7PUn+7TSjRzz6FF1mk4mkzA6LzG6y9L0LSsCXj8lT5xeKEibAzyn1c0HOu7
         gn+ixbTRVitHE/NnJwEvOn820bsFc1r2srJ32s/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 186/266] mfd: stmfx: Reset chip on resume as supply was disabled
Date:   Wed, 17 Jun 2020 21:15:11 -0400
Message-Id: <20200618011631.604574-186-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
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

