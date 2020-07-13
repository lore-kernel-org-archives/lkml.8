Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE625C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8865920738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N9DsKSXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgGMLvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:51:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C83C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0VFAIjFfZ5APIxw6QxOHI9YiNxSPgGB0GYAhZQL1j5k=; b=N9DsKSXpTDqJ2UUz2PcJCTYiJF
        YRH+hSnew3uLhFh/wNWlKlbhhOjArTkPbf/7P+YLfvYmSUAZL/q/ZP+zzXZxDpj7ALoj6MZIF0oUt
        pK0+QiAVwSaORk1C8SZrjQTdIw8Zwa/6n6lL6NzIYdoAmLgz6+Py+WE4PsPODeePpxCqMIdqHCZeD
        YYxUY8ZqBcwtjWgU6awPwM5gQPJVpiMcyDpoZKsBhTkdFp4vWuCCReRPhxjwsHL/6g5q1qlzyptzP
        gKVDzr3VAbfhySnRoL3ZLpA0C4b7plgMDzK8BDS1U+NHse2ypa6isNi4vpvNJAFJn32zZz4B3Iy7s
        sHpdouwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juwzp-0004V6-1m; Mon, 13 Jul 2020 11:51:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5373E300F7A;
        Mon, 13 Jul 2020 13:51:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A50E20C03C56; Mon, 13 Jul 2020 13:51:41 +0200 (CEST)
Date:   Mon, 13 Jul 2020 13:51:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwsem: fix commas in initialisation
Message-ID: <20200713115141.GH10769@hirez.programming.kicks-ass.net>
References: <20200711145954.GA1178171@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711145954.GA1178171@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 05:59:54PM +0300, Alexey Dobriyan wrote:
> Leading comma prevents arbitrary reordering of initialisation clauses.
> The whole point of C99 initialisation is to allow any such reordering.

I'm conflicted on this argument, the only reason I'd be inclined to take
this patch is that it allows fixing the initialization order to not be
random.

That is, I'd fold in the below.

--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -89,9 +89,9 @@ static inline int rwsem_is_locked(struct
 #define __RWSEM_INITIALIZER(name)				\
 	{ __RWSEM_INIT_COUNT(name),				\
 	  .owner = ATOMIC_LONG_INIT(0),				\
-	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
-	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
 	  __RWSEM_OPT_INIT(name)				\
+	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
+	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
 	  __DEBUG_RWSEM_INITIALIZER(name)			\
 	  __RWSEM_DEP_MAP_INIT(name) }
 
