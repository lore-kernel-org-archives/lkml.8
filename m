Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26BFC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA80206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQyBJ4J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgBUPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:42:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728177AbgBUPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582299741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d1xiBHabr0cI0nVkv2W8qe7S3hdWOCkmluHZNS5Fdjo=;
        b=LQyBJ4J1NTEk80WtxtbOOS250EOJUSGrdk9/V/MFOxMHoZfQEx6h2JvLEaBI3gZpVcoAbv
        236SoT0QJolujSRa1JjScas/J52yCBQ6+X4+tZM2pk0s8EE5qIruTB+/11B0NBdQIRn6gu
        iaTr/DHwUpoEMd6Le9iBV6evEPfcxKo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491--wjrvbvTO5yo1uW5zNe7kg-1; Fri, 21 Feb 2020 10:42:19 -0500
X-MC-Unique: -wjrvbvTO5yo1uW5zNe7kg-1
Received: by mail-wm1-f70.google.com with SMTP id g26so769593wmk.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1xiBHabr0cI0nVkv2W8qe7S3hdWOCkmluHZNS5Fdjo=;
        b=HBKxPf5eFJ/TlbHoKKVGg2pW7Zy3yBDt56o8Pxm9SblCKeE4nOv4HnmN9DwFnJde4C
         eWtDf2zDFWhwFLKL1N5QfGugifM85d1VzoSIyqVcQZfTCpDyiRyToqJCLQLmEhQrniIt
         N+gpAWDrTWtnVXWUsuxt1PlJsjuyUozby2RimgCkd+P87UNTZNJgCHm+UeujK4B9L0oE
         h/beKG2Jc9O6YO/4PgArjQNR9hEkBGVVtGgXwesl0AGdsmFkJH17Z0QlRB6WkJ40K+1Y
         tF42Pd2Az6vtHEDBQjD6wR0OwwYH1j69uY5dwjZvYjiTSX1SYeGI1sOkROVzv2CurD8d
         N3rA==
X-Gm-Message-State: APjAAAWBZWQrAz6Q5rnMROBrKp7L94lhmNrojzDulcRLmS7OqTAJdxpR
        F6AigsdfywZuv+P0whwA2lGtRJEWGwCjxO6PBrvffnD9ger+tHNow5sZfNAGdodMR9UU/Nbp1TC
        UOS81vJd8LV7nFSRAiJW9DO2j
X-Received: by 2002:a7b:c753:: with SMTP id w19mr4665156wmk.34.1582299738379;
        Fri, 21 Feb 2020 07:42:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSWhT4n2jDvp8FWxa5PtF0QnBD+5CXqoCnpF/WyJoVcrZZSoX+kB/LMcPcy2QzVI9BPmha7Q==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr4665132wmk.34.1582299738067;
        Fri, 21 Feb 2020 07:42:18 -0800 (PST)
Received: from steredhat.redhat.com (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id c9sm4238078wme.41.2020.02.21.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:42:17 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: prevent sq_thread from spinning when it should stop
Date:   Fri, 21 Feb 2020 16:42:16 +0100
Message-Id: <20200221154216.206367-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch drops 'cur_mm' before calling cond_resched(), to prevent
the sq_thread from spinning even when the user process is finished.

Before this patch, if the user process ended without closing the
io_uring fd, the sq_thread continues to spin until the
'sq_thread_idle' timeout ends.

In the worst case where the 'sq_thread_idle' parameter is bigger than
INT_MAX, the sq_thread will spin forever.

Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Hi Jens,
I'm also sending a test to liburing for this case.

Cheers,
Stefano
---
 fs/io_uring.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5a826017ebb8..f902f77964ef 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5138,6 +5138,18 @@ static int io_sq_thread(void *data)
 		 * to enter the kernel to reap and flush events.
 		 */
 		if (!to_submit || ret == -EBUSY) {
+			/*
+			 * Drop cur_mm before scheduling, we can't hold it for
+			 * long periods (or over schedule()). Do this before
+			 * adding ourselves to the waitqueue, as the unuse/drop
+			 * may sleep.
+			 */
+			if (cur_mm) {
+				unuse_mm(cur_mm);
+				mmput(cur_mm);
+				cur_mm = NULL;
+			}
+
 			/*
 			 * We're polling. If we're within the defined idle
 			 * period, then let us spin without work before going
@@ -5152,18 +5164,6 @@ static int io_sq_thread(void *data)
 				continue;
 			}
 
-			/*
-			 * Drop cur_mm before scheduling, we can't hold it for
-			 * long periods (or over schedule()). Do this before
-			 * adding ourselves to the waitqueue, as the unuse/drop
-			 * may sleep.
-			 */
-			if (cur_mm) {
-				unuse_mm(cur_mm);
-				mmput(cur_mm);
-				cur_mm = NULL;
-			}
-
 			prepare_to_wait(&ctx->sqo_wait, &wait,
 						TASK_INTERRUPTIBLE);
 
-- 
2.24.1

