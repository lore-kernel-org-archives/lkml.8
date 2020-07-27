Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0FAC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46B1206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860503;
	bh=/0e8zbtjZG5O2Hxxhu69ogYtwdJgBKk1ewlVZTJgiZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G7wjKfRqtntMTui3T83PFajCmFD3PI7WN48CZmK2LB8fdznYEUVhlGHivdSdpkr3C
	 qqs0DUE5aRLEedViH8+f5/UcERg1scrgoTy4e6gt1goqkPYfMc+jI4lGBL15IM4yxG
	 mybnIQH1LsXz+PyCKCxSRSklhRNKeyMLKibfpbEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgG0OPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbgG0OP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:15:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F03B82078E;
        Mon, 27 Jul 2020 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859325;
        bh=/0e8zbtjZG5O2Hxxhu69ogYtwdJgBKk1ewlVZTJgiZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPlHDUWhdwfnzhK78110hYsE2FaP8SmMXHIz2WtpNJqeWb2kPvivhLH50MFIuhJKs
         hcII7lK+quhvSAITDfZn+3nq5D6y20C7vy7jThdH1L+bc7mVMUx4AxWf0aB1t4PHbg
         01ZWzKW+CmWPWXPDgdkncWDvxcWUPN7WCedyUFn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 064/138] i2c: rcar: always clear ICSAR to avoid side effects
Date:   Mon, 27 Jul 2020 16:04:19 +0200
Message-Id: <20200727134928.605270271@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit eb01597158ffb1853a7a7fc2c57d4c844640f75e ]

On R-Car Gen2, we get a timeout when reading from the address set in
ICSAR, even though the slave interface is disabled. Clearing it fixes
this situation. Note that Gen3 is not affected.

To reproduce: bind and undbind an I2C slave on some bus, run
'i2cdetect' on that bus.

Fixes: de20d1857dd6 ("i2c: rcar: add slave support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 531c01100b560..36af8fdb66586 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -865,6 +865,7 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 	/* disable irqs and ensure none is running before clearing ptr */
 	rcar_i2c_write(priv, ICSIER, 0);
 	rcar_i2c_write(priv, ICSCR, 0);
+	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	synchronize_irq(priv->irq);
 	priv->slave = NULL;
@@ -971,6 +972,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_pm_put;
 
+	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+
 	if (priv->devtype == I2C_RCAR_GEN3) {
 		priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 		if (!IS_ERR(priv->rstc)) {
-- 
2.25.1



