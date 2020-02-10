Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9186C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB4320842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Db62e2zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgBJMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:11:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727505AbgBJMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581336706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KToqo3vgNyBHRDRhobK+A4mQ66+OslNDKm9gvh/dCYw=;
        b=Db62e2zyKpPLEGG7dHQf3ux55c32jKlMMbnuFH54ldtEk//dGzCDhmn4lBfgHYvxyWbxqq
        c08lKsKXjdRPltpJjZKKnILT18YUK8lHctI8JbXOnVwSmNFbUv6+hEuU97bTfJZ/qeCq3s
        V3ECJZxD77tkKl/OkkfGs3XFXRxvEOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-0of35acdM86UPjtdqnRHuw-1; Mon, 10 Feb 2020 07:11:42 -0500
X-MC-Unique: 0of35acdM86UPjtdqnRHuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD610800D48;
        Mon, 10 Feb 2020 12:11:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1177287058;
        Mon, 10 Feb 2020 12:11:37 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:11:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200210121135.GI1907700@krava>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
 <20200206184510.GA1669706@krava>
 <51a4b570eb47e80801a460c89acf20d13a269600.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a4b570eb47e80801a460c89acf20d13a269600.camel@perches.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:58:12AM -0800, Joe Perches wrote:
> On Thu, 2020-02-06 at 19:45 +0100, Jiri Olsa wrote:
> > On Fri, Jan 31, 2020 at 10:55:22AM +0530, Kajol Jain wrote:
> > 
> > SNIP
> > 
> > >  				ev->metric_leader = metric_events[i];
> > >  			}
> > > +			j++;
> > >  		}
> > > +		ev = metric_events[i];
> > > +		evlist_used[ev->idx] = true;
> > >  	}
> > >  
> > >  	return metric_events[0];
> > > @@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
> > >  	int ret = 0;
> > >  	struct egroup *eg;
> > >  	struct evsel *evsel;
> > > +	bool evlist_used[perf_evlist->core.nr_entries];
> > > +
> > > +	memset(evlist_used, 0, perf_evlist->core.nr_entries);
> > 
> > I know I posted this in the previous email, but are we sure bool
> > is always 1 byte?  would sizeod(evlist_used) be safer?
> > 
> > other than that it looks ok
> > 
> > Andi, you're ok with this?
> 
> stack declarations of variable length arrays are not
> a good thing.
> 
> https://lwn.net/Articles/749089/
> 
> and
> 
> 	bool evlist_used[perf_evlist->core.nr_entries] = {};

hum, I think we already have few of them in perf ;-)
thanks for the link

right, that initialization is of course much better, thanks

jirka

