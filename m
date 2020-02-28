Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EBC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59227246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898462;
	bh=pGRHdecX8oozXDewQOBi7wKwK9yCV4p0F+wtt7OtnKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cyPyHKNyaHWdyKJy6xOANHWa6c1Egt3M0Z0Swq8CseOkfAr/NcS6q1wlKNXDW9zX/
	 /sMA4iAe7tz64QkliZ01yBsoVahzpacZfYPgQQH6/uzcxcOHRB0y0xYXjh3wTs2Z94
	 kaxxxaJBEmvE690SFrbTs+Y7HLnhgCPSLWWsP+Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgB1OBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB1OBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:00 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631FD246B6;
        Fri, 28 Feb 2020 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898460;
        bh=pGRHdecX8oozXDewQOBi7wKwK9yCV4p0F+wtt7OtnKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVfAm7GsfEVvP3kpswXkhAq2MTbIBM9BORhq2rCM14Qz2xoSkc4WMlQEKrmtLT0So
         0bAG/sz5Yhd81e1Qh2bRuS5LL6Lh1h5jYiaq+uqByc0sn6HOACzkJMA9rxpwT8NZPk
         lQ26V6a42eHKf3FhvrK2fLG9hq7vkqqVPvWBPnEk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 08/15] perf annotate: Prefer cmdline option over default config
Date:   Fri, 28 Feb 2020 11:00:07 -0300
Message-Id: <20200228140014.1236-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

For all the perf-config options that can also be set from command line
option, the preference is given to command line version in case of any
conflict. But that's opposite in case of perf annotate. i.e. the more
preference is given to default option rather than command line option.
Fix it.

Before:

  $ ./perf config
  annotate.show_nr_samples=false

  $ ./perf annotate shash --show-nr-samples
  Percent│
         │24:   mov    -0xc(%rbp),%eax
   49.19 │      imul   $0x1003f,%eax,%ecx
         │      mov    -0x18(%rbp),%rax

After:

  Samples│
         │24:   mov    -0xc(%rbp),%eax
       1 │      imul   $0x1003f,%eax,%ecx
         │      mov    -0x18(%rbp),%rax

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-7-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ea89077bb8e0..6c0a0412502e 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -566,6 +566,8 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	annotation_config__init(&annotate.opts);
+
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
 	if (argc) {
 		/*
@@ -605,8 +607,6 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	annotation_config__init(&annotate.opts);
-
 	symbol_conf.try_vmlinux_path = true;
 
 	ret = symbol__init(&annotate.session->header.env);
-- 
2.21.1

