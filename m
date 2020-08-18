Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C85C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DBE206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597757806;
	bh=RVyDQEUwJhH5RMxRj5OKU9DVJFQceIMcBQHgKS2zs18=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AgcbQ2lvYRWUnTD9Hgt5ihDr/xAaFYinfeTXoO6Nxvg/Mnj/+RCbfEgXQnk6uLMI9
	 Z0J2y5tFFJ1yYfprIDCdU8B+FsPplaPlKgJCUzMgxRPuimKzDWlfWZCyepE3c09Rob
	 rXwVCMY/d6rJe+NpSeJgBwXRNpKyEFAYLUiBW4nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgHRNgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgHRNgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:36:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E04206B5;
        Tue, 18 Aug 2020 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597757799;
        bh=RVyDQEUwJhH5RMxRj5OKU9DVJFQceIMcBQHgKS2zs18=;
        h=From:To:Cc:Subject:Date:From;
        b=uaWb7VGKd1fYgkjVJUmdfBjhxrVAdaDQjIuUbJJ73gKChdu5JPpQ/t/HWbAitbrX3
         CbVGmydUQhSvUOdhlB2RPrEvAqTJOC9enWxZDJXBCAzoCsiZwxSa5Nqw9QruXMppfM
         Q5JEVn1CGGYdE922AyTubfSJR9KtZKdvtk5w4Vj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: dbx500: no need to check return value of debugfs_create functions
Date:   Tue, 18 Aug 2020 15:37:01 +0200
Message-Id: <20200818133701.462958-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/dbx500-prcmu.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index c3ad6aa6b5d3..7395ad2105ab 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -67,8 +67,6 @@ static int power_state_active_get(void)
 
 static struct ux500_regulator_debug {
 	struct dentry *dir;
-	struct dentry *status_file;
-	struct dentry *power_state_cnt_file;
 	struct dbx500_regulator_info *regulator_array;
 	int num_regulators;
 	u8 *state_before_suspend;
@@ -117,22 +115,14 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 {
 	/* create directory */
 	rdebug.dir = debugfs_create_dir("ux500-regulator", NULL);
-	if (!rdebug.dir)
-		goto exit_no_debugfs;
 
 	/* create "status" file */
-	rdebug.status_file = debugfs_create_file("status",
-		S_IRUGO, rdebug.dir, &pdev->dev,
-		&ux500_regulator_status_fops);
-	if (!rdebug.status_file)
-		goto exit_destroy_dir;
+	debugfs_create_file("status", S_IRUGO, rdebug.dir, &pdev->dev,
+			    &ux500_regulator_status_fops);
 
 	/* create "power-state-count" file */
-	rdebug.power_state_cnt_file = debugfs_create_file("power-state-count",
-		S_IRUGO, rdebug.dir, &pdev->dev,
-		&ux500_regulator_power_state_cnt_fops);
-	if (!rdebug.power_state_cnt_file)
-		goto exit_destroy_status;
+	debugfs_create_file("power-state-count", S_IRUGO, rdebug.dir,
+			    &pdev->dev, &ux500_regulator_power_state_cnt_fops);
 
 	rdebug.regulator_array = regulator_info;
 	rdebug.num_regulators = num_regulators;
@@ -150,11 +140,7 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 exit_free:
 	kfree(rdebug.state_before_suspend);
 exit_destroy_power_state:
-	debugfs_remove(rdebug.power_state_cnt_file);
-exit_destroy_status:
-	debugfs_remove(rdebug.status_file);
-exit_destroy_dir:
-	debugfs_remove(rdebug.dir);
+	debugfs_remove_recursive(rdebug.dir);
 exit_no_debugfs:
 	dev_err(&pdev->dev, "failed to create debugfs entries.\n");
 	return -ENOMEM;
-- 
2.28.0

