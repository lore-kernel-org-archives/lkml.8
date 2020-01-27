Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E405FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE702071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/o0KiyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgA0RqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:46:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgA0Rp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580147158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FX8kD0L9qov6JUPvvdbzynW/esn7R+NY8dv4X6oArXY=;
        b=Q/o0KiyIN7fYR0KPmLApw9mvtgE867GKrH88VxNP3wx5pCEA1xas6oL2qitUqNN4HJqp8O
        u/nXw1XsQrtDMoDj1Lu3fEpOBWK+LUXBmOOPs3wVp1Gbnc/DG0Ys0vpJVIPKSOPcxFq+8d
        yN9x4hGHGPnWSUuq4dNacfIy1SsVwd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-3bUITg18Mj61EUVl44xXQg-1; Mon, 27 Jan 2020 12:45:53 -0500
X-MC-Unique: 3bUITg18Mj61EUVl44xXQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF828017CC;
        Mon, 27 Jan 2020 17:45:52 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C4BA19C58;
        Mon, 27 Jan 2020 17:45:51 +0000 (UTC)
Date:   Mon, 27 Jan 2020 12:45:49 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]sched/rt: Stop for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20200127174549.GD1295@pauld.bos.csb>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180425194915.GH4064@hirez.programming.kicks-ass.net>
 <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
 <20200123215616.GA14789@pauld.bos.csb>
 <20200127164315.GJ14879@hirez.programming.kicks-ass.net>
 <20200127165638.GC1295@pauld.bos.csb>
 <20200127170010.GK14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127170010.GK14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 06:00:10PM +0100 Peter Zijlstra wrote:
> On Mon, Jan 27, 2020 at 11:56:38AM -0500, Phil Auld wrote:
> > On Mon, Jan 27, 2020 at 05:43:15PM +0100 Peter Zijlstra wrote:
> > > On Thu, Jan 23, 2020 at 04:56:19PM -0500, Phil Auld wrote:
> > > > Peter, is there any chance of taking something like this?
> > > 
> > > Whoopsy, looks like this fell on the floor. Can do I suppose.
> > > 
> > > Thanks!
> > > 
> > 
> > Thanks. Probably make sense at this point to use Konstantin's new version?
> > But they both do the trick.
> 
> Care to send it along?
> 

I think you were on the CC, but here's a link:

https://lkml.org/lkml/2020/1/25/167

It's called: 

[PATCH] sched/rt: optimize checking group rt scheduler constraints

It does a little bit more and needs an "|=" changed to "=". And actually
looking at it again, it should probably just have a break in the loop.

I'll make that comment in the thread for it.


Thanks,
Phil

-- 

