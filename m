Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DAC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA392206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjmi1LTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgBMRHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:07:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgBMRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SvmRDf3hGMgAeGNvz1waHZ3BIKpau0hy1IjF2C4Sj74=; b=qjmi1LTszhgAQscgEph7HdcxCA
        XW0JdEv9KpcJWXRD4M+d24+XtTK5yziamUpXnaTvnam0jI7UQC6FX+EW3U17QKNgeNpWReFzqQ4rJ
        tJkK86KeLcOgisBokhxmBfv0m3/lFJ+r+zQ77jNOjPNh1CbdvA9hNGMcr+fDDQGpIOVRbCwKCEvNA
        MMfv49EBF2VdXVijrD4JYBnVmeIN897T9E06HgXUNkkCsi//2PnevZKrCuZkd9kU8CzG6AfTgk8K3
        QPuz8RV3e8IixryOPDwxw/T6+71ZrewEWcvEDxCtQy+gp4deUMzpLPJfXh5v0KTCVDYsTN/oyXGMI
        u2hsU6FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Hwn-0006I2-LE; Thu, 13 Feb 2020 17:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F64C300446;
        Thu, 13 Feb 2020 18:04:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9058A20206D63; Thu, 13 Feb 2020 18:06:39 +0100 (CET)
Date:   Thu, 13 Feb 2020 18:06:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Replace zero-length array with
 flexible-array member
Message-ID: <20200213170639.GK14914@hirez.programming.kicks-ass.net>
References: <20200213151951.GA32363@embeddedor>
 <20200213164518.GI14914@hirez.programming.kicks-ass.net>
 <9d516501-2624-f915-32be-13ba6f881019@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d516501-2624-f915-32be-13ba6f881019@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:58:31AM -0600, Gustavo A. R. Silva wrote:
> > Hurmph, and where are all the other similar changes for kernel/sched/ ?
> > Because this really isn't the only such usage and I really don't see the
> > point in having a separate patch for every single one of them.
> > 
> 
> Yeah. I can do that. I'll send a patch for the whole kernel/sched.

Thanks!

> > Also; couldn't you've taught the compiler to also warn about [0] ?
> > There's really no other purpose to having a zero length array.
> > 
> 
> Yeah, this is something we'd like to see in the short future.
> Unfortunately, for now, the only way for the compiler to warn
> about zero-length arrays in through the use of "-pedantic".
> And we definitely don't want to follow this path.
> 
> What we can do, in the meantime, is to add a test for it to
> checkpatch.

Oh, I means, warn if it isn't the last member of a struct. Not warn on
any use. Or we mean the same and I'm just confused.
