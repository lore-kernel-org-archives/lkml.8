Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F212F2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTUwEG1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgIDPL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIDPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:11:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEC5C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:11:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so7105911wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=0/0GXn0B+kUH2sz1v6n2Lld/M16vBnqePYs9K5OQkgg=;
        b=oTUwEG1LSm3WzGdzF1AVf4wKi+0v4s838H2QIBJs1VW+aYZG8KtCNTsPAq3cJDH9EH
         2Vhj2jPne9XzEJZy9n8J9uZXc1nkSDCMQf6SNsLj2SWZnGwzvm49PhAsQxIvfDVdgNiU
         x1TGH4LzxXoHNEg5Yw1ZX/kS9OkEFkhZVwxbLRn0H7YzM0p+aIXvdRpPU5bPqCIAFCwz
         In4aABZIuPHGP4Nj389lnofHoeghKc8mLxCjluLXwoqBqS/YDqKbWDB253oGurQlXU5w
         lNJx/BqHNijWw7NNY6Xc9ZAI0TG7tIqXklxBSfaFnXr7l0zJeGMxFLyCK6Uve4vx8h7u
         uuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=0/0GXn0B+kUH2sz1v6n2Lld/M16vBnqePYs9K5OQkgg=;
        b=MB8VtiFK5yd/FQ+sTx05XS0tcOtOOO3LICRpDFvCnTXExaTiOCwfRJ5oxm9aEFeEHY
         oZrIVKhaIOIxgG7eqyOFtDVyfDNlPw+8qocpxX3fE9Ei6NU7/QsOquDLgCSXMMX1YhgQ
         VzNw88u+oY7sMjdxCGkg36wGXyDxOiz+932lOXUCSvAD4wl435AsPeZ2tAvZHMkputUn
         LIRZ3cat5h1VVkBQHurzPd2GkVLPD0t90axqt0IG+iOa10eImUWtb5cJYN8lJtCDWx7H
         vMukAvAY5O07GpUHBYNefj09+xG+Y1ZGVe7E7BIvxhR96EnBQaEkNhMGRTpRVyAzfPZq
         a7fQ==
X-Gm-Message-State: AOAM532QHGh8KLKr4OkRSVau6oipw3IFGo8CB8iB2uzQxp4438ir6N3b
        bZABCE9jdx2q1VxG0NONM76yWMOLhjs=
X-Google-Smtp-Source: ABdhPJySLjw1Wgw6FkT1mzo6IMfHEVFg9/kRS+RKN6CaOAKRD5PYKRJugLymPKYzLrPjMKaVpcpaGA==
X-Received: by 2002:adf:9bc9:: with SMTP id e9mr8022953wrc.123.1599232282940;
        Fri, 04 Sep 2020 08:11:22 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id b194sm13053786wmd.42.2020.09.04.08.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:11:21 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: count dropped CS because max CS in-flight
Date:   Fri,  4 Sep 2020 18:11:19 +0300
Message-Id: <20200904151119.24224-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a case where the user reaches the maximum number of CS in-flight.
In that case, the driver rejects the new CS of the user with EAGAIN. Count
that event so the user can query the driver later to see if it happened.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_submission.c | 5 ++++-
 include/uapi/misc/habanalabs.h                      | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a811a9fdf13b..470bffbe9bdc 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -252,6 +252,8 @@ static void cs_counters_aggregate(struct hl_device *hdev, struct hl_ctx *ctx)
 			ctx->cs_counters.parsing_drop_cnt;
 	hdev->aggregated_cs_counters.queue_full_drop_cnt +=
 			ctx->cs_counters.queue_full_drop_cnt;
+	hdev->aggregated_cs_counters.max_cs_in_flight_drop_cnt +=
+			ctx->cs_counters.max_cs_in_flight_drop_cnt;
 }
 
 static void cs_do_release(struct kref *ref)
@@ -431,8 +433,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 				(hdev->asic_prop.max_pending_cs - 1)];
 
 	if (other && !completion_done(&other->completion)) {
-		dev_dbg(hdev->dev,
+		dev_dbg_ratelimited(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
+		ctx->cs_counters.max_cs_in_flight_drop_cnt++;
 		rc = -EAGAIN;
 		goto free_fence;
 	}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a2dcad29340f..69fb44d35292 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -401,12 +401,14 @@ struct hl_info_sync_manager {
  * @parsing_drop_cnt: dropped due to error in packet parsing
  * @queue_full_drop_cnt: dropped due to queue full
  * @device_in_reset_drop_cnt: dropped due to device in reset
+ * @max_cs_in_flight_drop_cnt: dropped due to maximum CS in-flight
  */
 struct hl_cs_counters {
 	__u64 out_of_mem_drop_cnt;
 	__u64 parsing_drop_cnt;
 	__u64 queue_full_drop_cnt;
 	__u64 device_in_reset_drop_cnt;
+	__u64 max_cs_in_flight_drop_cnt;
 };
 
 struct hl_info_cs_counters {
-- 
2.17.1

