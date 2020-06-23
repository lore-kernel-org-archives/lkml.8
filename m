Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ABAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E70207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933770;
	bh=nEt41+L6I/iykkT5L7QHCFrEli9hUrXRjbuM6cER2BY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aaGRtjCv1adcjr2ajSeT/orhCPHN4lWDxij47NSz1tL0l9PGKIPVFdH3RtuF3+T6q
	 zTor42vX16qTp8RZR1ODc8J2JC38O5iTruDykFfoc4VIgjeOhaOf0w0Eb8ULKyflCO
	 1cPXbODqfpiVh03/GdcoJrSlfXnn9ivIb9d+X+pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbgFWRgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbgFWRgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989C420780;
        Tue, 23 Jun 2020 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933761;
        bh=nEt41+L6I/iykkT5L7QHCFrEli9hUrXRjbuM6cER2BY=;
        h=From:To:Cc:Subject:Date:From;
        b=vXY2LqE1m5QSo0+lIpBrzJobQB6O1LZ818P2HByFAxoCm2X22xhAch9qWpzCuNYtI
         CHJdvTgfz8GUHSMi37WsbGi56lOH2kJk59u2T1Ip+8ZKilnMYC8N63Gp/WANIdDZ/a
         SsPAWoKOqJL8sbRtfFeQePQ1K4K5SHs7qP3xNPJg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/24] sata_rcar: handle pm_runtime_get_sync failure cases
Date:   Tue, 23 Jun 2020 13:35:36 -0400
Message-Id: <20200623173559.1355728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
index 3495e1733a8e6..c35b7b993133e 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -905,7 +905,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
-		goto err_pm_disable;
+		goto err_pm_put;
 
 	host = ata_host_alloc(dev, 1);
 	if (!host) {
@@ -935,7 +935,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-err_pm_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
@@ -989,8 +988,10 @@ static int sata_rcar_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	if (priv->type == RCAR_GEN3_SATA) {
 		sata_rcar_init_module(priv);
@@ -1015,8 +1016,10 @@ static int sata_rcar_restore(struct device *dev)
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

