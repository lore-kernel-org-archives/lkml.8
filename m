Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48243207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQLvsu5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgEVGpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgEVGpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:45:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A4C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:45:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r18so8101002ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e4ZuqY0dvGBYqCt3ap0PI418kddCLr0S/2WUHAYpSJo=;
        b=kQLvsu5Jfv/fBVRLNROHCbutMjMHY/xDfUiD9FKsknin2bVeeJVJu+YI9Gyhmf303g
         Wy8Ac+jqpOyOfTHWHbhIZXlbJqc+MMRUMjSDmzW4htVw0+wD2yaoooh6N59CdEbU3Ll5
         cAUyfP/LnmIhrO/foTtx5tL7P3VWvOZqGioxJsvOVWZ91v1b1BhPd4xUjw10Rh7S3RBw
         NIoN7Ar+l1L/3FcBh3dzFf/A+mhuQbX2VfcdwelG61g8kA5k3JxAw2SMcj1it+T30kDf
         Nuqofw2K0vJMNfkurMMh996GacAywBHaSPvFRXmfoUxlhGoAMhSkiD0lb99itJJ428ND
         wKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e4ZuqY0dvGBYqCt3ap0PI418kddCLr0S/2WUHAYpSJo=;
        b=SHkXumfjFxkcpTJzhzVJI/KD/IEjCrj6f4AJex9ldNA106MSf5iRByJYg2Ob/Uueao
         S8DugoplGN4CIR5hhvYn5ct8U4cgKh1ojXdPds8aaVm+0+a8VukURJu8qH2lU5yDu1AG
         KN1dp505ybUTya6UxJIeT4qKoyB4l6Qo5wJXuIfqNxl3uV45zN1s7wC4reR2AS6frKD8
         gb1hmjcbe464ZgbmHGlsdlgxm1UcjCvyZimYX/HAghpG1hWaBvRAMVc+OV8cUhJvUqFE
         oA7EVBj8+fKn/mBDq2gspmcZxciCyjFGg5hJGMH1UFhsoohsEVbxAzCh3Y7wG+ZLC5YL
         +THA==
X-Gm-Message-State: AOAM531/kaSa+vv3yE6/xK6eyVZ/nXRJ1o/j7yFepD/c+5sihiRiHGjP
        NVDqYOb3D6yWRnwUad5/uWGqWp4lHSVT
X-Google-Smtp-Source: ABdhPJwFCgRMS0RBJaIp0jrhtuTECFdIg5eF0ubW8VIKUbGEMzeHGau752hDkrj6FMoTBbCYlME7HWHJerxj
X-Received: by 2002:a25:c509:: with SMTP id v9mr20360524ybe.263.1590129950926;
 Thu, 21 May 2020 23:45:50 -0700 (PDT)
Date:   Thu, 21 May 2020 23:45:46 -0700
Message-Id: <20200522064546.164259-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] perf list: Add metrics to command line usage
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before:
 Usage: perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]
After:
 Usage: perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 965ef017496f..0a7fe4cb5555 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -42,7 +42,7 @@ int cmd_list(int argc, const char **argv)
 		OPT_END()
 	};
 	const char * const list_usage[] = {
-		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
+		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]",
 		NULL
 	};
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

