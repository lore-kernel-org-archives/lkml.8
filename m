Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39FC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8072082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCdaAMPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgD3Hvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgD3Hvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6647BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j4so6788543ybj.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D5tpZw1i2R58vBAfGzRizvOpwrXZg+TLaUwg0kTWWxs=;
        b=XCdaAMPam24ZXt93ooP5BoahXateVjXo5BoCUYusyNVeIHKB/sbE0Un+TitRvAFZeC
         5A5jtrIQNFdwKbEIhxcDI4PfN3eQEz5K7TLUpstN6qxxBYxrSgh3oN7389USrJ25N1j6
         VCFnOLwaHEtCiUEhMdUrsgJamBdY5rMJ9RE9ck2LMxmci86jP+D/8MJQ7p13JrjRctu+
         6TdsgKhATLBU09+uTFmgp/SumWVoCCWgktqdGagsLUFzSMHKL693QXopW1jYwmrsyPp/
         RbiKFWb+wbCZzSNhxXwK+o8aMnSyRvmgcy5tK+AmKV7+OaD6dLFsFN5Kqs6NZI7Mdbm3
         AMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D5tpZw1i2R58vBAfGzRizvOpwrXZg+TLaUwg0kTWWxs=;
        b=Mxy2SpAsvAtiXL6ttE75emSdjLqkeLZSQjatdlhTCpKb3dKwX9Qbw96o/QO57/IpOf
         TSK85LYPcmseZ79/Q7ZtR7SfFFlojPKbaaIV0Lgen/jRgFQ+0N/zYwKBPhr6EUUuW6Lz
         HZtmMaaRSUyIzqhE5XSGuuO75kJrISNiPA2HHW3IRs85CO105fs8TjJvgbT2ldHApDq9
         vVPVh6HJ1SZ1FTnxEUzyj/pI+8Bh2+GLBVqNZQH1wk99U2J9R956+BOLlHS4xd1Eh0Sl
         mUJ+UEuvg6mdlYKoWxDEhn3KF62501h7pA7BUUR9YvXqoHfYqJW0OHYdjOeB/fA3l+Zf
         zMNg==
X-Gm-Message-State: AGi0PuYsjKjj18NSqxYxswVhvj9voKFNi57DeI1RDb9Kmbq2pn7leiha
        idCwFnhk+hN768X6JrbR2hBpb0d/5L7m
X-Google-Smtp-Source: APiQypI2rjcJY28kTjn6TjpnlSdmooUU7Id9A2nsae1ktEyqi/7mztX0iGBm4MuuISL6nRyiRfQrxT6ovCGj
X-Received: by 2002:a25:908c:: with SMTP id t12mr3654995ybl.206.1588233109356;
 Thu, 30 Apr 2020 00:51:49 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:33 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-2-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 01/12] perf expr: unlimited escaped characters in a symbol
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current expression allows 2 escaped '-,=' characters. However, some
metrics require more, for example Haswell DRAM_BW_Use.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 2582c2464938..95bcf3629edf 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -73,7 +73,7 @@ number		[0-9]+
 sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@]+
-symbol		{spec}*{sym}*{spec}*{sym}*
+symbol		({spec}|{sym})+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
-- 
2.26.2.303.gf8c07b1a785-goog

