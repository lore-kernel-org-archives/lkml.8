Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C5C20773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWnTFVpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgFRG4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFRG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:56:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD7C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:56:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so674597wmm.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSrkiGW58xhvGfSrRGedc+QGiK8uOANQBZ1I7RWUHHI=;
        b=HWnTFVpohThf7Fdkvat33YIOcm7zYbrdV95naO4qF84KEu/h4oYSpvvTqhB9AtsatH
         SfUot7MpxgX1G2SOhgRNiMYui6xwcEHO8SzPUineH9eJ/6xOKPJd+Ui/EzHOlkK8DVfZ
         i4pFJnumMJ3sv1W2Hf0OrouBqm2Oz9AN8VHatluMUqFfTb5NSMDze4h3ro+34ze89RfR
         DkBAHciDL+BJNQGPHkrw7fM/PxMyZWSFs1GGLkj1noxnmVHK82anflJI3zdV6Y6ZAf1z
         ST3dlenPkfnFI5tqSoj1yh6xFwyB4imXbhPLRQuaMQGLqoNupDGU3o5Y1v3jczUERPIf
         vSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSrkiGW58xhvGfSrRGedc+QGiK8uOANQBZ1I7RWUHHI=;
        b=RBJlb3+5Ljr74tPT1mlz2330rl4SXqcw6ksSXseh0d3GPOVq7ouYvlUeHXAXLuBXVU
         VSjmtg/xznrmn67XkUuH2/AMfpbJQJY37nqayhiv0wrtag/jxcD/7GMiaK98FwCNjMSU
         lYf+2x49XvNuKgVXvUUrLwLqBNtg5zQ2GSlomunf64p+jzj90AI3xTngzRfXPsIlHcJU
         GQWONlv4koQsjv943x5wuYeBX62gPSkuq7k/m7MJNbaS2OyPGm1KivKD6zi34mW1vtgX
         NE2A/LqwouIM93S3r0w6NH9Td1byu9BXRe2hZNIQ5jgftT3l6QM3yKdNQHrPhIlKoVAi
         +dEA==
X-Gm-Message-State: AOAM532KkDpS/8QUPaIBA6px7hk8+C19cP3QTfafTU8rNvvFW2ycjAHx
        TCvBh44E3YIuzfwpb2KXv5/1vB+lNrCMYQ==
X-Google-Smtp-Source: ABdhPJwUfDrxDKg/4SB3Auoc6JYEqU+K1I4XTCLKFkatHGtP1VA4FI4VgiKLrEswGI0NO2iAXkYFzg==
X-Received: by 2002:a1c:7d85:: with SMTP id y127mr2467276wmc.181.1592463397435;
        Wed, 17 Jun 2020 23:56:37 -0700 (PDT)
Received: from kedthinkpad.tpwlan.net ([213.197.144.54])
        by smtp.gmail.com with ESMTPSA id c143sm9104107wmd.1.2020.06.17.23.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 23:56:36 -0700 (PDT)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrey@lebedev.lt
Subject: [PATCH] drm/lima: Expose job_hang_limit module parameter
Date:   Thu, 18 Jun 2020 09:56:18 +0300
Message-Id: <20200618065619.2804351-1-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAKGbVbuV8meZji9PqFUwt4CpFEy6efpX63hJBgMY7fzAnZS4Rg@mail.gmail.com>
References: <CAKGbVbuV8meZji9PqFUwt4CpFEy6efpX63hJBgMY7fzAnZS4Rg@mail.gmail.com>
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

Changed type of lima_job_hang_limit to unsigned int.

 drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
 drivers/gpu/drm/lima/lima_drv.h   | 1 +
 drivers/gpu/drm/lima/lima_sched.c | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index a831565af813..2400b8d52d92 100644
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
+module_param_named(job_hang_limit, lima_job_hang_limit, int, 0444);
+
 static int lima_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
 {
 	struct drm_lima_get_param *args = data;
diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
index fdbd4077c768..39fd98e3b14d 100644
--- a/drivers/gpu/drm/lima/lima_drv.h
+++ b/drivers/gpu/drm/lima/lima_drv.h
@@ -11,6 +11,7 @@
 extern int lima_sched_timeout_ms;
 extern uint lima_heap_init_nr_pages;
 extern uint lima_max_error_tasks;
+extern int lima_job_hang_limit;
 
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

