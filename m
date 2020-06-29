Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B24AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC2A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461441;
	bh=W1eadARlGahJjOg5KrWyJCvs5DwkTNwLFWf11lo/REc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7Rn7XdAR02NGbVCovBxF+MQqHZ9U3II4NKm0knPRfM+knItAfw8t6gIdnfCSXIv2
	 TCdYbznshaxcog39q18G/6iTNU2oE0OAdaIFhc6zH8XaCmUoubgg0feiJ3ljWgzNe/
	 tgkpVUV95+rGScLgXtUV/Li0s/nn278Qt+4LBo/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgF2UKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732909AbgF2TaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A272527C;
        Mon, 29 Jun 2020 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444990;
        bh=W1eadARlGahJjOg5KrWyJCvs5DwkTNwLFWf11lo/REc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOnpUs+wwNlp6tw6UyaQHLk52QxsMVOCIVVqQTZzT7n6f5LQcCH/2wD2fpvGh9pm6
         Uzn9pnMIaO5A8cmVXdm3+IrkX0myLRoJTFukimQ4KRqaCzMEhTPuUDe/LuBHkqjhNW
         4WZfqZ+YiNQBqxCI5c8Y07xtE/+9N50otBEusY9w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 090/131] sata_rcar: handle pm_runtime_get_sync failure cases
Date:   Mon, 29 Jun 2020 11:34:21 -0400
Message-Id: <20200629153502.2494656-91-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit eea1238867205b9e48a67c1a63219529a73c46fd ]

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_rcar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 03867f539f3a8..50ebd779d975f 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -909,7 +909,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
-		goto err_pm_disable;
+		goto err_pm_put;
 
 	host = ata_host_alloc(dev, 1);
 	if (!host) {
@@ -940,7 +940,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-err_pm_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
@@ -994,8 +993,10 @@ static int sata_rcar_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	if (priv->type == RCAR_GEN3_SATA) {
 		sata_rcar_init_module(priv);
@@ -1020,8 +1021,10 @@ static int sata_rcar_restore(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	sata_rcar_setup_port(host);
 
-- 
2.25.1

