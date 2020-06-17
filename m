Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC9B21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hot41bfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:57:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1FDC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:57:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so4014307lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY7fprr0DDACjWieFfe2ChRtojrwX3BZmzgMO+wfVKc=;
        b=hot41bfOqSh2U0gr5jjoD2IPokslzvquFN9OF6L5rUkFdkCMxoVQLZaJDwO2R0Nc8F
         7JKuArzVoS159bDQorZ1MBqJtI6TPJw8KR5HdNU5rRtbv7kKNGP5Re4SNGC2/5SjIw0U
         1Ec7Zzgbtx7FU/8i6+pSCremhMVFGCbzkmm2cZ6wo0B2DJUmTaVwWI4sbS5WqlzQb1iV
         98hnL6i9rZCB+3diIOiJS9G1J0z9okzRJol/RyL7jEXpSMnyOCye2WV30knOUm2EfQN1
         cv2ZjTEM+yaCXB4N5d3VJ0dUX+UlpEK/GbIuC1/ndXEci9/4vk/z49l2X9lfk1k26gM3
         Kr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY7fprr0DDACjWieFfe2ChRtojrwX3BZmzgMO+wfVKc=;
        b=AOrCyoKjfKjT+o4wkyr9+4bIOEtsfxSk8YyUc7TcKPUIBWYHBALWdomw2TyQ5jkYuv
         zCHzRknza4baQwyKbZ8Kuwfbr/XhTCnomO0tTJCQA37/VHspKnEiEAfv9PrjJrOsvEWd
         KAb2f+AUiKqlGmHIozmgQS5E8wsz2MegrEk5MaDYepQILU/LMrY3EICO9shPaJC2zfzi
         Z+DBL8gScUBD0gV8MWotWf+b90SN7rCRG7uVwQnWKNZnuESFhgYhgMWvJRXknNyZRx03
         nWglykPPIysnbyNu3VAyHY98aYuSlNsu9vI79d9X1Xokfa28vrNUFusfyRcn2ZwpaA/o
         V1yA==
X-Gm-Message-State: AOAM532rIgj+R+4kNr0pR3Q2TjqTgEUDBnV4HowDT8bdm9FmVSnRJzum
        45mgGezXSkDnQO9cfvR00tHvfFzV/Hs=
X-Google-Smtp-Source: ABdhPJwCUIZGY4uVMQ7lm8qgRAXZLFSjzWtWXUSeWEr056z+tQUUhX2bXp/JXcFF3uHKSPKbTrEGtA==
X-Received: by 2002:a2e:95d6:: with SMTP id y22mr211356ljh.469.1592416639064;
        Wed, 17 Jun 2020 10:57:19 -0700 (PDT)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id h4sm95471ljg.112.2020.06.17.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:57:18 -0700 (PDT)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrey@lebedev.lt
Subject: [PATCH] drm/lima: Expose job_hang_limit module parameter
Date:   Wed, 17 Jun 2020 20:54:47 +0300
Message-Id: <20200617175447.2681047-1-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hello,

This patch allows to work around a freezing problem as discussed in
https://gitlab.freedesktop.org/lima/linux/-/issues/33

 drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
 drivers/gpu/drm/lima/lima_drv.h   | 1 +
 drivers/gpu/drm/lima/lima_sched.c | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index a831565af813..2807eba26c55 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -19,6 +19,7 @@
 int lima_sched_timeout_ms;
 uint lima_heap_init_nr_pages = 8;
 uint lima_max_error_tasks;
+int lima_job_hang_limit;
 
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

