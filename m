Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D009C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1403022CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u16vv/o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGWUVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:21:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC94C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OPQGqVX7mpZKPOmHDFbLw6MaXxi0mJcAVB6J/0PTbKw=; b=u16vv/o6OXUjKP55To9rkix2Q0
        eHPw387bJVQj4gAEYDSOA2Qzm17xFwpyGN0nT+cjSowtwJWgi7aGfIZ7PVgZLY5esU2RSetLw0VxK
        lhbVXl7SfZVmiYkUPSNO1n0etinUOYxplzhFtJrVS/41Sot1Llqc97YfOJXKqnvOF13vSFh+756Gl
        dHdcFC3P5amyNKijoAdUrB9eqsW9PGc/khFCQFK+3jW/s45tw1ru2r4FJ4Jcfe9MbaxwZkIxuWnPB
        PGg47IyDDucf/NbHrG0Piv87y+uD5yyvAIDn93ODN9veSWDrnTYh1UmBS+c1YFhXHkg0oSTMeezbF
        aC9ZtKag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyhiA-0004LR-2p; Thu, 23 Jul 2020 20:21:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5AC8305E21;
        Thu, 23 Jul 2020 22:20:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B228D200DD94D; Thu, 23 Jul 2020 22:20:59 +0200 (CEST)
Date:   Thu, 23 Jul 2020 22:20:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Warn if garbage is passed to
 default_wake_function()
Message-ID: <20200723202059.GU10769@hirez.programming.kicks-ass.net>
References: <20200723201042.18861-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723201042.18861-1-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:10:42PM +0100, Chris Wilson wrote:
> Since the default_wake_function() passes its flags onto
> try_to_wake_up(), warn if those flags collide with internal values.
> Given that the supplied flags are garbage, no repair can be done but at
> least alert the user to the damage they are causing.
> 
> In the belief that these errors should be picked up during testing, the
> warning is only compiled in under CONFIG_SCHED_DEBUG.
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
