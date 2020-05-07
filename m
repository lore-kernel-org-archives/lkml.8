Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13927C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D863F21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588845068;
	bh=wEet3Kks4IbCC87KvNzP3t3EghbuGVJkCqccqP5QfEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AaBdGbnj4eSjl8USrcSJNUUx+PA0YxjEMIfvDbU6h0ocsvad6tx6MbLgAYHFUX9X3
	 CLFIxbk2WwGDWVsXoPFdk3ODq+iuEIvw5OABMdciqJ6plb8rP8J/FsB+4iszOn/aRy
	 1JUxCaQ7hce/jhthWC3mfmQdKysmMnhdJ4b9lM30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEGJvI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:51:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53107 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgEGJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:51:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-vgamMrb2M_u2QLFBGd4O6w-1; Thu, 07 May 2020 05:51:02 -0400
X-MC-Unique: vgamMrb2M_u2QLFBGd4O6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C577107ACF6;
        Thu,  7 May 2020 09:51:00 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94E4310013BD;
        Thu,  7 May 2020 09:50:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>, Paul Khuong <pvk@pvk.ca>
Subject: [PATCH 3/5] perf session: Try to read pipe data from file
Date:   Thu,  7 May 2020 11:50:22 +0200
Message-Id: <20200507095024.2789147-4-jolsa@kernel.org>
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

Ian came with the idea of having support to read the pipe
data also from file. Currently pipe mode files fail like:

  $ perf record -o - sleep 1 > /tmp/perf.pipe.data
  $ perf report -i /tmp/perf.pipe.data
  incompatible file format (rerun with -v to learn more)

This patch adds the support to do that by trying the pipe
header first, and if its successfully detected, switching
the perf data to pipe mode.

Original-patch-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 13a1fe4ac0c0..7a67d017d72c 100644
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

