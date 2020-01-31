Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D22C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C8E20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="al+Fp398"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAaPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:18:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAaPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IcI3x8o7HZQnoP+HjD1skPBuEnJN1YCJ8o2S/TJ+pxU=; b=al+Fp398PU6xh2t9u29cEadZzk
        4OmmwLv+ZxtRr3OLwcgjFGK54qCEVXdXvD0K9GQI1bpJasXM5L5+Rqn1w4aiSspnBXtY7uZ6dhTNo
        5k/AiV3MtKUWAo6AFgObapoHbbCDTLlhZ1x1tTP+/H0fykzT6ilJHRGSAk25YoWXK/a7qjDrEssc+
        2rB6ATbknXZbW2kbJBpD8oAdM//8qXhbxqdh9o6K4SGRYTRMCmpDff4+4KpfrndB1V3khkIrNSPm6
        ZhmVx6ZA2TQYZLaDKbuOllLUSo7aJVBMDkPmh7VXOoic5HVI9wQhtrVC8469E4jvOSwb6uZV6I94R
        fl2RXoIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixY3W-00045b-Va; Fri, 31 Jan 2020 15:18:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 052DD3062B3;
        Fri, 31 Jan 2020 16:16:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BF79D2B64DB7A; Fri, 31 Jan 2020 16:17:58 +0100 (CET)
Message-Id: <20200131151540.098485539@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 16:07:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH -v2 4/7] locking/percpu-rwsem: Extract __percpu_down_read_trylock()
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing the embedded rwsem and building a custom
lock, extract the read-trylock primitive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/locking/percpu-rwsem.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ void percpu_free_rwsem(struct percpu_rw_
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
 	__this_cpu_inc(*sem->read_count);
 
@@ -73,11 +73,18 @@ bool __percpu_down_read(struct percpu_rw
 	if (likely(!smp_load_acquire(&sem->readers_block)))
 		return true;
 
-	/*
-	 * Per the above comment; we still have preemption disabled and
-	 * will thus decrement on the same CPU as we incremented.
-	 */
-	__percpu_up_read(sem);
+	__this_cpu_dec(*sem->read_count);
+
+	/* Prod writer to re-evaluate readers_active_check() */
+	rcuwait_wake_up(&sem->writer);
+
+	return false;
+}
+
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+{
+	if (__percpu_down_read_trylock(sem))
+		return true;
 
 	if (try)
 		return false;


