Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D480C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620AF207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOfv3pE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBSCS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:18:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33303 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSCS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:18:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so8908367plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nt7KCfOCeoniLbejBgBQRi5gzr/DUGn0cHKbOhTd9/Q=;
        b=dOfv3pE6XbFb8+IRmXPhqeV8igWMRBbr+HjmaMwvwVzN9E/7yEORi7dYoDiXgpqnOd
         YbNIC741TwrprDCJYLH3GbQBZzKZBTZ4hgruvN8k6MAu7lNWg/YmqdPtnGRBKSEC7ELr
         5cXWrgy6pUF46qjvO9k1oqqPXRDgof2z+DaGUJ8Ta9LjbCgSX+QG7ob36DdlOqc1tEPz
         pLVVNUKMkQy13ZjCvs5MYJeMBh8Yb11VwrKuj+Z7g29jZJGByTnOUD44UUa8CmSYNWTS
         /pXvhI7S/Ob1rEthERuwJqU9v9YToQJcP6Apb7oIpa5LZFeBFlGJNxlVAgrgF8P8QaLT
         HElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nt7KCfOCeoniLbejBgBQRi5gzr/DUGn0cHKbOhTd9/Q=;
        b=o/nyintBXyFFozNOJqTExjwjo2uM/9v930r+jCMhruZ1a0Z8aeEoPPVkmELGcTi2NL
         KV6Po+BY8rjuJ+QmAPVRMRHBqnMZNzRI2m8DiWiJei3vEbaiQX8Ll26qdn+tAmAi0Lfa
         tV2lQtRgAmMQKaQHYHl/UOnJwYJFcvpVf54v1CofVlesRiF8SbqTo8G/SqsNBlVguVqv
         qMi94NXbyjtIID7jmRD/ZLKdIn9NjLU/b71zpCMzGmnMBr8Pc2bGaSJMp2CpkUL5y8Mc
         LjUYNyYaLV9Hq082s9nOvLo1+wfy3HQXzm0UMHRwx63qDarDBjKWDQqWitezqcnBwnGo
         z6qg==
X-Gm-Message-State: APjAAAX9kOvL4+OZ29o+lhnxUI8q3yiCdBo78Vn9lv18SY6cuRo2lpg0
        uE1BpzqxvjLlQN0/b9FlrKqqTQ==
X-Google-Smtp-Source: APXvYqxDMsV8y7MK6jcTkE0Nuq8R5uyaSz1O3tf6S14c6N+G6BlQ2tLZV9SIKkIeGfxUC7AzaJhMIA==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr22905597plb.11.1582078736772;
        Tue, 18 Feb 2020 18:18:56 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id q11sm322698pff.111.2020.02.18.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:18:56 -0800 (PST)
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
Subject: [PATCH v5 2/5] perf cs-etm: Continuously record last branch
Date:   Wed, 19 Feb 2020 10:18:08 +0800
Message-Id: <20200219021811.20067-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219021811.20067-1-leo.yan@linaro.org>
References: <20200219021811.20067-1-leo.yan@linaro.org>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

