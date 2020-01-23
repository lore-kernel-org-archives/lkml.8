Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF1C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32D520665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAWAZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 19:25:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52510 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgAWAZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 19:25:55 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iuQJl-000436-Es; Thu, 23 Jan 2020 00:25:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds1wm: fix spelling mistake "to" -> "too"
Date:   Thu, 23 Jan 2020 00:25:52 +0000
Message-Id: <20200123002552.2832419-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/w1/masters/ds1wm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index f661695fb589..39c66d9093c2 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -548,7 +548,7 @@ static int ds1wm_probe(struct platform_device *pdev)
 	/* make sure resource has space for 8 registers */
 	if ((8 << ds1wm_data->bus_shift) > resource_size(res)) {
 		dev_err(&ds1wm_data->pdev->dev,
-			"memory resource size %d to small, should be %d\n",
+			"memory resource size %d too small, should be %d\n",
 			(int)resource_size(res),
 			8 << ds1wm_data->bus_shift);
 		return -EINVAL;
-- 
2.24.0

