Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E12C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C876B2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8EQAFxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAQOcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:32:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726827AbgAQOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579271541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rB4/SIKshMmHhqm2XVjUkYvosyY6DPjwv3996fiGs1Q=;
        b=H8EQAFxiEqjD21qBSMJ5/5iOWPYwweRfmhyc7vhlMj1/YH9XK5EKZfTi1epNE9k6+RK8TS
        Qstw5Hx/Tye/HDpeO4t0/6crDdNl3soki9h2BzJqpwKPUMkaqMzDuanJ6f9NDjDk13em1u
        F+gr0cv0MmIsmjerNhsw9wsa/aY4vpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-XlCFKmivOK2-soQSTH3xow-1; Fri, 17 Jan 2020 09:32:17 -0500
X-MC-Unique: XlCFKmivOK2-soQSTH3xow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C21100550E;
        Fri, 17 Jan 2020 14:32:15 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ECB51001901;
        Fri, 17 Jan 2020 14:32:14 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:32:12 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200117143212.GB6339@pauld.bos.csb>
References: <20200114101319.GO3466@techsingularity.net>
 <20200116163529.GP3466@techsingularity.net>
 <CAKfTPtBznUt20QFzeQBPELcmN6+F=BOx09oSqVMzSGvXF5ByHg@mail.gmail.com>
 <20200117141503.GQ3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117141503.GQ3466@techsingularity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:15:03PM +0000 Mel Gorman wrote:
> On Fri, Jan 17, 2020 at 02:08:13PM +0100, Vincent Guittot wrote:
> > > > This patch allows a fixed degree of imbalance of two tasks to exist
> > > > between NUMA domains regardless of utilisation levels. In many cases,
> > > > this prevents communicating tasks being pulled apart. It was evaluated
> > > > whether the imbalance should be scaled to the domain size. However, no
> > > > additional benefit was measured across a range of workloads and machines
> > > > and scaling adds the risk that lower domains have to be rebalanced. While
> > > > this could change again in the future, such a change should specify the
> > > > use case and benefit.
> > > >
> > >
> > > Any thoughts on whether this is ok for tip or are there suggestions on
> > > an alternative approach?
> > 
> > I have just finished to run some tests on my system with your patch
> > and I haven't seen any noticeable any changes so far which was a bit
> > expected. The tests that I usually run, use more than 4 tasks on my 2
> > nodes system;
> 
> This is indeed expected. With more active tasks, normal load balancing
> applies.
> 
> > the only exception is perf sched  pipe and the results
> > for this test stays the same with and without your patch.
> 
> I never saw much difference with perf sched pipe either. It was
> generally within the noise.
> 
> > I'm curious
> > if this impacts Phil's tests which run LU.c benchmark with some
> > burning cpu tasks
> 
> I didn't see any problem with LU.c whether parallelised by openMPI or
> openMP but an independent check would be nice.
> 

My particular case is not straight up LU.c. It's the group imbalance 
setup which was totally borken before Vincent's work. The test setup
is designed to show how the load balancer (used to) fail by using group
scaled "load" at larger (NUMA) domain levels. It's very susceptible to 
imbalances so I wanted to make sure your patch allowing imblanances 
didn't re-break it. 


Cheers,
Phil


> -- 
> Mel Gorman
> SUSE Labs
> 

-- 

