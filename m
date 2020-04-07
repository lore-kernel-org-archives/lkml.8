Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440BE20747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gy9VuPQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDGWAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:00:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDGWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:00:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so1425960pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va+2nc4i3Yd/W+iIcLatzp6wimnXHUJvgsPfQPVfjOk=;
        b=gy9VuPQkWxTJk5f0NPImzjXAgbmkdVnSGu/aCOlfUYUONmXPV34RUXTT3IJ7hCCZeZ
         qk0UN2+a0tnubLFizwXeReioGyiMApRKwoHrXd6DWPlY8tn3qMLBbhUo5cwYMalX/UWJ
         d0V3h9CexwCSBJhcf92nXnfL5uzWNpMz3ppyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va+2nc4i3Yd/W+iIcLatzp6wimnXHUJvgsPfQPVfjOk=;
        b=Sg2RPuiQLiCpsqkREZ4rC7hHqtX+903izr4oZ1oKu/h0OD8qCGbML3xfmBjU+S28uY
         dWRup3esCq8bund7xTmuq7aOKmzev+bzQwm6wrOHZQGoOsNwlMgAAUERNIUB7JeNb9H2
         jcyaqoEce5IiPDUIGUPibauEQLaDdXKSWi9X2238bkNx1rGhxgWzUF8fWG7bSJyElBrX
         mf/mfPw3CexLpzsY2Oq4LxNcGASWS0j6xmCMThU44yNn7dSzre/eHnKLcGlWvFKGc6d0
         SPZ0UMPzn4mpcXDRgk5z0iiqwkbcIVnd2YOoQDNkQbuuWWe+pHqY3DCh2DExzTCLKX9W
         y/Pg==
X-Gm-Message-State: AGi0PuYguVHWZRQIlF40DDvl71jXiEx0TIF2XQPxfeIU5fnVlXtohuxM
        3fk6NjKCJldMN0uUpr4KdjbISg==
X-Google-Smtp-Source: APiQypL2Qu8KYDrWW/tOAFF4GfWMTLWK8Gme7f6J6H+6CiWntfa0rfCy/dU1fPn7+ho9ZB99Vqc/kA==
X-Received: by 2002:a63:e350:: with SMTP id o16mr3931135pgj.250.1586296842988;
        Tue, 07 Apr 2020 15:00:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g3sm880112pgd.64.2020.04.07.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:00:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        sqazi@google.com, Gwendal Grignou <gwendal@chromium.org>,
        groeck@chromium.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] Revert "scsi: core: run queue if SCSI device queue isn't ready and queue is idle"
Date:   Tue,  7 Apr 2020 15:00:05 -0700
Message-Id: <20200407145906.v3.4.I630e6ca4cdcf9ab13ea899274745f9e3174eb12b@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407220005.119540-1-dianders@chromium.org>
References: <20200407220005.119540-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7e70aa789d4a0c89dbfbd2c8a974a4df717475ec.

Now that we have the patches ("blk-mq: In blk_mq_dispatch_rq_list()
"no budget" is a reason to kick") and ("blk-mq: Rerun dispatching in
the case of budget contention") we should no longer need the fix in
the SCSI code.  Revert it, resolving conflicts with other patches that
have touched this code.

With this revert (and the two new patches) I can run the script that
was in commit 7e70aa789d4a ("scsi: core: run queue if SCSI device
queue isn't ready and queue is idle") in a loop with no failure.  If I
do this revert without the two new patches I can easily get a failure.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't know for sure that we can revert this patch, but in the very
least the original test case now passes.  If there is any question
about this, we can just drop this patch.

Changes in v3:
- ("Revert "scsi: core: run queue...") new for v3.

Changes in v2: None

 drivers/scsi/scsi_lib.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 47835c4b4ee0..ea18f618dc66 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1610,12 +1610,7 @@ static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct scsi_device *sdev = q->queuedata;
 
-	if (scsi_dev_queue_ready(q, sdev))
-		return true;
-
-	if (atomic_read(&sdev->device_busy) == 0 && !scsi_device_blocked(sdev))
-		blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
-	return false;
+	return scsi_dev_queue_ready(q, sdev);
 }
 
 static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.26.0.292.g33ef6b2f38-goog

