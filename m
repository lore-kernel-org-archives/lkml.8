Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC28C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A4D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480890;
	bh=l06XKShEPefboDcMeEJXBOoke+d6Gxpvi0aiqJjQEbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ki4aUE5MuPnQ6iV/JU2MK4kYsQSV8WvnmOnIHbCD1vT/vEoFe+ZMlRojXdUmrlaZk
	 /dJoXBg8c6WDijxuaoyykfcJeROEdsA2Ebd2CyFruKIx6TqKDwcsRSROmG24cgE8EK
	 GTxMJmMuZXTc+/vSXj0MqGG9ex3X2n5N5lonDQw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCQVes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgCQVeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1A820777;
        Tue, 17 Mar 2020 21:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480861;
        bh=l06XKShEPefboDcMeEJXBOoke+d6Gxpvi0aiqJjQEbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYdX3HINDbwaU9ksq2rDY7mufTeWZ9Ts7/VgjIFAE/GOPqQkoZYqFCQax1iwLKdbk
         DxM0OnrfCfM8YMV0h2JRvpy9JUMCbghOGQTpTCq5+d8WpxZhcOnYnV/B+KBNo1tBM1
         zeH7Knnip66/k7czCgDvDW3dfCt12JXaYQ2bjNcU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/23] perf test: Print if shell directory isn't present
Date:   Tue, 17 Mar 2020 18:32:56 -0300
Message-Id: <20200317213259.15494-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

If the shell test directory isn't present the exit code will be 255 but
with no error messages printed. Add an error message.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200313005602.45236-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5f05db75cdd8..54d9516c9839 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -543,8 +543,11 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 		return -1;
 
 	dir = opendir(st.dir);
-	if (!dir)
+	if (!dir) {
+		pr_err("failed to open shell test directory: %s\n",
+			st.dir);
 		return -1;
+	}
 
 	for_each_shell_test(dir, st.dir, ent) {
 		int curr = i++;
-- 
2.21.1

