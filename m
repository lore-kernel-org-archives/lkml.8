Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0883C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E2C2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgALBzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 20:55:21 -0500
Received: from foss.arm.com ([217.140.110.172]:57784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731897AbgALBzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 20:55:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C452FDA7;
        Sat, 11 Jan 2020 17:55:19 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCCEB3F6C4;
        Sat, 11 Jan 2020 17:55:18 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: [PATCH v2 2/5] mfd: rk808: Ensure suspend/resume hooks always work
Date:   Sun, 12 Jan 2020 01:55:01 +0000
Message-Id: <e2cd9aa88c96f69fd931d606e0e70784c3020551.1578789410.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
References: <cover.1578789410.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK809/RK817 suspend/resume hooks should not have to depend on
whether this driver owns the pm_power_off hook, and thus the global
rk808_i2c_client is set - indeed, the GPIO-based control is really
only relevant when PSCI firmware is in charge of power rather than
the kernel. As driver model callbacks, they have an appropriate
device argument to hand, so can just always use that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 616e44e7ef98..ac798053c26a 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -712,7 +712,7 @@ static int rk808_remove(struct i2c_client *client)
 
 static int __maybe_unused rk8xx_suspend(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
 	int ret = 0;
 
 	switch (rk808->variant) {
@@ -732,7 +732,7 @@ static int __maybe_unused rk8xx_suspend(struct device *dev)
 
 static int __maybe_unused rk8xx_resume(struct device *dev)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
 	int ret = 0;
 
 	switch (rk808->variant) {
-- 
2.17.1

