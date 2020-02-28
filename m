Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436F246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZHhsOAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgB1SeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:34:07 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36775 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgB1SeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:34:05 -0500
Received: by mail-yw1-f68.google.com with SMTP id y72so4258113ywg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GIcV50HzfFuzHnFyxJZaw5ayTXhu+ot1cYJZR5HNC2I=;
        b=rZHhsOAub+cbp14f0VQ94mMSWV+s83mEdNkA061F4J1uF3G54XpGHLT0hB3XBf0b9l
         vQBZrBGUl464onvfp7WNa0eFDneYBz/SZmtOk4UFQQqTISZRyLjF0Ijxw4lJS11xjvd8
         W9ED6lThimFZMP+nCTqUxWka0vWjrqd6PX630j8loEy1Pi/JnrrLck/3sFUxtOSl9ZhQ
         7b/KFiYweB5+DySbOgti5DiHQbbWM0fdByQaoKFbMFjkVoW5DFyoJYI9UyESyx95zEFU
         HgrwrZuwIq3v1cjE4xtG2woxXufkxtKoCd0QL9jUsvVcMjkv+yXlZgMw323aCfm6f0Dt
         xR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GIcV50HzfFuzHnFyxJZaw5ayTXhu+ot1cYJZR5HNC2I=;
        b=LGuwhBJR/pssp7n6keFg19ih4d+3seoinNyokntpWSLCFbPnlEH1bhk84+0EogS2Jr
         XRXAI6UVa3b1To8bj+uIbQoOfL8dD+S5CGb/jQGhrN06sWS/HBMNAEvr6v1LFHewOmyu
         urrmdh4MlAMDFycQ2+xjiBSw8VxVNiQ1Rkw++QdUp1Q0vV3uK+Rbmh9W7c5/ak8/QCwg
         RdMiJ1NlWXPDj3+oapViff8YVsdDL4yEOTJ/kq/nRsyNchog+b0k0f7wi1OI3m/DavsK
         K8lqI5z+BItOG37vW5EYjStZ/RfMXTM0tj4qxM/8HynmYJKj6RWWJvtJIkmQ0ooKwjyL
         b8Rw==
X-Gm-Message-State: APjAAAU9pAk4vSVHy/HOjlC8Pk+y4F9fs/7MjMvDvjLCA3dP3zXEQWPp
        XJzpRA3kTSmXuzXcDHQLsfesqA==
X-Google-Smtp-Source: APXvYqy0T88Ery5T/84/Na8fYDmQec02Ukk7u5LokLZ6FVxaUPs9/9ebRaw/9+yxnnxgyVs/hIEmqA==
X-Received: by 2002:a25:aa6a:: with SMTP id s97mr4799522ybi.232.1582914844407;
        Fri, 28 Feb 2020 10:34:04 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o127sm4409884ywf.43.2020.02.28.10.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 10:34:03 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] remoteproc: re-check state in rproc_trigger_recovery()
Date:   Fri, 28 Feb 2020 12:33:56 -0600
Message-Id: <20200228183359.16229-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228183359.16229-1-elder@linaro.org>
References: <20200228183359.16229-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two places call rproc_trigger_recovery():
  - rproc_crash_handler_work() sets rproc->state to CRASHED under
    protection of the mutex, then calls it if recovery is not
    disabled.  This function is called in workqueue context when
    scheduled in rproc_report_crash().
  - rproc_recovery_write() calls it in two spots, both of which
    the only call it if the rproc->state is CRASHED.

The mutex is taken right away in rproc_trigger_recovery().  However,
by the time the mutex is acquired, something else might have changed
rproc->state to something other than CRASHED.

The work that follows that is only appropriate for a remoteproc in
CRASHED state.  So check the state after acquiring the mutex, and
only proceed with the recovery work if the remoteproc is still in
CRASHED state.

Delay reporting that recovering has begun until after we hold the
mutex and we know the remote processor is in CRASHED state.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..d327cb31d5c8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1653,12 +1653,16 @@ int rproc_trigger_recovery(struct rproc *rproc)
 	struct device *dev = &rproc->dev;
 	int ret;
 
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret)
+		return ret;
+
+	/* State could have changed before we got the mutex */
+	if (rproc->state != RPROC_CRASHED)
+		goto unlock_mutex;
+
 	dev_err(dev, "recovering %s\n", rproc->name);
 
-	ret = mutex_lock_interruptible(&rproc->lock);
-	if (ret)
-		return ret;
-
 	ret = rproc_stop(rproc, true);
 	if (ret)
 		goto unlock_mutex;
-- 
2.20.1

