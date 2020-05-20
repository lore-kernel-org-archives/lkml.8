Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61568205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEYhJcwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgETH3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgETH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:28:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0FC05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n7so1000607ybh.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LKKy4EOgcjxJnFjWUFUBMKy8IeFiRStXwAEvj/pKQVw=;
        b=CEYhJcwg0f4hgHy2KLu81eyGz7ACAd9la5BDRLXj9Lvo+9VU0bpSkYhmftvVnSkJXa
         Z6xsHILnqtSr1rxriSmbEBdrTHp1WBRBQkbupoV+zq7OWb+2kqcgXkHEeQ8bNv+5VrvN
         /RyrbVpaFiVYvIYl/BBnzpupmA9j+ADQLD8ggT1EJHRF/1DCJk9axgJN/oMS2laBy/cZ
         wjeFpNcv4tf5YCwIRCLAtNbNP1UXdqsa3LlDjI4CDOXp/zjXXmBD+jWQTta/WtNzR+Zs
         eLlxtYkZna6h6KeDoC+jsO7PPZLGTbNtgELVQi+f9OhW+wVnBg8iftO8HcquGuMPjyQF
         MsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LKKy4EOgcjxJnFjWUFUBMKy8IeFiRStXwAEvj/pKQVw=;
        b=akh8hpvPn97niPq5sy5oIt0c6l3XyD4K8xC3UuKjYv522Qay4XdpdCjSVAYGu75/cJ
         Q6LqMlBhREnO8RCHVmZqITTmPr2mJZAh/Ych4N/glwJk1gsI6Nh7aK0bw1BBb107KdfO
         euBcs+TMQEvxm9O9V8XvkGx9OUDwZcCB0Relcv4nnu4zUKo90goA3u3z4Ft2zol8Leya
         gwbE+djsZp0OqJPxloKi/x0BueFkpYqYdVRl4sG0cuD8y1tJgLjceiJqaszqLRgakmuA
         OeEzFMviYJmWZK/a8vkdYOHo9+FHMqtgXdOK+0L2IulDYM0sFnwg/sapT17dkGT24w6y
         /xJA==
X-Gm-Message-State: AOAM533XAe4/GrIIGst9rdkTi7+Ae+zzFLAcRIpCF6Eso/fnxDWNbTtW
        pvRSI5l9W45gLT3BpRI+7F2Z2zuSXd00
X-Google-Smtp-Source: ABdhPJwQ50lnRVO0QJ4LMsurz9oD9nYh8VxhBcPlPXBME3O2v0MTpRxh/x4lo31Qvxr+4ILJYejvme4sdhkO
X-Received: by 2002:a5b:14a:: with SMTP id c10mr4688572ybp.369.1589959710270;
 Wed, 20 May 2020 00:28:30 -0700 (PDT)
Date:   Wed, 20 May 2020 00:28:11 -0700
In-Reply-To: <20200520072814.128267-1-irogers@google.com>
Message-Id: <20200520072814.128267-5-irogers@google.com>
Mime-Version: 1.0
References: <20200520072814.128267-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 4/7] perf metricgroup: Order event groups by size
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paul Clarke <pc@us.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding event groups to the group list, insert them in size order.
This performs an insertion sort on the group list. By placing the
largest groups at the front of the group list it is possible to see if a
larger group contains the same events as a later group. This can make
the later group redundant - it can reuse the events from the large group.
A later patch will add this sharing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index afd960d03a77..52e4c3e4748a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -508,7 +508,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 		return -EINVAL;
 	}
 
-	list_add_tail(&eg->nd, group_list);
+	if (list_empty(group_list))
+		list_add(&eg->nd, group_list);
+	else {
+		struct list_head *pos;
+
+		/* Place the largest groups at the front. */
+		list_for_each_prev(pos, group_list) {
+			struct egroup *old = list_entry(pos, struct egroup, nd);
+
+			if (hashmap__size(&eg->pctx.ids) <=
+			    hashmap__size(&old->pctx.ids))
+				break;
+		}
+		list_add(&eg->nd, pos);
+	}
 
 	return 0;
 }
-- 
2.26.2.761.g0e0b3e54be-goog

