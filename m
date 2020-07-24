Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1992074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SKZzUlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ApW+XMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgGXIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGXIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701CC0619E4;
        Fri, 24 Jul 2020 01:33:49 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m10yIAAugBrNN90umDqQAH7IAURKVBeL6B4w8iZu0XY=;
        b=1SKZzUlSj+6k03BJNo4I5dDc/lt6UEM77NWUj3jdJAU+GDnC39UHYtnVpQA+ZFje+CUsTt
        gygrs/bZpA2KL6JWdhaBRG8bgklcO4mRWgXsNZcbHHsW+3w2olJt8WYdy7VnIXeqYA+ijb
        KL1PQcYTxRL087PwPX4dSVx9Mg046FHiFKr2tO0TKq/wVorc0+Y9mPdlxwyllQdTbyV2aF
        AEsSai01IbDCslppkVOy3xk0an8A1yohDMih4f5CziIs5dywOqgcLgB29GqNLEunpvt+jj
        plxJfTFEjhKYP1lEc4GTyDlN4TPDAcUGHoPwQaPUQJzNITE6dldX3QDmVTPCbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m10yIAAugBrNN90umDqQAH7IAURKVBeL6B4w8iZu0XY=;
        b=7ApW+XMtO0bSddi8Bos1pKfLg76HWzZw05cM6fp4V9FcrMMtyApi6iUZkQTSykwnbfWaCh
        MtRCp90U31lV10Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,ivtv: Convert to sched_set_fifo*()
Cc:     awalls@md.metrocast.net,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962710.4006.4061141520149933157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     73f73cc2432acf2e1c8a1ce0720eaced7b5dda16
Gitweb:        https://git.kernel.org/tip/73f73cc2432acf2e1c8a1ce0720eaced7b5dda16
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:22 +02:00

sched,ivtv: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively changes from 99 to 50.

Cc: awalls@md.metrocast.net
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/pci/ivtv/ivtv-driver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index b1dde1b..28acb14 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -737,8 +737,6 @@ done:
  */
 static int ivtv_init_struct1(struct ivtv *itv)
 {
-	struct sched_param param = { .sched_priority = 99 };
-
 	itv->base_addr = pci_resource_start(itv->pdev, 0);
 	itv->enc_mbox.max_mbox = 2; /* the encoder has 3 mailboxes (0-2) */
 	itv->dec_mbox.max_mbox = 1; /* the decoder has 2 mailboxes (0-1) */
@@ -758,7 +756,7 @@ static int ivtv_init_struct1(struct ivtv *itv)
 		return -1;
 	}
 	/* must use the FIFO scheduler as it is realtime sensitive */
-	sched_setscheduler(itv->irq_worker_task, SCHED_FIFO, &param);
+	sched_set_fifo(itv->irq_worker_task);
 
 	kthread_init_work(&itv->irq_work, ivtv_irq_work_handler);
 
