Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F084C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD1820760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599272379;
	bh=egaktmLv9vv4SnVSGZWvMCl2L8jomAwlugvUanpRZ3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpmU8C5RW2j5b49OhESV6kjsPcx++VH6rFhR0jZ1yuIPFA5gQA9qmBh5RhQ0zBV8v
	 coyWoHgt9R+R6DqDkZYh1ZAcNLTqTebiWS/IuOSGd4hTG8hEtAqZv0p1ZiHxbeLExV
	 GuA+RVabp6U7fwHRtgznxH2AtrM6ULn7lu0yITLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgIECTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIECTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 22:19:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384FCC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 19:19:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c142so5570289pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 19:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxinKIwYdmIrjNnt1TtDx7mBkGxJupuWtsWZpbciQxc=;
        b=CZmnHrVzoBu9rfAQSJCOjZmkc0XQ4oI3FzhhM5AWcqMaTMmTMiXK5W7+Z57u+m4GOe
         rBT1bkW23MM0pqM7kPTMdEUm5QuJ9Yjpn4ofLYic3I7D8zCAlhoVAbEn6f8GH6Qy5ngl
         GHfLcOUh/HCBIR9ecSc7bi2eGrhvTO/FHqNw0t4pOnvtSawUlGjiNHDq3vwFs9Sikwz3
         47WMQc6AB1lQvzcf5W+xdDUMzNAbMowNBy0XrpFANDPhgPwyA/529Ht65gyoR7Cgz+5E
         VA0Yzfx6jCyitruDgyzfETWiOfjc6ak/nB6QASVLB8dK/Kp7SbjMg6wM848ZwX7Os383
         kv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uxinKIwYdmIrjNnt1TtDx7mBkGxJupuWtsWZpbciQxc=;
        b=fxxXx1udpJNL8HN0FfN65ab3RPICUM4VRZHWwHxekpxphgNZmJILcHBVHF8MNaCUn4
         0H6JvqIRbScnNO2l74HRRgwvDjNq77MRpO5MyDheglAg6lTVK533G9n3PhFelK8LJyPl
         VwdETIQQhyNNOP0oibtV/eMn/Ubw4TtIo7DCSJdNKP6KMqLSkywsu2dz6ud60//40jFo
         nP/giEif3lgTfjxxQ1N2BJlXTxF5gWDCLD5TopaCxLi00PcUnT6kL0fuun12RWXC+uK5
         tdVFwYisqCvXID5NyD1N+9UHO0xLK2xku4w8QdCJKmGZ7zdmtATFcTkTwyCu1RFWRMPM
         8nyA==
X-Gm-Message-State: AOAM532O+0gFBv0pBTiDX0efBAh5f2VtK/JotNMTG3PVyMcBxLmyLOkt
        eFFAtL2+f6OCn6GvTnGGDr8=
X-Google-Smtp-Source: ABdhPJwH7wnMC7wWeF6WnPUaaiI2U+sQ1N1oGbpVXU0YDoyuzoesQqoZanC8Y2iQouyyBEZQnpo/Vg==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr9208695pgp.341.1599272370373;
        Fri, 04 Sep 2020 19:19:30 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v17sm7691147pfn.24.2020.09.04.19.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 19:19:29 -0700 (PDT)
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
Subject: [PATCH v2 2/2] perf metric: Fix some memory leaks - part 2
Date:   Sat,  5 Sep 2020 11:19:12 +0900
Message-Id: <20200905021912.621388-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200905021912.621388-1-namhyung@kernel.org>
References: <20200905021912.621388-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metric_event_delete() missed to free expr->metric_events and it
should free an expr when metric_refs allocation failed.

Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Fixes: 4ea2896715e67 ("perf metric: Collect referenced metrics in struct metric_expr")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index af664d6218d6..b28c09447c10 100644
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
 
-- 
2.28.0.526.ge36021eeef-goog

