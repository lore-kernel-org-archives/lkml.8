Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF252250E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="DTrz2FM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgG2IFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2IFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:05:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D40FC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:05:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so6134104plz.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8J9alNt9j182Qo6m9IaWrfQJWEuKo3Ae7Fy1SBu7uw=;
        b=DTrz2FM1MLC8vGx39HW6Jry1xeb06rXJcHKnWh+HuCeMvKJ9oq5Vj4RrlidvaGX++A
         CQMgWwfIo31vSimiVcxkVJITMaIN0XU4JXi4jmbwP2V2bnlE1aSMxGyPB4TVGu3jmz4W
         zIyi0kLyPirkkU4SiR6KUMrZk1L0zn3+ciByG4fqqHGFONIbBiiXQ+20D71vihyoNfK+
         uioMps8mu8Qjn//jPrxkCphrELaxfnbsQvYmrst9tD06SDyfOs+ym9ur5u3fN0BzEzYu
         IOadSSCCdz+CjFhpRTXTCIGWO2820zzu+w3pthYtJ++F74jxIvf9Xa75Wefq31v+RqVz
         94Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8J9alNt9j182Qo6m9IaWrfQJWEuKo3Ae7Fy1SBu7uw=;
        b=VPWBvKJ00gz45S9sClhQ5sTFVSHpCsBDSoZUfKEhijnhH9L2KcdFMTnq9y6y8dmVBB
         S8omMkt2TxDM/YIiQGm19L//YV2Q+wTSEoeM7ga9gsHjxhIsD2cCiTZbZJZxryrQIHeO
         ybeqVM/kBm6n1sG/J3I8717kkVZKP0IdsgND1BLR2E3x6B2R2MTHyz1lpWGOyTltHMB3
         VV0VIJG9VMtj6EUCRllhS5/appewuf65A/sTwhXAL/MvRVIJJ8imz2JfxZ9+m2IT9djY
         SONZFgq1twc1elEZiNwb/VCVfAEZdfOas048bKOrj7r14FXUeoy7UWqTluqcGlxWHlMg
         dMng==
X-Gm-Message-State: AOAM533aTztqc5eefT6Ki51En9Y5HPE1wTUv6Mwrj2b9EToWwIIkP0zT
        zs4wHp941ggF+3YeyVtjgy0y8g==
X-Google-Smtp-Source: ABdhPJzp5tMn3uZPlfTXXh5uqofStWTTKRqKNv7x0hK6omQGXyLlQH5Pv7C20nQSSpcXNjFC/1qC4w==
X-Received: by 2002:a17:90a:1a83:: with SMTP id p3mr7912459pjp.113.1596009943908;
        Wed, 29 Jul 2020 01:05:43 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id a3sm1399383pgd.73.2020.07.29.01.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:05:43 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH v2] Staging: media: atomisp: Fixed a brace coding sytle issue
Date:   Wed, 29 Jul 2020 13:35:16 +0530
Message-Id: <20200729080516.2830-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728021518.19639-1-b18007@students.iitmandi.ac.in>
References: <20200728021518.19639-1-b18007@students.iitmandi.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed braces in 'if else' condition as it only consists of 
one line each and according to coding style rules , in this case 
the braces are not required.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
---
Change in -v2:
	-Removed space before ':' in subject line.
	-Added space before '<' in 'From' and 'Signed-off-by' line.
	-Added detailed description.

 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index f8d616f08b51..701de098cb29 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1828,11 +1828,10 @@ static int atomisp_streamon(struct file *file, void *fh,
 			dev_err(isp->dev, "master slave sensor stream on failed!\n");
 			goto out;
 		}
-		if (!IS_ISP2401) {
+		if (!IS_ISP2401)
 			__wdt_on_master_slave_sensor(isp, wdt_duration);
-		} else {
+		else
 			__wdt_on_master_slave_sensor_pipe(pipe, wdt_duration, true);
-		}
 		goto start_delay_wq;
 	} else if (asd->depth_mode->val && (atomisp_streaming_count(isp) <
 					    ATOMISP_DEPTH_SENSOR_STREAMON_COUNT)) {
-- 
2.25.1

