Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2749C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B17B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581345157;
	bh=PZHwuhKFVCaJzJJaXaEjOXGm3PrK011pj0niPgqzNm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GNIz1OKbJfpeLGszc6jthnBuerwhbeFflJrwHzA7msVLCA8h/h8CPZL4orItVObl3
	 222LgMScNHLE8NWkc1bDNIwPi4Fkt1Vd5ylHiZnfpxEN9T7JG5obTPrWTHlQyaL3Kq
	 xCtSYC+uOxp3ccRjpzK4z348P2ofERpt/KWdPTzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgBJOcg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728193AbgBJOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:32:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-w69qbkjJP4qn1RIJf3pVWg-1; Mon, 10 Feb 2020 09:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E257F8010CB;
        Mon, 10 Feb 2020 14:32:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E99560BF1;
        Mon, 10 Feb 2020 14:32:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 3/4] perf tools: Fix map__clone for struct kmap
Date:   Mon, 10 Feb 2020 15:32:17 +0100
Message-Id: <20200210143218.24948-4-jolsa@kernel.org>
In-Reply-To: <20200210143218.24948-1-jolsa@kernel.org>
References: <20200210143218.24948-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: w69qbkjJP4qn1RIJf3pVWg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The map__clone function can be called on kernel maps
as well, so it needs to duplicate the whole kmap data.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f67960bedebb..cea05fc9595c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -375,8 +375,13 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 
 struct map *map__clone(struct map *from)
 {
-	struct map *map = memdup(from, sizeof(*map));
+	size_t size = sizeof(struct map);
+	struct map *map;
+
+	if (from->dso && from->dso->kernel)
+		size += sizeof(struct kmap);
 
+	map = memdup(from, size);
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
-- 
2.24.1

