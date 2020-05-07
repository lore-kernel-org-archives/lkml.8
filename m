Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1092C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921F421473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588845044;
	bh=1eZZ11x1T4U6At2lMZIbbWRTloErxHtIDE+wWJcF3Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LidPUykEF6JOlwzoPbZUDUHstZ8pTFW6yncjbKzbWg/Xmc1/dN8qDoERNCfda44cS
	 9gcZYF64s0coCvE+vbV4OhvnN0JJGtfNL19qLSLDAA58tr2lWZ7Z3IZWJ1rQLxQ7lP
	 wyfOhUom32/khtQntokqgjepmY7xzp/SiRV+2iVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEGJuo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:50:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25072 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbgEGJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:50:42 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-_3RZuUPaMVeWDcTaM-wNzw-1; Thu, 07 May 2020 05:50:34 -0400
X-MC-Unique: _3RZuUPaMVeWDcTaM-wNzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C9DB80183C;
        Thu,  7 May 2020 09:50:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8079010013BD;
        Thu,  7 May 2020 09:50:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: [PATCH 2/5] perf tools: Do not seek in pipe fd during tracing data processing
Date:   Thu,  7 May 2020 11:50:21 +0200
Message-Id: <20200507095024.2789147-3-jolsa@kernel.org>
In-Reply-To: <20200507095024.2789147-1-jolsa@kernel.org>
References: <20200507095024.2789147-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to set 'fd' position in pipe mode, the file
descriptor is already in proper place. Moreover the lseek will
fail on pipe descriptor and that's why it's been working properly.

I was tempted to remove the lseek calls completely, because it seems
that tracing data event was always synthesized only in pipe mode, so
there's no need for 'file' mode handling. But I guess there was a reason
behind this and there might (however unlikely) be a perf.data that we
could break processing for.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c  | 18 ++++++++++++++----
 tools/perf/util/session.c |  9 +++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0ce47283a8a1..13a1fe4ac0c0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3947,12 +3947,22 @@ int perf_event__process_tracing_data(struct perf_session *session,
 {
 	ssize_t size_read, padding, size = event->tracing_data.size;
 	int fd = perf_data__fd(session->data);
-	off_t offset = lseek(fd, 0, SEEK_CUR);
 	char buf[BUFSIZ];
 
-	/* setup for reading amidst mmap */
-	lseek(fd, offset + sizeof(struct perf_record_header_tracing_data),
-	      SEEK_SET);
+	/*
+	 * The pipe fd is already in proper place and in any case
+	 * we can't move it, and we'd screw the case where we read
+	 * 'pipe' data from regular file. The trace_report reads
+	 * data from 'fd' so we need to set it directly behind the
+	 * event, where the tracing data starts.
+	 */
+	if (!perf_data__is_pipe(session->data)) {
+		off_t offset = lseek(fd, 0, SEEK_CUR);
+
+		/* setup for reading amidst mmap */
+		lseek(fd, offset + sizeof(struct perf_record_header_tracing_data),
+		      SEEK_SET);
+	}
 
 	size_read = trace_report(fd, &session->tevent,
 				 session->repipe);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c11d89e0ee55..b860f9f1b09e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1542,8 +1542,13 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 */
 		return 0;
 	case PERF_RECORD_HEADER_TRACING_DATA:
-		/* setup for reading amidst mmap */
-		lseek(fd, file_offset, SEEK_SET);
+		/*
+		 * Setup for reading amidst mmap, but only when we
+		 * are in 'file' mode. The 'pipe' fd is in proper
+		 * place already.
+		 */
+		if (!perf_data__is_pipe(session->data))
+			lseek(fd, file_offset, SEEK_SET);
 		return tool->tracing_data(session, event);
 	case PERF_RECORD_HEADER_BUILD_ID:
 		return tool->build_id(session, event);
-- 
2.25.4

