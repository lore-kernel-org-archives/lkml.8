Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71836C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E401205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FezNRTpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHRLbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHRL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD915C061347
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OKFRlXWNEddzDw53ssxjFdKgXZ+jfOMyaRhLefhCHJk=; b=FezNRTpKbSpwqn/eN02FSax3gM
        qyQEDbtM6GWsOIif5QH8EZFExYWs3k3b2XjqqoyQwS0cTf2j99F6C7Jd8suvNOBJ88KtkJYLwJt2A
        jrk5MSBd5WYVcfcAB+WE9KBO68bSI+kDB6cEfkRd0F6o4onRncd7ujZ2ZvsKHcFoIuW8NCpZmUTXr
        TUt9P2ZCV1Scr6d6sOxc6DIgEp+ubDruvk/vwEZmHlRJ1m0hwB+4E5LDrcNCYp7iyYnYxa7bO/muM
        WxjwSNcDBeMoeEKBeHq+kz7ir0Nriy2uau/82MYw2rtL2vbhtgTalIqSugT5/aqZdyd3eRRvI5YtM
        dF2TfGrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmP-0002AX-ND; Tue, 18 Aug 2020 11:27:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E98A23075F1;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E9DE200D4C3D; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.393286046@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH v2 07/10] sched/fair: Exclude the current CPU from find_new_ilb()
References: <20200818105102.926463950@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for find_new_ilb() to select the current CPU, however,
this only happens from newidle balancing, in which case need_resched()
will be true, and consequently nohz_csd_func() will not trigger the
softirq.

Exclude the current CPU from becoming an ILB target.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10026,6 +10026,10 @@ static inline int find_new_ilb(void)
 
 	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
 			      housekeeping_cpumask(HK_FLAG_MISC)) {
+
+		if (ilb == smp_processor_id())
+			continue;
+
 		if (idle_cpu(ilb))
 			return ilb;
 	}


