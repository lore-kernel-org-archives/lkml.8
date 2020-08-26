Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17588C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77092078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453468;
	bh=rf7zsP6dACnKfYBm9zRmVe9qedTxdc/aAmPH+PZPZZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BRfIR4RI15FN736l+cSZArG6f51f2n5BpwYR/MdnGZwoZp0GcMOKCBLVd/P6QcRU0
	 1UXTE1RHDI1Vw7SY/lWOuB8GkbKoYNB/Gj8rAF4QI3/kLnnK8AcpXaBo29scWQHWdj
	 yjr73ZbuFK9WSX0+ZSLrosJot9ZOc96K/mL9tgio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgHZOuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgHZOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 859FF21741;
        Wed, 26 Aug 2020 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453383;
        bh=rf7zsP6dACnKfYBm9zRmVe9qedTxdc/aAmPH+PZPZZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9Xiglad3I74ATAeJSFUx4soE1XJFBfIApc63HcQhhtLj7XmewZG5doK5QdqT1aIT
         OFE6+VAxfJMgJSmeBVZn7XXhGTdI0pKt1UQt9H5IOW4lupScq5ZhHckGhZ8Z2z4GOS
         3XY6HI9kEePSFWod5449v5PbX+s/Fdsk3B6PdaFA=
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
Subject: [PATCH 2/3] mfd: stmfx: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:49:34 +0200
Message-Id: <20200826144935.10067-2-krzk@kernel.org>
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
 drivers/mfd/stmfx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 711979afd90a..5e680bfdf5c9 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -331,11 +331,9 @@ static int stmfx_chip_init(struct i2c_client *client)
 	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
 	if (ret == -ENODEV) {
 		stmfx->vdd = NULL;
-	} else if (ret == -EPROBE_DEFER) {
-		return ret;
-	} else if (ret) {
-		dev_err(&client->dev, "Failed to get VDD regulator: %d\n", ret);
-		return ret;
+	} else {
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get VDD regulator\n");
 	}
 
 	if (stmfx->vdd) {
-- 
2.17.1

