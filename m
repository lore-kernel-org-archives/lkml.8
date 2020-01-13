Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD3C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BB920661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578912255;
	bh=B7v+lFotiptKRkbpzVcSFxVJrrKPxDE5VOwLgOGBcb0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dccjZ/P9BpodlcjJbFeAX9POEVE/DyWOwT5OZHcYmdFpJ8M7i66rwLXlxjWkJxsz4
	 YtZ7XzhsjvSZ9d06NnDZHGb4xKOUhTtmHoIaZdPg4MS40zlnMop0w+otwquyA0Djwg
	 QaHRhT2dce6fgePmPl8BQaWi5iToW7Kj1VQtC9xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAMKoO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:44:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgAMKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:44:09 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-mfJjSqxGOLqaWlj1nET5Kg-1; Mon, 13 Jan 2020 05:44:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393FB801A24;
        Mon, 13 Jan 2020 10:44:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F9BF5C21B;
        Mon, 13 Jan 2020 10:43:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH 1/2] perf/ui/gtk: Add missing zalloc object
Date:   Mon, 13 Jan 2020 11:43:57 +0100
Message-Id: <20200113104358.123511-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mfJjSqxGOLqaWlj1nET5Kg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we moved zalloc.o to the library we missed gtk library
which needs it compiled in, otherwise the missing __zfree
symbol will cause the library to fail to load.

Adding the zalloc object to the gtk library build.

Fixes: 7f7c536f23e6 ("tools lib: Adopt zalloc()/zfree() from tools/perf")
Link: https://lkml.kernel.org/n/tip-nuu3lyzzmi2t9zdvlg0i0bh0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/ui/gtk/Build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index ec22e899a224..9b5d5cbb7af7 100644
--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -7,3 +7,8 @@ gtk-y += util.o
 gtk-y += helpline.o
 gtk-y += progress.o
 gtk-y += annotate.o
+gtk-y += zalloc.o
+
+$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.24.1

