Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7209C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6121206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6Ah1duV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgA2SHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:07:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgA2SHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ti7tqcCoopz85yAZx6ODwlyVLtxIWBrtp0ypbKnSIIQ=; b=G6Ah1duV6XYd7U02JYqwA9701
        BYJscf1GahK9hRHau93+bYNyshPFIk3rCBti2rpJlwa00ZJ8bV9SriQfyVqTZpxx0W07qDSzmMS7y
        3Xk1UhhS0XHt9ksGdXz6TNCibZJoRghnWkWg8dusjDQmdcrhUw2l1vFyM1m8Uh1vjtsj8uPYkIrHh
        u//Nm5ZeFBzPFR2Tj5OIPsXrKv8RB8HOLuJRwKl8G66axlVYIxXTedxqM9CdWMC7CvdYgOndg/4M9
        Q+LAyDjlHHGUuIoY5S0lVRuPO1kcNj8lijzvMLmsNS8Fzx655R3eyr8T4hcdSlRFvhDY+a+F2rOWG
        9tqRrZJ1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwrk9-0005CU-1G; Wed, 29 Jan 2020 18:07:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6CCD300606;
        Wed, 29 Jan 2020 19:05:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3EF12B7A8626; Wed, 29 Jan 2020 19:07:09 +0100 (CET)
Date:   Wed, 29 Jan 2020 19:07:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     sjpark@amazon.com
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        sj38.park@gmail.com, acme@kernel.org, amit@kernel.org,
        brendan.d.gregg@gmail.com, corbet@lwn.net, dwmw@amazon.com,
        mgorman@suse.de, rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, vdavydov@parallels.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Message-ID: <20200129180709.GS14879@hirez.programming.kicks-ass.net>
References: <20200129125615.GQ14879@hirez.programming.kicks-ass.net>
 <20200129143758.896-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129143758.896-1-sjpark@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 03:37:58PM +0100, sjpark@amazon.com wrote:
> On Wed, 29 Jan 2020 13:56:15 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Jan 28, 2020 at 01:00:33PM +0100, sjpark@amazon.com wrote:
> > 
> > > I worried whether it could be a bother to send the mail to everyone in the
> > > section, but seems it was an unnecessary worry.  Adding those to recipients.
> > > You can get the original thread of this patchset from
> > > https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/
> > 
> > I read first patch (the document) and still have no friggin clue.
> 
> Do you mean the document has insufficient description only?  If so, could you
> please point me me which information do you want to be added?

There was a lot of words; but I'm still not sure what it actually does.

I've read some of the code that followed; is it simply sampling the
page-table access bit? It did some really weird things though, like that
whole 3 regions thing.

Also, you wrote you wanted feedback from perf people; but it doesn't use
perf, what are you asking?

Perf can do address based sampling of memops, I suspect you can create
something using that.
