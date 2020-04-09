Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FF8C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5180C2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiYfLRBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDIS5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:57:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56594 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:57:50 -0400
Received: by mail-pf1-f202.google.com with SMTP id s8so9341923pfd.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dV55i5OKu53gCjPKMaS+sZiUvBZF3vLXGMZJy5h6XOc=;
        b=ZiYfLRBaKJhlf9CX1sSOjJ7CgSo0ClqkHyg8VYmtwE4byvPBDaP/lfX/FPo9rHWn4H
         6D8mz+kHbyKmgS4X9kuwgWN8LjOihcIEzej/lBr7aQBAyL1GXPfhw7UyAE/7voDE07So
         AtPFxbF8v10HGuCUcFZ38oXkvyUaDAU+JXNnMKvQ1/IvDlsqeQnJUWLaXlOPbnmlCTde
         3yYMLF5owG4wd1GPyjYUEt4O5KbbqRtkGu6mdSAqwa1NBX4mRaQwndjLwn+YSmiIpjEc
         S4LZfMsc00nakMKVnGdFeAIYpdtVSvahkVclTa0NnNk0yTh76kXdu4/ViQoh3UHlrlRb
         1l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dV55i5OKu53gCjPKMaS+sZiUvBZF3vLXGMZJy5h6XOc=;
        b=NpyiHSO/F0eHQ1hBabmSy+O0kW+PqYDCXv/iD0BCAyjnPvcS/LVlovfUszMNn8YNRz
         m5yfkCO/6ulbDPcn5ZHeicB8JjBWEPwb8kkBhLUPYOSKr1Rq/N7zId/ESZgfEjp8efcN
         dOXLHz36H8LlnNThMWMOZrdtHaU6WZSHs7dZPiDXY721nkIZcYzfoyH1FVhrBjhxQ+Ah
         6ewPtMcvN28pcUgCMWAUiWCJLl2de5H+xNFllUEJUU5d9EYfB5PbrL0Buviyv3guXz85
         ExdCtcko2BLYSLhNXb89O9/0V7RVhBEWLgnqXu100lOqUIG7rchRuCWsrIiwAknSTSmp
         +a5A==
X-Gm-Message-State: AGi0Pub8EH/nxirYV2u0jeLjT7JsL7Ooh39DzSFdpQ8dXLwAsnBa2dOD
        r5TDHjgn7XmdmSQLfuCD/KJh9QfiNKmx
X-Google-Smtp-Source: APiQypKY6/nEHpXGGlZxKpfFrwe1RhKQeuZaRgXMLoMRAsPbVhfI5AHYA213uY15Qcz8QxRxiZ3cU9XmYS6S
X-Received: by 2002:a63:ee0b:: with SMTP id e11mr939106pgi.80.1586458667642;
 Thu, 09 Apr 2020 11:57:47 -0700 (PDT)
Date:   Thu,  9 Apr 2020 11:57:44 -0700
Message-Id: <20200409185744.255881-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH] perf data: if a bad header size, retry in pipe mode
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pipe mode files fail like:
$ perf record -o - sleep 1 > /tmp/perf.pipe.data
$ perf report -i /tmp/perf.pipe.data
incompatible file format (rerun with -v to learn more)

This change makes it so that if a perf.data file's header size is wrong
it is re-checked in pipe mode, where if wrong it fails as it currently
does.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 35 ++++++++++++++++++++++++++---------
 tools/perf/util/header.h |  5 -----
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index acbd046bf95c..1df00a4a71b6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3329,8 +3329,15 @@ static int check_magic_endian(u64 magic, uint64_t hdr_sz,
 	return 0;
 }
 
-int perf_file_header__read(struct perf_file_header *header,
-			   struct perf_header *ph, int fd)
+enum header_read_status {
+	HEADER_READ_OK,
+	HEADER_READ_BAD_SIZE,
+	HEADER_READ_BAD,
+};
+
+static enum header_read_status
+perf_file_header__read(struct perf_file_header *header,
+		       struct perf_header *ph, int fd)
 {
 	ssize_t ret;
 
@@ -3338,12 +3345,12 @@ int perf_file_header__read(struct perf_file_header *header,
 
 	ret = readn(fd, header, sizeof(*header));
 	if (ret <= 0)
-		return -1;
+		return HEADER_READ_BAD;
 
 	if (check_magic_endian(header->magic,
 			       header->attr_size, false, ph) < 0) {
 		pr_debug("magic/endian check failed\n");
-		return -1;
+		return HEADER_READ_BAD;
 	}
 
 	if (ph->needs_swap) {
@@ -3356,7 +3363,7 @@ int perf_file_header__read(struct perf_file_header *header,
 		if (header->size == offsetof(typeof(*header), adds_features))
 			bitmap_zero(header->adds_features, HEADER_FEAT_BITS);
 		else
-			return -1;
+			return HEADER_READ_BAD_SIZE;
 	} else if (ph->needs_swap) {
 		/*
 		 * feature bitmap is declared as an array of unsigned longs --
@@ -3398,7 +3405,7 @@ int perf_file_header__read(struct perf_file_header *header,
 	ph->data_offset  = header->data.offset;
 	ph->data_size	 = header->data.size;
 	ph->feat_offset  = header->data.offset + header->data.size;
-	return 0;
+	return HEADER_READ_OK;
 }
 
 static int perf_file_section__process(struct perf_file_section *section,
@@ -3580,12 +3587,22 @@ int perf_session__read_header(struct perf_session *session)
 
 	session->evlist->env = &header->env;
 	session->machines.host.env = &header->env;
+
+	if (!perf_data__is_pipe(data)) {
+		enum header_read_status status =
+			perf_file_header__read(&f_header, header, fd);
+		if (status == HEADER_READ_BAD)
+			return -EINVAL;
+		if (status == HEADER_READ_BAD_SIZE) {
+			pr_debug("Data had a bad header size, retrying in pipe mode\n");
+			lseek(fd, 0, SEEK_SET);
+			data->is_pipe = true;
+		}
+	}
+
 	if (perf_data__is_pipe(data))
 		return perf_header__read_pipe(session);
 
-	if (perf_file_header__read(&f_header, header, fd) < 0)
-		return -EINVAL;
-
 	/*
 	 * Sanity check that perf.data was written cleanly; data size is
 	 * initialized to 0 and updated only if the on_exit function is run.
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 840f95cee349..3d7f39358265 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -73,11 +73,6 @@ struct perf_pipe_file_header {
 	u64				size;
 };
 
-struct perf_header;
-
-int perf_file_header__read(struct perf_file_header *header,
-			   struct perf_header *ph, int fd);
-
 struct perf_header {
 	enum perf_header_version	version;
 	bool				needs_swap;
-- 
2.26.0.292.g33ef6b2f38-goog

