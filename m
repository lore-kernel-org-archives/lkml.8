Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82069C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55334222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0r85c8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgBUJrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:47:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727036AbgBUJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582278426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYJv/RNLBVK+CZZ2NpY92PU2DlYHjj7XOPRvAHWJX7o=;
        b=W0r85c8JzdSocmJTL4VsrnsY4TAxvcVgpIEltzmWR3jsCWoL44F8i5qsbhgUi125XNSn5G
        Y8z19JfHlQoVV+wakWAlji3qrsTmK+1DDC1J+gYVdS6cIl4zvzHz2H0gasUDqnnWSreXHi
        cdJP5COANrd1/oHMbwXwjy9vOV7quCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-4t6dH4tCNi2Kw8YW27L6JQ-1; Fri, 21 Feb 2020 04:47:04 -0500
X-MC-Unique: 4t6dH4tCNi2Kw8YW27L6JQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B2AD100550E;
        Fri, 21 Feb 2020 09:47:02 +0000 (UTC)
Received: from krava (ovpn-204-101.brq.redhat.com [10.40.204.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAC80909EC;
        Fri, 21 Feb 2020 09:46:56 +0000 (UTC)
Date:   Fri, 21 Feb 2020 10:46:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
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
Message-ID: <20200221094653.GF586895@krava>
References: <20200220050104.14094-1-kjain@linux.ibm.com>
 <20200220105645.GB553812@krava>
 <1346f859-601f-4d79-c0b9-2dda41e71354@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1346f859-601f-4d79-c0b9-2dda41e71354@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:12:15PM +0530, kajoljain wrote:
> 
> 
> On 2/20/20 4:26 PM, Jiri Olsa wrote:
> > On Thu, Feb 20, 2020 at 10:31:04AM +0530, Kajol Jain wrote:
> > 
> > SNIP
> > 
> >> +				i++;
> >> +				if (i == idnum)
> >> +					break;
> >>  			}
> >>  		}
> >>  	}
> >> @@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >>  			    !strcmp(ev->name, metric_events[i]->name)) {
> >>  				ev->metric_leader = metric_events[i];
> >>  			}
> >> +			j++;
> >>  		}
> >> +		ev = metric_events[i];
> >> +		evlist_used[ev->idx] = true;
> >>  	}
> >>  
> >>  	return metric_events[0];
> >> @@ -160,6 +161,14 @@ static int metricgroup__setup_events(struct list_head *groups,
> >>  	int ret = 0;
> >>  	struct egroup *eg;
> >>  	struct evsel *evsel;
> >> +	bool *evlist_used;
> >> +
> >> +	evlist_used = (bool *)calloc(perf_evlist->core.nr_entries,
> >> +				     sizeof(bool));
> > 
> > no need for the (bool *) cast
> 
> Hi Jiri,
>      Should I resend patch with this change?

yes, and include my ack plz, thanks

jirka

> Thanks,
> Kajol
> > 
> > other than that
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> > 
> 

