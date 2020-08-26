Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C662074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dm3yYqUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHZQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgHZQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A42C061797
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so1150878pjv.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcCaJSWZ5zZ/Rso84Md8LnddY1FwOKOfNkmuWIoFYnQ=;
        b=dm3yYqUInguZ89okbV11/vGYlFn82cIagLPzf0RhAV98yFFrfo6gFzi0A+Am5O0Gyc
         ugVm7/J+o0C60T8u1lkYXbgxuDp1uAWUunJ4hDDQ6aktWXMBcZcE3DFRx7rsZb89V79i
         phENsosVHMy2FmSQuDkPI5t6YiewbvczlZtupyC7tmVaN41rqiIdwoDsCtwPA3MDM+Um
         gLbdNlYPKztMByVz7kSoS+1PGlCUjk4Zo6ygy3N0o0rBpLcg2ra4fIgrqwapiqO+xrjZ
         VqXiWhvM/h4yeN6eBeemv9FFKc6okpYMaLjygSLWkdgijMGF8eATrWjRFfFolw5fBiq7
         pD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcCaJSWZ5zZ/Rso84Md8LnddY1FwOKOfNkmuWIoFYnQ=;
        b=au4khtD3FXAM+dMtjhFungT/8CV+uwAMsnJh6R72y+lRpd0IGTQTzdFVydmx1HZpUC
         dNbFUudaGwiaZQzY8m2m9fMi+Lbp3CWiBL2uY5qoMWm7mShKjvoAAeDD8Rc9uRGjOyZa
         z5rAJL9KZH8CGHBjAmN63hXU4WKIawUUUJuyiiBfeUbJ6krRTFri9Enq5/cUU8B4dTe2
         UxUzUmZ2IWyvzvaMw0TLKyUYWXu/8eGAyEkltFhc/9EsN1jTWS0MDz9IxGBsLkIYswmV
         rm5+9kFFF2iMpz0glH6w5dNqtNjOWu8P9mQDfj+VNo53+vFYBwm1EBxrD4CBecONwQ3x
         mqIg==
X-Gm-Message-State: AOAM530fQwm1H9VFAA2lp2NkEA1LBGp2iEvqxtoocN8Vdc2iEytihHYA
        0gMwym7tsUKVhThwdFrnUgUSuA==
X-Google-Smtp-Source: ABdhPJzHWCXaJwC+6m4F9wmmPbzgzuPs4WmDpHbnpqyB7UWrdT1pyuF+UfV2jrrtlse91ns9DP7Dbw==
X-Received: by 2002:a17:90a:8909:: with SMTP id u9mr6936602pjn.119.1598460334598;
        Wed, 26 Aug 2020 09:45:34 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:34 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] remoteproc: Add new RPROC_ATTACHED state
Date:   Wed, 26 Aug 2020 10:45:19 -0600
Message-Id: <20200826164529.224476-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_ATTACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index eea514cec50e..2d575e6c9eb8 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -84,6 +84,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_ATTACHED]	= "attached",
 	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 2fa68bf5aa4f..4e107615121a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -403,6 +403,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_ATTACHED:	device has been booted by another entity and the core
+ *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
@@ -419,8 +421,9 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_DETACHED	= 5,
-	RPROC_LAST	= 6,
+	RPROC_ATTACHED	= 5,
+	RPROC_DETACHED	= 6,
+	RPROC_LAST	= 7,
 };
 
 /**
-- 
2.25.1

