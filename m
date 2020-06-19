Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CD7208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsiqp5Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391478AbgFSRbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgFSRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:31:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3AFC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGQYAy353h8usQVvoM8ZQptssTrkQAxhrWa3SGPOXCg=; b=fsiqp5BfJvmIshAQeSR6UH4L1M
        R+O+x1YUSNeVrjNEAszs+DmO1vQICJ+VHQBSNfga4LH1s8W+yzm8nquE3G+PhLGuJrQJkjuQ1s4tz
        D7kXk1GfOkjmUgupg/Wkc/GDRmYoKiLs+6OF0rEda59MCMbJNB2Ae5Yr2dF+n43ztn0X0dpRcCe1K
        52wJbR2fJE7EYrRYVcp3z726n7i67i93HQz6LoryyqxfNiPwjMll5igno6C2fccVn5zr9Xy58avYJ
        tHTkG642Sl/j1g9xQolnxBvJHTMddV/N3t1M5YQ+WoxGbeQPGguh/Kn1OraQnsnNiQ6ru4k6AmMp3
        SW+EDHVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmKqw-0003Ny-SX; Fri, 19 Jun 2020 17:30:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C55E3079CB;
        Fri, 19 Jun 2020 19:30:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68F0321390E42; Fri, 19 Jun 2020 19:30:55 +0200 (CEST)
Date:   Fri, 19 Jun 2020 19:30:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
Message-ID: <20200619173055.GA576888@hirez.programming.kicks-ass.net>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618195525.7889-2-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 08:55:24PM +0100, Qais Yousef wrote:

> +	for_each_clamp_id(clamp_id) {
> +		memset(uc_rq[clamp_id].bucket,
> +		       0,
> +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> +
> +		uc_rq[clamp_id].value = uclamp_none(clamp_id);

I think you can replace all that with:

		*uc_rq = (struct uclamp_rq){
			.value = uclamp_none(clamp_id),
		};

it's shorter and is free or weird line-breaks :-)

> +	}
