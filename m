Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC54C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C633E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZmXIctw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgFVKPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgFVKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:15:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D8FC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2RjTqVx5JWKQDiDk1go5O08KBZuLHTrJZdO+ffoqORs=; b=XZmXIctwNA4j8p/VK6gkF6Lpkg
        VsjApmEIxDl9erX9MR9GUKKQsmT8McHyqkS04B7GRfg0xXEZ/2wEFYk54fsfSRUPVnC21GSNIQiqS
        Nr9o5I9YU2sivkQPKM9uOBLrxCn2i7rXhrU2t8HBJ98k/1d85TZiuZe9AbEa6MtJQsrKmx8Eql+G2
        ZOMqYS62aAnUl9/EkKQ064QoZV+92sTJkTWYXeMnv4Y2RrwIaLvVViM/xR9wNlg2m6xO9KdBGfTR5
        VcFtoc7tg7qYrAHnlhapkLaRtE0MkGRh11egDlw9K4O8lHKO6UVEtjxrLIhxT3lPnJiERXCUsDQ5p
        zSMRjlpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnJTj-0008JL-UK; Mon, 22 Jun 2020 10:15:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46A8F303CE9;
        Mon, 22 Jun 2020 12:15:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2418729994FCF; Mon, 22 Jun 2020 12:15:02 +0200 (CEST)
Message-ID: <20200622100122.477087977@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Jun 2020 12:01:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hch@lst.de
Subject: [PATCH -v2 0/5] sched: TTWU, IPI and stuff
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Like earlier, Paul's rcutorture is fixed by #1, but now it actually makes sense
and I can explain how it happens. Therefore this patch is _much_ better than the
last one :-)

I was going to push 1-3 into sched/urgent, #3 removes the horrible BUG_ON crap in
kernel/smp.c and trades them for slightly less horrible unions.

I was planning on keeping #4,#5 back for the next round, but if Linus wants
them now, that can certainly be arranged too. I have some further work on top
that creates and uses irq_work_queue_remote() to replace many (hopefully all)
smp_call_function_single_async() users so we can get rid of that head-ache, but
those need to cook a little more.

(#5 has 'trivial' conflicts with patches from hch that are targeted at
the next round)

