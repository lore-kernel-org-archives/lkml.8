Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC3C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A120206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WvigMhq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506018AbgDPLDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505744AbgDPLBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:01:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6aotlsYF19Op+YGPIeXUJS1el9SdNu8r3JRRcRSfqB8=; b=WvigMhq5KQAZjMIV844kXvY6bk
        VV1Hu22IGoQtTHy8p1PZQxskAk8hLsbgICnINSQnGB6ww0kkT6QNKL9ginqinDRsN/KRZSqAK2gnj
        InKVrDXKRGngl5KzZAOFtHzmm8nsO0Kowey7/dQQi/l7ps4/s3l4kWaTwfi/trpjgDKUrqoRChQPb
        dUxyx3OJUkUhFhdOVR8GNXFDTU9d6PMZiMCpGqnbgI2wACD0J3sExjRUlTbSS//iNIcnsoJ41oRdi
        7C2sfWaKe613heQ/5tXs5zeOACbN1XgWVgBeMRrITNKkdTXzCkDP7h5AbShlwQEYJTt5JLsK20ebG
        WeKgY3FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP2GQ-0002VM-Dz; Thu, 16 Apr 2020 11:00:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D2413015D0;
        Thu, 16 Apr 2020 13:00:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77C162B0DC725; Thu, 16 Apr 2020 13:00:56 +0200 (CEST)
Date:   Thu, 16 Apr 2020 13:00:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/9] sched: Streamline select_task_rq() &
 select_task_rq_fair()
Message-ID: <20200416110056.GT20760@hirez.programming.kicks-ass.net>
References: <20200415210512.805-1-valentin.schneider@arm.com>
 <20200416105828.GN20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416105828.GN20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:58:28PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 15, 2020 at 10:05:03PM +0100, Valentin Schneider wrote:
> > Valentin Schneider (9):
> >   sched/fair: find_idlest_group(): Remove unused sd_flag parameter
> >   sched/debug: Make sd->flags sysctl read-only
> >   sched: Remove checks against SD_LOAD_BALANCE
> >   sched/topology: Kill SD_LOAD_BALANCE
> >   sched: Add WF_TTWU, WF_EXEC wakeup flags
> 
> How about I queue two first 5, and you rework these last few?

Argh, 4 ofcourse, that 5th patch doesn't make much sense if we have to
rework those flags like I proposed.

> >   sched: Kill select_task_rq()'s sd_flag parameter
> >   sched/fair: Dissociate wakeup decisions from SD flag value
> >   sched/fair: Split select_task_rq_fair want_affine logic
> >   sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
> 
> 
