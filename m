Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D7C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7806206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uph/QBYf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/4TXYni+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGYKNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:13:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:13:36 -0400
Date:   Sat, 25 Jul 2020 10:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595672014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYoF8hY7myky2pnc6JSt8kEeqXo7a7WL/ip8dCcLkjA=;
        b=Uph/QBYf+1WaWraTBk8zRHcYFUjwZGHA4ud41oKNGbh5z7sZd1+vzPKNdQpaMradGjmkGR
        yUgOqd7ZviZSsVEYCIFSpbVf1ij02YAqyAkFHDALsUG38GWirHVkXMeopZlKix+J0DIFno
        ZVfWw6mzdOTbntZzpIgwVkF2W0LJDaEuy1hYAVhnE4w9yRTXC4VFGZhmCRT0x9bfDDPUs2
        08d9uGWxfn3F1ILb3qP+bDaM9+1HpsTo8ok4K/dbI6cAgM9QN5m+FZkNsfDGx/0lpXLwBO
        MicmexzZYwJtNA5XYM2FnJRDRXIlPDm1IAT97MLg4W4hZTq/jlEYhtt3sxUKbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595672014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYoF8hY7myky2pnc6JSt8kEeqXo7a7WL/ip8dCcLkjA=;
        b=/4TXYni+zFp2xKXUPaGtUfn9K33yUJdg3KY8x+ljEq/AbepvgWGD6fCMR5A/EwZ+6cBPyI
        QhHsNzjUmncTSaAw==
From:   "tip-bot2 for Qinglang Miao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Remove unnecessary mutex_init()
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200725085629.98292-1-miaoqinglang@huawei.com>
References: <20200725085629.98292-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Message-ID: <159567201333.4006.12551438170876994206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     13efa616124f7eec7d6a58adeeef31864aa03879
Gitweb:        https://git.kernel.org/tip/13efa616124f7eec7d6a58adeeef31864aa03879
Author:        Qinglang Miao <miaoqinglang@huawei.com>
AuthorDate:    Sat, 25 Jul 2020 16:56:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 12:10:36 +02:00

sched/uclamp: Remove unnecessary mutex_init()

The uclamp_mutex lock is initialized statically via DEFINE_MUTEX(),
it is unnecessary to initialize it runtime via mutex_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20200725085629.98292-1-miaoqinglang@huawei.com
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bd8e521..6782534 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1425,8 +1425,6 @@ static void __init init_uclamp(void)
 	enum uclamp_id clamp_id;
 	int cpu;
 
-	mutex_init(&uclamp_mutex);
-
 	for_each_possible_cpu(cpu)
 		init_uclamp_rq(cpu_rq(cpu));
 
