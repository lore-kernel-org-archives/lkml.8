Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C120732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052237;
	bh=Cu0bIJ+vz5khx9IVzUJPi8H2/VKCJ3eiUPqW2uMzAk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcGIkoV7j/0f+slqznIfa7qBIUoF0rYDexvIhXlVwT/9oeEZw3HjT2AlpVrvRY5/x
	 aChZ+42oC/fdej8T3OVftTEHJVvifhgdfRbWpp7F/6Rpn2nyorpmePvt2irAIApRts
	 EwL04vJn3475CCyfwoczkLgfmWlTwG+Wt3WvOiTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442770AbgDPPud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896666AbgDPNdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA5922272;
        Thu, 16 Apr 2020 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043966;
        bh=Cu0bIJ+vz5khx9IVzUJPi8H2/VKCJ3eiUPqW2uMzAk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eczbtQDQd4XkxoLvpxYYBjdPpvUoN7jQ+lQyhOcqRqvi7X2tiec1WQ5tfNIEIB+7y
         DJB+vDwqOqcbgOajEOeu2G9UXPZn60yQ7sy2OcT8YpbZwzNVfLBFCMjc7LvC18SoPf
         w15aFpuEBySgOmaM+1FrQdXdGOrq3vBtX6EVsmLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 026/257] i2c: pca-platform: Use platform_irq_get_optional
Date:   Thu, 16 Apr 2020 15:21:17 +0200
Message-Id: <20200416131329.216587875@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 14c1fe699cad9cb0acda4559c584f136d18fea50 ]

The interrupt is not required so use platform_irq_get_optional() to
avoid error messages like

  i2c-pca-platform 22080000.i2c: IRQ index 0 not found

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pca-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index a7a81846d5b1d..635dd697ac0bb 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -140,7 +140,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	int ret = 0;
 	int irq;
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	/* If irq is 0, we do polling. */
 	if (irq < 0)
 		irq = 0;
-- 
2.20.1



