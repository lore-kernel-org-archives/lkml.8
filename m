Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F86C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E057D206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKExp35R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgDZS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgDZS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:58:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC14C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id y6so6429517pjc.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3i2flU80gai+judhhFKuvAvWyLfx9zeA9RGlgxWN5Q=;
        b=CKExp35RH6rrVYZf5vXfCon5651RmZbjoQsxKk1snxxhRAjxDEi5orr4cksepYMVpD
         1DQHiFpDBFUnh35DM04PSq8snNIsDjS4BOXIpMEzU0W4IVSQ/g8InAvfISr19ju4oGLV
         CIOT9LzT7Wsbd0uphG4020IVfSNaBCsWylkbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3i2flU80gai+judhhFKuvAvWyLfx9zeA9RGlgxWN5Q=;
        b=RrdrcoHj4CVTGdYcEgMf80CTAWf/YdekJ6BKIhwtrR7KkgRpzC/fKHpJnJcrD4Syj0
         eG8hgr5QX/dFd9R6e/6bebsNvFrrv/s0rfc0PP+xSQa6OO5i5w/F+DYys7LEwSLiqe+u
         Qv106J17c68vLiJ9k0mGd0Cy4bqcZ0MMZl5Y3Db9sORqJJUzaeUo+8FPb/rb28XOZ19P
         tpLNuMt09hnsz4X6Of1wZBu+rLVYlYyq9y3zEnp7c6qI0Khi2uznwxFRHO/nu8lgSJEr
         CvVCkuocXIHNueB1iv5e5DXZlo6Pq7KxaLp2dCZ1AJYC8a9j47VnVZo9k8rwvo6jXgUS
         o7ug==
X-Gm-Message-State: AGi0PuYZhUkT8lnX5wdtAXU54tgnL0NmZLXCE7EKpIzBL0SfhOrUozF4
        +lUCEXBQqCIU/hmF5x2r3wGUGWDUiYo=
X-Google-Smtp-Source: APiQypL2aZCoe1BGEmB9HPKQE18g7LHRDsJ4fzgjvL2I+3C29fpVwxnrx/b12/hGVqc9MH0v0Mu/Uw==
X-Received: by 2002:a17:90a:b884:: with SMTP id o4mr18991300pjr.8.1587927489319;
        Sun, 26 Apr 2020 11:58:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h27sm9425153pgb.90.2020.04.26.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 3/5] coresight: Don't initialize variables unnecessarily
Date:   Sun, 26 Apr 2020 11:58:03 -0700
Message-Id: <20200426185805.14923-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200426185805.14923-1-swboyd@chromium.org>
References: <20200426185805.14923-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These variables are assigned again before they're used. Leave them
unassigned at first so that the compiler can detect problems in the
future with use before initialization.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 7da846a3a829..77e14e770806 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -1043,8 +1043,8 @@ static int cti_create_con_sysfs_attr(struct device *dev,
 				     enum cti_conn_attr_type attr_type,
 				     int attr_idx)
 {
-	struct dev_ext_attribute *eattr = 0;
-	char *name = 0;
+	struct dev_ext_attribute *eattr;
+	char *name;
 
 	eattr = devm_kzalloc(dev, sizeof(struct dev_ext_attribute),
 				    GFP_KERNEL);
@@ -1163,8 +1163,8 @@ static int cti_create_cons_groups(struct device *dev, struct cti_device *ctidev)
 int cti_create_cons_sysfs(struct device *dev, struct cti_drvdata *drvdata)
 {
 	struct cti_device *ctidev = &drvdata->ctidev;
-	int err = 0, con_idx = 0, i;
-	struct cti_trig_con *tc = NULL;
+	int err, con_idx = 0, i;
+	struct cti_trig_con *tc;
 
 	err = cti_create_cons_groups(dev, ctidev);
 	if (err)
-- 
Sent by a computer, using git, on the internet

