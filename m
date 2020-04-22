Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDECC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B52084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JKCTxASJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgDVLaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727005AbgDVL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4AC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AUh8MmslpUMJ2wP8frp01q4WQHBBNTkSlBFah8W1k6g=; b=JKCTxASJUqyTc3ajl8yY3w+RAm
        K2418edj37jpeBskutijj1HuCQpG2iHDMZuZBAT56QoGcGfbdahkv0YOG5+/TWJeVqRFBukwi6KEh
        o9IsrEHMISdg7xKKmywjGNwv0Q3Kbejvlc/GLfWCSyxtDZ6XtS2JEan+P+hvb+kL4cJUYb6ZdBpn0
        HyTajDa4saDsVa37nBMcJ3z+gJ/Rj4t+TDB1R9oMs7scSmPc+Nj49/Jzz7bgUAq6Nm+iXWNxlGS2V
        s++uvbtJZRl4wagFlPDhmhcul62xcSl6Z3KjRRlxV+H3MQEIziFNVru2kJZCLfUcmDfvHRIt8mYeT
        8TM0Bojw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rA-8l; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 521F6307972;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC4DD22B9589E; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112832.105778342@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, gregkh@linuxfoundation.org
Subject: [PATCH 15/23] sched,serial: Convert to sched_set_fifo()
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

Effectively no change.

Cc: gregkh@linuxfoundation.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1178,7 +1178,6 @@ static int sc16is7xx_probe(struct device
 			   const struct sc16is7xx_devtype *devtype,
 			   struct regmap *regmap, int irq, unsigned long flags)
 {
-	struct sched_param sched_param = { .sched_priority = MAX_RT_PRIO / 2 };
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
 	u32 uartclk = 0;
 	int i, ret;
@@ -1228,7 +1227,7 @@ static int sc16is7xx_probe(struct device
 		ret = PTR_ERR(s->kworker_task);
 		goto out_clk;
 	}
-	sched_setscheduler(s->kworker_task, SCHED_FIFO, &sched_param);
+	sched_set_fifo(s->kworker_task);
 
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio) {


