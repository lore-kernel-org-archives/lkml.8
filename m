Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF6C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BAD20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v50UMiFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDVN0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgDVN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:26:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C45C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bduZ/9IMfziqIRTnhoBaYjslx+rtMD8dHnYkLXsa/Tc=; b=v50UMiFftdWzYsHHn1JilwsyVF
        0nGoYo28zhxHKriaOQ/SiOYxOqGeT+yXtIfdpeU+mUOCbipC2vh+u1PKSwDaY1ehs5r/ya0+a4r0b
        wioy79gBZy0hvrSD9Uq8BBFVbguypGouZ9Acl471bTIVpOEudQfAoNDDpfZWAOuzJWWk6rLp+1zyb
        lFVzD4BNc9fg55faldXHtMU5Cv1/n0ElBiPsAWjrzGPraByxXGN57g+WH173Zv8SPgWuHjZ1/1prC
        LMr8bS2dgE67q6PvhBeY6LmQlU8kDs6e8/4NBi/hE3kgcfX9dPNyScu8NCvBjWPaF+wlvI8IriFet
        ju3pPYfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRFOA-0000y5-7o; Wed, 22 Apr 2020 13:26:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D736D304CFD;
        Wed, 22 Apr 2020 15:26:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C80B8286A6E3B; Wed, 22 Apr 2020 15:26:04 +0200 (CEST)
Date:   Wed, 22 Apr 2020 15:26:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, hverkuil@xs4all.nl,
        awalls@md.metrocast.net
Subject: Re: [PATCH 09/23] sched,ivtv: Convert to sched_set_fifo*()
Message-ID: <20200422132604.GI20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.752048390@infradead.org>
 <20200422085345.48b50508@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422085345.48b50508@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:53:45AM -0400, Steven Rostedt wrote:
> On Wed, 22 Apr 2020 13:27:28 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > take away the priority field, the kernel can't possibly make an
> > informed decision.
> > 
> > Effectively changes from 99 to 50.
> 
> I wonder for the 99 users, we should have a sched_set_high() that would set
> the task to something like 75.
> 
> That is, above default 50?

No. If userspace knows, userspace can fix it. We must not bother with
priority, simply because we cannot, possibly, say something useful.
