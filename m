Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA85C35E1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CBE2468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813499;
	bh=hzIUODltB8CaaldLAxlIk6S4sMoGiLxfeP47cHNFmO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eublaqLT4xRSm9lM/EFBMmOFLwaWYCHW3XpmdhH+3TJ0Mhx3FeqM+BGKwOkKE/MvD
	 AlyRxlzT7tjswk0VzA60/siyvUrZTN6YjbDNmZbjMxTn9Mn+29m44KaDt2cfGIG/WC
	 EuH7v0y/mExLMemnIi3ePtbpkF53VYrP6kFwcInI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgB0OML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387743AbgB0OME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:12:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B3120578;
        Thu, 27 Feb 2020 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812724;
        bh=hzIUODltB8CaaldLAxlIk6S4sMoGiLxfeP47cHNFmO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/SFMx1m/0sdcti6gDBEWb3rPVoyf9vLFLU2cWajpvnKiTKm4ARXxWuIhzVQceGqn
         nb4oCZt8YZkP3krG6sGXAGAXhVbSjR41A+1Y14cNPTNcDeOymoQfLFWDXxfJRiFIsL
         +YytcUUAzw6tmMJXH/TpVrDH2t6HRZc31SI1quYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 127/135] io_uring: prevent sq_thread from spinning when it should stop
Date:   Thu, 27 Feb 2020 14:37:47 +0100
Message-Id: <20200227132248.126675153@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

commit 7143b5ac5750f404ff3a594b34fdf3fc2f99f828 upstream.

This patch drops 'cur_mm' before calling cond_resched(), to prevent
the sq_thread from spinning even when the user process is finished.

Before this patch, if the user process ended without closing the
io_uring fd, the sq_thread continues to spin until the
'sq_thread_idle' timeout ends.

In the worst case where the 'sq_thread_idle' parameter is bigger than
INT_MAX, the sq_thread will spin forever.

Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/io_uring.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2732,16 +2732,6 @@ static int io_sq_thread(void *data)
 		to_submit = io_sqring_entries(ctx);
 		if (!to_submit) {
 			/*
-			 * We're polling. If we're within the defined idle
-			 * period, then let us spin without work before going
-			 * to sleep.
-			 */
-			if (inflight || !time_after(jiffies, timeout)) {
-				cond_resched();
-				continue;
-			}
-
-			/*
 			 * Drop cur_mm before scheduling, we can't hold it for
 			 * long periods (or over schedule()). Do this before
 			 * adding ourselves to the waitqueue, as the unuse/drop
@@ -2753,6 +2743,16 @@ static int io_sq_thread(void *data)
 				cur_mm = NULL;
 			}
 
+			/*
+			 * We're polling. If we're within the defined idle
+			 * period, then let us spin without work before going
+			 * to sleep.
+			 */
+			if (inflight || !time_after(jiffies, timeout)) {
+				cond_resched();
+				continue;
+			}
+
 			prepare_to_wait(&ctx->sqo_wait, &wait,
 						TASK_INTERRUPTIBLE);
 


