Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE375C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813AF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JATpC/dH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbgE0Q2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:28:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389669AbgE0Q2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590596894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR9o35/WlFstlR0XZiU7qrsKtxElCJ2J6+AN52+sduY=;
        b=JATpC/dHQDDxYRThxXJeK6GwmVtZ5HbJe+QaXy0sHrHVEQingKYpJlqM8IBSEi9XMWga16
        IgBC0k+KVE4O7wQx2fwTLpKU79+iEd4jWtW9/bqPP/r+9cHAEIdhOl0G/6dJjKN3E81Xu7
        vJTKC8FvrxZXNPly0jUtdM0cNFmWI/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-ZJnzmQQ6MFG-rSvJ6qKhdQ-1; Wed, 27 May 2020 12:28:07 -0400
X-MC-Unique: ZJnzmQQ6MFG-rSvJ6qKhdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C8681005512;
        Wed, 27 May 2020 16:28:04 +0000 (UTC)
Received: from krava (unknown [10.40.195.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0793F7E467;
        Wed, 27 May 2020 16:28:01 +0000 (UTC)
Date:   Wed, 27 May 2020 18:28:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu
 map
Message-ID: <20200527162800.GC420698@krava>
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
 <20200526115155.GE333164@krava>
 <32c4663a-6934-2a2d-79e2-7a335e3629a2@linux.intel.com>
 <d6986a15-1e21-3414-9d68-c265e7db03f4@linux.intel.com>
 <20200527102805.GA420698@krava>
 <19b749fa-fa96-85ac-8c7d-10336ff7475a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b749fa-fa96-85ac-8c7d-10336ff7475a@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:49:11PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 5/27/2020 6:28 PM, Jiri Olsa wrote:
> > On Wed, May 27, 2020 at 02:31:03PM +0800, Jin, Yao wrote:
> > 
> > SNIP
> > 
> > > > Thanks
> > > > Jin Yao
> > > 
> > > Issue is found!
> > > 
> > > It looks we can't set "pos->leader = pos" in either for_each_group_member()
> > > or in for_each_group_evsel() because it may exit the iteration immediately.
> > > 
> > > 	evlist__for_each_entry(evlist, evsel) {
> > > 		if (evsel->leader == evsel)
> > > 			continue;
> > > 
> > > 		if (cpu_maps_matched(evsel->leader, evsel))
> > > 			continue;
> > > 
> > > 		pr_warning("WARNING: event cpu maps are not fully matched, "
> > > 			   "disable group\n");
> > > 
> > > 		for_each_group_member(pos, evsel->leader) {
> > > 			pos->leader = pos;
> > > 			pos->core.nr_members = 0;
> > > 		}
> > > 
> > > Let me use the example of '{cycles,unc_cbo_cache_lookup.any_i}' again.
> > > 
> > > In evlist:
> > > cycles,
> > > unc_cbo_cache_lookup.any_i,
> > > unc_cbo_cache_lookup.any_i,
> > > unc_cbo_cache_lookup.any_i,
> > > unc_cbo_cache_lookup.any_i,
> > > 
> > > When we reach the for_each_group_member at first time, evsel is the first
> > > unc_cbo_cache_lookup.any_i and evsel->leader is cycles. pos is same as the
> > > evsel (the first unc_cbo_cache_lookup.any_i).
> > > 
> > > Once we execute "pos->leader = pos;", it's actually "evsel->leader = evsel".
> > > So now evsel->leader is changed to the first unc_cbo_cache_lookup.any_i.
> > > 
> > > In next iteration, pos is the second unc_cbo_cache_lookup.any_i. pos->leader
> > > is cycles but unfortunately evsel->leader has been changed to the first
> > > unc_cbo_cache_lookup.any_i. So iteration stops immediately.
> > 
> > hum, AFAICS the iteration will not break but continue to next evsel and
> > pass the 'continue' for another group member.. what do I miss?
> > 
> > jirka
> > 
> 
> Let me use this example again.
> 
> cycles,
> unc_cbo_cache_lookup.any_i,
> unc_cbo_cache_lookup.any_i,
> unc_cbo_cache_lookup.any_i,
> unc_cbo_cache_lookup.any_i,
> 
> Yes, once for_each_group_member breaks (due to the issue in 'pos->leader =
> pos'), evlist__for_each_entry will continue to the second
> unc_cbo_cache_lookup.any_i. But now evsel->leader != evsel (evsel->leader is
> "cycles"), so it will go to cpu_maps_matched.
> 
> But actually we don't need to go to cpu_maps_matched again.
> 
> for_each_group_member(pos, evsel->leader) {
> 	pos->leader = pos;
> 	pos->core.nr_members = 0;
> }
> 
> If we solve the issue in above code, for_each_group_member doesn't break,
> the leaders of all members in this group will be set to themselves.
> 
> if (evsel->leader == evsel)
> 	continue;

I see.. the problem is in the for_each_group_member, how about
saving the leader into separate variable, like below

jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f789103d8306..a754cad3f5a0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -189,6 +189,51 @@ static struct perf_stat_config stat_config = {
 	.big_num		= true,
 };
 
+static bool cpus_map_matched(struct evsel *a, struct evsel *b)
+{
+	if (!a->core.cpus && !b->core.cpus)
+		return true;
+
+	if (!a->core.cpus || !b->core.cpus)
+		return false;
+
+	if (a->core.cpus->nr != b->core.cpus->nr)
+		return false;
+
+	for (int i = 0; i < a->core.cpus->nr; i++) {
+		if (a->core.cpus->map[i] != b->core.cpus->map[i])
+			return false;
+	}
+
+	return true;
+}
+
+
+static void evlist__check_cpu_maps(struct evlist *evlist)
+{
+	struct evsel *evsel, *pos, *leader;
+
+	evlist__for_each_entry(evlist, evsel) {
+		char buf[1024];
+
+		leader = evsel->leader;
+		if (leader == evsel)
+			continue;
+		if (cpus_map_matched(leader, evsel))
+			continue;
+
+		evsel__group_desc(leader, buf, sizeof(buf));
+		WARN_ONCE(1, "WARNING: event cpu maps do not match, disabling group:\n");
+		pr_warning("  %s\n", buf);
+
+		for_each_group_evsel(pos, leader) {
+			pos->leader = pos;
+			pos->core.nr_members = 0;
+		}
+		evsel->leader->core.nr_members = 0;
+	}
+}
+
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
 				 struct timespec *b)
 {
@@ -1956,6 +2001,8 @@ int cmd_stat(int argc, const char **argv)
 	} else if (argc && !strncmp(argv[0], "rep", 3))
 		return __cmd_report(argc, argv);
 
+	evlist__check_cpu_maps(evsel_list);
+
 	interval = stat_config.interval;
 	timeout = stat_config.timeout;
 

