Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59953C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389CC2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596620203;
	bh=4dyE5Gx6clBYi2vjUW8rhJ/Rxs/aoGQ5d4mu+Q1fSFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1Ls8X0RdyevdrH4pxlDWkp67AgsE8LVA1RWM4UpENBJKPnnqnaGTzsdsuoVBnvEd
	 dYeWH5iVBS29vSXE+530YIxLzr/b2q2Xwm+nIHvNozMhOsttLc1wbCwOeA6uwzZ6Ur
	 Yuswkc0+xGVDvy+tHj7lyzpT/jKveHjOimnjE8DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgHEJgl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:36:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728378AbgHEJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:35:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-db6gC643OpCV6XPvJ_8RpQ-1; Wed, 05 Aug 2020 05:35:01 -0400
X-MC-Unique: db6gC643OpCV6XPvJ_8RpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5736918C63C1;
        Wed,  5 Aug 2020 09:34:58 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D64517193A;
        Wed,  5 Aug 2020 09:34:54 +0000 (UTC)
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
Subject: [PATCH v2 2/7] perf tools: Add clockid_name function
Date:   Wed,  5 Aug 2020 11:34:39 +0200
Message-Id: <20200805093444.314999-3-jolsa@kernel.org>
In-Reply-To: <20200805093444.314999-1-jolsa@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 tools/perf/util/clockid.c | 11 +++++++++++
 tools/perf/util/clockid.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/util/clockid.c b/tools/perf/util/clockid.c
index b7a08606dc3e..74365a5d99c1 100644
--- a/tools/perf/util/clockid.c
+++ b/tools/perf/util/clockid.c
@@ -106,3 +106,14 @@ int parse_clockid(const struct option *opt, const char *str, int unset)
 	ui__warning("unknown clockid %s, check man page\n", ostr);
 	return -1;
 }
+
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
diff --git a/tools/perf/util/clockid.h b/tools/perf/util/clockid.h
index 8e567b3ebbbd..9b49b4711c76 100644
--- a/tools/perf/util/clockid.h
+++ b/tools/perf/util/clockid.h
@@ -6,4 +6,6 @@
 struct option;
 int parse_clockid(const struct option *opt, const char *str, int unset);
 
+const char *clockid_name(clockid_t clk_id);
+
 #endif
-- 
2.25.4

