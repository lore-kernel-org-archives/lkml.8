Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8136DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC4820792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/CHcoXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGWULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:11:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511AC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/rj5UU6tGdG+2asVe5JXVTkUwXIGY3WdZ5un4JY8Vf4=; b=j/CHcoXSsZZ0Um3pDllJCl9MsR
        GGrruV7XTpUCFhljY3hAACYerSw70BI1nrteXRuzYmY63g3OYylzPw2vhagDSjgwzbHBbm4qyXuPD
        F8QmY5mQoV+aZh7mQkCWm541BLB0CT7VwDLGhRqLngnzvO6cY1E4aetu8DL8iPtYAd+cGtucnMQWj
        7HvgVtoIuiOkTrMoMYbnyeQdBxp+bVOyJoSPCjYFCuer22i4PBCx6j2qDmIzJO8gLZgF4kaLkvaMy
        +nnmu7Zoye+MzV4vxpR9lY8TShCypEK+hkDnUoAp9th09bkhYGQaHAKipKmYVQ4ddZ47as9sFqMkL
        VEctz0HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyhYv-0000pD-Ou; Thu, 23 Jul 2020 20:11:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE673301A7A;
        Thu, 23 Jul 2020 22:11:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4D49200F77CC; Thu, 23 Jul 2020 22:11:28 +0200 (CEST)
Date:   Thu, 23 Jul 2020 22:11:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
Message-ID: <20200723201128.GT10769@hirez.programming.kicks-ass.net>
References: <20200622100122.477087977@infradead.org>
 <20200622100825.726200103@infradead.org>
 <159532854586.15672.5123219635720172265@build.alporthouse.com>
 <20200721113719.GI119549@hirez.programming.kicks-ass.net>
 <159541187604.15672.2433896906671712337@build.alporthouse.com>
 <20200723182841.GS10769@hirez.programming.kicks-ass.net>
 <159553326368.21069.3167204000119437062@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159553326368.21069.3167204000119437062@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 08:41:03PM +0100, Chris Wilson wrote:

> I am very sorry for the wild goose chase.

*phew*... all good then. I was starting to go a little ga-ga trying to
make sense of things.

Arguably we should probably do something like:


@@ -4555,7 +4572,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	return try_to_wake_up(curr->private, mode, wake_flags);
+	return try_to_wake_up(curr->private, mode, wake_flags & WF_SYNC);
 }
 EXPORT_SYMBOL(default_wake_function);


Since I don't think anybody uses anything other than WF_SYNC, ever. And
the rest of the WF_flags are used internally.

Thanks Chris!
