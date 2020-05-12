Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A49FC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FCC206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UACElRPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgELOKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgELOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:10:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D03C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NO+sRIrtcWsU8pzSoEXB29WcYJfcotevuQ/7ctpOgOc=; b=UACElRPkuH49mAtmVFRanStviN
        Rd5L8NoVCXQcyxMBOcoHv8PcdmLteBLXj+l+DxhgNyyDF+l8P3mj10gF/AfZBvnyaF2HQ2o4+gyDX
        EGF3aQs9FQG3tC6jmnJbAbMDRACqURJhcLPOaVi8MREykLrnqAdGuc+J7IKdU3FWWw8RFH66AMV3x
        8r1ZZS8gq5ohw/XQsffeqWu/hIf+zsuILWBlW49/WGErOW7Ncyd/ypOOprLL3oqffsikTS+SRgtmP
        OW+Fs54cOBSXrrz57HegSIWE9j/1OaanNoqAzV98nplM/RjXLmZ9d943MEiR1WqUq+KXN2XoLtDvw
        oBor4lSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYVcQ-0006mx-7h; Tue, 12 May 2020 14:10:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D342305EEF;
        Tue, 12 May 2020 16:10:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73EA320962E33; Tue, 12 May 2020 16:10:48 +0200 (CEST)
Date:   Tue, 12 May 2020 16:10:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        zohooouoto@zoho.com.cn, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200512141048.GL2978@hirez.programming.kicks-ass.net>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200512135222.GC2201@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512135222.GC2201@lorien.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:52:22AM -0400, Phil Auld wrote:
> sched/fair: Fix enqueue_task_fair warning some more
> 
> The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> did not fully resolve the issues with the rq->tmp_alone_branch !=
> &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> the first for_each_sched_entity loop exits due to on_rq, having incompletely
> updated the list.  In this case the second for_each_sched_entity loop can
> further modify se. The later code to fix up the list management fails to do
> what is needed because se does not point to the sched_entity which broke out
> of the first loop. The list is not fixed up because the throttled parent was
> already added back to the list by a task enqueue in a parallel child hierarchy.
> 
> Address this by calling list_add_leaf_cfs_rq if there are throttled parents
> while doing the second for_each_sched_entity loop.
> 
> v3: clean up commit message and add fixes and review tags.

Excellent, ignore what I just sent, I now have this one.
