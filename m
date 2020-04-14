Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4773BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F034206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4GU/RlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438694AbgDNKzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438454AbgDNKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:54:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985FFC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQdhtZUh2w+VXylKnu+sVoWH4g/eMf/YEy4RUfaImPw=; b=R4GU/RlX4Nu9Km3U91xRlUk2wF
        Oh096iAk4sThU2Gu6XglGWmRfb3XetSjZEAHY/3eQ0kBnN3t0/NqGWHr7J60WB2zOVjZPQrx6rZwp
        Nj9iWkqVkcv71Mo0zJixeV6r6E1rX3e/FnHN1hB5TkIUUpT40U1/t56RgkLWKkIrnsx+8pYnAcG5A
        O0ikMhDbKNEGOS5zZlkaX884htriMYjMDPSHo/fXKgLYcxNkbErKiJ2bPIckARV7N4eEkWUnZcteL
        4Deycj4BOrn+MhanOYmnzM990tMD4WyG38fJngit8WIfBSIx++1ULlSTOFgkT1oxxB4BHvRKvuY+1
        gGXuVWzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJDC-0000zf-3C; Tue, 14 Apr 2020 10:54:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0438305EEC;
        Tue, 14 Apr 2020 12:54:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D1762038BC54; Tue, 14 Apr 2020 12:54:35 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:54:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Phil Auld <pauld@redhead.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched: remove distribute_running from CFS bandwidth
Message-ID: <20200414105435.GM20713@hirez.programming.kicks-ass.net>
References: <20200410225208.109717-1-joshdon@google.com>
 <20200410225208.109717-3-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410225208.109717-3-joshdon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 03:52:08PM -0700, Josh Don wrote:
> This is mostly a revert of baa9be4ff.

That's written like:

"This is mostly a revert of commit:

  baa9be4ffb55 ("sched/fair: Fix throttle_list starvation with low CFS quota")"

Fixed that for you.
