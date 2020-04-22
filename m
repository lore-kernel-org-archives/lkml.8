Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E95CC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BC920787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QTMBIgTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgDVL3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgDVL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91390C03C1AC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cnrSiGbC4LxIy+T+mcqfCXXAUeMg7Ccfmt0ZXcDLJiA=; b=QTMBIgTUwlAfvvUmLVqM405WTD
        BHLZZSwL7BF11lHVjYs2w9JHuydqcEbQ18DEoxCBE/WZcgsaRwBuKjM9pweFIakEEGlLInlcJ04su
        jwBWjaH8v1UhbcTzF5+tgIquEYs7TspuECuhmD4pNBR4ySpDCUewjDKcqRNNL9nbcq+iNMKGsR76w
        XKpyXkQOG+D/Vbd+dPEAem9vjEBsRX8VijK4oSE3qYE7cLyZxU7dDP4w0jHyAfBnjyPYLpTB/dVjA
        Ac2sByJ3/UzFSAoinCQ+h29yEHzUWTA/16G8WnptUVKCa4H1yaFeUIArqVAOCDj48LUeZymDlt2iU
        oJ1OElig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYw-0006qr-Rx; Wed, 22 Apr 2020 11:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49C7530796C;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DBB3B200BFB5A; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.870192415@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, broonie@kernel.org
Subject: [PATCH 11/23] sched,spi: Convert to sched_set_fifo*()
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

No effective change.

Cc: broonie@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/platform/chrome/cros_ec_spi.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -709,9 +709,6 @@ static void cros_ec_spi_high_pri_release
 static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 					   struct cros_ec_spi *ec_spi)
 {
-	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO / 2,
-	};
 	int err;
 
 	ec_spi->high_pri_worker =
@@ -728,8 +725,7 @@ static int cros_ec_spi_devm_high_pri_all
 	if (err)
 		return err;
 
-	err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
-					 SCHED_FIFO, &sched_priority);
+	err = sched_set_fifo(ec_spi->high_pri_worker->task);
 	if (err)
 		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
 	return err;
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1589,11 +1589,9 @@ EXPORT_SYMBOL_GPL(spi_take_timestamp_pos
  */
 static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
-
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
-	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
+	sched_set_fifo(ctlr->kworker_task);
 }
 
 static int spi_init_queue(struct spi_controller *ctlr)


