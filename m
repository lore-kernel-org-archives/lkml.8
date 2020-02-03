Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C551C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4345520679
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/IXNJ12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBCBws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:52:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36765 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBCBws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:52:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so6938360pgc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 17:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZtN+IROjimT43JRsQbvVHYEPbYXMl/SFxC9S1PE8YyU=;
        b=Y/IXNJ12F5S6PUOYu/CZK9rJNDd7h11FIFLQ6fKVTLwqXoftlCYeAQGUyGJtZSi6pB
         Q/7W679nH+eykxUvg09VFHGK4rfp5+qGQqh9QwLW4I7l86iA5HcjqYP7ycxUw7v81ouh
         3fp/JKM1xdEPaP6ffdUZgYtbR96NiLt8DbxVnoWFb7ctHHxb0ub6mrlGRV7gk6MvcoYv
         SYPEs9ZPpjGVjWauFH3wBvTfNGGWt8YhXYPm0Ga/pVKN+IwpabPHTW4th67NK6/r2KzL
         +McB5oY0WhM9f9TW6LyiAT3Bqp9VQJaom3LJ7NEBeH3lEb860qdeSqKCCWrciqTkNtyX
         wIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZtN+IROjimT43JRsQbvVHYEPbYXMl/SFxC9S1PE8YyU=;
        b=ecCw2TtJ05mHoobbkc8AKm5ZHp/0jFMt0fmOaa9E9Jw43rfTjGL6cMR3wpRguZR9xD
         g8WLcf6L6KoWZuuL8p2P7HwPJaeuKktGT4GqR4gPTvjMPwZu0q4rKw3tDqkvFSq1qBOU
         c+3M+h45TEBkTrSXStIaPeUQTC/NB2Qc0ZZPnLtpZ8SXySlOY9ui0+PrQ5mRfTxy+16M
         9FTur9omdSxyQL8dkp3ZKdQFE1lyp7Zf3v8Ixfw6ql7iSFdWMGL1YV3b04M8+yuZh72B
         BhY/YsZp3XJQIYhuqmW19KTAMY1HgwFKREacqsyNz49pQKTjtth2rsdPdyh0nQQRHqNU
         qOYA==
X-Gm-Message-State: APjAAAV5WXjXbO3TYSFcsYr5AYPt0g8C+2dxo1aZlYLNe/dhUmZ9So5E
        zgLX74pJkTZO0iLsgji35argIQ==
X-Google-Smtp-Source: APXvYqzEiR+0CTK6680g0QGF4i1TNS4yfGIjltdxtCdltKTWyfljfcUy9Xmi9qNXIujbFFNHEv8fkA==
X-Received: by 2002:a63:5962:: with SMTP id j34mr23492237pgm.421.1580694766237;
        Sun, 02 Feb 2020 17:52:46 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id y38sm17348308pgk.33.2020.02.02.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 17:52:45 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/5] perf cs-etm: Continuously record last branch
Date:   Mon,  3 Feb 2020 09:52:00 +0800
Message-Id: <20200203015203.27882-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203015203.27882-1-leo.yan@linaro.org>
References: <20200203015203.27882-1-leo.yan@linaro.org>
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
---
 tools/perf/util/cs-etm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3dd5ba34a2c2..3e28462609e7 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1153,9 +1153,6 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 			"CS ETM Trace: failed to deliver instruction event, error %d\n",
 			ret);
 
-	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
-
 	return ret;
 }
 
@@ -1488,6 +1485,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		tidq->prev_packet = tmp;
 	}
 
+	/* Reset last branches after flush the trace */
+	if (etm->synth_opts.last_branch)
+		cs_etm__reset_last_branch_rb(tidq);
+
 	return err;
 }
 
-- 
2.17.1

