Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56129C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2372220809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596145262;
	bh=KDERprKxcWQdG+Nig2gY1rxvP71EcfMxr+2KYIquQoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CtikafF4jE2mQzYT9lld1vieJ1gq1HzkgGrOm4D4hNYhv7T9vZSQQ44WhK/o/Q1x/
	 9TrxuZ3trAHnY6e6iDTfjSVpSxJBqQcJwCszh9pOKy93aJZFid7Yh8fkmyHARrurUd
	 Tz3JEUT5x0Acsp2iKYllJTqT1yVsm7HNvdH/A334=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgG3VlA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:41:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730734AbgG3Vkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:40:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-OOTwgVC_NCy-2dxwqIZQbQ-1; Thu, 30 Jul 2020 17:40:17 -0400
X-MC-Unique: OOTwgVC_NCy-2dxwqIZQbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F13C1DFB;
        Thu, 30 Jul 2020 21:40:16 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F63F87B20;
        Thu, 30 Jul 2020 21:40:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH 1/6] perf tools: Add clockid_name function
Date:   Thu, 30 Jul 2020 23:39:45 +0200
Message-Id: <20200730213950.1503773-2-jolsa@kernel.org>
In-Reply-To: <20200730213950.1503773-1-jolsa@kernel.org>
References: <20200730213950.1503773-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding clockid_name function to get the clock name based
on its clockid. It will be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 11 +++++++++++
 tools/perf/util/util.h      |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b6bdccd875bc..468c669519a6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2121,6 +2121,17 @@ static const struct clockid_map clockids[] = {
 	CLOCKID_END,
 };
 
+const char *clockid_name(clockid_t clk_id)
+{
+	const struct clockid_map *cm;
+
+	for (cm = clockids; cm->name; cm++) {
+		if (cm->clockid == clk_id)
+			return cm->name;
+	}
+	return "(not found)";
+}
+
 static int get_clockid_res(clockid_t clk_id, u64 *res_ns)
 {
 	struct timespec res;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f486fdd3a538..126dad238ee3 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -62,4 +62,6 @@ char *perf_exe(char *buf, int len);
 #endif
 #endif
 
+const char *clockid_name(clockid_t clk_id);
+
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.25.4

