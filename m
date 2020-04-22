Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25112C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042092084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qf0tl6o9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgDVLaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbgDVL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:48 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349FC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=F/2M+3uCcIIYBaEgbSMCa+xIQ9jhjFLQi2y3VV4uMS0=; b=qf0tl6o9j0mZYhS0+GjDLY08lr
        wc+TwAHba2lEy+bVkg8aPqQ1dCf9/5FDhxCZQ+k4kDP+/DV7B/bA3wamXLCa+amu0Y1gENMavxXlX
        NDWvGCsT/D7V+P2ABd+1asv4wtaK47GR4n82wc5FjNgfbecKGduQXdCvaYYnSDL+T2V9EmvEJ3isy
        L+NycOsQ4plcJv+kKYS+b8jAU3PfUG4HKEwWbkbbcI/iYm19IR01PpDe4nFMjigcKdlMOuRSKs85W
        xIv8STA5SdVkFHHfh35kzDpt+VvjDpVoWdmbx+muKCVXzLiPELczx+25MFepKlTqyNcf79LsmDbqX
        7aqm09/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rF-D2; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5043230796F;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E87E322B9588C; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112832.046704918@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, rafael.j.wysocki@intel.com
Subject: [PATCH 14/23] sched,powerclamp: Convert to sched_set_fifo()
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

Cc: rafael.j.wysocki@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -70,9 +70,6 @@ static unsigned int control_cpu; /* The
 				  */
 static bool clamping;
 
-static const struct sched_param sparam = {
-	.sched_priority = MAX_USER_RT_PRIO / 2,
-};
 struct powerclamp_worker_data {
 	struct kthread_worker *worker;
 	struct kthread_work balancing_work;
@@ -488,7 +485,7 @@ static void start_power_clamp_worker(uns
 	w_data->cpu = cpu;
 	w_data->clamping = true;
 	set_bit(cpu, cpu_clamping_mask);
-	sched_setscheduler(worker->task, SCHED_FIFO, &sparam);
+	sched_set_fifo(worker->task);
 	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
 	kthread_init_delayed_work(&w_data->idle_injection_work,
 				  clamp_idle_injection_func);


