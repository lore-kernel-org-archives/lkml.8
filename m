Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F1BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CB42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7dSyM5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgDVLaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgDVL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:41 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6001AC03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9g4r6q7AhlxJyKMxLMZSOJaQKW4RGNomXN8KXNdpsA4=; b=d7dSyM5JLwraX8GDOhoQCDT5bU
        I6AKAtKyzrhL/vsljt2kKLhI7R5P/w67Z2n9HzaxNLaimnDRE006AMKFIWF89Bn9lPZ+1dwohvmBS
        6t90L473q8nIVxm6YblUlVx4ppt6DuHy9oifl27gdFhL39AOo3W8iDV5lqxxt0tKxDRfWk/rV6OUx
        dO2ZT9fFrZI8nBuPswnXv4WnoL2+pyX5R205rmFjNVjgN5chf0/YTPlny6971B5a031Ug1XNlDQwd
        XleYb38Eg1d/mgYVb0LhIZcI03KDaWp6fPvAx5zYcNv+ztfOE4pCMj/nsa8DqLoGZHKnld2opXq0K
        l4Lb3d8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rE-Cp; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41AB1307968;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D35CE200C22D9; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.752048390@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, hverkuil@xs4all.nl, awalls@md.metrocast.net
Subject: [PATCH 09/23] sched,ivtv: Convert to sched_set_fifo*()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively changes from 99 to 50.

Cc: hverkuil@xs4all.nl
Cc: awalls@md.metrocast.net
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/media/pci/ivtv/ivtv-driver.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -737,8 +737,6 @@ static void ivtv_process_options(struct
  */
 static int ivtv_init_struct1(struct ivtv *itv)
 {
-	struct sched_param param = { .sched_priority = 99 };
-
 	itv->base_addr = pci_resource_start(itv->pdev, 0);
 	itv->enc_mbox.max_mbox = 2; /* the encoder has 3 mailboxes (0-2) */
 	itv->dec_mbox.max_mbox = 1; /* the decoder has 2 mailboxes (0-1) */
@@ -758,7 +756,7 @@ static int ivtv_init_struct1(struct ivtv
 		return -1;
 	}
 	/* must use the FIFO scheduler as it is realtime sensitive */
-	sched_setscheduler(itv->irq_worker_task, SCHED_FIFO, &param);
+	sched_set_fifo(itv->irq_worker_task);
 
 	kthread_init_work(&itv->irq_work, ivtv_irq_work_handler);
 


