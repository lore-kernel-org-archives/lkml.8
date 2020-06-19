Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D463C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CDF207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9iEaej+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgFSH7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgFSH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:59:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D0C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:59:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so8235207wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeRTvG0uCKHbriogGBEyjyc5UzHZBdJsborWRefc+F8=;
        b=d9iEaej+2YgHJdaSbvT+TEKt/f5Ph9RdVJRhp4BntFFPQM3K8gbIZAgab6+Lm7mFdt
         0lqGhogx0MmOARRhReNaonKMSf9mTA0dVsiqB/SD3TPt6bvSj+VvpDxn33sdzauqsn06
         zWKGNxoZwlou4EPfRpSJqGF0LdGZmjCUZ4830lf2JbNSy+Ttzj6LJTcCj/r2lbJkzmcZ
         vf4oaKANCdg50sR9ILHLm5mSKH6Er7Jlz8icc93abTBkIODKgVeFQxOcqt7Xn4gLZkxp
         VZMRPT6ju3D7H77Vnf4ldp/s/X+puNbm/eDZIrN2JkMPgsCJ66zIf5/v4Ya+Is+JE1VW
         7nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeRTvG0uCKHbriogGBEyjyc5UzHZBdJsborWRefc+F8=;
        b=IqrIIwM2zpOMIZyT1JO/W1qC1qR25sv6DeMbvHRM2x+2crTblOcGXma+GEQWppyDhW
         lLWagNKxE8CHUDV2gvoqDtMRpGRE2pdNlh26qhTSFuG0NrbTy4hzk5AxIftZay6h7FWs
         MSfe+gckcQ+89712EOF+bayqdeKq0YCvZyBTTc737oNG+PX8qFXAC2RZjsqQVW/mcVQ2
         UgllT19xPSGk6ltChr8T4qofaNeqlaxcYS3FIQBzHiFYdy00rT/9qEreh67/hRQaixkb
         f0KxXlSht7xigw2CxiBSo4aU0ySJd5V18QxewqpTQA1xsPKNZ59O8I+IKzRBbRL+7VPQ
         xPgg==
X-Gm-Message-State: AOAM532aKN1uX2e+uTLA2SGAt88reQHNVSGzx8WvMWLDRQCWJV+F/5mJ
        H2Bs7AfTcZuvY9CIz8l2oL0=
X-Google-Smtp-Source: ABdhPJxF4cF5V82JZiJN8gB/gu9ctvnFr1pdscpxJVnUgvJkLIB1x0dIrih1Rc7C4WF2ynX9CUnFrg==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr2462594wmj.180.1592553547251;
        Fri, 19 Jun 2020 00:59:07 -0700 (PDT)
Received: from kedthinkpad.tpwlan.net ([213.197.144.54])
        by smtp.gmail.com with ESMTPSA id f11sm6381244wrj.2.2020.06.19.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 00:59:05 -0700 (PDT)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrey@lebedev.lt
Subject: [PATCH] drm/lima: Expose job_hang_limit module parameter
Date:   Fri, 19 Jun 2020 10:58:59 +0300
Message-Id: <20200619075900.3030696-1-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAKGbVbtYusvURFcUyQtgUycNJPAQyDGDaLXW8qw-x49DqfKmQA@mail.gmail.com>
References: <CAKGbVbtYusvURFcUyQtgUycNJPAQyDGDaLXW8qw-x49DqfKmQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Lebedev <andrey@lebedev.lt>

Some pp or gp jobs can be successfully repeated even after they time outs.
Introduce lima module parameter to specify number of times a job can hang
before being dropped.

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---

Now all types are correct (uint).

 drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
 drivers/gpu/drm/lima/lima_drv.h   | 1 +
 drivers/gpu/drm/lima/lima_sched.c | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index a831565af813..ab460121fd52 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -19,6 +19,7 @@
 int lima_sched_timeout_ms;
 uint lima_heap_init_nr_pages = 8;
 uint lima_max_error_tasks;
+uint lima_job_hang_limit;
 
 MODULE_PARM_DESC(sched_timeout_ms, "task run timeout in ms");
 module_param_named(sched_timeout_ms, lima_sched_timeout_ms, int, 0444);
@@ -29,6 +30,9 @@ module_param_named(heap_init_nr_pages, lima_heap_init_nr_pages, uint, 0444);
 MODULE_PARM_DESC(max_error_tasks, "max number of error tasks to save");
 module_param_named(max_error_tasks, lima_max_error_tasks, uint, 0644);
 
+MODULE_PARM_DESC(job_hang_limit, "number of times to allow a job to hang before dropping it (default 0)");
+module_param_named(job_hang_limit, lima_job_hang_limit, uint, 0444);
+
 static int lima_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
 {
 	struct drm_lima_get_param *args = data;
diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
index fdbd4077c768..c738d288547b 100644
--- a/drivers/gpu/drm/lima/lima_drv.h
+++ b/drivers/gpu/drm/lima/lima_drv.h
@@ -11,6 +11,7 @@
 extern int lima_sched_timeout_ms;
 extern uint lima_heap_init_nr_pages;
 extern uint lima_max_error_tasks;
+extern uint lima_job_hang_limit;
 
 struct lima_vm;
 struct lima_bo;
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index e6cefda00279..1602985dfa04 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -503,8 +503,9 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 
 	INIT_WORK(&pipe->recover_work, lima_sched_recover_work);
 
-	return drm_sched_init(&pipe->base, &lima_sched_ops, 1, 0,
-			      msecs_to_jiffies(timeout), name);
+	return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
+			      lima_job_hang_limit, msecs_to_jiffies(timeout),
+			      name);
 }
 
 void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
-- 
2.25.1

