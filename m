Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D96D20663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443437;
	bh=Jiv2L8x1UrhUVZJ3+GJukZ7OLVFFYw+CmLuVM0LVPtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hyJdu8uU4813qa7C5A6Zj4QkLI9o7N022S+8M6/Fopv2vZiAcjcVN/8xvOq0YuUko
	 erOUjYoK1E0Fl8+XMoPLmvTAXAWAbzu5Rwd/JREoF3ICy1hscspyAu4d9AObusuMQ8
	 PZg53C84K5BLAsFLjJTQ45rbJZVOpxif0N4EcX0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgFRBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgFRBUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF3A20776;
        Thu, 18 Jun 2020 01:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443236;
        bh=Jiv2L8x1UrhUVZJ3+GJukZ7OLVFFYw+CmLuVM0LVPtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgBPV2dP1cCZ23w9s9eJ4Ktj9iXi7h1MnRLVjQtV+qpwp2sDs/svrsufYygLa5mId
         hkx8ZPk/Y2ZJKWOlEfKZvUQkx4zlOpqr25CeB/+mcaZpoEofA2jFqpUMFGS6H7wkub
         GQOde/a+68vUh4/lyONrPMr81Tv2kGvEx0+6wsyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 188/266] mfd: stmfx: Disable IRQ in suspend to avoid spurious interrupt
Date:   Wed, 17 Jun 2020 21:15:13 -0400
Message-Id: <20200618011631.604574-188-sashal@kernel.org>
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

[ Upstream commit 97eda5dcc2cde5dcc778bef7a9344db3b6bf8ef5 ]

When STMFX supply is stopped, spurious interrupt can occur. To avoid that,
disable the interrupt in suspend before disabling the regulator and
re-enable it at the end of resume.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c       | 6 ++++++
 include/linux/mfd/stmfx.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 1977fe95f876..711979afd90a 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -296,6 +296,8 @@ static int stmfx_irq_init(struct i2c_client *client)
 	if (ret)
 		goto irq_exit;
 
+	stmfx->irq = client->irq;
+
 	return 0;
 
 irq_exit:
@@ -486,6 +488,8 @@ static int stmfx_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	disable_irq(stmfx->irq);
+
 	if (stmfx->vdd)
 		return regulator_disable(stmfx->vdd);
 
@@ -529,6 +533,8 @@ static int stmfx_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	enable_irq(stmfx->irq);
+
 	return 0;
 }
 #endif
diff --git a/include/linux/mfd/stmfx.h b/include/linux/mfd/stmfx.h
index 3c67983678ec..744dce63946e 100644
--- a/include/linux/mfd/stmfx.h
+++ b/include/linux/mfd/stmfx.h
@@ -109,6 +109,7 @@ struct stmfx {
 	struct device *dev;
 	struct regmap *map;
 	struct regulator *vdd;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct mutex lock; /* IRQ bus lock */
 	u8 irq_src;
-- 
2.25.1

