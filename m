Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD84C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FC2222E7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159032;
	bh=uB/nrNTc33V1p9MjKZ2UT3WMBnL+IeRKZpIjZGkr7aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qY+Z6GUYrObw9UWf0IGsT/RvmkN7Al5002U7kqrcV1GO/LVh6hTlHNf6MKgeGwcoD
	 9btO9cckaeHLw6pUmdoML45KFG/D5AwZxP/wiTshOsuP8LItZMkP4h5kGL6BJvnLCK
	 rgAAPOKub2Sd358mH/ivduVtQV3VGbXe8kd1/1Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgEVOuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgEVOu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAB22145D;
        Fri, 22 May 2020 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159025;
        bh=uB/nrNTc33V1p9MjKZ2UT3WMBnL+IeRKZpIjZGkr7aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4Mx2Ui0UURwwV4IW/clbhLgK0q6SIMmlqQOqatwu1qmW5qSyoSAa3ZZvgGYCNR1A
         dP0L2bAjScVrHIzSk29TXYK+sKabZ0EZm5pGBUAFqPfcDBe5alzVMaIU6TzBcVci9T
         kQpl8pfBp+TOIJZ9MdKAOev/gOW9xaGj81qHbXcY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 23/41] usb: phy: twl6030-usb: Fix a resource leak in an error handling path in 'twl6030_usb_probe()'
Date:   Fri, 22 May 2020 10:49:40 -0400
Message-Id: <20200522144959.434379-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit f058764d19000d98aef72010468db1f69faf9fa0 ]

A call to 'regulator_get()' is hidden in 'twl6030_usb_ldo_init()'. A
corresponding put must be performed in the error handling path, as
already done in the remove function.

While at it, also move a 'free_irq()' call in the error handling path in
order to be consistent.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-twl6030-usb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index bfebf1f2e991..9a7e655d5280 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -377,7 +377,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	if (status < 0) {
 		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 			twl->irq1, status);
-		return status;
+		goto err_put_regulator;
 	}
 
 	status = request_threaded_irq(twl->irq2, NULL, twl6030_usb_irq,
@@ -386,8 +386,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	if (status < 0) {
 		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 			twl->irq2, status);
-		free_irq(twl->irq1, twl);
-		return status;
+		goto err_free_irq1;
 	}
 
 	twl->asleep = 0;
@@ -396,6 +395,13 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
 
 	return 0;
+
+err_free_irq1:
+	free_irq(twl->irq1, twl);
+err_put_regulator:
+	regulator_put(twl->usb3v3);
+
+	return status;
 }
 
 static int twl6030_usb_remove(struct platform_device *pdev)
-- 
2.25.1

