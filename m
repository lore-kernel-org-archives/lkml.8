Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2A320644
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvpZkEOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgDUNxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728884AbgDUNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:53:36 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF17C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cm++CYMcsoHl8cG3ue51rLtk5CV6sBkxw+kso6vgYGo=; b=NvpZkEOh9d9dZ42Sx/O1xfgNtp
        bGhF2PkYFUNGYKyFrPHeKINYmNp/MsvFY+rbz6szP/KJaMGQzie1f0eKsYHzF1pB+ZLxn0wpQLCGq
        foadxUdbwgobnwwB9t2aRe7Xt3vLRV/nwxtjCguJcO0HQUxTR02Svg7IbTacCpJ1d+8qUZwaWZu+k
        vfnXtQIBTCmZwPWZFeeLDXFJscCcbuHoiOB1uO1cdu9pQTykRikutnxu6+rWOYgh9Uq8pg7GEypUw
        giW6Eqsy44ErQHhRHEC8LvPrbs1EqXMxeYaZZzRFKdFJq1Un7Dil+ahaV8QdLcDdI4udyfgaGseHC
        TsRuwD6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQtKe-00008i-S5; Tue, 21 Apr 2020 13:53:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B518030275A;
        Tue, 21 Apr 2020 15:52:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9861C2BAC7929; Tue, 21 Apr 2020 15:52:58 +0200 (CEST)
Date:   Tue, 21 Apr 2020 15:52:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, joel@joelfernandes.org
Subject: Re: [PATCH] sched/fair: Fix call walk_tg_tree_from() without hold
 rcu_lock
Message-ID: <20200421135258.GS20730@hirez.programming.kicks-ass.net>
References: <20200406121008.62903-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406121008.62903-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:10:08PM +0800, Muchun Song wrote:
> The walk_tg_tree_from() caller must hold rcu_lock,

Not quite; with the RCU unification done 'recently' having preemption
disabled is sufficient. AFAICT preemption is disabled.

In fact; and I mentioned this to someone the other day, perhaps Joel; we
can go and delete a whole bunch of rcu_read_lock() from the scheduler --
basically undo all the work we did after RCU was split many years ago.
