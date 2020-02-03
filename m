Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E58DC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401A20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfpBpPqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBCKlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33823 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgBCKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:41:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so17349618wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9S9BwHx5UyCKJX2JPPBf1rlNAUg9PfPZ0MUkcYcdubg=;
        b=mfpBpPqmwAcPO0e1BueHHoL83GQn+u39S5fzLWe3sm5x6q5ch5+7z+JZBr4ud9N0ka
         hlCWy6oQ6MXEvBvTA8Q+j+u28FVALLwfiLqQx7aIal1Ejk3ATshmevA5ZWy9nfGeA07n
         6y6mFC7QPC8xUMujiRmFt0sG3zlgNQ7Gi9EReoaRy3Yshq+V4b2MZmGIJrv2/xpIMUpA
         xhDin3yzdFtWzB9QeaGkIcW+DKXTuvfOlUdjgia27BH37xhmkX5GBHnLVoiGQw25/Pq6
         U4mfRfzrL9gTtnfZ8Cr7P8f4pVg+ugLieOD+Eb91fD8v0VQp9ph0V2zYweLoCT/0rDJi
         iuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9S9BwHx5UyCKJX2JPPBf1rlNAUg9PfPZ0MUkcYcdubg=;
        b=enra6teAA4ABqKWD0Ybrenn7FUROr5VPFo2KO1P9/bZSXXxLJtQ301L68Cfg1NXJEP
         z1yXAFpmDh5TAhaESf1uOf+kxpbsYVqw4RuVxlpWtszn5VF2dxq3gZZltRIrspXyzTxd
         elmkhXB6olw0vE2g/fF4EcpfNcEBdqL4hCsaQSGjYKoyEQaDxjNP4NGVJ0oGlGEk/uoK
         7vynGceUR5GWmSiI/IrGYJEwfkT7w+kmVUFyNrkA04y/3Ss3PrswhiDkasZn+iGXmMin
         qCSNINNHgg4LoRUanEewBa+Y1fPVqWlsxYUeyZtO8T99cv7waaMeZLHWe/qC16AM6b0H
         B1DQ==
X-Gm-Message-State: APjAAAWBnDg4nPm8bN8QlNJoWHYIgjS0uHH20ayzAVKGCOCrwYfwoh/U
        jw8PARc7/77pzhAN6Xh2zZl27w==
X-Google-Smtp-Source: APXvYqzvjhTRZEZ5VF4yVYhrSP28dia4+T4/m+hIu2Fuz4jmFCuGLvFyyZMHxuYLNAm7vCE7ys+TmQ==
X-Received: by 2002:adf:b352:: with SMTP id k18mr14456202wrd.242.1580726478647;
        Mon, 03 Feb 2020 02:41:18 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:18 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 3/7] block, bfq: get extra ref to prevent a queue from being freed during a group move
Date:   Mon,  3 Feb 2020 11:40:56 +0100
Message-Id: <20200203104100.16965-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bfq_bfqq_move(), the bfq_queue, say Q, to be moved to a new group
may happen to be deactivated in the scheduling data structures of the
source group (and then activated in the destination group). If Q is
referred only by the data structures in the source group when the
deactivation happens, then Q is freed upon the deactivation.

This commit addresses this issue by getting an extra reference before
the possible deactivation, and releasing this extra reference after Q
has been moved.

Tested-by: Chris Evich <cevich@redhat.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e1419edde2ec..8ab7f18ff8cb 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
+	/*
+	 * get extra reference to prevent bfqq from being freed in
+	 * next possible deactivate
+	 */
+	bfqq->ref++;
+
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st)
@@ -670,6 +676,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
+	/* release extra ref taken above */
+	bfq_put_queue(bfqq);
 }
 
 /**
-- 
2.20.1

