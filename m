Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F32C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88487206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597757791;
	bh=2qNEoE6XtmSILCN5KRmGGUpLPbT+yPlnrqcOhfIc3W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r5+Ch/qS3F+wGnaWwhdFFkAMbYwXbE1pWqROXNjmhAaIYvahHJGR33TMTmuiomjSz
	 n2b02hh51dzNUQlahDTaMje7D6lOyeM34tXhz1MPMS7IKkOcVmdXED8E2xLDMM+edI
	 ZIJO7IcA6VISkmRSEd5PMEscB81crw2rk61+DCHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHRNga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgHRNgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:36:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B9C206B5;
        Tue, 18 Aug 2020 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597757766;
        bh=2qNEoE6XtmSILCN5KRmGGUpLPbT+yPlnrqcOhfIc3W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZQ4Mt8657P5Q7xQHrXf5KB4fKiKgT31lIxOWkCBP6NODeeQP3J6JXMeF5nKTt4wR
         vOedWGnSPhqN748Ny/3iUis0aGOfaMc2EQ57cf1mFe2TOr6hsCzrDmYFPD0vRocNOw
         A7daa75r0SWNAcoUilOURRm93keMjV0cvHaXKbys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] media: radio: si476x: no need to check return value of debugfs_create functions
Date:   Tue, 18 Aug 2020 15:36:07 +0200
Message-Id: <20200818133608.462514-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818133608.462514-1-gregkh@linuxfoundation.org>
References: <20200818133608.462514-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/radio/radio-si476x.c | 66 ++++++------------------------
 1 file changed, 13 insertions(+), 53 deletions(-)

diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index b203296de977..485b2d2d977d 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -1344,60 +1344,24 @@ static const struct file_operations radio_rsq_primary_fops = {
 };
 
 
-static int si476x_radio_init_debugfs(struct si476x_radio *radio)
+static void si476x_radio_init_debugfs(struct si476x_radio *radio)
 {
-	struct dentry	*dentry;
-	int		ret;
+	radio->debugfs = debugfs_create_dir(dev_name(radio->v4l2dev.dev), NULL);
 
-	dentry = debugfs_create_dir(dev_name(radio->v4l2dev.dev), NULL);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto exit;
-	}
-	radio->debugfs = dentry;
-
-	dentry = debugfs_create_file("acf", S_IRUGO,
-				     radio->debugfs, radio, &radio_acf_fops);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto cleanup;
-	}
+	debugfs_create_file("acf", S_IRUGO, radio->debugfs, radio,
+			    &radio_acf_fops);
 
-	dentry = debugfs_create_file("rds_blckcnt", S_IRUGO,
-				     radio->debugfs, radio,
-				     &radio_rds_blckcnt_fops);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto cleanup;
-	}
+	debugfs_create_file("rds_blckcnt", S_IRUGO, radio->debugfs, radio,
+			    &radio_rds_blckcnt_fops);
 
-	dentry = debugfs_create_file("agc", S_IRUGO,
-				     radio->debugfs, radio, &radio_agc_fops);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto cleanup;
-	}
+	debugfs_create_file("agc", S_IRUGO, radio->debugfs, radio,
+			    &radio_agc_fops);
 
-	dentry = debugfs_create_file("rsq", S_IRUGO,
-				     radio->debugfs, radio, &radio_rsq_fops);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto cleanup;
-	}
+	debugfs_create_file("rsq", S_IRUGO, radio->debugfs, radio,
+			    &radio_rsq_fops);
 
-	dentry = debugfs_create_file("rsq_primary", S_IRUGO,
-				     radio->debugfs, radio,
-				     &radio_rsq_primary_fops);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto cleanup;
-	}
-
-	return 0;
-cleanup:
-	debugfs_remove_recursive(radio->debugfs);
-exit:
-	return ret;
+	debugfs_create_file("rsq_primary", S_IRUGO, radio->debugfs, radio,
+			    &radio_rsq_primary_fops);
 }
 
 
@@ -1534,11 +1498,7 @@ static int si476x_radio_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	rval = si476x_radio_init_debugfs(radio);
-	if (rval < 0) {
-		dev_err(&pdev->dev, "Could not create debugfs interface\n");
-		goto exit;
-	}
+	si476x_radio_init_debugfs(radio);
 
 	return 0;
 exit:
-- 
2.28.0

