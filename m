Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4735C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFFE207D0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skhoYdka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgGGVAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgGGVAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0523C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so1247717pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4hkCqVCeOMZgcGJmCmeYT1tYbutzJigRMD38BY9+lY=;
        b=skhoYdkaprvrrYvb7cLlxtvHSZIP1JXvNY5H59zSulwBZznsxe5PwG8/tb0EdKgMXu
         R94Beq1AyHUthM/hUUGgdj0vn7WRz4eaX4yJI9s1/5YbSlJiwUE+a2QFdR9vpsUp9ux8
         3Lbtf80MKp8IgIpbKsCnhLgJiX3gcjczj0XLmhxVFZPZJgMFVakumZg79o/Fr9i8bbxP
         j43R8pBYDaGi8I7Mt4IxOcJX2X5XdUAsHZNL1BocEAB5z8K92AuwJC9GKQg5iKCPELJA
         O3mET5jlADa1Ny58wEWUehDhyskXRwJfPf0fwq6kO5C4XjTzSSMfPrCecT6suDJ3hTcv
         aomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4hkCqVCeOMZgcGJmCmeYT1tYbutzJigRMD38BY9+lY=;
        b=PKALFlZeeLvoxF0Hyh18fpBVkkmc5nY3IeVlpx3nJJO3CpyrMUNA75aWBoQkpWIoB2
         EBNXBllVCqTfdRoi2pRrc2KRItxf60KCL73dqZ/CaAb/sYrFDK2zo9l3zqZPZeDK0zBn
         aL6Y6iIpiJ2h4fhi7cG0QQxP+w3r0Z7MtfCa5lGkXPsHxxlQ6X08WZdWUH5+Ky+3Aw7D
         sLLEOZfhhnmyTho1pW+yZVJNAg7p4G9X/e32Ljp+cqDuM+nbrSa8GzEX7dyQWcZFVr7I
         AawV8Erb7NPcEv8bcmesl/MxSQ2/y0huCKMfV/ag88De/OQdDzyxlxHRuj2tjGNUlNt6
         Oj9w==
X-Gm-Message-State: AOAM531nVTBrqnPEOAUyFXprBXVRVWAI5A0IAObRLPiYysAWt4weteuT
        vDhv/69UYOHie8SzaNMRyKtmihxiKK4=
X-Google-Smtp-Source: ABdhPJxZWe4+LqvbhLX+FR1pDBbdohuGLXTvW36qakI87t3n/y2FTLbHFO0wsREYVkEZkji1GFPqHA==
X-Received: by 2002:a63:5004:: with SMTP id e4mr24268596pgb.208.1594155617393;
        Tue, 07 Jul 2020 14:00:17 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/9] remoteproc: Add new RPROC_DETACHED state
Date:   Tue,  7 Jul 2020 15:00:06 -0600
Message-Id: <20200707210014.927691-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_DETACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 52b871327b55..264759713934 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -72,6 +72,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e7b7bab8b235..21182ad2d059 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -400,6 +400,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_DETACHED:	device has been booted by another entity and waiting
+ *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
  *
  * Please note that the values of these states are used as indices
@@ -414,7 +416,8 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_LAST	= 5,
+	RPROC_DETACHED	= 5,
+	RPROC_LAST	= 6,
 };
 
 /**
-- 
2.25.1

