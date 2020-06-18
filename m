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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C10520739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUhjuTRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgFRO6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFRO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:58:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B5C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:58:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so6405096wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jD/vaqPgqn/GbyEshdpFayy0rmaV/B8hrtCZ/Jh2OJE=;
        b=MUhjuTRE41q8DNA4MiAfGDVi5SKnOjfYcFcOhQx7Q0shrPeqQgpSkt8vNdagw81CtD
         lWLMX4+/HZFFKq9CRKzRPyqosy7lw1AjTREEIydy8HM7KhD0t5cCYtapY8p+iKvwIrJU
         7Y88sQstzp0ZvxbnwwQ/GnOgH5HrC0o3bQQGhF1y9V/l2jWwfjAyYqDJ0mEp/rMQv6Bv
         4Ijzapji4+JZXd8P9bxQJK/BbyzgGnHZJ85AWAhCegMt6uaB13sZTFWoihMIAObxx9kA
         VnN/1RVFtOzFZJfnVmAtV2Nbbt8eJXjLOLPUk1vH1u2XdGfLw7QjcUBdogC9RiXY3BIR
         g9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jD/vaqPgqn/GbyEshdpFayy0rmaV/B8hrtCZ/Jh2OJE=;
        b=FgQYa6ea5x+j1lPrr1GMbDvzMNoccMTEbjyXl5KPRXpfevabZ31iSvqj51DYvSUmgd
         dlAvLe9itdKlKDVxfnwwynMfXPR9fyjciTjZVjpoViWmJ9ScyMGvlkcpsbrtXtqKLl+D
         uTicvfF88hVCKlXuzSsFDljPdpiUW8rCkiZsDH2JGyEtY77tn4+geybFWYIdkBgnKnuS
         BwIiOUuX+0lwjL+6tNeGYpIAA8kgBOdblIiP4XwkrD+ZmsudVtMUCs6ar0bfq+aDGXCT
         VhCTUc9E7Zck25IBWCJPMrLFmEwZW3E/MjfEUyPJ6G3AeIt7v9vFyJhQm451SaCXsGyd
         GSYA==
X-Gm-Message-State: AOAM533aMNDRPC1wdHj/3p6EscLxYZFSIlJX2ye9J/0u/mUH+pJrTVz7
        kPO67W1DK3nEwU7OarrOQ6U=
X-Google-Smtp-Source: ABdhPJzOZoyx7rjEtPKa6qEeScd/wg3eiCkfIoiDdKF8rKK6pseRXTi7+uxRtJKxdSB6is1mRGCuOw==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr4969310wrj.227.1592492331224;
        Thu, 18 Jun 2020 07:58:51 -0700 (PDT)
Received: from kedthinkpad.tpwlan.net ([213.197.144.54])
        by smtp.gmail.com with ESMTPSA id e2sm1941346wrt.76.2020.06.18.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:58:50 -0700 (PDT)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrey@lebedev.lt, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/lima: Expose job_hang_limit module parameter
Date:   Thu, 18 Jun 2020 17:58:38 +0300
Message-Id: <20200618145838.2956591-1-andrey.lebedev@gmail.com>
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

Fixes for the embarrassing build error
Reported-by: kernel test robot <lkp@intel.com>

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

