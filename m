Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFCDC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADDC206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQj7u2Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgA2Tgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:36:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgA2Tgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m8XtGCoj/Rgqwp4rgy8+qM/2t7I9us+2QhgbXiUwMMs=; b=OQj7u2PkCLXgOD7LOfBHdmIjv
        OmB24ayrGnvtecw5aFRY8MRd+Whr/VOv/YE1luD75ZthbeVU6MqgqutWaWv4V01LXe9fJlfyirknM
        f4Lyx6vGjHXqzzgreKCLAtqFGWyLli7YZu0UORiIkyRcadjZuQ/vggyzPk4oXmTHSZ8DkUYzijIWY
        DPLCZAyQL4g4DNLFUx70capYXl2mHA27gH+TMOWNPYcvGpoQscSeLNw1irEMebpUDhnC/lb9eIgqE
        p7OrFC3VfQrnGOSSDWwMNmCAiQnVVK3JEK9ss64IupYj4UC9VJdr5YWsXapJiXVzx+74/PDJHiLa7
        HnOpv8E8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwt8M-0005M8-Sb; Wed, 29 Jan 2020 19:36:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73AB5305FB6;
        Wed, 29 Jan 2020 20:34:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B3702B7337BB; Wed, 29 Jan 2020 20:36:16 +0100 (CET)
Date:   Wed, 29 Jan 2020 20:36:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     sjpark@amazon.com, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com, corbet@lwn.net,
        dwmw@amazon.com, mgorman@suse.de, rostedt@goodmis.org,
        kirill@shutemov.name, brendanhiggins@google.com,
        colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Re: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Message-ID: <20200129193616.GT14914@hirez.programming.kicks-ass.net>
References: <20200129180709.GS14879@hirez.programming.kicks-ass.net>
 <20200129190645.2137-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129190645.2137-1-sj38.park@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 08:06:45PM +0100, SeongJae Park wrote:
> > Perf can do address based sampling of memops, I suspect you can create
> > something using that.
> 
> If you're saying implementing DAMON in 'perf mem', I think it would conflict
> with abovely explained DAMON's goal.
> 
> Else, if you're saying it would be the right place to handle the DAMON
> generated data, I agree, thank you for pointing me that.  Will keep it in mind
> while shaping the interface of DAMON.

I'm saying it might be able to provide the data you need; without damon.

Might; because I'm not entirely sure what you're looking for, nor
exactly what events we have that provide address information.
