Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693EEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CC0206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoF+1DPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgEEAEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 20:04:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728223AbgEEAED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 20:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588637042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwVHFxYYjOkkdD9SX+7OmmC4/WqixEH8rx2g3a5Y1PE=;
        b=HoF+1DPHuAsgQieOzoWsOKYHe/2zRXnF4oWxOAEgt3Q52ycA+DmMzflK6skLdRC0qcqFh0
        sE7XjqOaYmE4DmcwquFJhzrVmxHEmx4Jc0sc3dbKXt3lvQJpTlC9lPFFZvJYMMjAe/RDy2
        ikxDoSP5jiJbX3Zr/nM0AN7U/RWo80I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-7vmAu_pHMM2arvLjdhPsjQ-1; Mon, 04 May 2020 20:03:58 -0400
X-MC-Unique: 7vmAu_pHMM2arvLjdhPsjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1877107ACCA;
        Tue,  5 May 2020 00:03:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD0AA66062;
        Tue,  5 May 2020 00:03:54 +0000 (UTC)
Date:   Tue, 5 May 2020 02:03:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
Message-ID: <20200505000352.GH1916255@krava>
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
 <20200501102337.GA1761222@krava>
 <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 10:33:59AM +0800, Jin, Yao wrote:

SNIP

> > > @@ -1461,6 +1461,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
> > >   	BUG_ON(!leader->core.fd);
> > >   	fd = FD(leader, cpu, thread);
> > > +	if (fd == -1 && leader->core.system_wide)
> > 
> > fd does not need to be -1 in here.. in my setup cstate_pkg/c2-residency/
> > has cpumask 0, so other cpus never get open and are 0, and the whole thing
> > ends up with:
> > 
> > 	sys_perf_event_open: pid -1  cpu 1  group_fd 0  flags 0
> > 	sys_perf_event_open failed, error -9
> > 
> > I actualy thought we put -1 to fd array but couldn't find it.. perhaps we should od that
> > 
> > 
> 
> I have tested on two platforms. On KBL desktop fd is 0 for this case, but on
> oncascadelakex server, fd is -1, so the BUG_ON(fd == -1) is triggered.
> 
> > > +		fd = FD(leader, 0, thread);
> > > +
> > 
> > so how do we group following events?
> > 
> >    cstate_pkg/c2-residency/ - cpumask 0
> >    msr/tsc/                 - all cpus
> > 
> 
> Not sure if it's enough to only use cpumask 0 because
> cstate_pkg/c2-residency/ should be per-socket.
> 
> > cpu 0 is fine.. the rest I have no idea ;-)
> > 
> 
> Perhaps we directly remove the BUG_ON(fd == -1) assertion?

I think we need to make clear how to deal with grouping over
events that comes for different cpus

	so how do we group following events?
	
	   cstate_pkg/c2-residency/ - cpumask 0
	   msr/tsc/                 - all cpus


what's the reason/expected output of groups with above events?
seems to make sense only if we limit msr/tsc/ to cpumask 0 as well

jirka

