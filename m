Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE9AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C65214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="17x6lzuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgA0RAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:00:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0RAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EJ85mn6woq34Qia8kElVSP/Mw4no/xQr3/rCKnqaAEM=; b=17x6lzuVhx51Td/62Le0ctgAM
        PK6tV0i8OyXMtc/vA1dw/YRpwb71wuYVWHSs1x7nlysTUV6KF8gAJqCrcusIMJEYkCV9M4cwnzBhi
        GEw2zV0gMzH9SgrKgpOWvFFAfn8HrAKk/8uUXUEUT7/x3mBjlupnxaRmFGEvRFQGR1T0GtyjvbCkO
        sfyth4cx3mHRmiLvOBslcwmpvcxj4phn2BF5bu5F7ufu4QsFjyMeJ694cEUbH2GpKYQa9HXa880J/
        EzR7OszuNOfcso1fxDBMwTtIbuchLTFR5S6/RbKVUzKNvepWw3vzh5SN0BaeuQgBEtObQGQDLiHd5
        u+x6LhPHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iw7kB-0002Uz-Hl; Mon, 27 Jan 2020 17:00:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50AFE300739;
        Mon, 27 Jan 2020 17:58:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46A8B201EBCA2; Mon, 27 Jan 2020 18:00:10 +0100 (CET)
Date:   Mon, 27 Jan 2020 18:00:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]sched/rt: Stop for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20200127170010.GK14879@hirez.programming.kicks-ass.net>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180425194915.GH4064@hirez.programming.kicks-ass.net>
 <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
 <20200123215616.GA14789@pauld.bos.csb>
 <20200127164315.GJ14879@hirez.programming.kicks-ass.net>
 <20200127165638.GC1295@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127165638.GC1295@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:56:38AM -0500, Phil Auld wrote:
> On Mon, Jan 27, 2020 at 05:43:15PM +0100 Peter Zijlstra wrote:
> > On Thu, Jan 23, 2020 at 04:56:19PM -0500, Phil Auld wrote:
> > > Peter, is there any chance of taking something like this?
> > 
> > Whoopsy, looks like this fell on the floor. Can do I suppose.
> > 
> > Thanks!
> > 
> 
> Thanks. Probably make sense at this point to use Konstantin's new version?
> But they both do the trick.

Care to send it along?
