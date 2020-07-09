Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B7D20708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARXdkVSN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8vytKF5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGIIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgGIIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:45:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C8C08C5CE;
        Thu,  9 Jul 2020 01:45:57 -0700 (PDT)
Date:   Thu, 09 Jul 2020 08:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594284355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSFByPEcypiIEyf6y4RGTkTjeXRIWMgg+yKtgv59gYU=;
        b=ARXdkVSNe4phMNXvjRJdHUq34+NuR++G+rJoosb141F62hsXgkrl17jFRuD/b9thGT0R1o
        rQKeKnb9KUen+fwaFYy491X6nqyUzt8U+cYpUkWQ6DrwBuB+Zn6kos7hfTZPNuNV9dbt9Q
        buck9I6LrcZzTzfbsy4BdP74WjjQpjctHnSuS/OkGXx/n/K6/ag/iTxd/WCKlwm+8Bt/d1
        /8A3XqLvBCVt/c3tuA4TE5aG11yZQVDTD6bS9tx9uupKDI0LxpkvujlOTMXJWn7+BihKtu
        /VrCiLp288geWfaeuHcT3S18TrlYqCe2WGq3Bkm5qr2VbWfD82D9O3bI5ZWP1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594284355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSFByPEcypiIEyf6y4RGTkTjeXRIWMgg+yKtgv59gYU=;
        b=8vytKF5BxZxgqCqDzaY0cqo3FzVv9ksQeyKGapV2KwdfSQYrEhfuIwh844PLpZ14QK7lO0
        byWwkzTM/cTJP6BA==
From:   "tip-bot2 for Alex Belits" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] net: Restrict receive packets queuing to housekeeping CPUs
Cc:     Alex Belits <abelits@marvell.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200625223443.2684-4-nitesh@redhat.com>
References: <20200625223443.2684-4-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <159428435486.4006.10724144371533226449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     07bbecb3410617816a99e76a2df7576507a0c8ad
Gitweb:        https://git.kernel.org/tip/07bbecb3410617816a99e76a2df7576507a0c8ad
Author:        Alex Belits <abelits@marvell.com>
AuthorDate:    Thu, 25 Jun 2020 18:34:43 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:39:02 +02:00

net: Restrict receive packets queuing to housekeeping CPUs

With the existing implementation of store_rps_map(), packets are queued
in the receive path on the backlog queues of other CPUs irrespective of
whether they are isolated or not. This could add a latency overhead to
any RT workload that is running on the same CPU.

Ensure that store_rps_map() only uses available housekeeping CPUs for
storing the rps_map.

Signed-off-by: Alex Belits <abelits@marvell.com>
Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200625223443.2684-4-nitesh@redhat.com
---
 net/core/net-sysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e353b82..677868f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/if_arp.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/isolation.h>
 #include <linux/nsproxy.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
@@ -741,7 +742,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 {
 	struct rps_map *old_map, *map;
 	cpumask_var_t mask;
-	int err, cpu, i;
+	int err, cpu, i, hk_flags;
 	static DEFINE_MUTEX(rps_map_mutex);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -756,6 +757,13 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 		return err;
 	}
 
+	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
+	if (cpumask_empty(mask)) {
+		free_cpumask_var(mask);
+		return -EINVAL;
+	}
+
 	map = kzalloc(max_t(unsigned int,
 			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
 		      GFP_KERNEL);
