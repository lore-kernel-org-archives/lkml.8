Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592AC43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8B920739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdXLpXQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgCUJpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:45:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgCUJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:45:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so3161844wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p07172ZoAYLhgL8MhlQdQDPQm1FytxKJ4TUV9O0POto=;
        b=zdXLpXQcmYSY7ZbBRXUOXbyjJ6V4owIHKwkhSp5juYJCLE0AaXgek+6PXgKKrLdwwd
         2X6dU/PbshRwWKHUipBZ0UKJmMpzKbJQN9fW44JFPIDGQZ2i8NAImsWRN0w/gQt9M6LY
         LWqA1VNcWBXl7WtBw6nsN5in5dKCG/zWK2LzR/cOQmZenyrQmRjh+wp5lTfDqzaAQEH+
         xdOQ/VOSghP5CeLTG5s7/hMnz1b25ZPKBf0FDc3u1Cfz7Vfsfi9/BB8FJKGwXAEL2yuD
         K+0Y88lobxoddQ/vTyjNKI4f1b3eCjAPzXNlVjH3z3A5MvCFm54LaRS6Jcd6IBb3/qZL
         FgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p07172ZoAYLhgL8MhlQdQDPQm1FytxKJ4TUV9O0POto=;
        b=qCjf0Kz11LoaZRhSB/hUnUoJA26sHh1MsBBPpegcWbzUNpNJlSL4CD7yfFYF09LY+J
         H5KuM6yjQUSYfZhK4EIS/VHqAXt/GTizC60PVtS+CYDCJdRnxl6SdFeDLxRpAQ8VIXxH
         R7R8NGBFU9IcgpTkD0U7wIVi4cYJEbzLDjj4I5uBYhrNduDipYeToFmeYmjndCaMoiI6
         Rb8UJxgQ3cWcHmlfDEmucnSXtZjMgsoXCNIVhBd/eeGIshFclIefKqJufknZJhL7Id7g
         5isBcMqv27vr17ilaLEdMUiscV87V1+oDx9pyxDpkunEoxY5ELyr0Ytvej+Qhdac0hQV
         OSfQ==
X-Gm-Message-State: ANhLgQ24OVHF10GA4lzhzir+zbk+Hrn1SLcMlDF+d7WvH+rbEopBZXas
        VOl9IMj/swhqjgA9S8H1xEpbgA==
X-Google-Smtp-Source: ADFU+vuMvU0VAEsp5NxIjE3HoyKfXnehkLji93VVgZ1i9x4FykxgYwnmFfxgCFWyRurhFhB9d4xvtA==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr15153060wmc.188.1584783918623;
        Sat, 21 Mar 2020 02:45:18 -0700 (PDT)
Received: from localhost.localdomain ([84.33.129.193])
        by smtp.gmail.com with ESMTPSA id z203sm5396378wmg.12.2020.03.21.02.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:45:17 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        cki-project@redhat.com
Subject: [PATCH BUGFIX 4/4] block, bfq: invoke flush_idle_tree after reparent_active_queues in pd_offline
Date:   Sat, 21 Mar 2020 10:45:21 +0100
Message-Id: <20200321094521.85986-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
References: <20200321094521.85986-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bfq_pd_offline(), the function bfq_flush_idle_tree() is invoked to
flush the rb tree that contains all idle entities belonging to the pd
(cgroup) being destroyed. In particular, bfq_flush_idle_tree() is
invoked before bfq_reparent_active_queues(). Yet the latter may happen
to add some entities to the idle tree. It happens if, in some of the
calls to bfq_bfqq_move() performed by bfq_reparent_active_queues(),
the queue to move is empty and gets expired.

This commit simply reverses the invocation order between
bfq_flush_idle_tree() and bfq_reparent_active_queues().

Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index efb89db7ba24..68882b9b8f11 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -893,13 +893,6 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
 		st = bfqg->sched_data.service_tree + i;
 
-		/*
-		 * The idle tree may still contain bfq_queues belonging
-		 * to exited task because they never migrated to a different
-		 * cgroup from the one being destroyed now.
-		 */
-		bfq_flush_idle_tree(st);
-
 		/*
 		 * It may happen that some queues are still active
 		 * (busy) upon group destruction (if the corresponding
@@ -913,6 +906,19 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 		 * scheduler has taken no reference.
 		 */
 		bfq_reparent_active_queues(bfqd, bfqg, st, i);
+
+		/*
+		 * The idle tree may still contain bfq_queues
+		 * belonging to exited task because they never
+		 * migrated to a different cgroup from the one being
+		 * destroyed now. In addition, even
+		 * bfq_reparent_active_queues() may happen to add some
+		 * entities to the idle tree. It happens if, in some
+		 * of the calls to bfq_bfqq_move() performed by
+		 * bfq_reparent_active_queues(), the queue to move is
+		 * empty and gets expired.
+		 */
+		bfq_flush_idle_tree(st);
 	}
 
 	__bfq_deactivate_entity(entity, false);
-- 
2.20.1

