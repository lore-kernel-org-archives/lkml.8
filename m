Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3340C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743DC20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdbyEJ7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAaPS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:18:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgAaPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qdQ72X8eJDUegByfpEinwuR80lTNXL8pwZViVX83mfE=; b=OdbyEJ7ed8QFDLDOsIXw4wXSCa
        gpQugNCHyN5wXQJLRlLF+LXJn1lc0P04BUQS/ljpy6yyW8MM8NSzGw6bRlSvuYBlOGmYtgstqc8ey
        8mTn1fiqqhnKQYm+GhqInJZO6WFEX7aMQZyzccuP+N5iMNDazqvn75jcQfIcFdPMyU/eAycrgMabw
        CkFo5Kp5wN8oiwAuBYMc9x6wObplBbOcvfw1lavFP8wtRVHmzNdiZvrt08FR6Ox5F2VaDmUCJFnxs
        t5ILk5dXjEfy7fSw34XZXasWGj+OuMLxWAz4gKEMEuDBU+F9TfUmVg09wiMwKkBykeAxL2ql2XmQu
        XDT4LraA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixY3W-00045c-VQ; Fri, 31 Jan 2020 15:18:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DAD3306BE4;
        Fri, 31 Jan 2020 16:16:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C85A32B64DB7C; Fri, 31 Jan 2020 16:17:58 +0100 (CET)
Message-Id: <20200131151540.269115130@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 16:07:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -v2 7/7] locking/percpu-rwsem: Add might_sleep() for writer locking
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

We are missing this annotation in percpu_down_write(). Correct
this.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200108013305.7732-1-dave@stgolabs.net
---
 kernel/locking/percpu-rwsem.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -212,6 +212,7 @@ static bool readers_active_check(struct
 
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
 	/* Notify readers to take the slow path. */


