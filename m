Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1CEC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523FB222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="EBaUbOvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCJXJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:09:54 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46611 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJXJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:09:53 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 88EFD23E76;
        Wed, 11 Mar 2020 00:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583881790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LdXbv3uElz5yQ5qGjxhsqm0U2lY05oTqfEXnfYIHMz8=;
        b=EBaUbOvIfKodPUEguZcuPIKEw1o7IPARUaZHCLEDdGGbzV9pgOXIcrsnTPxVyxkKVTzMWm
        zSIkvieCuDuHiLrqpx9fzACg5r+sdU/+e4nK8SMjKvhpl/Qe1MIz4orUWaigbbrfr6awsY
        hDK7YzdcBVlmOyFODj7Rzf356IOjA/A=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Michael Walle <michael@walle.cc>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [RFC PATCH] mfd: mfd-core: inherit only valid dma_masks/flags from parent
Date:   Wed, 11 Mar 2020 00:09:35 +0100
Message-Id: <20200310230935.23962-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 88EFD23E76
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.530];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only copy the dma_masks and flags from the parent device, if the parent
has a valid dma_mask/flags. Commit cdfee5623290 ("driver core:
initialize a default DMA mask for platform device") initialize the DMA
masks of a platform device. But if the parent doesn't have a dma_mask
set, for example if it's an I2C device, the dma_mask of the child
platform device will be set to zero again. Which leads to many "DMA mask
not set" warnings, if the MFD cell has the of_compatible property set.

[    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
[    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
[    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set

Thus a MFD child should just inherit valid dma_masks and keep the
platform default otherwise.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Michael Walle <michael@walle.cc>
---

Hi,

I don't know if that is the correct way of handling things. Maybe I'm
also doing something wrong in my driver, I had a look at other I2C MFD
drivers but couldn't find a clue why they shouldn't have the same
problem.

There was also a thread [1] about this topic, but there seems to be no
conclusion.

[1] https://www.spinics.net/lists/linux-renesas-soc/msg31581.html

 drivers/mfd/mfd-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index b9eb8f40c073..5d8ea5e8e93c 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -139,9 +139,12 @@ static int mfd_add_device(struct device *parent, int id,
 
 	pdev->dev.parent = parent;
 	pdev->dev.type = &mfd_dev_type;
-	pdev->dev.dma_mask = parent->dma_mask;
-	pdev->dev.dma_parms = parent->dma_parms;
-	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
+	if (parent->dma_mask)
+		pdev->dev.dma_mask = parent->dma_mask;
+	if (parent->dma_parms)
+		pdev->dev.dma_parms = parent->dma_parms;
+	if (parent->coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
 	ret = regulator_bulk_register_supply_alias(
 			&pdev->dev, cell->parent_supplies,
-- 
2.20.1

