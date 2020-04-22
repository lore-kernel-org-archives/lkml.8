Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A141C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E1220784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hJK16TrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgDVLai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A3C03C1AC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hIBaCNSRemFVEzhqrrl9kg85oWY2pS0HF6ixxeBRHNw=; b=hJK16TrSGxulCJj9Io39Ej14GX
        mSNdLOTjweF+330qm6SwbwIB/tTRjBUFRMCrvAOnau5zOXvu1sA84wE/0eeTyDDnPTo6U2EnY7u2T
        fViuUYCkEHP6oJwtAdKszqPitQHAzT5Fke+DrStSN0/kPhz4XqzLZsRAV+zEqU6hqBmr2r+jGSDhr
        OeOULyDLQqH5Q67o0uZo18x9fqx/LyS7QS04m8FvJzpI0DmCb/hF/u2/gO1nILyGfWDV10Mu8dm/c
        enHXE9pmk7Taj3YJuEu5M00oQ6vUc+Wwvfub+rhXT4ZeqBSV/FueuPCuwfRljlp3T4PwCNhLKaFUd
        MY4KmkZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYx-0003aw-5r; Wed, 22 Apr 2020 11:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6BDE30761D;
        Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C1E73200D6D77; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.455977635@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, rafael.j.wysocki@intel.com
Subject: [PATCH 04/23] sched,acpi_pad: Convert to sched_set_fifo*()
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

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively no change in behaviour.

XXX: this driver is still complete crap; why isn't it using proper
idle injection or at the very least play_idle() ?

Cc: rafael.j.wysocki@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/acpi/acpi_pad.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -136,12 +136,11 @@ static unsigned int idle_pct = 5; /* per
 static unsigned int round_robin_time = 1; /* second */
 static int power_saving_thread(void *data)
 {
-	struct sched_param param = {.sched_priority = 1};
 	int do_sleep;
 	unsigned int tsk_index = (unsigned long)data;
 	u64 last_jiffies = 0;
 
-	sched_setscheduler(current, SCHED_RR, &param);
+	sched_set_fifo_low(current);
 
 	while (!kthread_should_stop()) {
 		unsigned long expire_time;


