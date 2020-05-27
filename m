Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E12C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7F0207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8jRghwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbgE0K2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:28:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729830AbgE0K2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590575291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgWmlq9h7MEFRhAYArTCqlHsgNgDJX7NFnKqNMmx80g=;
        b=a8jRghwR2vgdxR02p9EKdscDX3aq4S5XbHS/fMBQw/1IIIB0wY3L/stQfTeS6SojfASmq+
        aczrXjwraUwVQmtILZYPbP605AxjxnvoNf5Fhul++EPzpjJZvVVpJw06GJjLwRU+wGQhcX
        Aotsx/tdKZhnIifgZqBW+iBaVH/czsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-BUvFFrQHOWq-OZn1AZ_OiQ-1; Wed, 27 May 2020 06:28:09 -0400
X-MC-Unique: BUvFFrQHOWq-OZn1AZ_OiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FE2C18FE867;
        Wed, 27 May 2020 10:28:08 +0000 (UTC)
Received: from krava (unknown [10.40.195.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3124B619C0;
        Wed, 27 May 2020 10:28:06 +0000 (UTC)
Date:   Wed, 27 May 2020 12:28:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu
 map
Message-ID: <20200527102805.GA420698@krava>
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
 <20200526115155.GE333164@krava>
 <32c4663a-6934-2a2d-79e2-7a335e3629a2@linux.intel.com>
 <d6986a15-1e21-3414-9d68-c265e7db03f4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6986a15-1e21-3414-9d68-c265e7db03f4@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 02:31:03PM +0800, Jin, Yao wrote:

SNIP

> > Thanks
> > Jin Yao
> 
> Issue is found!
> 
> It looks we can't set "pos->leader = pos" in either for_each_group_member()
> or in for_each_group_evsel() because it may exit the iteration immediately.
> 
> 	evlist__for_each_entry(evlist, evsel) {
> 		if (evsel->leader == evsel)
> 			continue;
> 
> 		if (cpu_maps_matched(evsel->leader, evsel))
> 			continue;
> 
> 		pr_warning("WARNING: event cpu maps are not fully matched, "
> 			   "disable group\n");
> 
> 		for_each_group_member(pos, evsel->leader) {
> 			pos->leader = pos;
> 			pos->core.nr_members = 0;
> 		}
> 
> Let me use the example of '{cycles,unc_cbo_cache_lookup.any_i}' again.
> 
> In evlist:
> cycles,
> unc_cbo_cache_lookup.any_i,
> unc_cbo_cache_lookup.any_i,
> unc_cbo_cache_lookup.any_i,
> unc_cbo_cache_lookup.any_i,
> 
> When we reach the for_each_group_member at first time, evsel is the first
> unc_cbo_cache_lookup.any_i and evsel->leader is cycles. pos is same as the
> evsel (the first unc_cbo_cache_lookup.any_i).
> 
> Once we execute "pos->leader = pos;", it's actually "evsel->leader = evsel".
> So now evsel->leader is changed to the first unc_cbo_cache_lookup.any_i.
> 
> In next iteration, pos is the second unc_cbo_cache_lookup.any_i. pos->leader
> is cycles but unfortunately evsel->leader has been changed to the first
> unc_cbo_cache_lookup.any_i. So iteration stops immediately.

hum, AFAICS the iteration will not break but continue to next evsel and
pass the 'continue' for another group member.. what do I miss?

jirka

> 
> I'm now thinking if we can solve this issue by an easy way.
> 
> Thanks
> Jin Yao
> 

