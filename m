Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED63C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1DA206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiPlFM++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgEDW5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:57:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38514 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728118AbgEDW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588633037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkjR4idjNOUSc/GgoWxAHk5uuwUM084U0aZLz6e4Oxw=;
        b=EiPlFM++ErtpEt07JYommneai5Zb5WrZ8soKOn1EEx86Qb6zaH4YIkAWJP/1/da8lMg7HN
        P9Rg4PORnIij+tq1UTgL4DkfkX0vfGW4lR4aGN5DoAVnE5TF7gqT5FyH+MesS3BCXQu1xn
        h8AXXmkK+xuz4pY3dKEpLDEhEmaAdsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-azVAEaE4NxidvXOzULQWKw-1; Mon, 04 May 2020 18:57:13 -0400
X-MC-Unique: azVAEaE4NxidvXOzULQWKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189558014C0;
        Mon,  4 May 2020 22:57:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B423E2C2D3;
        Mon,  4 May 2020 22:57:09 +0000 (UTC)
Date:   Tue, 5 May 2020 00:57:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf session: Try to read pipe data from file
Message-ID: <20200504225325.GE1916255@krava>
References: <20200501113448.1809037-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501113448.1809037-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:34:47PM +0200, Jiri Olsa wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> 
> Ian came with the idea of having support to read the pipe
> data also from file [1]. Currently pipe mode files fails
> like:
> 
>   $ perf record -o - sleep 1 > /tmp/perf.pipe.data
>   $ perf report -i /tmp/perf.pipe.data
>   incompatible file format (rerun with -v to learn more)
> 
> This patch adds the support to do that by trying the pipe
> header first, and if its successfully detected, switching
> the perf data to pipe mode.
> 
> [1] https://lore.kernel.org/lkml/20200409185744.255881-1-irogers@google.com/
> Original-patch-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

actualy.. I found another issue while trying this on tracepoints:

  # ./perf record -g  -e 'raw_syscalls:sys_enter' -o -  true > data
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  # ./perf script -i ./data
  perf_event__process_tracing_data: tracing data size mismatch0x1034 [0xc]: failed to process type: 66

it's because some of the pipe synthesize code calls lseek, which
fails on pipe, but succeeds on normal file (with pipe data)

patch below fixes that for me, but I wonder there are other leftovers
like this.. I'll check on post it all together

jirka


---
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8ca709f938b8..33e299674121 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3955,13 +3955,8 @@ int perf_event__process_tracing_data(struct perf_session *session,
 {
 	ssize_t size_read, padding, size = event->tracing_data.size;
 	int fd = perf_data__fd(session->data);
-	off_t offset = lseek(fd, 0, SEEK_CUR);
 	char buf[BUFSIZ];
 
-	/* setup for reading amidst mmap */
-	lseek(fd, offset + sizeof(struct perf_record_header_tracing_data),
-	      SEEK_SET);
-
 	size_read = trace_report(fd, &session->tevent,
 				 session->repipe);
 	padding = PERF_ALIGN(size_read, sizeof(u64)) - size_read;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c11d89e0ee55..b75df19feaf1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1543,7 +1543,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return 0;
 	case PERF_RECORD_HEADER_TRACING_DATA:
 		/* setup for reading amidst mmap */
-		lseek(fd, file_offset, SEEK_SET);
+		if (!perf_data__is_pipe(session->data))
+			lseek(fd, file_offset, SEEK_SET);
 		return tool->tracing_data(session, event);
 	case PERF_RECORD_HEADER_BUILD_ID:
 		return tool->build_id(session, event);

