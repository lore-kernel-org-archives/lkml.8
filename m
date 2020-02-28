Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9FDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEFF246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898452;
	bh=qvaRwdaabddfBc0cStVfEigIf2vX1wDwlm/3OKCL4Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dwWTHQXt+Mkm4PRxcJ0LeIpRaXlEt5lbz+xtL+LvfZfLziNxrtEK5EpbHnS97HYX3
	 FsppI2pNuGDOxN5QQYolAK6PK0NqHuCFbHCrNBwNI/btfzSJYLAW3nogDyYFkLS5oQ
	 bG8gjfl0L2Li7gnMVn3sAq9FkELuGdNMpUs6CS+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgB1OAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB1OAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:00:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0619246AF;
        Fri, 28 Feb 2020 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898449;
        bh=qvaRwdaabddfBc0cStVfEigIf2vX1wDwlm/3OKCL4Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=192fPyWwL2gY2BKPW6XUQkAFaQpY4HHjRpH44I/T7tMJZRXM8ioyIIBVPEd39vtQV
         vGNIj1IdzsR8046bubLRRNEGstHf3TbpjZ8oSsPrk2oMLz/rSymKN58gPImgUwoD9N
         k6XzdlV7wY9Gv7SUlveLqT1MwG7twa+JhGOhqfmk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/15] perf config: Introduce perf_config_u8()
Date:   Fri, 28 Feb 2020 11:00:05 -0300
Message-Id: <20200228140014.1236-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Introduce perf_config_u8() utility function to convert char * input into
u8 destination. We will utilize it in followup patch.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
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
Link: http://lore.kernel.org/lkml/20200213064306.160480-5-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 12 ++++++++++++
 tools/perf/util/config.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0bc9c4d7fdc5..ef38eba56ed0 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -374,6 +374,18 @@ int perf_config_int(int *dest, const char *name, const char *value)
 	return 0;
 }
 
+int perf_config_u8(u8 *dest, const char *name, const char *value)
+{
+	long ret = 0;
+
+	if (!perf_parse_long(value, &ret)) {
+		bad_config(name);
+		return -1;
+	}
+	*dest = ret;
+	return 0;
+}
+
 static int perf_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int ret;
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index bd0a5897c76a..c10b66dde2f3 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -29,6 +29,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
 int perf_config_int(int *dest, const char *, const char *);
+int perf_config_u8(u8 *dest, const char *name, const char *value);
 int perf_config_u64(u64 *dest, const char *, const char *);
 int perf_config_bool(const char *, const char *);
 int config_error_nonbool(const char *);
-- 
2.21.1

