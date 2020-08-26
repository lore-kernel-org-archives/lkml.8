Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E998C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526AE2224D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453411;
	bh=Ll4xsfiXa6dFreMGmr8jn0xtDKD1luWEnl5tzrpEESQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nUave23WMNzLVJ95DA8qc5jsbQJGvZh7/ymfvHW3nPO+aPPtllvHbKzyIUo5LJd7I
	 NYS/49a0YIG0Wi5u+vWECQrmo61IJQN8ehHVPywp6xw1aJS05ZCbu7ygydZts7Q/mm
	 WIO5SU7qfPMcP+9Seu/X4LZqPW0cdcnfO4qjwbEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHZOuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbgHZOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E6B22B3F;
        Wed, 26 Aug 2020 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453386;
        bh=Ll4xsfiXa6dFreMGmr8jn0xtDKD1luWEnl5tzrpEESQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmkqytJ1uLO963Cue4uNLvLBqkcqbxwCNpO+LlZadCR2QQapaEbddrJcUTfClnrue
         ZbzdsVKMUFNFQTsmFGInc/detcyLH99Z0e9tomw1/7P67wWWT5rz5Q2aE66BP5fbgL
         i1z4oOIkhjMBYuRov1to802Suxp4iT3qfLbV/m3E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] mfd: wcd934x: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:49:35 +0200
Message-Id: <20200826144935.10067-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144935.10067-1-krzk@kernel.org>
References: <20200826144935.10067-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/wcd934x.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index da910302d51a..c274d733b656 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -219,12 +219,9 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 		return	-ENOMEM;
 
 	ddata->irq = of_irq_get(np, 0);
-	if (ddata->irq < 0) {
-		if (ddata->irq != -EPROBE_DEFER)
-			dev_err(ddata->dev, "Failed to get IRQ: err = %d\n",
-				ddata->irq);
-		return ddata->irq;
-	}
+	if (ddata->irq < 0)
+		return dev_err_probe(ddata->dev, ddata->irq,
+				     "Failed to get IRQ\n");
 
 	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
 	if (reset_gpio < 0) {
-- 
2.17.1

