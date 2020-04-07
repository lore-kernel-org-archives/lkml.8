Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9BCC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B722074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mRqdmR8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDGWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:00:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38485 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDGWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:00:41 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so320049pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awDfB0MGcHAXl5KbIU74aBGmtjn2jxdDVI+x1Gk8xDs=;
        b=mRqdmR8zkn7Oe+uQ+gvTuRHtTrAik93NY0bijY+0jJIx/5WhlsXhcGiZu+mud4zJh/
         vA3KnP3CnypjDiKg0Pt1RSaSrHd+g0rk3V8TGbWm50PtEiCKkbjh1ChsF6xFrL2gQJqt
         PpVKJ0PnKPe2te8xnLj0vPYnJUoSzX0X/jHtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awDfB0MGcHAXl5KbIU74aBGmtjn2jxdDVI+x1Gk8xDs=;
        b=EFMuI7dfdobgjd8n5yGd1zQGYv8FnTFC0YUkgAXSVSsNXcc4byDe3xftm4wMG2Bmdh
         4g/7ZbuIUihLwyqPJNnB8t0ZplJhfX+BOP60rqMaYdP+KHBz7GgtXzWedc2MVc8ExcIs
         1N6pUVIwYC+bTOTSC3RcAHexRVsbY9qb1B/Q1RqgFG61FbfkE+xQ8lp6S4yXiSyNytt4
         4cQq1VFD8Qy35j8bPBoGJAW3CkcQIlrqkDhbvM46w8yhDp/YO9WSiKStAV/9NcbDdJho
         EU/vAypIbaHETiHcs1uyr/RddHqfqzPKus/TSrcj27FKfvBUYX9ULkn4b4XSK7maYf6y
         z+uA==
X-Gm-Message-State: AGi0PuaPP8a96CbTmnSaa16Oqs+FkScqbkYyqtIgr7bSWlRx7vu8wGB3
        ARQg7/0F27z/aB3JXgzLRmQ9hg==
X-Google-Smtp-Source: APiQypKCpubmYvC/OrHLHAy3Hs14HLFfQ51lPxMeGFhqpteEmJI+Q2j4qlF2dWKK85YyeUtNBIlN+A==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr4332621plf.42.1586296840284;
        Tue, 07 Apr 2020 15:00:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g3sm880112pgd.64.2020.04.07.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:00:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        sqazi@google.com, Gwendal Grignou <gwendal@chromium.org>,
        groeck@chromium.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] blk-mq: Add blk_mq_delay_run_hw_queues() API call
Date:   Tue,  7 Apr 2020 15:00:03 -0700
Message-Id: <20200407145906.v3.2.I4c665d70212a5b33e103fec4d5019a59b4c05577@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407220005.119540-1-dianders@chromium.org>
References: <20200407220005.119540-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have:
* blk_mq_run_hw_queue()
* blk_mq_delay_run_hw_queue()
* blk_mq_run_hw_queues()

...but not blk_mq_delay_run_hw_queues(), presumably because nobody
needed it before now.  Since we need it for a later patch in this
series, add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("blk-mq: Add blk_mq_delay_run_hw_queues() API call") new for v3

Changes in v2: None

 block/blk-mq.c         | 19 +++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7d5f388b7da9..f0a89109fb6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1544,6 +1544,25 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queues);
 
+/**
+ * blk_mq_delay_run_hw_queues - Run all hardware queues asynchronously.
+ * @q: Pointer to the request queue to run.
+ * @msecs: Microseconds of delay to wait before running the queues.
+ */
+void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (blk_mq_hctx_stopped(hctx))
+			continue;
+
+		blk_mq_delay_run_hw_queue(hctx, msecs);
+	}
+}
+EXPORT_SYMBOL(blk_mq_delay_run_hw_queues);
+
 /**
  * blk_mq_queue_stopped() - check whether one or more hctxs have been stopped
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f389d7c724bd..3bbc730eca72 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -508,6 +508,7 @@ void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
+void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
-- 
2.26.0.292.g33ef6b2f38-goog

