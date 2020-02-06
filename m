Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71EAC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B372521927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBFUKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:10:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:52228 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgBFUKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:10:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 12:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="225348205"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2020 12:10:23 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id F37893003A2; Thu,  6 Feb 2020 12:10:22 -0800 (PST)
Date:   Thu, 6 Feb 2020 12:10:22 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200206201022.GN302770@tassilo.jf.intel.com>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
 <20200206184510.GA1669706@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206184510.GA1669706@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:45:10PM +0100, Jiri Olsa wrote:
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

Yes.

-Andi
