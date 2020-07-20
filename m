Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC0C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C7E2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260170;
	bh=xisV9O1MQFO//s+dF/qHJwRuCjGNODsK2gNeBFmefYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=peFlx0ZgdebDZlFdhmi2sQtycB3Li3RBFFqNN/wCQ3loabPPVpgqfF71mPcabMsBb
	 V8i2sopeVrpLtFHtd23VCuf8sJNNkjjL3XKzIzLJTHPm8gBZGQ+X+Nfpm4ttfAwA3X
	 gzcy562dl964Qkb4FM3GUB1LImCFpnk0veM0s7n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgGTPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731011AbgGTPtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:49:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DC3206E9;
        Mon, 20 Jul 2020 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260163;
        bh=xisV9O1MQFO//s+dF/qHJwRuCjGNODsK2gNeBFmefYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmhV11thPE9hK7YfIYZzDTvfCTP3nqw9USsvLMtkOwhJJnXxNklzcIpfIbIHeUqET
         vkaOnsfHTmXz1VmpCVAHDZ1Kut6z0AjtR/jSEbNFNKGzhnUeo/akUfDTofU56x2vbU
         9qiX70xQq747eccwVvCQhGGkt2FoVmzGtGtcvfxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 4.14 122/125] sched/fair: handle case of task_h_load() returning 0
Date:   Mon, 20 Jul 2020 17:37:41 +0200
Message-Id: <20200720152808.948148629@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

commit 01cfcde9c26d8555f0e6e9aea9d6049f87683998 upstream.

task_h_load() can return 0 in some situations like running stress-ng
mmapfork, which forks thousands of threads, in a sched group on a 224 cores
system. The load balance doesn't handle this correctly because
env->imbalance never decreases and it will stop pulling tasks only after
reaching loop_max, which can be equal to the number of running tasks of
the cfs. Make sure that imbalance will be decreased by at least 1.

misfit task is the other feature that doesn't handle correctly such
situation although it's probably more difficult to face the problem
because of the smaller number of CPUs and running tasks on heterogenous
system.

We can't simply ensure that task_h_load() returns at least one because it
would imply to handle underflow in other places.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: <stable@vger.kernel.org> # v4.4+
Link: https://lkml.kernel.org/r/20200710152426.16981-1-vincent.guittot@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 kernel/sched/fair.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6871,7 +6871,15 @@ static int detach_tasks(struct lb_env *e
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		load = task_h_load(p);
+		/*
+		 * Depending of the number of CPUs and tasks and the
+		 * cgroup hierarchy, task_h_load() can return a null
+		 * value. Make sure that env->imbalance decreases
+		 * otherwise detach_tasks() will stop only after
+		 * detaching up to loop_max tasks.
+		 */
+		load = max_t(unsigned long, task_h_load(p), 1);
+
 
 		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
 			goto next;


