Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5428C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87A020848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krwQ6sIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgBMJm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:42:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45409 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:42:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2784665pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GZ5nyXgOdQJHZ2cR30e/+vtSPLvl2FoSgBANtMAsC3w=;
        b=krwQ6sIKq1EtFX9uJx37mA/JlSIdFZBp9pSRKe0hxbRsdNfhL+NWHJ/7btNCGQ06h5
         ckpj1vPA072BGG8kAahDKoqZtN8u16iEypF7iTJwlJb7aMZ93KNoKUjBdWkO1gZkWTCd
         gfmJtVTGe8p5gWV3vg4fTtTcOtOn21+oXXjiz859yYzqHoNSteC53vrut/mpj8BlrKVf
         i0zurWflO9wJe9xzrhWEJKeF1JfTz/EsQgLnPccNQdZ2RD91oHGuiCq7ZyIlaLyUKL7g
         7kuTD/tXHWvB/+lQPXIoNI1qMyJMAs/eGC0zBd9yalzwNNDJwCxcVBv6XGRgA0WlztUV
         zV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GZ5nyXgOdQJHZ2cR30e/+vtSPLvl2FoSgBANtMAsC3w=;
        b=BptkE26NnSpiuF+e6a+4i+r9c2EoHGiSa48aEfJKCZ9u1uKZ9gAqlUf2yYStwpkk96
         ZOegdWpDbfrUrJ/CqZXDAgA264VTGyIkifU/6WyEopkQxS6bq74cDFBvgbU8SeZAwBKJ
         4TuKMBjHj5Y3yQBl7gI1MBS2djuTA4RsGWwSfF55gvajsFPrJDOyCvQvW3tHkJaPokB+
         Z1n6UcCPhLSgp6qsqI5IRIiwJ6L1IahQmz9EDXPI5kqjTO6oZlZi2GAm66JfJcQfVSrR
         IlYBcXB3pdpOGDjr2/WUurQSyDwlV3vl2qQVqqf481XtF09S2bIwjgxK/fokmxlhSiA+
         0h/Q==
X-Gm-Message-State: APjAAAVyITSnt+eaT0NufBeIFCnHrE0NviNELE73GyD6oauoQlBAu50t
        cUwlx+2xjHUs+dJ34e03UfkY1Q==
X-Google-Smtp-Source: APXvYqwwFnhUMc3e+nIoi46LQxwZ/BKqxx5Qc3gbVTYD2Yj6SMe+VVEZ1UYEjQ7mExqzjyNoMkXzUg==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr13196607pfo.213.1581586974535;
        Thu, 13 Feb 2020 01:42:54 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id 3sm2310277pfi.13.2020.02.13.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:42:54 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/5] perf cs-etm: Continuously record last branch
Date:   Thu, 13 Feb 2020 17:42:01 +0800
Message-Id: <20200213094204.2568-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213094204.2568-1-leo.yan@linaro.org>
References: <20200213094204.2568-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time synthesize instruction sample, the last branch recording
will be reset.  This is fine if the instruction period is big enough,
for example if use the option '--itrace=i100000', the last branch
array is reset for every sample with 100000 instructions per period;
before generate the next instruction sample, there has the sufficient
packets coming to fill the last branch array.

On the other hand, if set a very small period, the packets will be
significantly reduced between two continuous instruction samples, thus
the last branch array is almost empty for new instruction sample by
frequently resetting.

To allow the last branches to work properly for any instruction periods,
this patch avoids to reset the last branch for every instruction sample
and only reset it when flush the trace data.  The last branches will
be reset only for two cases, one is for trace starting, another case
is for discontinuous trace; other cases can keep recording last branches
for continuous instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 84f30c2de185..b2f31390126a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1170,9 +1170,6 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 			"CS ETM Trace: failed to deliver instruction event, error %d\n",
 			ret);
 
-	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
-
 	return ret;
 }
 
@@ -1485,6 +1482,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 swap_packet:
 	cs_etm__packet_swap(etm, tidq);
 
+	/* Reset last branches after flush the trace */
+	if (etm->synth_opts.last_branch)
+		cs_etm__reset_last_branch_rb(tidq);
+
 	return err;
 }
 
-- 
2.17.1

