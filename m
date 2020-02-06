Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF6C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4DD20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgBFS72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:59:28 -0500
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:41289 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgBFS72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:59:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4FBF3180301AE;
        Thu,  6 Feb 2020 18:59:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wrist39_523ece1de781a
X-Filterd-Recvd-Size: 2302
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Feb 2020 18:59:25 +0000 (UTC)
Message-ID: <51a4b570eb47e80801a460c89acf20d13a269600.camel@perches.com>
Subject: Re: [PATCH v3] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
From:   Joe Perches <joe@perches.com>
To:     Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>
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
Date:   Thu, 06 Feb 2020 10:58:12 -0800
In-Reply-To: <20200206184510.GA1669706@krava>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
         <20200206184510.GA1669706@krava>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 19:45 +0100, Jiri Olsa wrote:
> On Fri, Jan 31, 2020 at 10:55:22AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
> >  				ev->metric_leader = metric_events[i];
> >  			}
> > +			j++;
> >  		}
> > +		ev = metric_events[i];
> > +		evlist_used[ev->idx] = true;
> >  	}
> >  
> >  	return metric_events[0];
> > @@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
> >  	int ret = 0;
> >  	struct egroup *eg;
> >  	struct evsel *evsel;
> > +	bool evlist_used[perf_evlist->core.nr_entries];
> > +
> > +	memset(evlist_used, 0, perf_evlist->core.nr_entries);
> 
> I know I posted this in the previous email, but are we sure bool
> is always 1 byte?  would sizeod(evlist_used) be safer?
> 
> other than that it looks ok
> 
> Andi, you're ok with this?

stack declarations of variable length arrays are not
a good thing.

https://lwn.net/Articles/749089/

and

	bool evlist_used[perf_evlist->core.nr_entries] = {};

would be better.


