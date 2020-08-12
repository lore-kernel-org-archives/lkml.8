Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F3B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597251031;
	bh=d1y8d3X6Gye9u0mJ4HY9FyhQltB7BnKNoY+bges04bM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8nMignRxSgkjn/TZdZbITlajonJiLpx9fGpVDYJ3CM3yb3A7r2LD6hYHbd5OglxY
	 bUGtxko4QoX/hSv0kBx8BCe0JU6c06ZWFQGw3kaaYiWxtqoNHXu/PYZW/b15Beemmi
	 CyVRl9xTbHAof7I1lq/KQK+77gcQKMSyFdmyOQrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHLQu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgHLQuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:50:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888F120855;
        Wed, 12 Aug 2020 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597251025;
        bh=d1y8d3X6Gye9u0mJ4HY9FyhQltB7BnKNoY+bges04bM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PX4jmO9MFdaiJBkxcMih7RufEkrYLFe0hl5m9P8OUxLZV4ANSWqzllpQEhplARfQc
         l5JwpGAEMZWME4399yM7jNCVdtZTc/LK6MOSmx0IhceM2LRonj3V3oH8OyOTnSDjD9
         z3y1ADNYzBFlpv2s3pDVRjC5hbcAyTa+ksVQ0VJg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 12/13] extcon: ptn5150: Convert to module_i2c_driver
Date:   Wed, 12 Aug 2020 18:50:12 +0200
Message-Id: <20200812165013.2699-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use module_i2c_driver() to simplify driver init boilerplate.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index fd9723f86d55..559e26214f48 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -338,12 +338,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
 	.probe	= ptn5150_i2c_probe,
 	.id_table = ptn5150_i2c_id,
 };
-
-static int __init ptn5150_i2c_init(void)
-{
-	return i2c_add_driver(&ptn5150_i2c_driver);
-}
-subsys_initcall(ptn5150_i2c_init);
+module_i2c_driver(ptn5150_i2c_driver);
 
 MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
 MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
-- 
2.17.1

