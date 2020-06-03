Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DBB2087D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBxMVUoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFCLnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgFCLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3DC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yPkPZ4WAEN9GaKTtWJwMN7uBHheFrK3ZxdnYRFtfdVY=; b=oBxMVUoKGJnkIbDA7cVfxLp/u2
        LXo1oISDtMlx6Hd1HloXuPETyTK6om9nVkaxK7j/vCbFB8AfkWhaVXI1NkmsCtKyJsW/yZFi0egae
        0S6M1rV8QKYwH54ykncdjcDoQ7CXq+MIgDAaJjKWlgc2P6EtMGNsE1okepLmP9chSkhpL1/hkvZFj
        Ot3eChvTGZdwQNHe9R1zLPmWWtlLyK0VBoA6ipDXBvoa36eOeF43kiFu6hH2rwlEVatIQHWTbK6/P
        J/ZxWlvvqdFqyxxhCot4WXG3ucfoEPeVRENDtZc8j34w0E84uwI63HJrXabqCEQ+h69bxIBpitvc0
        msUYZi8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRmr-0005oV-F1; Wed, 03 Jun 2020 11:42:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 080FC306E56;
        Wed,  3 Jun 2020 13:42:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BB489209DB0D8; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114052.185201076@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 7/9] lockdep: __always_inline more for noinstr
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: debug_locks_off()+0xd: call to __debug_locks_off() leaves .noinstr.text section
vmlinux.o: warning: objtool: match_held_lock()+0x6a: call to look_up_lock_class.isra.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x90: call to lockdep_recursion_finish() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/debug_locks.h |    2 +-
 kernel/locking/lockdep.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -12,7 +12,7 @@ extern int debug_locks __read_mostly;
 extern int debug_locks_silent __read_mostly;
 
 
-static inline int __debug_locks_off(void)
+static __always_inline int __debug_locks_off(void)
 {
 	return xchg(&debug_locks, 0);
 }
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -393,7 +393,7 @@ void lockdep_init_task(struct task_struc
 	task->lockdep_recursion = 0;
 }
 
-static inline void lockdep_recursion_finish(void)
+static __always_inline void lockdep_recursion_finish(void)
 {
 	if (WARN_ON_ONCE(--current->lockdep_recursion))
 		current->lockdep_recursion = 0;
@@ -801,7 +801,7 @@ static int count_matching_names(struct l
 }
 
 /* used from NMI context -- must be lockless */
-static inline struct lock_class *
+static __always_inline struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;


