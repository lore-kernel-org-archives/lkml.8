Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFDC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787E32076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T44mrEDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgGJRg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:36:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61548C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so6750811wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wINVzYbX4hym9njO572/iv9oDiFGq4oqnD7AIf9n9f0=;
        b=T44mrEDTCRydaV3PPVng0S8uEpiY6EkKiEWisDyWQPpUacn82XcTAgdVcLOuuKPy1o
         LoO9V2X4IaetT2mCSTbBIZ7EB7hbYEVLCTpu9kGipxPg4dB1ipFvfDkDXdefGcLka/zG
         8y3O73fn7YJkcczRVqtWWoRQf5a6Z5d2Ry3MNsb/TyD6Gl96peDtmr1o/ZGIvquQyjjF
         HVpS5TfOhUgwh8HCqRoTEO3dD0gtaOJijYgHtHYlPChbbyo9RjSG1uMW1lsBCvcu1EiQ
         KnnJCsTSfj9ZzIZH/ytDVkwJTogAzj6gbItrxQa0k2osv1HYukd2mcR6KnmiSv7/4OT9
         3InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wINVzYbX4hym9njO572/iv9oDiFGq4oqnD7AIf9n9f0=;
        b=Vg7TqNdwLGqnsqeerUTc7CGDBLr9GP+j6vjDOB6AL7wJL1IqDeI/MS0GfmDKnmGXvB
         6AZWj1+kjFTUwIEGTXcMQYoK0f3Vjhhaia3XJKyJUrTnuhx0s3kBFbzRWxws0//KD1RG
         vgIGQIi7Rv3Gjjz4ThXGNf+SP8wUwr6mU4sKvsFTd12gIyOzm0gk6sLx2U/A3zqvIiRw
         K/TGPIFnNWh4Bkwt4PkDwfw6Kvx4tUsAqSpWdeBNnQ580Yt9lwVCMQFG9QFkKosGMMp0
         iTVy9vS5qUH7ytvCFgoGqYf0Q3BXz5ejAoveFiih/iW/qSGT2UXoF+35YfhT/3IDEFLZ
         KnlA==
X-Gm-Message-State: AOAM530hxWkLFqwdVM47oLuWUGZknVTuJ1BJ1osm595EyDLy66QorYxr
        WpQeXceEpJwkJVCx/Ova8GKGjejw
X-Google-Smtp-Source: ABdhPJw6xvHm5w2uAhBOpHOBoNNqyZCAvOWpAg5HRyRZgfY6Q8eh7KUz31GzbTEkZBPgOrPqRMftkg==
X-Received: by 2002:adf:ea84:: with SMTP id s4mr67491284wrm.222.1594402613729;
        Fri, 10 Jul 2020 10:36:53 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n16sm9903857wmc.40.2020.07.10.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:36:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/4] habanalabs: verify queue can contain all cs jobs
Date:   Fri, 10 Jul 2020 20:36:51 +0300
Message-Id: <20200710173652.31039-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710173652.31039-1-oded.gabbay@gmail.com>
References: <20200710173652.31039-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order for the user to be aware of wrong inputs, we must return
error in case the amount of jobs per cs exceeds the corresponding
queue size.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h | 4 ++++
 drivers/misc/habanalabs/hw_queue.c   | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 01fb45887a5a..14def0d26d2d 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -421,6 +421,10 @@ struct hl_cs_job;
 #define HL_QUEUE_LENGTH			4096
 #define HL_QUEUE_SIZE_IN_BYTES		(HL_QUEUE_LENGTH * HL_BD_SIZE)
 
+#if (HL_MAX_JOBS_PER_CS > HL_QUEUE_LENGTH)
+#error "HL_QUEUE_LENGTH must be greater than HL_MAX_JOBS_PER_CS"
+#endif
+
 /* HL_CQ_LENGTH is in units of struct hl_cq_entry */
 #define HL_CQ_LENGTH			HL_QUEUE_LENGTH
 #define HL_CQ_SIZE_IN_BYTES		(HL_CQ_LENGTH * HL_CQ_ENTRY_SIZE)
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 474a0e8a7797..287681646071 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -158,6 +158,13 @@ static int int_queue_sanity_checks(struct hl_device *hdev,
 {
 	int free_slots_cnt;
 
+	if (num_of_entries > q->int_queue_len) {
+		dev_err(hdev->dev,
+			"Cannot populate queue %u with %u jobs\n",
+			q->hw_queue_id, num_of_entries);
+		return -ENOMEM;
+	}
+
 	/* Check we have enough space in the queue */
 	free_slots_cnt = queue_free_slots(q, q->int_queue_len);
 
-- 
2.17.1

