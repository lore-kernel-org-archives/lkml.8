Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C3822B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598539795;
	bh=/NAdj6agcPqW//TYsymG19Ca6BlL6Tmzrmg3HikzrwA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=y6MNOpMy+jz4etk5mCKYNbW0lwhuDPz8ETtHVTPg5OcN3aw83dIYDvIK8pkG6CT2H
	 TWJxuNGmtv0tTAIPudkOHXntd2FeJmu6m5VSLKWIyBIXu9Ay8rYGtYmwa8jtNY5YIa
	 syosdNKRyJZcjHRNUDsPtXDRHRuwVD9UN/sI2fRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgH0Otw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727866AbgH0N5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:57:18 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-sP3gFXKOMm6mZiOyc_iYeA-1; Thu, 27 Aug 2020 09:48:35 -0400
X-MC-Unique: sP3gFXKOMm6mZiOyc_iYeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD9F08018A1;
        Thu, 27 Aug 2020 13:48:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32FC37C55A;
        Thu, 27 Aug 2020 13:48:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf tools: Disable ordered_events for report raw dump
Date:   Thu, 27 Aug 2020 15:48:29 +0200
Message-Id: <20200827134830.126721-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable ordered_events for report raw dump, because
for raw dump we want to see events as they are stored
in the perf.data file, not sorted by time.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ece1cddfcd7c..3c74c9c0f3c3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1332,6 +1332,9 @@ int cmd_report(int argc, const char **argv)
 	if (report.mmaps_mode)
 		report.tasks_mode = true;
 
+	if (dump_trace)
+		report.tool.ordered_events = false;
+
 	if (quiet)
 		perf_quiet_option();
 
-- 
2.26.2

