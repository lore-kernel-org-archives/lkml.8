Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7375C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE81A205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlkSlFbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHRLfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRLfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:35:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4EBC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pg9bLsU6l9G88ZYLI6rak6/wPwxiNcw3KCO9a4fmWsM=; b=nlkSlFbouJ1ClxHCFQY5iGX0xc
        aLu9eYFhsZHUuVWklwB2srnsEqXYNGme2lwL6slSz1gJ36gJ8UConPZkLGx3wuDP07BCfqf1iv+8n
        flTBEOZToc4ubMFGmY5lpj2ggl0ADRbJ6i3vuPPOlLSc2KSwlfpMbHyPWv84g/k01zhxgKhRaA5ah
        CK4ifbZMYQeqBO8U5XMpu8p1rCPz5RVel2Yi8GlcbEmuluzsL0u+tNrYTzbth9rkHhz0K6zgh3FEd
        Qm+z+4v7Qo+e2SIt/NgOo+DQMgatCmoGVvggR5eFx2ngvh1mnLXiqlPX3iPNH+PSUbWDFix/c2Z6/
        JCmUr65g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7ztI-0002c1-G1; Tue, 18 Aug 2020 11:34:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6973301179;
        Tue, 18 Aug 2020 13:34:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96452200D4C26; Tue, 18 Aug 2020 13:34:54 +0200 (CEST)
Date:   Tue, 18 Aug 2020 13:34:54 +0200
From:   peterz@infradead.org
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Jiang Biao <benbjiang@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Subject: Re: [PATCH v3] sched/fair: simplfy the work when reweighting entity
Message-ID: <20200818113454.GS2674@hirez.programming.kicks-ass.net>
References: <20200811113209.34057-1-benbjiang@tencent.com>
 <CAKfTPtBReSax0AK9sanzcSzBMJzx7jK-K8Umc3kfH_n11N7f3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBReSax0AK9sanzcSzBMJzx7jK-K8Umc3kfH_n11N7f3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:07:37AM +0200, Vincent Guittot wrote:
> On Tue, 11 Aug 2020 at 13:32, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > From: Jiang Biao <benbjiang@tencent.com>
> >
> > The code in reweight_entity() can be simplified.
> >
> > For a sched entity on the rq, the entity accounting can be replaced by
> > cfs_rq instantaneous load updates currently called from within the
> > entity accounting.
> >
> > Even though an entity on the rq can't represent a task in
> > reweight_entity() (a task is always dequeued before calling this
> > function) and so the numa task accounting and the rq->cfs_tasks list
> > management of the entity accounting are never called, the redundant
> > cfs_rq->nr_running decrement/increment will be avoided.
> >
> > Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> 
> Minor typo of the subject: s/simplfy/simplify/

I've made it "Simplify" :-)

Thanks guys!
