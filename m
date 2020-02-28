Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A086AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A2246B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898492;
	bh=CB7W/6xkcP7nwAHpR0kQ5LajNWEjHNAQQW40iG7oxpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOxZYSS/8hrQjXn/LFOczsWu+laO5BQ2YkBAZmpEoys8OO71nEZIeE6bPqWiz4gzR
	 crjCRYqkPgQJIw/1LzAEvgNS2ebB8Ey+O7oGtK13tvq5VYxOtpxN94rsA8UtvQKwEN
	 p0i2HsPQBNuwex2Hll2eSWj0zW7cMbljmUfkvI0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgB1OBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbgB1OB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:26 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA63246BE;
        Fri, 28 Feb 2020 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898485;
        bh=CB7W/6xkcP7nwAHpR0kQ5LajNWEjHNAQQW40iG7oxpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3nGEHelRjiXcXA+LwFAMG2wEunmR1O+f4sjp4hIWqKJM+rHOx66dNNWeJGmrRO9j
         7yVB/vpJu3cSSQmqGsvCorDls8/zCk4pCF8zlvUAfPR8P3YqWs71hpE0G1IXn4pI38
         tiI/kNWS9z3V2vbDkwL9XQ2RFsK+SPJEb0xYg2/U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/15] perf annotate: Align struct annotate_args
Date:   Fri, 28 Feb 2020 11:00:13 -0300
Message-Id: <20200228140014.1236-15-acme@kernel.org>
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

Align fields of struct annotate_args.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f11031a40290..c816e5840166 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1143,13 +1143,13 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 }
 
 struct annotate_args {
-	struct arch		*arch;
-	struct map_symbol	 ms;
-	struct evsel	*evsel;
+	struct arch		  *arch;
+	struct map_symbol	  ms;
+	struct evsel		  *evsel;
 	struct annotation_options *options;
-	s64			 offset;
-	char			*line;
-	int			 line_nr;
+	s64			  offset;
+	char			  *line;
+	int			  line_nr;
 };
 
 static void annotation_line__init(struct annotation_line *al,
-- 
2.21.1

