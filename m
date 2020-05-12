Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB76DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D1520747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYN9uooS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbgELXwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgELXwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:52:07 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E1C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:52:07 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h1so15983101qtu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K2rAmVHL4TH0AEa1bnbzgmyhwl+VsVwYNsqFsu2K9Rc=;
        b=BYN9uooS4F+fj6kP0wG3by5ZHtzUa4RIpSq84ACcAyfU3HIwqFy0NW015T5LppHwbb
         937ycCPDdwbWGtXzTMFFSF7gzE2+Jg9kXCQ4WnRiattkQdTES2qjZTPUWSJ7zOR5zv/0
         Dn0ECCEpXYSHdzy3f10bLssYAjbmu4kcgxeduw0QEah+cB8AMOmSc8Y5k0Cjf3QELbnk
         9+rrN//w0xqtktoMA2hUgy78t8KENZZ4Hl7nBRlfp9+0cR5Ke2+Tke8dOm72ZMdMORZe
         ArigwEe+ezp1ZaDXvM/I6YTDKkd8fA8Xnn29mYmd8L7hN2ZIZ7HQSxkwgAwO9daa1Sg2
         zZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K2rAmVHL4TH0AEa1bnbzgmyhwl+VsVwYNsqFsu2K9Rc=;
        b=jx4RVKyAF8uyH1bqxJpZMWC4aP7E1HNWOe8Cz8hMbuZQuhwYGXjOF+4dOi0UzgIgZD
         g0KEQ4y0xvrHAn34a3+bPChQjlbGu+vygec1viEoMy1UsyINP5BjPWx4eFRpCVuJ/iL8
         FDF23y3EU9Dy+IXdLaMDoVh30e5shbyCIGJsCwqAi4AOkACopEtYX/acEH+DmRaP7XWf
         jCUvBdTaj23lFXz5E+LW4Ms19JYHEWhJf8O2MkOfEj0SUbYFuneJ5Y/xz3H+7nh69+1w
         yiRo5qnlAfFX39sTYUJLZ7fgc/9t20AKBZ61t6/wYVNRbu8Ibj97egwp6MdNK3g7cf33
         2ZpQ==
X-Gm-Message-State: AGi0Pubi/h7tEeUrOiJypC3ZBT711fFfoCkg0xX/9SVVJxUKOxu0tT6n
        8DSSOn/RopBnd9hszbxJzIPg1nkQ/7Ew
X-Google-Smtp-Source: APiQypKQkm+pPPWlercd58QMleUFxq2w2JaGA3OfHv9ZnK2i5Csw/ge7pGHqrEnpL4Nm+NNIp98J4Q+ZhVSu
X-Received: by 2002:a05:6214:1152:: with SMTP id b18mr11309850qvt.13.1589327526455;
 Tue, 12 May 2020 16:52:06 -0700 (PDT)
Date:   Tue, 12 May 2020 16:52:02 -0700
Message-Id: <20200512235202.7619-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] perf parse-events: Avoid free on non malloc-ed memory
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caught by libfuzzer, there is a segfault with:
$ perf stat -e i/bs,tsc,L2/o sleep 1
As a config_term is added that isn't a string.

Fixes: e8dfb81838b1 (perf parse-events: Fix memory leaks found on parse_events)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e9464b04f149..e37a6a3e6217 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1480,7 +1480,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
 			list_del_init(&pos->list);
-			zfree(&pos->val.str);
+			if (pos->free_str)
+				zfree(&pos->val.str);
 			free(pos);
 		}
 		return -EINVAL;
-- 
2.26.2.645.ge9eca65c58-goog

