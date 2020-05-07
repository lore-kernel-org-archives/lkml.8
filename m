Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54727C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FB42084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eur0wIBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgEGOJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgEGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:09:07 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75A9C05BD0E
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:09:07 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l26so7263251qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wdUpgcjdyvRHeAuiwINZJwatakpGlpcmPaMYucAxya4=;
        b=eur0wIBtvOH+Sz4003Csm24kTQO29K/AzdN7JLl/TqtLWDLPQt1yrq0CNrOvgdiPMY
         0W5KlOEOpnUfEhTJ22vhbpZES0DoE9DGo+562tFsbt3f/pTlmmJ9z0LsMHBqV1k2E86j
         DaZrjk+orMMIiRf3z/d9emq4Dx2eUKcCM9p6KmmA96MFWLr2paywBjWSA0/n9LJLtW14
         OjZftxrB2Vacqf378/mIJinuUryPOx10KBsLQZf38NmtCYSgPnNec8DaG7jqndUGDx6v
         R5cjNtIjmVC1ObR3POGiF6WuxJf46c5ggyINgg9Dc1REmoes7SxpiwhUhM/6OjOqPENJ
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wdUpgcjdyvRHeAuiwINZJwatakpGlpcmPaMYucAxya4=;
        b=uLzNcAnaxGCHkgO71/pfrb0kspQr1Ot6ZEymutl9BiIB2kWB77v/mB/gLGkbXlDOlU
         2Et7LkCK3f+FEaZE+iV/CitHmPRctK2RnYapJoRE7mVADiuAo4tvHj1/zmFyv/0pTHw3
         1X1J2/Ir5xftOyRXEwonLuMmqR1CGPo4Tr/2C8NZJqBATNcpK7K5x49lRk+cTPIAI1Qm
         HNXxavEOPwGWUrXQsYN17TL7OZsNPlM5sd6n59HvOYP/KKR8ndSmQLla7azhVAEob7/W
         Q6W25UUhaOrgbJmFu5ZhUcdx1ARuy5vQutgaYYuMSCFgpS8ab9VOUnFx3hkfYYpiftmL
         +imQ==
X-Gm-Message-State: AGi0PuYCSiSf/gpn4KJnHn5N/Bwfyw+rgbKfLjgCb2mGrj5i4/KX3iI2
        E3cdtSn3M4gY1NPu7Gy8DYjF8ugmbJ10
X-Google-Smtp-Source: APiQypLkzvxuHxLhzwSmD5W2sg2i23YZbECGdr9Qm17sVLocyiOKCFOYaEoudaj9IK3UpEAAh+fU0KuTtuJ8
X-Received: by 2002:a0c:8583:: with SMTP id o3mr6252930qva.233.1588860546820;
 Thu, 07 May 2020 07:09:06 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:18 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-23-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 22/23] perf metricgroup: order event groups by size
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
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
index 0a00c0f87872..25e3e8df6b45 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -519,7 +519,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
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
2.26.2.526.g744177e7f7-goog

