Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A10AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AAA2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk2hX4/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD2IQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:16:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726355AbgD2IQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588148208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gNkjTiGAz2R8MMqKluleYUcDiaJ0cWYcMV4d5C4/Ams=;
        b=Hk2hX4/q/an5C+pRgT9ky/8OtdK+fiQyEPjKXD3nddRTMS6ILQ6hzJakSVcPo39TJXhG2j
        nDyG85kFqsJfWmdUah6U4ZhdBZ7lgB1CmS7ZLb4sU0QPPOYmwJBTQ/+5kWBEt6tBRHjxg+
        kIVS/phrxAydPo+WML+0LqmN6ao1agk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-uVwcsBLmPnK3RrZcrkl7aA-1; Wed, 29 Apr 2020 04:16:44 -0400
X-MC-Unique: uVwcsBLmPnK3RrZcrkl7aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C58721005510;
        Wed, 29 Apr 2020 08:16:42 +0000 (UTC)
Received: from krava (ovpn-114-35.ams2.redhat.com [10.36.114.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B312E5D9E5;
        Wed, 29 Apr 2020 08:16:40 +0000 (UTC)
Date:   Wed, 29 Apr 2020 10:16:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix uncore event mixed metric with workload
 error issue
Message-ID: <20200429081639.GJ1476763@krava>
References: <20200427144116.27330-1-yao.jin@linux.intel.com>
 <20200428105155.GG1476763@krava>
 <20200428211922.GA874567@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428211922.GA874567@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:19:22PM -0700, Andi Kleen wrote:
> > I wonder this would break some expectations.. would it be
> > more safe to detect duration event and bypass it from the
> > decission? but maybe the case I'm worried about is not a
> > problem at all.. Andi?
> 
> Don't see what it would break.
> 
> Yes maybe we need to special case duration_time more, but that would
> be a much bigger patch.

would below change work for you? if duration_time is the only
case, I'd rather go with the special case for it

jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9207b6c45475..2518204cffd1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1853,6 +1853,8 @@ static void setup_system_wide(int forks)
 		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
+			if (counter->tool_event == PERF_TOOL_DURATION_TIME)
+				continue;
 			if (!counter->core.system_wide)
 				return;
 		}

