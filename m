Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E1CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F026B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597251034;
	bh=gVGb7sNLAIhYGstS5KXbZV0W+9i8eM/O/IElQDO4KD8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XZHheGewtQR+VT0dzZNK3te0DYMH1aGQlQhbfGYbtKtho8/tPM2NZelYXj6lMflDt
	 THZu7aJk98PzuG2xUdcBK8RjrcTHKPDS+4R+hxHxDt/wUdtvAfQ0Izv9/pHy6WRM8g
	 nYrAw4WePXQyVfH4F3C9jVy5P1hn2k8WrG2R6/EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHLQud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgHLQu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:50:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B669220656;
        Wed, 12 Aug 2020 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597251027;
        bh=gVGb7sNLAIhYGstS5KXbZV0W+9i8eM/O/IElQDO4KD8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GmCsmViBy3cFQonjqfXChi01zLz8Q7zRvYeJNOWRoUtIiiYVFoVO0pDTXdb/IYEeE
         z13mHBrxwlr5IMeumXxeQMmPzHiLrPmtHeLP/OHB4qTZQACqE7y6/m0COztF7eVFcW
         SVJW7nMMEfPZdjExOC2qWhKpe5rYT//LSQDrtO3w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 13/13] extcon: ptn5150: Convert to .probe_new
Date:   Wed, 12 Aug 2020 18:50:13 +0200
Message-Id: <20200812165013.2699-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812165013.2699-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
 <20200812165013.2699-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'struct i2c_device_id' argument of probe function is not used, so
convert the driver to simpler 'probe_new' interface.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 559e26214f48..e9585e870fe9 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -219,8 +219,7 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 	return 0;
 }
 
-static int ptn5150_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *id)
+static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct device_node *np = i2c->dev.of_node;
@@ -335,7 +334,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
 		.name	= "ptn5150",
 		.of_match_table = ptn5150_dt_match,
 	},
-	.probe	= ptn5150_i2c_probe,
+	.probe_new	= ptn5150_i2c_probe,
 	.id_table = ptn5150_i2c_id,
 };
 module_i2c_driver(ptn5150_i2c_driver);
-- 
2.17.1

