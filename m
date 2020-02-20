Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F55EC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D8C2068F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9j3iw7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBTK46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:56:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726882AbgBTK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582196216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEJcc92FXgviReBjRemrl4fnoayV9MImYJJA2MdtkA8=;
        b=W9j3iw7p3rAQCtL7DEsLWSsVj/g9kr4vZCS9iR6GlqK5D8lcfKYDAISFtr8GKHUda+PjG+
        UPnb2SniojVulmufbI6YmkKwuyMythRPJkv3DOGHX6HQvkksaAABROSO5aB85J85pioS91
        lFabcUivT6aloMa+s+655maOUIft54E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-gHhh2198Nh2MoK5K6rM03w-1; Thu, 20 Feb 2020 05:56:52 -0500
X-MC-Unique: gHhh2198Nh2MoK5K6rM03w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C44F7107B267;
        Thu, 20 Feb 2020 10:56:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 505CB90F7E;
        Thu, 20 Feb 2020 10:56:48 +0000 (UTC)
Date:   Thu, 20 Feb 2020 11:56:45 +0100
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
Subject: Re: [PATCH v5] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200220105645.GB553812@krava>
References: <20200220050104.14094-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220050104.14094-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:31:04AM +0530, Kajol Jain wrote:

SNIP

> +				i++;
> +				if (i == idnum)
> +					break;
>  			}
>  		}
>  	}
> @@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  			    !strcmp(ev->name, metric_events[i]->name)) {
>  				ev->metric_leader = metric_events[i];
>  			}
> +			j++;
>  		}
> +		ev = metric_events[i];
> +		evlist_used[ev->idx] = true;
>  	}
>  
>  	return metric_events[0];
> @@ -160,6 +161,14 @@ static int metricgroup__setup_events(struct list_head *groups,
>  	int ret = 0;
>  	struct egroup *eg;
>  	struct evsel *evsel;
> +	bool *evlist_used;
> +
> +	evlist_used = (bool *)calloc(perf_evlist->core.nr_entries,
> +				     sizeof(bool));

no need for the (bool *) cast

other than that

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

