Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD457C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E6F20679
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOtFjfzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBCBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:53:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39112 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBCBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:53:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so6700072pfy.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 17:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+2YWgBMeeryAAU9fYclXtNdUgS1YJs1/8RQuKlQaE8=;
        b=HOtFjfzsqzJtNZK8kSGu8LnG5oJm+REHMExI1vFCBQR7p1YFxE3PiBeN2XMp8dM3mu
         aAvEHJl8lXIqD2PguYF76B8wK9dK8rDxyZJh90JQku3rINQPzMEJkvmd4KrracreRGND
         mVyYYSAfXdRUmlvhKjerkcLqwV1fZ0J7VOMKjUsL5mY79s5Zsou2lpGHkZqpUiNIijb3
         DYlnTCldlG9XM7qlsOIGH4LNEn+qfAvadE5cKhuCe1y6Qw1KQXKnFefFcuNKb28dcO4S
         vIgaWVZYfdZTeEbpyhKTjuwWhLP5Dho9CoZj7bp2urRRQMOHn4K+jJvoQS9yPunnTUua
         KA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+2YWgBMeeryAAU9fYclXtNdUgS1YJs1/8RQuKlQaE8=;
        b=Ap0NlQks+TBEQyYmk2PSYwx6kZStK46M9FTyzgocNNhdocDsz4m/eq3eGTKxFKs+30
         2+FfyLKjhP23DxXSvl5qc3XlpLC71XJ9zd8QozJp17j7eEYR2+w+nrNP3vFCcReosgBU
         /hoG1BrVDH6o0wJOkwuRnu39LDqdjYHACUdgk9L9JjXzSFpQf5NfZygtLQPj+xSKj4iF
         GwRItiKmThkJ8akg/LnSJvA2hIjfEZmJQCB/6YO2rfNUB28UbSIfh+u3KbK7TNbv8/HT
         j+E4gbwQGB/ZJgqSKnXoAX3jsZOIlRizD5YjmYv8pHo2xHGKRVjz59zYtEgnohuuUBQj
         NrWA==
X-Gm-Message-State: APjAAAUU0zWICd0K0210RQbAWKWoF2zmdc70ERYK8fBM263Bo/iFqsUU
        FF7dfMp6yu9niuzWIpFH9pMcig==
X-Google-Smtp-Source: APXvYqyAbgLqJ9Isw3Tp2wOvQehMh8mkseNeD3y6W7Gpa4NaE0cR6RhiKf7WDy1GXf+n7lrx2pGgkQ==
X-Received: by 2002:a63:520a:: with SMTP id g10mr20966953pgb.298.1580694791834;
        Sun, 02 Feb 2020 17:53:11 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id y38sm17348308pgk.33.2020.02.02.17.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 17:53:11 -0800 (PST)
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
Subject: [PATCH v3 5/5] perf cs-etm: Fix unsigned variable comparison to zero
Date:   Mon,  3 Feb 2020 09:52:03 +0800
Message-Id: <20200203015203.27882-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203015203.27882-1-leo.yan@linaro.org>
References: <20200203015203.27882-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'offset' in function cs_etm__sample() is u64 type, it's not
appropriate to check it with 'while (offset > 0)'; this patch changes to
'while (offset)'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index dbddf1eec2be..720108bd8dba 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -945,7 +945,7 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
 
-		while (offset > 0) {
+		while (offset) {
 			addr += cs_etm__t32_instr_size(etmq,
 						       trace_chan_id, addr);
 			offset--;
-- 
2.17.1

