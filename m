Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5D206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Tptn7ggY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgFDVaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:30:51 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8951FC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:30:51 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 333D122708;
        Thu,  4 Jun 2020 23:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591306249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Hu99ss9oTQ7LnLqOoe3fAITii0LfZbanya/jMFkUIY=;
        b=Tptn7ggY73OR1BeJvQxcdMe2R0MU1SMjIhIrGd2OJ+4HHHKcUEXyNpOGrLL8D08Oy6sLZ2
        54xuFIC3KBxF8EMsAiN6bqb8CstckFJaASyic5LfGdZiQd3cEskW+lBj3rvUulVqs7hm9l
        lkNNAdyl0hwUJwmdZJMHS7kBd0peojU=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Gene Chen <gene.chen.richtek@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mfd: mfd-core: Don't overwrite the dma_mask of the child device
Date:   Thu,  4 Jun 2020 23:30:37 +0200
Message-Id: <20200604213037.17254-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cdfee5623290 ("driver core: initialize a default DMA mask for
platform device") initialize the DMA of a platform device. But if the
parent doesn't have a dma_mask set, for example if it's an I2C device,
the dma_mask of the child platform device will be set to zero again.
Which leads to many "DMA mask not set" warnings, if the MFD cell has the
of_compatible property set.

[    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
[    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
[    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set

Thus don't overwrite the dma_mask of the children. Instead set the
dma_mask of the platform device.

Signed-off-by: Michael Walle <michael@walle.cc>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
---
Former discussion was here:
https://lore.kernel.org/lkml/20200423174543.17161-3-michael@walle.cc/

Because my MFD driver now uses of_platform_populate() it doesn't trigger
this anymore. But it may be useful for others, e.g. if I'm not mistaken it
should apply to the mt6360 sub devices.

Thus I'm submitting this patch seperately.

 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd4..e735565969b3 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -138,7 +138,7 @@ static int mfd_add_device(struct device *parent, int id,
 
 	pdev->dev.parent = parent;
 	pdev->dev.type = &mfd_dev_type;
-	pdev->dev.dma_mask = parent->dma_mask;
+	pdev->platform_dma_mask = parent->dma_mask ? *parent->dma_mask : 0;
 	pdev->dev.dma_parms = parent->dma_parms;
 	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
-- 
2.20.1

