Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93216C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7079C2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hH5W1bOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgFPRHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgFPRHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:07:51 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA20C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bX5RxJCfhao4qGkqFy8rLm+I3C4jvjPT2fFLvPCoBgM=; b=hH5W1bOgR9508FnCl3pPwtAr26
        z3wWRiIK2CQJX3/v5uyHd3+uX9UZU6RGKVo3ZnaSh2rJCMI1qjWzT29NIrAfXSnVycoe7YGuXo6DX
        9go0YDbtqRsJ1Ox0CWVmMegK8YvuAJSXzP2RZHwWZ3Gg1XWKMEMaDi8176Zr3xu0Wqcps5ZRcXRO+
        Ux87ere+iHJWwzlSYoMV5OVzXL5wA1qH+8v+AFRJINTITDJWbeCD/Q0S5kmOm3Aaiqb418JsJelTz
        mcQ8+LmEU7JQBkBYCQIPs0gucPShKKNE/50cDRvSmpSunWCadd/3b4FX1Fqk320Y8bLFqQ+/ro3Dz
        rr9P0CeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlF3L-0001lX-Tc; Tue, 16 Jun 2020 17:07:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D3D53017B7;
        Tue, 16 Jun 2020 19:07:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B7522038E4F2; Tue, 16 Jun 2020 19:07:11 +0200 (CEST)
Date:   Tue, 16 Jun 2020 19:07:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lichao Liu <liulichao@loongson.cn>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Don't active rt throtting when no running cfs
 task
Message-ID: <20200616170711.GZ2531@hirez.programming.kicks-ass.net>
References: <20200616123729.153430-1-liulichao@loongson.cn>
 <20200616095027.1a2048d0@oasis.local.home>
 <20200616140158.GY2531@hirez.programming.kicks-ass.net>
 <20200616105900.5cb0671d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616105900.5cb0671d@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:59:00AM -0400, Steven Rostedt wrote:
> On Tue, 16 Jun 2020 16:01:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Jun 16, 2020 at 09:50:27AM -0400, Steven Rostedt wrote:
> > > On Tue, 16 Jun 2020 20:37:29 +0800
> > > Lichao Liu <liulichao@loongson.cn> wrote:
> > >   
> > > > Active rt throtting will dequeue rt_rq from rq at least 50ms,
> > > > When there is no running cfs task, do we still active it?
> > > >   
> > > 
> > > This is something I would like to have.
> > > 
> > > Peter, what's your thought on this?  
> > 
> > I'd love to just delete all of this.. that said, I'm not sure this
> > change makes sense, because it doesn't deal sanely with the case where
> > the task will appear right after we did this.
> 
> I haven't looked closely at the surrounding code, but wouldn't it get
> throttled in the next period? Do we care if a task has to wait a bit
> longer?

Either way around, who cares?

> > The right thing to do is that fair deadline server thing.
> 
> But we've been saying that for years now.

Hey, I even coded most of it, but clearly nobody cares about this enough
to finish it ... 
