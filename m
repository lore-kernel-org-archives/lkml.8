Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6179E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578669350;
	bh=Ra8yEb/Pzk4Eyn55vPzXo269tkBlf7aFTPtdSaLVEa8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Lb9JrqJsd+0pCtHg9aGb/vR3COwppyI3kG7uHcrrz7yAyHF1p9O7t5MK6ryrEVdFl
	 UPf70G7OegsJcmk9EDnupp0qWvVB5ENqn8GpH0KrOkbKZhcqu+/rtNzZp163x1DB0J
	 vwPK1uPur4EgJJKfWKVs2CPQttzrtbvfaEW+Ca20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgAJPPt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:15:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbgAJPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:15:49 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-khQgLo3xPieZKhEqLPLOZQ-1; Fri, 10 Jan 2020 10:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3075D911E8;
        Fri, 10 Jan 2020 15:15:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-205-164.brq.redhat.com [10.40.205.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D31A60CC0;
        Fri, 10 Jan 2020 15:15:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jann Horn <jannh@google.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Setup initial evlist::all_cpus value
Date:   Fri, 10 Jan 2020 16:15:37 +0100
Message-Id: <20200110151537.153012-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: khQgLo3xPieZKhEqLPLOZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn reported crash in perf ftrace because evlist::all_cpus
isn't initialized if there's evlist without events, which is the
case for perf ftrace.

Adding initial initialization of evlist::all_cpus from given cpus,
regardless of events in the evlist.

Reported-by: Jann Horn <jannh@google.com>
Link: https://lkml.kernel.org/n/tip-kzioebqr5c3u4t7tafju8pbx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index ae9e65aa2491..5b9f2ca50591 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -164,6 +164,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
+	if (!evlist->all_cpus && cpus)
+		evlist->all_cpus = perf_cpu_map__get(cpus);
+
 	perf_evlist__propagate_maps(evlist);
 }
 
-- 
2.24.1

