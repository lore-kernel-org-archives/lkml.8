Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA0C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6384206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uwSjVicy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgIJKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgIJKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:15:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDDBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:15:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207so4939800ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mYpLRmqZZNbowlnMVp5aofFQ5BShHcephw2SKa0G+DA=;
        b=uwSjVicytfVIBYIjNeLQ0S++GaFHI6da2IvVQ1a7tPxuevmnOvVFRW8+HwjHJ8tZXr
         gXArB/ETfRlhFAbs/BrfA2takdMvL9pHyuWt2qVvc6kQBmwqpwARV3uCMCr+xAhyTxqd
         g4qiYBX3bwWmJWBPoys1yHgg23Qhhz4ZdhRrEpOqhFkVQYt1znuPerz2O+E3tUB/sair
         4v8jtMYMu2pN5SAU4Dwlfc6ztiLmgYkSUODfLiQWpI2810zlOOrm7rLNyts87EGr/3mZ
         N0H7ptJWMVDSBGZrNtiUZyfOMVC5FVb0HTQw4M3EyhEXv0Ueyq2+XZ95uw5qSyXE5kEs
         Gu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mYpLRmqZZNbowlnMVp5aofFQ5BShHcephw2SKa0G+DA=;
        b=ciLWXTyrdpSgXddgWaO9T+CCaNkpPdfqqxypAN/curEuAFJYCMMBLPBG9UX/1YSEZ4
         J48xwl43BDtaqjMQmhG144TfInOBJv85JzYowIhZZ15+FDoYhS5AOdH/VQwThb6osaYr
         FrBcg+M02AuMznCmuXsyEMz5/TqsT5CkI5oV2MAH2jMjMpbINo0WMYXvxUkfwCbpvlUP
         foH2ADVCEyr2ST7pH7oX9qI79xSoYpfCntdo6KkyLKLZw96A8sRjdjtkFTPaJqFkXO2V
         +RJCWduPpdOAvpEUd0qLBzPMIQRlJt25HJw+ogQB1UOb1a9bSe4VYRs7tw2gNLQ1r/q8
         63lA==
X-Gm-Message-State: AOAM531ZklM/ua09Cw41vy99QuJ+BBDqAWgMls0SFO1R4gNg4iTlb943
        KyiHoMZRhVaO2i2HYUIqw1Tz7uzmMmEPPzQwJmY=
X-Google-Smtp-Source: ABdhPJzATmV4RhOQNteGALkdPJ93cqcUh0oOS9eTKpZbNLT9tBvt6yJnMdaRqHNDDwBwIi8UrQjYI1T9+go2q3X89kg=
X-Received: from huangrandall-z840-2.tao.corp.google.com ([2401:fa00:fd:2:3e52:82ff:fe5f:bc1])
 (user=huangrandall job=sendgmr) by 2002:a25:da8c:: with SMTP id
 n134mr12091694ybf.84.1599732917609; Thu, 10 Sep 2020 03:15:17 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:15:13 +0800
Message-Id: <20200910101513.2900079-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] scsi: clear UAC before sending SG_IO
From:   Randall Huang <huangrandall@google.com>
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure UAC is clear before sending SG_IO.

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 drivers/scsi/sg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630..ad11bca47ae8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -922,6 +922,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 	int result, val, read_only;
 	Sg_request *srp;
 	unsigned long iflags;
+	int _cmd;
 
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
 				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
@@ -933,6 +934,13 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 			return -ENODEV;
 		if (!scsi_block_when_processing_errors(sdp->device))
 			return -ENXIO;
+
+		_cmd = SCSI_UFS_REQUEST_SENSE;
+		if (sdp->device->host->wlun_clr_uac) {
+			sdp->device->host->hostt->ioctl(sdp->device, _cmd, NULL);
+			sdp->device->host->wlun_clr_uac = false;
+		}
+
 		result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
 				 1, read_only, 1, &srp);
 		if (result < 0)
