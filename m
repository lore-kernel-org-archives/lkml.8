Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F89C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2A22176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElOwfH5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBSCTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:19:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43091 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSCTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:19:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so8880151plq.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0n3bCMKVPcTL7ZDSsdKbGiesjZL6H1rMCnqz/XkRXJ8=;
        b=ElOwfH5Onz8U8ol8oSfjBK0bPmP3l325hdSQjzWnNQhHXcDjV+SFvxlvtt43NbNSrA
         pnulaAvng4VefC9rILZVbu07OUdV3qhymebe732MKgx0KDzbfmEr0BuUPzUrl+fXIYvC
         BeNe1n02qOg9lDzkYOOG/YHngHJ0Fxy/Ygh37b9nGeCYQeB0GIFoGz2ZZlzMZAkmBdA1
         rnJ1pomZ0ZIwz3YO+3jD1U30mAJS3x5cxCyDeG5UBMEW6YIvHEdD76zBbBYbaNxjPAKM
         LN3Mx//kt9u/kY52UjTqc+crWNmD0u7IV0ppDu4OsmovP15N6MNmTK/2BXmSyaF+VH54
         UEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0n3bCMKVPcTL7ZDSsdKbGiesjZL6H1rMCnqz/XkRXJ8=;
        b=A9jCl5sb6WZHdarH9vsey9deF/XP+nCxalSKVFVemzT2DFuUG1o+wletdnwwrVNfS4
         uuPpGUzaoSWvZ9eiy1rAjAnUJ1jHAiCjCnewKqhtqOZh3W9CnQmN5wMxV9ar6sOtXRn7
         U2jKuWFmIMRL7+Ris345Y93uUsOv5osr4cd8mxdY0r92QfcB2cbETc51ysvQRZORjlYJ
         sYIPgp14LEpBpbf3fsSZd0f9rOX+XLcD6OQ68NFNsfjdduN0Vul+Arq1PtyUSeG/oZg5
         4d1SNDmfEDk5g26xb38IEwPT/xIsw9LySppzlvk/AmdB/rCv82H5zF0Wsy1ywpBJf2ta
         kZ8Q==
X-Gm-Message-State: APjAAAWbCRaVxd6CYtZEVgyQ6TlZq9MhvYLB86AzpuRe6cgan+8sBiHr
        JBs22nue36MWKwXYmvxea2UxTg==
X-Google-Smtp-Source: APXvYqwD9w+iDoltztRVgp/7slI+JKpGxGX4xI+qC2WnbgD6u5THByB9GOxIQT/5SsrJOkj/cck0dA==
X-Received: by 2002:a17:902:820b:: with SMTP id x11mr23692815pln.196.1582078772192;
        Tue, 18 Feb 2020 18:19:32 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id q11sm322698pff.111.2020.02.18.18.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:19:31 -0800 (PST)
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
Subject: [PATCH v5 5/5] perf cs-etm: Fix unsigned variable comparison to zero
Date:   Wed, 19 Feb 2020 10:18:11 +0800
Message-Id: <20200219021811.20067-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219021811.20067-1-leo.yan@linaro.org>
References: <20200219021811.20067-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'offset' in function cs_etm__sample() is u64 type, it's not
appropriate to check it with 'while (offset > 0)'; this patch changes to
'while (offset)'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aa4b6d060ebb..bba969d48076 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -962,7 +962,7 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
 
-		while (offset > 0) {
+		while (offset) {
 			addr += cs_etm__t32_instr_size(etmq,
 						       trace_chan_id, addr);
 			offset--;
-- 
2.17.1

