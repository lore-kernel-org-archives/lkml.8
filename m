Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F64C208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbDfIOxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEHFhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgEHFg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:36:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEFC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:36:56 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id p31so665363qte.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qye1SVonTjqMOsVJuQeCBVCNLKV3+4pjVh0/bspBuQI=;
        b=CbDfIOxVT2dx5RZ83D4pkiUFNFhJ1sVAiBjizdkmRAvy0BO+EEXFy/kOCH2+kOlyzC
         2HkZMRFi8zBHJVdpkv5SmTDm4wXrXSakYtZCKlFJy6GE9FCbZQS6v/BiCflmUiUKit5Q
         DtUESQzY5X6tgPPinxek9XaFvK95W5b2w1Vcxd4THyaoSj/8IfeWeMHFwOQ4niq6AI0h
         W1U0ZFn+S7qzVA6xC1h2trc43J0goe2fQ1PUJQwoPCsepiASp2TgeMIOv73mkynRu/mX
         T7oFZtsStM9SlRg7yw7whM1bd5C03VhGgYbFMoKesas0wrfRbgzNS2BNLzIJgkL0jl0I
         /xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qye1SVonTjqMOsVJuQeCBVCNLKV3+4pjVh0/bspBuQI=;
        b=UcK5ZXzWndkgb8tOF7bSLJ2wbWva0r9e6N52NIIicQKGDrUQ/0RMbjOn2duvGr7w8S
         RK0i2plii0359cSPvIYq2mA9vHo+hXIht7uf+B4OcAbX0ks6kCL5kUmYr96h6zTbPCc+
         OHUUOXXue5/81jcg8+XZDCSNKt0G9qYIrO92Z/eoR43s0n6kp5IkJnZFl1jrrwavnxeJ
         ldGZT4EkxMU/JDGDhsT5q2rw3/LEDFqQ64Ce9kgrtbzHk0UxcdZTtCFyk8Zp1TNHWXMu
         Nyc82XEkL9dKBSCZgm8wLgI4pwWqLS4miVS4YY3lLUfAQAWUknXypRIja/8rM8zOsH6o
         1xLg==
X-Gm-Message-State: AGi0PubNfp2+uLO/l93rOeyRcfzM5W1iwFw5ldp2dfbTxja6Sjqfd7LV
        McutBGEW6bmbM2wv6hKb98xArShVKG0p
X-Google-Smtp-Source: APiQypJ1fookbhjSVt29vq8vulwRv7GbvsjbjS5kIOZ8ULGRiQnYVCkmIhCpb3LShI5EaEMa3+PzanIRhgqz
X-Received: by 2002:a05:6214:18c9:: with SMTP id cy9mr1066619qvb.35.1588916215992;
 Thu, 07 May 2020 22:36:55 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:27 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-13-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 12/14] perf metricgroup: order event groups by size
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
index 2a6456fa178b..69fbff47089f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -520,7 +520,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
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
2.26.2.645.ge9eca65c58-goog

