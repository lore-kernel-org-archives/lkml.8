Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C793F206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p07Rgq4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFCMPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgFCMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:15:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58912C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f1FnoPxb145EbSYlJUrHoV56rrWGOqUPLJKVSr5+ovA=; b=p07Rgq4YmULU6SWcQLwlM2zbyv
        lb74GTDdkulMV+MUA91/kFXaTx2Aj4UrOPF8wjtE3L++s7zC3MgoRwXXQE5rgBBsj/meOgkG7i+b6
        G3nvSiCq0vB3Xbiro8XhfmfYqmKIZFtDLuUXm91hJlmNJ2OvqZkD64wKp51/V/3EqL0cJ7yXWEQu3
        mf12lh+bnu1YTbFozGyLU83KzpxUJMSwMMn+2WtcRnJ2eai6oPFujFNY3vVktCHRu8JEczHmlwzQn
        g5SLveh3cbVCJxuYJB6ZG5cfQ5Zp6f11WiIubMZ72tvwqykm1JEEeAbxuYPQsTMwzQbE7Zqq1u0yh
        Z4EWpV8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgSIu-0003bs-A1; Wed, 03 Jun 2020 12:15:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A365B304BDF;
        Wed,  3 Jun 2020 14:15:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B886209C23E0; Wed,  3 Jun 2020 14:15:30 +0200 (CEST)
Date:   Wed, 3 Jun 2020 14:15:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, dietmar.eggemann@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] sched/debug: Add new tracepoints to track util_est
Message-ID: <20200603121530.GB2570@hirez.programming.kicks-ass.net>
References: <1590597554-370150-1-git-send-email-vincent.donnefort@arm.com>
 <jhjlfl4icdx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjlfl4icdx.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:04:26PM +0100, Valentin Schneider wrote:
> 
> On 27/05/20 17:39, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > The util_est signals are key elements for EAS task placement and
> > frequency selection. Having tracepoints to track these signals enables
> > load-tracking and schedutil testing and/or debugging by a toolkit.
> >
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> 
> To put it more bluntly, we can't really do task placement / load tracking
> testing if util_est is enabled (which reminds me we may want to get rid of
> the SCHED_FEAT at some point, it's been default on since ~v4.17), since
> there can be noticeable gaps between util_avg and util_est.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!
