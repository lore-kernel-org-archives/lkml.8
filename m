Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD3C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042282068F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mk0PvoGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgGVPdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732687AbgGVPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:33:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF89C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tnE2QcGso/BBm62aYkEJDg/K9hAdP+FR0nkIemAjNPY=; b=mk0PvoGfuFReIV2yyVnlhidasR
        a997mjYi0WxNxvl+MT9nsYn+Uc1R8dfAZnGLrf4FfprDpc/7IPBevsKCSC5914HvkgrigxHS0gJp5
        zP5Qt6KyF+HHXU5FiYeXP7+DHPXA40ph+Pa4KKX3GZALblrl4hvNC983o+nt6xjgKHxcNZl7eDVN/
        RuLWa1cssBXaSo6tJCmKmeiTOwog42FSEc4HfhiboAQkQvbG8QY62JSr3kAgm8yAzYHXu4wKotHPL
        VZNI/809+vAf09cLsLOQuQgCI20WZdCcCbzCwo3GWtwb4wxU7bMZlJyNGQdREaNThjiJmOB8zzNrY
        AUvak30g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyGjw-0007sQ-VJ; Wed, 22 Jul 2020 15:33:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36E21307865;
        Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 37EBD200D416D; Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Message-ID: <20200722150149.525408253@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Jul 2020 17:01:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, peterz@infradead.org
Subject: [RFC][PATCH 0/9] smp: irq_work / smp_call_function rework
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of patches that continue the irq_work / smp_call_function
integration / cleanup.

One of the biggest warts in this area is smp_call_function_single_async(); it
looks like a useful function but is incredibly hard to use correctly due to the
test-and-set LOCK on the csd not being atomic. This means you need to be
incredibly careful to not corrupt the csd.

Simple patterns like allowing any CPU to IPI any other CPU end up requiring
nr_cpu^2 storage because of this.

On top of that the csd has external data, vs the more common internal/embedded
data pattern.

Now, irq_work has the embedded data pattern, but requires arch support for
self-IPI. But because irq_work for remote CPUs relies on the smp_call_function
infrastructure we can implement a generic irq_work_queue_remote().

Then it goes a bit ugly, and I introduce irq_work_queue_remote_static() that is
non-atomic in exactly the same way smp_call_function_single_async() is now, but
at least it has embedded data. A few performance sensitive users of
smp_call_function_single_async() are converted.

Finally, smp_call_function_single_async() is made safer by using an atomic
test-and-set.

TL;DR, I think at least the first few patches should go in the next round, but
the rest can use some feedback.

