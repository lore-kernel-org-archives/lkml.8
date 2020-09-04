Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57009206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599189719;
	bh=GLttCc5oB8mJ2SF7TxvISoCTh2bKhu6CJr3e0KvJRZk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nIZnugJ/VuyKPaoai8C2KhRYwjfLwFx08zWjGZ851ekiKDumnkPhoDF4MK8LfzHYs
	 VEgq4j0Vc/GZJc5VXJJ43KQLhxTKZ70LyWJQ3NKO1sGtWj3nm0JOJGL1OkM9WoEk6N
	 WB4S+5+KVgJiu9nd8AuH68hjFB8rPzwdmBw6EGY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgIDDV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgIDDVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:21:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90AC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:21:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so3822875pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 20:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cEGhSVKGyTcDoh4S8vfcg7s2VHDH8kS6rWS1UZv8ipc=;
        b=m9YRKlbzscj0981GJexrfFWy15d7fAeUIQi887wc0Ud72jlEeg1/Fxf4xtwB99kJ/B
         RCcOVcq1I5xbjwCOlYOiZexMMO02pvsUMStiAvfcJTOnAdItKUIJrR1onlFtyWVnyVrM
         EI7b+/tqxtB+DKiU9kA7EC/STr2ApbGm9g7/6atufIKqZ6u44Qy3qJ9B0PpVjFvbxU52
         TQ4iri2SUtsVtPrXaiRD82H4/13DP3fTyMgy0nsGzmqeQSn1JED1wtQI6JTnXPIjZ3Oa
         hWG9+FHZL3Iw3/MFlOBQsapDpGKH1WITVDvCmHob6ZcIjt/lKYfmzMxiIB7l6ClVNr2m
         O0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cEGhSVKGyTcDoh4S8vfcg7s2VHDH8kS6rWS1UZv8ipc=;
        b=H4KEb9W4Pp96JIc6IVcimLMDJ/qXxXOFxa7na6HoNtFbDM4hsBieaI2CwTGjC+qvRj
         9Yf6r2EqCMb76aynv04khiAbv2DqIqv2p5R+4yZYRoA+FJsw3bJLs5i0EO5cIR8jGRv1
         UwNoFgrD1BgUJS+DHFJwnQIpB2h8iTrM5q8sRQkU9+tGvHvj/J6OtOv8MskF50HhCDmf
         wT+lYZY/B0tudVGvW70ec4ie79z59dXNvnhtRh0CVKK6Cw46srwrVO9wNmtiIFfsa3pj
         QA73H4pxiqnrHSDkIRm8WGpcfkbtQBGwjMoE5emMDy26lly3OMmu13dx+FjwQRqygcvg
         wp/Q==
X-Gm-Message-State: AOAM531l9NysXRyOiMxdNm7XywhXbZRVYyXD26HhPB1iLy0BCUI+/kx1
        aZZpbRWEFFFSIlSuWyvgOIE=
X-Google-Smtp-Source: ABdhPJzBLSoaw4P8nWpL7d+Ey+LF7G42EZypYKQ8vGQ5UodTCOlM04AKtW1jJCfUC9v7VVWaO2K8Ig==
X-Received: by 2002:a62:7fd1:: with SMTP id a200mr6633985pfd.175.1599189711134;
        Thu, 03 Sep 2020 20:21:51 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id o63sm4731160pfb.190.2020.09.03.20.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 20:21:50 -0700 (PDT)
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
Subject: [PATCH] perf metric: Fix some memory leaks
Date:   Fri,  4 Sep 2020 12:21:42 +0900
Message-Id: <20200904032142.516333-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found some memory leaks while reading the metric code.  Some are
real and others only occur in the error path.

Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Fixes: 9afe5658a6fa8 ("perf tools: Release metric_events rblist")
Fixes: 4ea2896715e67 ("perf metric: Collect referenced metrics in struct metric_expr")
Fixes: 71b0acce78d12 ("perf list: Add metric groups to perf list")
Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
I'm not sure it'd better have them together or split each fix as
they came from different commits.  Please let me know if you prefer
split.

 tools/perf/util/metricgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..7e31c4578ce8 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -85,6 +85,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 
 	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
 		free(expr->metric_refs);
+		free(expr->metric_events);
 		free(expr);
 	}
 
@@ -316,6 +317,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			if (!metric_refs) {
 				ret = -ENOMEM;
 				free(metric_events);
+				free(expr);
 				break;
 			}
 
@@ -530,6 +532,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 						continue;
 					strlist__add(me->metrics, s);
 				}
+
+				if (!raw)
+					free(s);
 			}
 			free(omg);
 		}
@@ -1048,11 +1053,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
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

