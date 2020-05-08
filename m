Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B52C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8955921473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941932;
	bh=k+uF28bM3EYqbE1z4cQO2hhX68Gskq36OmYNkk2t11E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJCfkzwBM/4ePXXH9mQdXzBrSX0rgnY+CBdL1hS+pJUkj7PWK+MPtiRswXlrAcQaL
	 3liynWv7T+lZCtcXON2lELV4aiK2zJadsrFKymXKxqGUH6b0EuAS36vTP6qC8kqS4W
	 tIa/lyeQuoXAsPEQ+jG7XnVGyDvj2gvFOAhzq1gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgEHMpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgEHMp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21424208D6;
        Fri,  8 May 2020 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941927;
        bh=k+uF28bM3EYqbE1z4cQO2hhX68Gskq36OmYNkk2t11E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okOnPnqOfuQbhA2nq9wqxpkxXFuS4zmW3KgLB8rYre3j+0uwz/uXZEzaLss189Ene
         djMsM8g9rDzeQ1jYslK9jviSiNzFrp37sWKVr7CxzjivwvQUHD2PHpFlxh1q14IS8t
         dKQr6fF4cTh7T8qw4J8bII5mybvFlDfLveHnTB60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 226/312] pkt_sched: fq: use proper locking in fq_dump_stats()
Date:   Fri,  8 May 2020 14:33:37 +0200
Message-Id: <20200508123140.348222796@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 695b4ec0f0a9cf29deabd3ac075911d58b31f42b upstream.

When fq is used on 32bit kernels, we need to lock the qdisc before
copying 64bit fields.

Otherwise "tc -s qdisc ..." might report bogus values.

Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/sch_fq.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -830,20 +830,24 @@ nla_put_failure:
 static int fq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
-	u64 now = ktime_get_ns();
-	struct tc_fq_qd_stats st = {
-		.gc_flows		= q->stat_gc_flows,
-		.highprio_packets	= q->stat_internal_packets,
-		.tcp_retrans		= q->stat_tcp_retrans,
-		.throttled		= q->stat_throttled,
-		.flows_plimit		= q->stat_flows_plimit,
-		.pkts_too_long		= q->stat_pkts_too_long,
-		.allocation_errors	= q->stat_allocation_errors,
-		.flows			= q->flows,
-		.inactive_flows		= q->inactive_flows,
-		.throttled_flows	= q->throttled_flows,
-		.time_next_delayed_flow	= q->time_next_delayed_flow - now,
-	};
+	struct tc_fq_qd_stats st;
+
+	sch_tree_lock(sch);
+
+	st.gc_flows		  = q->stat_gc_flows;
+	st.highprio_packets	  = q->stat_internal_packets;
+	st.tcp_retrans		  = q->stat_tcp_retrans;
+	st.throttled		  = q->stat_throttled;
+	st.flows_plimit		  = q->stat_flows_plimit;
+	st.pkts_too_long	  = q->stat_pkts_too_long;
+	st.allocation_errors	  = q->stat_allocation_errors;
+	st.time_next_delayed_flow = q->time_next_delayed_flow - ktime_get_ns();
+	st.flows		  = q->flows;
+	st.inactive_flows	  = q->inactive_flows;
+	st.throttled_flows	  = q->throttled_flows;
+	st.pad			  = 0;
+
+	sch_tree_unlock(sch);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
 }


