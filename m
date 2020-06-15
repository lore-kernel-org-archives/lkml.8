Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D30C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE022074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kdkyl0us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgFONS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbgFONSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:18:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F462C05BD1E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lEanNV26xrwraWvKplWOGBh1gATz5JDvieSILpVYTO4=; b=kdkyl0usIQOy0V/GLii9UJ/JIK
        6WpideMfyqVveM5YxlrflX6jBGkXnMioMfffdaRQEEjslIqOj4OLSpwLXF7V5AXgSKXm/T9whBpgm
        RqffSSNNtnLzMz+E3fI1q8c4fVNaq0i6My8NVl3WtH/z5p2IUc9uBaW60wF6Yr9Z4/R2ZuvifPXC6
        uqvUTwcBRxJkRu92xNDK4sowmVwfNPhDrqwsjQX118QWQ6LdJgdazHM0/cFVgm48Q/3DA+WAroUzi
        ieZ8i7XErX6dRd8DK4VNy+e/dNj3tFz/4MZNoG7LEe1IZjV1xiVzlfO8r4Cwa9fH2+ggOzzDt7ER5
        Sj9FFv/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp0F-0004P8-OK; Mon, 15 Jun 2020 13:18:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A69D13003E1;
        Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9736E203B8070; Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Message-ID: <20200615125654.678940605@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Jun 2020 14:56:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org
Subject: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So Paul reported rcutorture hitting a NULL dereference, and patch #1 fixes it.

Now, patch #1 is obviously correct, but I can't explain how exactly it leads to
the observed NULL pointer dereference. The NULL pointer deref happens in
find_matching_se()'s last while() loop when is_same_group() fails even though
both parents are NULL.

The only explanation I have for that is that we just did an activate_task()
while: 'task_cpu(p) != cpu_of(rq)', because then 'p->se.cfs_rq' doesn't match.
However, I can't see how the lack of #1 would lead to that. Never-the-less,
patch #2 adds assertions to warn us of this case.

Patch #3 is a trivial rename that ought to eradicate some confusion.

The last 3 patches is what I ended up with for cleaning up the whole
smp_call_function/irq_work/ttwu thing more.

