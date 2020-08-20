Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9677C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BA320738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926335;
	bh=nDS9YM9aJxkFu5ZzfkTqvZdFAxXbEzlO2tlYmVHlIJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F6efouO0CsyyLdlA4GdEL04u8LhMNY4zDnOB5VfUTFnf3lSaoIv/TVx0s060oGqfB
	 t/J8GjfRQUxSdK3+A/f0VcmBqwqUlfgP6pHUke7fSZccg6lyaXV7cWnieZIBE1wK/X
	 O9Tyzg2vGmTGSvkhi+e57+0xjYv+1U3rPj8solaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgHTMZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgHTJxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:53:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8492075E;
        Thu, 20 Aug 2020 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917202;
        bh=nDS9YM9aJxkFu5ZzfkTqvZdFAxXbEzlO2tlYmVHlIJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eda2NLqv6yOYee+CoyL+mcXm8cG7aczWcAxzMzWTS8ZobWO++Vo2x06Ehjta9V7wf
         kH/rPwUEAVZFzGGoOS8Ou+1IB2WEfgbpR13sm4yDQraTYnIIQQaCEg8mKds0ZtcOFK
         VBkniqCWCl0+sFx7959ixq+lOwWnGu7Qnj7fMT7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Kevin Hao <haokexin@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 39/92] tracing/hwlat: Honor the tracing_cpumask
Date:   Thu, 20 Aug 2020 11:21:24 +0200
Message-Id: <20200820091539.647153467@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hao <haokexin@gmail.com>

commit 96b4833b6827a62c295b149213c68b559514c929 upstream.

In calculation of the cpu mask for the hwlat kernel thread, the wrong
cpu mask is used instead of the tracing_cpumask, this causes the
tracing/tracing_cpumask useless for hwlat tracer. Fixes it.

Link: https://lkml.kernel.org/r/20200730082318.42584-2-haokexin@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 0330f7aa8ee6 ("tracing: Have hwlat trace migrate across tracing_cpumask CPUs")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_hwlat.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -270,6 +270,7 @@ static bool disable_migrate;
 static void move_to_next_cpu(void)
 {
 	struct cpumask *current_mask = &save_cpumask;
+	struct trace_array *tr = hwlat_trace;
 	int next_cpu;
 
 	if (disable_migrate)
@@ -283,7 +284,7 @@ static void move_to_next_cpu(void)
 		goto disable;
 
 	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 	next_cpu = cpumask_next(smp_processor_id(), current_mask);
 	put_online_cpus();
 
@@ -360,7 +361,7 @@ static int start_kthread(struct trace_ar
 	/* Just pick the first CPU on first iteration */
 	current_mask = &save_cpumask;
 	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tracing_buffer_mask);
+	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 	put_online_cpus();
 	next_cpu = cpumask_first(current_mask);
 


