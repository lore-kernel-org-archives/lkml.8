Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4742EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FABE2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fERP93oD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFJWTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:19:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43920C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:19:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so1499531pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhuYJSC1VHruylv18DPHqIr538+R8iT9VQr5TN8ed1A=;
        b=fERP93oDnXfNKo4nZ8jb23h41NjAcbPRW1H9fmDlyHHO11k2/qxwtJuEcIOUKtuxBo
         IpUsH2lJo26qrxLSViY7mYtwmmokQle3Ru7g9qTOUR+0wu/wPoizV9F/AD+nWUjbUnMR
         Qq8Z1ss76MV3A2gRCwHVSoD0qsQq0XEilMQiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhuYJSC1VHruylv18DPHqIr538+R8iT9VQr5TN8ed1A=;
        b=f//TWvHQVNs6goYTTWrOoXw2LY/zxiG3tBk0VIX0rpz7wbWfWpvbAW0TFUJ9aoPr9D
         5ZqwVn1354CC/rx0a1gLHRnVar4bIBIIOD9uU4+dCgVwIRg3hsSidBoMviLiq6XxychD
         WGFh96vU2r8dzcsYIOs0ooaqnHL1mbY7PYxvT1MDsUoquNje4IB3m0dd7XehxtHOX+9j
         D7wUgGzTPkDaqk7gLazdL0/rUE8wdbxLBLOyXcwy89CvIQjiqWF9t5z4dW8JIln1TIRB
         OplT0Zr7vGJ229HfmD4sWrpAPlj6yilgPKdr+RRmT0lro8s5a4DaQWT8Sfd0q6nBeoZ4
         fupQ==
X-Gm-Message-State: AOAM531fqeFY43qg4aRrdUzKvkJLfqEXS9yCBeQMe2hEJ71/rvgznMWO
        7WyJWq3W5k9QUsfFq4gtcjvdgg==
X-Google-Smtp-Source: ABdhPJy27msuXD2eMtps/cp9jKmt0EEj2zVmkwWkSJq0jyHWRGT6WVGVWnOfxANQ0mTx0ojlu8O2eA==
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr4783574plb.12.1591827542296;
        Wed, 10 Jun 2020 15:19:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f136sm876033pfa.59.2020.06.10.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:19:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     hsinyi@chromium.org, joelaf@google.com, peterz@infradead.org,
        drinkcat@chromium.org, gwendal@chromium.org, qperret@google.com,
        ctheegal@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump cpu freq
Date:   Wed, 10 Jun 2020 15:18:43 -0700
Message-Id: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros_ec_spi driver is realtime priority so that it doesn't get
preempted by other taks while it's talking to the EC but overall it
really doesn't need lots of compute power.  Unfortunately, by default,
the kernel assumes that all realtime tasks should cause the cpufreq to
jump to max and burn through power to get things done as quickly as
possible.  That's just not the correct behavior for cros_ec_spi.

Switch to manually overriding the default.

This won't help us if our work moves over to the SPI pump thread but
that's not the common code path.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: This would cause a conflict if the patch
https://lore.kernel.org/r/20200422112831.870192415@infradead.org lands
first

 drivers/platform/chrome/cros_ec_spi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index debea5c4c829..76d59d5e7efd 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -709,8 +709,11 @@ static void cros_ec_spi_high_pri_release(void *worker)
 static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 					   struct cros_ec_spi *ec_spi)
 {
-	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO / 2,
+	struct sched_attr sched_attr = {
+		.sched_policy	= SCHED_FIFO,
+		.sched_priority	= MAX_RT_PRIO / 2,
+		.sched_flags	= SCHED_FLAG_UTIL_CLAMP_MIN,
+		.sched_util_min	= 0,
 	};
 	int err;
 
@@ -728,8 +731,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 	if (err)
 		return err;
 
-	err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
-					 SCHED_FIFO, &sched_priority);
+	err = sched_setattr_nocheck(ec_spi->high_pri_worker->task, &sched_attr);
 	if (err)
 		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
 	return err;
-- 
2.27.0.290.gba653c62da-goog

