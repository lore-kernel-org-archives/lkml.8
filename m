Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7088AC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903D214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ2/DfLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBFSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:45:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25989 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgBFSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581014730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TTShU17dPXmvecG0o1LJevam/FulFoOxzucu7Hkvbno=;
        b=PZ2/DfLs5ljDzuVgor5ydzBc462a9AC+/ejxcvwx0Go7nXk3pxwflP9WLt5POFvt3OgRAp
        GjOKKpthtW/OwqksWAlNtcfhSeL4N9uwZ0Nv7S0+t0Dm0SIp2RbVVugf5CEu1jdYNrRpdq
        jBcfQTAHWtfjMTihQ0BNbbnGk3bQFrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-uuWUjgWwMtCMuAwlXdnwzA-1; Thu, 06 Feb 2020 13:45:22 -0500
X-MC-Unique: uuWUjgWwMtCMuAwlXdnwzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6258C1088390;
        Thu,  6 Feb 2020 18:45:19 +0000 (UTC)
Received: from krava (ovpn-204-87.brq.redhat.com [10.40.204.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9C7790CF;
        Thu,  6 Feb 2020 18:45:14 +0000 (UTC)
Date:   Thu, 6 Feb 2020 19:45:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200206184510.GA1669706@krava>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131052522.7267-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:55:22AM +0530, Kajol Jain wrote:

SNIP

>  				ev->metric_leader = metric_events[i];
>  			}
> +			j++;
>  		}
> +		ev = metric_events[i];
> +		evlist_used[ev->idx] = true;
>  	}
>  
>  	return metric_events[0];
> @@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
>  	int ret = 0;
>  	struct egroup *eg;
>  	struct evsel *evsel;
> +	bool evlist_used[perf_evlist->core.nr_entries];
> +
> +	memset(evlist_used, 0, perf_evlist->core.nr_entries);

I know I posted this in the previous email, but are we sure bool
is always 1 byte?  would sizeod(evlist_used) be safer?

other than that it looks ok

Andi, you're ok with this?

thanks,
jirka

>  
>  	list_for_each_entry (eg, groups, nd) {
>  		struct evsel **metric_events;
> @@ -170,7 +174,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  			break;
>  		}
>  		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
> -					 metric_events);
> +					 metric_events, evlist_used);
>  		if (!evsel) {
>  			pr_debug("Cannot resolve %s: %s\n",
>  					eg->metric_name, eg->metric_expr);
> -- 
> 2.21.0
> 

