Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9267AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CA4207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWkydcid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbgIHUDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgIHPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189FEC06123D;
        Tue,  8 Sep 2020 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nqYpYzEbjozD6K+HBUuZ/V3Y3lp7izkRsPy7CYAzW8s=; b=KWkydcidVX5ZYdeTTD+VUnCru3
        A0kIT8bLZoCsFP23bNI2PrXTyN1+Sc+YbimoJtsPKZ/lRkY7tmseqwSSSMmXiCaKZBxXHOAgdwQM7
        FwrbfVI18HYOeBmhIMbYwtMW/FbeKCp+v18VIZcbIz04L1PCLT2yzSP2MQ9sQ9eIj0I6bZlD8jcR1
        xU8jlj8Q02FT3Qb4lzubn6bKy5qovrUhqwUfdoxc20kAST2QWV9SiAcR2jcm834YlLxYRJzzRnhJr
        MWuzdxK310tXSz0R2vngYhcXk7DwtH65jjfx3KyxE4Drt+lCwjC/0j3+rayY439qgOYD+aNeCcF4+
        6dEXNlMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFdhh-00074x-NE; Tue, 08 Sep 2020 13:30:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAEF93010D2;
        Tue,  8 Sep 2020 15:30:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70A8821219223; Tue,  8 Sep 2020 15:30:31 +0200 (CEST)
Date:   Tue, 8 Sep 2020 15:30:31 +0200
From:   peterz@infradead.org
To:     hca@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        rafael.j.wysocki@intel.com, svens@linux.ibm.com
Subject: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
lock tracepoints are visible to lockdep and RCU-lockdep is finding a
bunch more RCU violations that were previously hidden.

Switch the idle->seqcount over to using raw_write_*() to avoid the
lockdep annotation and thus the lock tracepoints.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/kernel/idle.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -39,14 +39,13 @@ void enabled_wait(void)
 	local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	/* XXX seqcount has tracepoints that require RCU */
-	write_seqcount_begin(&idle->seqcount);
+	raw_write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
 	idle->idle_time += idle_time;
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
-	write_seqcount_end(&idle->seqcount);
+	raw_write_seqcount_end(&idle->seqcount);
 }
 NOKPROBE_SYMBOL(enabled_wait);
 
