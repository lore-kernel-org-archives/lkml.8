Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D1C47409
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA60206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199460;
	bh=10IWbZKtLiSfkMg+zSvCP4zf9XlLcu8JzOFTXwphxRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sja09NNzaPMA2OOkxm6pha8FnRfIgK1WdkGcu7uSHEZFR3CfS0b3LQPVL9MPX3Zy2
	 esYtaLKmqrKDL+BCyldkKGQJ8TjSmiMd+NH0QIxarUnrBgOBD3GSw8vHRphO093mbW
	 oUx4N0Yh5tIQLpCW5A4o5uqjXD482eWLf87KDQ2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391959AbgAPRZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391897AbgAPRZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC949246A5;
        Thu, 16 Jan 2020 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195509;
        bh=10IWbZKtLiSfkMg+zSvCP4zf9XlLcu8JzOFTXwphxRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiLY2PX+oI0JI9kT8nIYBdeaSCF0wLOWxjtUWicri4GEZcKltI+px6HiEN9+RY1A1
         9H8dO1Y8g6skEf9HsXx1u7j9/k+QHOXFbf/vLjiKu3oME80ROjVHewDdB33UiQfDmt
         QQYztRNDDUaI8O9r+Kw13PP0rjf8OiTkH8VsKuDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 109/371] regulator: pv88090: Fix array out-of-bounds access
Date:   Thu, 16 Jan 2020 12:19:41 -0500
Message-Id: <20200116172403.18149-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit a5455c9159414748bed4678184bf69989a4f7ba3 ]

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: c90456e36d9c ("regulator: pv88090: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pv88090-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 7a0c15957bd0..2302b0df7630 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -157,7 +157,7 @@ static int pv88090_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 			return regmap_update_bits(rdev->regmap,
-- 
2.20.1

