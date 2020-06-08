Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E4BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2820801
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661756;
	bh=V+vcCCtE8fOBO6vP1/kpuBe7xlqLjt8XpmsrNP0SSZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSQmU23ULaNlmA8SXuqUx2tDEnCe7A1NPvPLnWxpKpsKVtqxep6MECyHa6fh8h8pk
	 HxclhWUJ0T5lo7DXv7saEbcOVvnlTIflz4IZgxf4aZtaXlrQxpZFTR/FMVCbF6mux/
	 G5tejL9PhZIYmyOW3nJvMYea5litTTzi4P1Shhf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgFIAP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgFHXTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:19:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED1F2083E;
        Mon,  8 Jun 2020 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658341;
        bh=V+vcCCtE8fOBO6vP1/kpuBe7xlqLjt8XpmsrNP0SSZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VB2E25tpmx+0t79c7yTgGKMDcA0rDpaE482z8dBXweHA4QLZTw2Sa0ZcoSKstEVmT
         StbHUJVuQcSEiLt2a+B7cpeUmqpl4j2aT6XRk+i2TdD8exyfA1kbuMNBwcvomIuD0k
         TMbZLSiHsRFaD53A82qSlu36+QBI/P7zLA1BNpnA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 010/175] media: vicodec: Fix error codes in probe function
Date:   Mon,  8 Jun 2020 19:16:03 -0400
Message-Id: <20200608231848.3366970-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f36592e7b343d853edf44d3545bb68961c0949a4 ]

If these functions fail then we return success, but we should instead
preserve negative error code and return that.

Fixes: fde649b418d1 ("media: vicodec: Register another node for stateless decoder")
Fixes: c022a4a95722 ("media: vicodec: add struct for encoder/decoder instance")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vicodec/vicodec-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 82350097503e..84ec36156f73 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -2172,16 +2172,19 @@ static int vicodec_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-	if (register_instance(dev, &dev->stateful_enc,
-			      "stateful-encoder", true))
+	ret = register_instance(dev, &dev->stateful_enc, "stateful-encoder",
+				true);
+	if (ret)
 		goto unreg_dev;
 
-	if (register_instance(dev, &dev->stateful_dec,
-			      "stateful-decoder", false))
+	ret = register_instance(dev, &dev->stateful_dec, "stateful-decoder",
+				false);
+	if (ret)
 		goto unreg_sf_enc;
 
-	if (register_instance(dev, &dev->stateless_dec,
-			      "stateless-decoder", false))
+	ret = register_instance(dev, &dev->stateless_dec, "stateless-decoder",
+				false);
+	if (ret)
 		goto unreg_sf_dec;
 
 #ifdef CONFIG_MEDIA_CONTROLLER
-- 
2.25.1

