Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF978C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFC020739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kvda+kiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCUQni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:43:38 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55329 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:43:38 -0400
Received: by mail-vk1-f201.google.com with SMTP id t206so2921925vke.22
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HgXAjyLC23ZhVlTcox+O6/nrMpzziWgcQJusj5HieHc=;
        b=Kvda+kiOMBWUb6ioXd8yM60BXoKj2UDHP8fX18NHTu6+tuT188uHlaaZsbxAzW4Wo/
         PJc+sUCbF6OlsgVZt3PoyiGuTpbGuuotfKP3KdFYO3T8ibG6VI35v4r4nykxlYAV+My+
         mzyn+lNb8Mp9wpYyQhBIs9RSsVyes4JKK5quV0TA7+tBP+xcj5Tv5PXrLUjruO9m+MdF
         jFFQH7AhVz+0FD/pa69SoLRXmk62OGQ4wl0Tdrixi9/7MehxtWNRi+htHwN2DhRXrZD0
         b9M2xihhfGRYdRsN+rrBehbTA9fEx37s3aBp9o5dqikzpn9/+PkeXIq0/uW6AVjQ+bMt
         rF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HgXAjyLC23ZhVlTcox+O6/nrMpzziWgcQJusj5HieHc=;
        b=qTMtSGQ7JjrmjEx98R2+7bLr4qJtaeqEzy494kUa2X6jOEXntKb6hgB8lVKdk82gG5
         CLcmliZ+WONDPxkVu++Co8pETmSmRHA7mOU3kMA+rCy8Dlza7AZ6HaityHDshmuma3Gx
         eFi1iRnwQj0Y0nlJBshqbk/tMtDTIa7oqWt2C1332V3YguF74yU5FgipagaT3EkG2pgP
         vYmX+kaEATEYCGMybVLu1bQ5YPoBGLMHnpZORMYgzmMrZ0A31+ZCQZyWzkb/iglR19yJ
         6UmTpC4flNTdpEvC9Ykpr1vkN5ug0gVbenD7ccjKbT4LWZ0zWmSZVsNW5N59/l2ATLrP
         b1vg==
X-Gm-Message-State: ANhLgQ1MkN5LZeT4EdoVBFp6CkwO8BZ4N8UDQxwcEqMfLaHdrtaP3qrO
        J/3ogoHRrJIQkmzFfXRWdwEULxlATz0g
X-Google-Smtp-Source: ADFU+vt18+PQcmneQDPypUfLR4zWWTsnj0EiB3FvjLlBI6kg1no1xIiU3juusVTcCraxiIDvDQlrth6scjDU
X-Received: by 2002:a67:ed86:: with SMTP id d6mr9972999vsp.53.1584809015194;
 Sat, 21 Mar 2020 09:43:35 -0700 (PDT)
Date:   Sat, 21 Mar 2020 09:43:31 -0700
Message-Id: <20200321164331.107337-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] perf/cgroup: correct indirection in perf_less_group_idx
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void* in perf_less_group_idx is to a cell in the array which points
at a perf_event*, as such it is a perf_event**.

Fixes: 6eef8a7116de ("perf/core: Use min_heap in visit_groups_merge()")
Reported-By: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d22e4ba59dfa..a758c2311c53 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3503,7 +3503,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 
 static bool perf_less_group_idx(const void *l, const void *r)
 {
-	const struct perf_event *le = l, *re = r;
+	const struct perf_event *le = *(const struct perf_event **)l;
+	const struct perf_event *re = *(const struct perf_event **)r;
 
 	return le->group_index < re->group_index;
 }
-- 
2.25.1.696.g5e7596f4ac-goog

