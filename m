Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F500214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG3isFzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBKNmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:42:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38521 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727653AbgBKNmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581428520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmX2QxmJTgqsJ7E84KMlupoW9uqlsOY7ScXnAyaxj68=;
        b=OG3isFzYu6jgKns9FbkE0RaeZOwytekk9mFOg6b5BG8Xud4y3EQx+/AEb3yKKRYdt3/OUx
        6T77pNma2Iv/RNXlg9jmQMl8QuC1mz240dqkx+uNbCyW+0RvvhDWKqJa8ws91TJ92OP35r
        jS9OgSMSbidk5kg4Dyb0l5g0twKRKqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-j2ABBXtlP6qzTAgIyTaP7Q-1; Tue, 11 Feb 2020 08:41:54 -0500
X-MC-Unique: j2ABBXtlP6qzTAgIyTaP7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63B2A1B18BFB;
        Tue, 11 Feb 2020 13:41:52 +0000 (UTC)
Received: from krava (ovpn-204-250.brq.redhat.com [10.40.204.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 062D65D9CA;
        Tue, 11 Feb 2020 13:41:48 +0000 (UTC)
Date:   Tue, 11 Feb 2020 14:41:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Joe Perches <joe@perches.com>, acme@kernel.org,
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
Message-ID: <20200211134145.GA93194@krava>
References: <20200131052522.7267-1-kjain@linux.ibm.com>
 <20200206184510.GA1669706@krava>
 <51a4b570eb47e80801a460c89acf20d13a269600.camel@perches.com>
 <20200210121135.GI1907700@krava>
 <c168e38f-ee24-f02c-9510-912ef4d3d6b4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c168e38f-ee24-f02c-9510-912ef4d3d6b4@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:50:41PM +0530, kajoljain wrote:
> 
> 
> On 2/10/20 5:41 PM, Jiri Olsa wrote:
> > On Thu, Feb 06, 2020 at 10:58:12AM -0800, Joe Perches wrote:
> >> On Thu, 2020-02-06 at 19:45 +0100, Jiri Olsa wrote:
> >>> On Fri, Jan 31, 2020 at 10:55:22AM +0530, Kajol Jain wrote:
> >>>
> >>> SNIP
> >>>
> >>>>  				ev->metric_leader = metric_events[i];
> >>>>  			}
> >>>> +			j++;
> >>>>  		}
> >>>> +		ev = metric_events[i];
> >>>> +		evlist_used[ev->idx] = true;
> >>>>  	}
> >>>>  
> >>>>  	return metric_events[0];
> >>>> @@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
> >>>>  	int ret = 0;
> >>>>  	struct egroup *eg;
> >>>>  	struct evsel *evsel;
> >>>> +	bool evlist_used[perf_evlist->core.nr_entries];
> >>>> +
> >>>> +	memset(evlist_used, 0, perf_evlist->core.nr_entries);
> >>>
> >>> I know I posted this in the previous email, but are we sure bool
> >>> is always 1 byte?  would sizeod(evlist_used) be safer?
> 
> 
> Hi jiri,
>      Yes you are right. We should use 'evlist_used' size itself.
> 
> >>>
> >>> other than that it looks ok
> >>>
> >>> Andi, you're ok with this?
> >>
> >> stack declarations of variable length arrays are not
> >> a good thing.
> >>
> >> https://lwn.net/Articles/749089/
> >>
> >> and
> >>
> >> 	bool evlist_used[perf_evlist->core.nr_entries] = {};
> 
> 
> I am planning to use calloc and free that memory later in function 'metricgroup__setup_events'.
> Something like this. 
> 
> 
> +       bool *evlist_used;
> +
> +       evlist_used = (bool *)calloc(perf_evlist->core.nr_entries,
> +                                    sizeof(bool));
> +       if (!evlist_used) {
> +               ret = -ENOMEM;
> +               break;
> +       }
> 
> Please let me know if its looking fine.

I'm also ok with the array on the stack, but I don't mind
this change as well

thanks,
jirka

