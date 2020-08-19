Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FAEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07B9204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ul91qwYc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ml5poECX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHSOHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgHSOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3CC061342;
        Wed, 19 Aug 2020 07:02:46 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZxacZYGwzkSlpWVldrL7lrGnse2xeeVTqQPZXow7kQ=;
        b=ul91qwYcdqt139yZBuGFRjyATEbRSa07bUzS//Zmyp7UHh1I9vLB3/1fBu7ic4EqX0InM3
        O5vLBH19YtJsS5H43NVX+V2FtcBA+34sQicUjTnQp4VyPH/gODHbb1Dbfo+cHg7yc9jd1V
        doci6TqrZjVp4XiaaLYDJNsPQnTNhG+SF5ZKWAzjpjweplmDTzpH/WbuSFCzLgL78X8ezy
        FO10DMtf6zhEiDF0pGKUavSrQKZg+rHm7V3aql9jdU/CWQOZ03BY757VO9Ayux8zIO9AmS
        L29g5ZcuAF3dqgwT5izTNQNNMQ6ZmqgfA9kGOxNlgNc7QuW2D7eS8SMKqAEbVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZxacZYGwzkSlpWVldrL7lrGnse2xeeVTqQPZXow7kQ=;
        b=ml5poECXhNaofqWnWZwY/R8TKE5nSmWcR6hdqd5THWCoHjYC/q5xxleAP5MQ6uVucZQ5gJ
        +p41OuIuQlyVcjCA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark SD_SERIALIZE as SDF_NEEDS_GROUPS
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-14-valentin.schneider@arm.com>
References: <20200817113003.20802-14-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576368.3192.17375211211805639534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bdb7c802cc0a7e21f5223dc3ce41b7ac220c576e
Gitweb:        https://git.kernel.org/tip/bdb7c802cc0a7e21f5223dc3ce41b7ac220c576e
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:49 +02:00

sched/topology: Mark SD_SERIALIZE as SDF_NEEDS_GROUPS

There would be no point in preserving a sched_domain with a single group
just because it has this flag set. Add it to SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-14-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 729510a..b7f4d80 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -112,11 +112,12 @@ SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
  * Only a single load balancing instance
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE. Could be set from a
- * different level upwards, but it doesn't change that if a domain has this flag
- * set, then all of its parents need to have it too (otherwise the serialization
- * doesn't make sense).
+ *                different level upwards, but it doesn't change that if a
+ *                domain has this flag set, then all of its parents need to have
+ *                it too (otherwise the serialization doesn't make sense).
+ * NEEDS_GROUPS: No point in preserving domain if it has a single group.
  */
-SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT)
+SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Place busy tasks earlier in the domain
