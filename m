Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A57CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3421622B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EaHVI8Yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgHETwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgHEQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:51:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5642AC0617A1;
        Wed,  5 Aug 2020 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=T7Zf13XTlUQSe/dbrPakLq04rPma9WfTqW7+qPuHC/8=; b=EaHVI8YpmOMLdyJSiFa8b1rMZa
        0pJMt8imbpuIDWtkEyuefvwlxGb3nV5J+pz5zWStG5j+fmTmLkA9tqg7L3p1a6WcpMKdFhV4a0DaD
        VyPLI7JjRDuAmMRSIWaEywhQdx9uRyCg0JYiAyPE0+sP7iSJ8zVa0RAAz36CQx1kqy9rUEy0DjUEM
        8SQ9nLZcb4IBuuGFOT5BwydR56trYSzQfkcWmmL5o5sY4LvAU9hqp4ye9W5vJrnYFflNd+9tQS/yL
        VIzjvHwaapa6qqUpbyx+xFkwsRpbKkKHZd4+3aVr/hc5UNNtsJDfW0W/niTsXW6+ZOGBtGxeX2EU0
        OQ+M/oAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Grl-0005Zg-JH; Wed, 05 Aug 2020 10:41:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEF00301A66;
        Wed,  5 Aug 2020 12:41:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CC03235CDBB2; Wed,  5 Aug 2020 12:41:46 +0200 (CEST)
Date:   Wed, 5 Aug 2020 12:41:46 +0200
From:   peterz@infradead.org
To:     ren_guo@c-sky.com
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        mathieu.desnoyers@efficios.com, Will Deacon <will@kernel.org>
Subject: csky: smp_mb__after_spinlock
Message-ID: <20200805104146.GP2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While doing an audit of smp_mb__after_spinlock, I found that csky
defines it, why?

CSKY only has smp_mb(), it doesn't override __atomic_acquire_fence or
otherwise special cases it's atomic*_acquire() primitives. It has an
explicit smp_mb() in its arch_spin_lock().

---
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 7cf3f2b34cea..22a05caf2d18 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -88,9 +88,6 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 
 #include <asm/qrwlock.h>
 
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()	smp_mb()
-
 #else /* CONFIG_QUEUED_RWLOCKS */
 
 /*
