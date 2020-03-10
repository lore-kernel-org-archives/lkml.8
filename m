Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06754C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FE420409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MFD38q7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgCJNHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:07:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50289 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbgCJNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:07:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so1334746wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PP63n4exnMNKX7lpvmvyJwMQWnXIxOlpOmy5QQY9xLA=;
        b=MFD38q7BzBjfElXqAV7xBgBy4BXd4rBDKr7W+kAopPCUZCNA/zrSAWTJTKbG+oxOPr
         AmfDSgyk63mq6fscWU8aPQOChW8ehrZdp1sE5NpXlcEV4hUUgdkkGaG8I2hP3td7kksZ
         zie2znp15Ow4/+KpsIM28rxV5SVJyLX9y4cH2W2iIMBZpg7SsmWGQdU085OXLbZwyws4
         eUCwyhhgiT+fpl/lnKbL0axo6NoVsJgrexFSl1X/1mmSXIG+72e8bOG63QW/a+/RuntM
         hveu9qnbXmI6vIJYuZJSpplVYSeQKraoaKTtH2s2pEEFgQd66L8m2f2iOa4PkmZNzI5N
         8kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PP63n4exnMNKX7lpvmvyJwMQWnXIxOlpOmy5QQY9xLA=;
        b=gi1stOWMGrWhYpZUNJaoVdOAGsrz/8XuMsRoEXKxLXk904pTcIrFO9LUrBAHmiN8qZ
         pnuxv1HGYy8SqZf+A/RVShNta1Q+Xt+AZkrGjDHnsvcWQYgyzZKxPG/4hcMbf/1cRt1V
         MENjTSKDXRpgesbWGYBl3W7s0h3fgqO7/E5dTEqTIxXqxxZ1AeXz+bkYNqLVPi8wZolO
         Z2eaHp34XDT09oS7f0n60Q+YB0dyUeXwrGQq5w4Dk0ZplzRPt4Y22TGHQKxSpg6RoUJs
         KhS2KyZaymZ7RYKgn2t4KUSq5ZHzqFeABzA8iQY2E0zGPiOGrqVFBy5DDJ5xEVOhxKT1
         fvSg==
X-Gm-Message-State: ANhLgQ2/AGZ1LCcSTlfnp+zpn65ZIBl2u/C9inKTxcddSZHsQwqNbH1O
        M+QGR7zuWj5MH/Z0PRKRuGwUkA==
X-Google-Smtp-Source: ADFU+vtEsPNZPcMrSWBibyD6jxev3SWQJHDu3DoFC+EAYrSBKkEFpF1BuZh38BFU06MmgQFunOgrFQ==
X-Received: by 2002:a1c:4642:: with SMTP id t63mr2084570wma.164.1583845628929;
        Tue, 10 Mar 2020 06:07:08 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id w22sm4129323wmk.34.2020.03.10.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:07:07 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Only freeze block queue when needed.
Date:   Tue, 10 Mar 2020 14:06:54 +0100
Message-Id: <20200310130654.92205-1-maco@android.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__loop_update_dio() can be called as a part of loop_set_fd(), when the
block queue is not yet up and running; avoid freezing the block queue in
that case, since that is an expensive operation.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..c1c844ad6b1a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -214,7 +214,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	 * LO_FLAGS_READ_ONLY, both are set from kernel, and losetup
 	 * will get updated by ioctl(LOOP_GET_STATUS)
 	 */
-	blk_mq_freeze_queue(lo->lo_queue);
+	if (lo->lo_state == Lo_bound)
+		blk_mq_freeze_queue(lo->lo_queue);
 	lo->use_dio = use_dio;
 	if (use_dio) {
 		blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, lo->lo_queue);
@@ -223,7 +224,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
 	}
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (lo->lo_state == Lo_bound)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
 static int
-- 
2.25.1.481.gfbce0eb801-goog

