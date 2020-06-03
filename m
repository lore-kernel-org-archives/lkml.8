Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70712081A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xyx6QhV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFCLxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFCLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:53:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83082C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6dSbjU+bvaFDAnNBse6Pi1hys7CEx2MawD7Uu/P7pQc=; b=Xyx6QhV1nepOxjq4scyPIozmi2
        5+4XykSBy6qFHAI51EIika+DdQ4++PKzIVwxNOexe1BHpBeqGl3f9NRdgb8MpdYd+Gn9gwQK4vKk2
        auFSgg3imtALNSaygFpNHDPhfcrQIJFzL5JaykMVTnE0Ynkmg83G8ixRyK0743X7sWaphu2g7v1sH
        V6hCE33AS6hbzapWbpLYpKczHi0BeeRBkipzCkGO0odli+33fW6jPV5kSJ7bFLrMiaYnx95dbRNmt
        jTYNJOJEVk7QQVDUZYoQ2PEEo0k8rn82GqFxA80FtjxUUvE/HlC0KYjcZdefWYjG02EYt3aYTcpLq
        EvrL3gfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRxI-0005YM-Jr; Wed, 03 Jun 2020 11:53:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCE8E301ABC;
        Wed,  3 Jun 2020 13:53:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC18920707D43; Wed,  3 Jun 2020 13:53:10 +0200 (CEST)
Date:   Wed, 3 Jun 2020 13:53:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched: Remove some redundancy
Message-ID: <20200603115310.GH2604@hirez.programming.kicks-ass.net>
References: <20200603080304.16548-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603080304.16548-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:03:00AM +0200, Dietmar Eggemann wrote:
> Remove redundant functions, parameters and macros from the task
> scheduler code.
> 
> Dietmar Eggemann (4):
>   sched/pelt: Remove redundant cap_scale() definition
>   sched/core: Remove redundant 'preempt' param from
>     sched_class->yield_to_task()
>   sched/idle,stop: Remove .get_rr_interval from sched_class
>   sched/fair: Remove unused 'sd' parameter from scale_rt_capacity()

Thanks!
