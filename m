Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4BFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C9120DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450346;
	bh=4raQMWdSpJImgzzbL1G9q81Uk3S7mEgJuRz65IRsg4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=felvYNwPpaZ3rVK67s0HCDU6RGCPNYZr3SvgtUe/MgRszxdqIx6FqNOe6AJxWXPBn
	 bjh4Z+O82QrF3VPrHpimbPGcHs89d5NS7n2XFPcCkJPqo2d7mFS30hzDBaMyZuuIfN
	 MIMnk/YirtImFXVGMp0zC6Gv1569CMjHSS3ScVqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIGDpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIGDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF0C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d19so424046pld.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vHtlKD/V9F7NxrIXamMSdU3ZLSFPaJyzGzZjwe8KqY=;
        b=M6F1I59Wp21nX8eEzSdSaAouSfWOh5JG6bhmbtSUGnhZKglf71aG0ur6ljllmdxsn6
         jrd0UQJbHnE+ApUKaf/Jc72EW2x+7wNsQE5x4rSrv+RE6Cnkog7EHB3zNs1/yG6sXncF
         W5ND6EofIlQKEcIRKCLE2AlJ8H91l1B8nVtHGb3UEosESoVbG0lmv3kZ/J35g5wGI+iV
         0f36A1xQ+F1/bc2Nj/8ESEGhVG04SYZHh5BbYF9Xb6gEiGA18JFsxdyxwFL4VPVCUBSD
         kqZ/n1C7LVryAL/Hjl4ULOyQFdjqcuO3K+oLz4xvVeFV8wq/DGSFA14gCB1J0OhhU3Vg
         iy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7vHtlKD/V9F7NxrIXamMSdU3ZLSFPaJyzGzZjwe8KqY=;
        b=OCS+ium37V2lJiGPGEaPa91XFrZlTRT9agDLwjHhqSo699+rB+DCINVi6fKiysiW3O
         gEqeweWd7ZS2lak2zrSZepSSdXj+iS5ZlRf3wSRFVm0o3rpRXoHLvdCs24R/jF42LaEJ
         4Z4tRXGR4H9gN5Cpgrkv5trp5xFinE6yy/gtrwClI3RLNf8XhLtt8EJttfil1EcaxOQf
         Q+3EUB28OtpD8XaIGgUMwuNgtJLJGcAMnJU8NfOcq5kL6kCDtpUmVoIZWK/nzIL2+udh
         sdztOlKleUPm+vfWxjKUdWf5pIZ41iHx902mKC12f8XQYh81SM4fRjiQgMRY6Wa7YWIb
         K73g==
X-Gm-Message-State: AOAM531W1WYvx0EOZHnH+7qmIrpKEIIASWRJXXF6pIdNEiZC4OktW/+t
        j7BfFlwYv3ojSR9dOr/e8o8=
X-Google-Smtp-Source: ABdhPJxCcMfTnOpPQHj48p6+Eks2+wDQrc413Va5wJ6XdegYqD+ZT0D5Lyq8k4T5AwBOuSZFeArBgw==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr18223149pjy.38.1599450341124;
        Sun, 06 Sep 2020 20:45:41 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:40 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCH 7/9] perf metric: Do not free metric when failed to resolve
Date:   Mon,  7 Sep 2020 12:45:00 +0900
Message-Id: <20200907034502.753230-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dangerous to free the original metric when it's called from
resolve_metric() as it's already in the metric_list and might have
other resources too.  Instead, it'd better let them bail out and be
released properly at the later stage.

So add a check when it's called from metricgroup__add_metric() and
release it.  Also make sure that mp is set properly.

Fixes: 83de0b7d535de ("perf metric: Collect referenced metrics in struct metric_ref_node")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c8904e471a71..ab5030fcfed4 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -672,7 +672,6 @@ static int __add_metric(struct list_head *metric_list,
 		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 		INIT_LIST_HEAD(&m->metric_refs);
 		m->metric_refs_cnt = 0;
-		*mp = m;
 
 		parent = expr_ids__alloc(ids);
 		if (!parent) {
@@ -685,6 +684,7 @@ static int __add_metric(struct list_head *metric_list,
 			free(m);
 			return -ENOMEM;
 		}
+		*mp = m;
 	} else {
 		/*
 		 * We got here for the referenced metric, via the
@@ -719,8 +719,11 @@ static int __add_metric(struct list_head *metric_list,
 	 * all the metric's IDs and add it to the parent context.
 	 */
 	if (expr__find_other(pe->metric_expr, NULL, &m->pctx, runtime) < 0) {
-		expr__ctx_clear(&m->pctx);
-		free(m);
+		if (m->metric_refs_cnt == 0) {
+			expr__ctx_clear(&m->pctx);
+			free(m);
+			*mp = NULL;
+		}
 		return -EINVAL;
 	}
 
-- 
2.28.0.526.ge36021eeef-goog

