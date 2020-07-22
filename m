Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC1DC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31E520729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Kc+aZvh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6FfKB5+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgGVJMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbgGVJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7877C0619DE;
        Wed, 22 Jul 2020 02:12:28 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omHB0IzWPPjMngZlXCyyJLHrhx3ZzshX+RzXI2T3C2Q=;
        b=1Kc+aZvhbfHATS4qa6EH7R6sGPiTbOfjQh6QL3rg1ehawkmZYOElrfVbnLneA5FjgsL0Ww
        X56HwjFn5TrN6dbcVt4G6w3n/ySIAAXXpSR5JbHuuJot9V/oEL8zV6LmXr3ic/dLXfEigf
        AzXZbVin09daw4VXefBf3D23Fbz7xRc0BMGn78RpZNYAx/FM2WxgYGf1LrK7RCNc6/C458
        1hNh8q/LQuOiYE5KfLxrY35PRu2kTCfHI2rclOdZ81KdEeSUzUOyHx+ZINlHqgVQoV8dKZ
        0szi5jcaMGF4yd9JwhgZ/vgBXVYdB+qWMgVAHDh2RHAhFAHTMUUpsTjKSDcvIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omHB0IzWPPjMngZlXCyyJLHrhx3ZzshX+RzXI2T3C2Q=;
        b=6FfKB5+rWBb9db7GVFArZ8IvC/Gy5roTTGjsM4RtyHnDg0KH4x8R5ToplxKpH5KxzKPByd
        4FeEWBAqBrX3nhDA==
From:   "tip-bot2 for Muchun Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Fix a potential usage of stale nr_cpus
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716070457.53255-1-songmuchun@bytedance.com>
References: <20200716070457.53255-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Message-ID: <159540914653.4006.6322052574571138388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     589343569d7b58a64ec2446e6686c8e79aea7fcf
Gitweb:        https://git.kernel.org/tip/589343569d7b58a64ec2446e6686c8e79aea7fcf
Author:        Muchun Song <songmuchun@bytedance.com>
AuthorDate:    Thu, 16 Jul 2020 15:04:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:04 +02:00

smp: Fix a potential usage of stale nr_cpus

The get_option() maybe return 0, it means that the nr_cpus is
not initialized. Then we will use the stale nr_cpus to initialize
the nr_cpu_ids. So fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200716070457.53255-1-songmuchun@bytedance.com
---
 kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index aa17eed..d0ae8eb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -634,8 +634,7 @@ static int __init nrcpus(char *str)
 {
 	int nr_cpus;
 
-	get_option(&str, &nr_cpus);
-	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
+	if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
 		nr_cpu_ids = nr_cpus;
 
 	return 0;
