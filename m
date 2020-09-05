Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28369C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D915420760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599272371;
	bh=PmMgz23NVFV+Npld5knd6pW/gl6RuNePiVrEidd/0QM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E9wf4nae2kgSbsWec7JMbncPtMb0qIsfO83Oo+Atp8zZwFgA1p+UuL21s7uuXez2h
	 DytJfJLpkNv1y/nsYSp7mqSfSKTJ9M4n4jbLK3vbSNIh9RPqlWRHOha+nZkrLhcvK/
	 WcdMfsA72Evt9t3IpKHaJ88uQdWqgzDwWyfJ1W/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgIECTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 22:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIECT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 22:19:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D714C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 19:19:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so6394plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 19:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ps8UrWtPZjRW5z/xkNr3IUsfpSMHDcpIAwHSm9Jd7tI=;
        b=YfVV2X++o6V0VPP+PYljURstgwh6v23aekbhitrjT1Cjhdm8lCtkT87KY2GdDTcMc4
         kU+eOlDhs6Fr+D3c1G/MENAXdQzU5/CrKMi3jcyJcUOYYVqkCHQVuWVSzXuBY7ZxWGO7
         p4THrJL1gexG0YWYD+2Qa0riV0HwO4JGRvbLGXNGCKrIQMRhn+zrgafyEVltLFHt68aV
         LzTvUNmIlMTMlVvLh0RwA8d1nKP9BfxXofLSyio+EyNHja74Dk92XBLn4dNKicTDwVPa
         R589KCCpIIUqNSVKXRyYsb3CofTNcHpoSv0L6CFvVAmObbYQGMdT31qCla4Luc+rtXAH
         0oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Ps8UrWtPZjRW5z/xkNr3IUsfpSMHDcpIAwHSm9Jd7tI=;
        b=jFTG5bINMd6GYvITOYVldJW1kbZF4r/8McpMr9xYpltN6sz22ST0SeAHtPWF5xqeKv
         jKQ2/BSoX2KiJ+8j5lHQwUyNGwUi74xnboMjWiXDqJHK70Xg56aEPxaHZv/rqq34qMys
         fbEkRqnY8FNsh7jBacaUhrBBpfEh92MOQobOSIn8B10Mm3k84+fvkw8/XkZBGGjbQCdt
         3DLxO2wOI9viaKjCfLiPpNkiL2obXInYMVuOqQy46VR5rkZfE+boUMtuA8zCw4wX0igi
         FZJSgHwZnDRaMYohKSGc3hc2ibvW+inlp9oquycnBrvXXkUGzxHuV19x6dCcc1BNOGiH
         e9+w==
X-Gm-Message-State: AOAM531sCSq0twN7KcQfMA/5Y9xymgbTaBJIZQBwfiTFuCbpQfuda1Dl
        QCYAzEzK78sSsBwtmAOXEjI=
X-Google-Smtp-Source: ABdhPJyjM3ALprwknZlcphteMwhvwd2FDKl6DI6PIy/lZ87UWg3L7gtg5LCOnZINoHTUGX0CREDOiA==
X-Received: by 2002:a17:90b:110a:: with SMTP id gi10mr10757471pjb.104.1599272366439;
        Fri, 04 Sep 2020 19:19:26 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v17sm7691147pfn.24.2020.09.04.19.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 19:19:25 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2 1/2] perf metric: Fix some memory leaks
Date:   Sat,  5 Sep 2020 11:19:11 +0900
Message-Id: <20200905021912.621388-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found some memory leaks while reading the metric code.  Some are
real and others only occur in the error path.  When it failed during
metric or event parsing, it should release all resources properly.

Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..af664d6218d6 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -530,6 +530,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 						continue;
 					strlist__add(me->metrics, s);
 				}
+
+				if (!raw)
+					free(s);
 			}
 			free(omg);
 		}
@@ -1040,7 +1043,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	ret = metricgroup__add_metric_list(str, metric_no_group,
 					   &extra_events, &metric_list, map);
 	if (ret)
-		return ret;
+		goto out;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
 	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
@@ -1048,11 +1051,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
 	}
-	strbuf_release(&extra_events);
 	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
 	metricgroup__free_metrics(&metric_list);
+	strbuf_release(&extra_events);
 	return ret;
 }
 
-- 
2.28.0.526.ge36021eeef-goog

