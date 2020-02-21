Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDEDC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E3A24672
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582250023;
	bh=kxnBMkPQlpPktAVe+rlFZ9ldhcYK8N2luly8CBV3iC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJOByNhDnZUTGJf500D4AQ4EWTpvUNwTa68kBat/Y988fca+NMEhGv/PlV9CvV8Jb
	 9MHkEc+e/jDloOikQzIvtiA1YD/e7nvfNMNUtiV6DUTPAvJ2l+LOPStqBlK66cmHh3
	 TVyHUuRYlUE5HpSAVHAhxi+XXLummovIQkUage3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgBUBxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgBUBxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:53:39 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7211206E2;
        Fri, 21 Feb 2020 01:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582250019;
        bh=kxnBMkPQlpPktAVe+rlFZ9ldhcYK8N2luly8CBV3iC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zVvhI6PcinajTRSoYMb3YJrVyX/4nT+k57baYRahrW/SSvbY2soMTu6UeUGFH/H6v
         EylSJW8KmPxmc2TRupD1wkQc1Rq+settujf+oKxrOp+8+cIH+QCrHzOwXJ9cblvD+y
         +vS6bK7uylbCU5Y9GD+CBF6ddwPH8+3PDSzah+cY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Wei Li <liwei391@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>, stable@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/8] perf cs-etm: Fix endless record after being terminated
Date:   Thu, 20 Feb 2020 22:53:07 -0300
Message-Id: <20200221015310.16914-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

In __cmd_record(), when receiving SIGINT(ctrl + c), a 'done' flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be
endless.

If the cs_etm event is disabled, we don't enable it again here.

Note: This patch is NOT tested since i don't have such a machine with
coresight feature, but the code seems buggy same as arm-spe and
intel-pt.

Tester notes:

Thanks for looping, Adrian.  Applied this patch and tested with
CoreSight on juno board, it works well.

Signed-off-by: Wei Li <liwei391@huawei.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: stable@vger.kernel.org # 5.4+
Link: http://lore.kernel.org/lkml/20200214132654.20395-4-adrian.hunter@intel.com
[ahunter: removed redundant 'else' after 'return']
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2898cfdf8fe1..60141c3007a9 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -865,9 +865,12 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
+		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
+			if (evsel->disabled)
+				return 0;
 			return perf_evlist__enable_event_idx(ptr->evlist,
 							     evsel, idx);
+		}
 	}
 
 	return -EINVAL;
-- 
2.21.1

