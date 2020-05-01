Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967FFC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654B12076D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588332900;
	bh=kUTMxm/rNI0UGAWNncs3IqDqP2WRm/WIBDikv3Djza0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KQiHtd4/EY6cegPqZi4I9VedS+Q8eMuxq2TQxWqM/a7rvrFiorgcyQbsnCEVvhNoW
	 9UmM9bePaXwltfuz5yDL1CkumpVNjN7jRfQ/9R5D6f4zl8ad7yk+xJ7pGLL0/t3yVs
	 WdY8/OmbWyPIjLh1+nprkHBLjelnnIH75sE3r+sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgEALe7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:34:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34203 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728611AbgEALe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:34:59 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-rDzu4dICN9y18Gyi0rcGPg-1; Fri, 01 May 2020 07:34:56 -0400
X-MC-Unique: rDzu4dICN9y18Gyi0rcGPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A03983DE6E;
        Fri,  1 May 2020 11:34:54 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49875101D480;
        Fri,  1 May 2020 11:34:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf session: Try to read pipe data from file
Date:   Fri,  1 May 2020 13:34:47 +0200
Message-Id: <20200501113448.1809037-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Ian came with the idea of having support to read the pipe
data also from file [1]. Currently pipe mode files fails
like:

  $ perf record -o - sleep 1 > /tmp/perf.pipe.data
  $ perf report -i /tmp/perf.pipe.data
  incompatible file format (rerun with -v to learn more)

This patch adds the support to do that by trying the pipe
header first, and if its successfully detected, switching
the perf data to pipe mode.

[1] https://lore.kernel.org/lkml/20200409185744.255881-1-irogers@google.com/
Original-patch-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0ce47283a8a1..8ca709f938b8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3574,7 +3574,7 @@ static int perf_header__read_pipe(struct perf_session *session)
 		return -EINVAL;
 	}
 
-	return 0;
+	return f_header.size == sizeof(f_header) ? 0 : -1;
 }
 
 static int read_attr(int fd, struct perf_header *ph,
@@ -3676,7 +3676,7 @@ int perf_session__read_header(struct perf_session *session)
 	struct perf_file_header	f_header;
 	struct perf_file_attr	f_attr;
 	u64			f_id;
-	int nr_attrs, nr_ids, i, j;
+	int nr_attrs, nr_ids, i, j, err;
 	int fd = perf_data__fd(data);
 
 	session->evlist = evlist__new();
@@ -3685,8 +3685,16 @@ int perf_session__read_header(struct perf_session *session)
 
 	session->evlist->env = &header->env;
 	session->machines.host.env = &header->env;
-	if (perf_data__is_pipe(data))
-		return perf_header__read_pipe(session);
+
+	/*
+	 * We can read 'pipe' data event from regular file,
+	 * check for the pipe header regardless of source.
+	 */
+	err = perf_header__read_pipe(session);
+	if (!err || (err && perf_data__is_pipe(data))) {
+		data->is_pipe = true;
+		return err;
+	}
 
 	if (perf_file_header__read(&f_header, header, fd) < 0)
 		return -EINVAL;
-- 
2.25.4

