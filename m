Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DC6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B65D20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="CvDtAG/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFALlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:41:07 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:51020 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFALlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VBQx/N8cvpysJ/T0NgTYzw977Pso25Y/X+vWd2p7yfA=; b=CvDtAG/AukDupLGz7r/lWPGyRY
        qwnHTQx5wsNMjy0DFY0LA739x8MHtOzM584hR1xG5ar+AmyPHBZo1ZxtsJolbt4npeuHJ01/ndXGH
        dMIbNfN8Euq9gPUOZ7BGAwpGT3h18VazHn5NTEMYWxifLDbprcjFT9oo0ZLDJxeJDgBQ=;
Received: from lfbn-mar-1-909-138.w90-73.abo.wanadoo.fr ([90.73.224.138] helo=xps9380.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <rbernon@codeweavers.com>)
        id 1jfiWu-0004nS-Df; Mon, 01 Jun 2020 06:22:58 -0500
From:   =?UTF-8?q?R=C3=A9mi=20Bernon?= <rbernon@codeweavers.com>
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?q?R=C3=A9mi=20Bernon?= <rbernon@codeweavers.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: [RFC PATCH 1/2] perf dso: Use libbfd to read build_id and .gnu_debuglink section
Date:   Mon,  1 Jun 2020 13:19:14 +0200
Message-Id: <20200601111915.114974-2-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200601111915.114974-1-rbernon@codeweavers.com>
References: <20200601111915.114974-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wine generates PE binaries for most of its modules and perf is unable
to parse these files to get build_id or .gnu_debuglink section.

Using libbfd when available, instead of libelf, makes it possible to
resolve debug file location regardless of the dso binary format.

Signed-off-by: Rémi Bernon <rbernon@codeweavers.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jacek Caban <jacek@codeweavers.com>
---
 tools/perf/util/symbol-elf.c | 65 ++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index be5b493f8284..85bbc1ec9fe5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -50,6 +50,10 @@ typedef Elf64_Nhdr GElf_Nhdr;
 #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
 #endif
 
+#ifdef HAVE_LIBBFD_SUPPORT
+#define PACKAGE 'perf'
+#include <bfd.h>
+#else
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
 extern char *cplus_demangle(const char *, int);
 
@@ -65,9 +69,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
 {
 	return NULL;
 }
-#else
-#define PACKAGE 'perf'
-#include <bfd.h>
+#endif
 #endif
 #endif
 
@@ -532,6 +534,30 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 
 int filename__read_build_id(const char *filename, void *bf, size_t size)
 {
+#ifdef HAVE_LIBBFD_SUPPORT
+	int err = -1;
+	bfd *abfd;
+
+	abfd = bfd_openr(filename, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	if (!abfd->build_id || abfd->build_id->size > size)
+		goto out_close;
+
+	memcpy(bf, abfd->build_id->data, abfd->build_id->size);
+	memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
+	err = 0;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+#else
 	int fd, err = -1;
 	Elf *elf;
 
@@ -555,6 +581,7 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
 	close(fd);
 out:
 	return err;
+#endif
 }
 
 int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
@@ -611,6 +638,37 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size)
 {
+#ifdef HAVE_LIBBFD_SUPPORT
+	int err = -1;
+	asection *section;
+	bfd *abfd;
+
+	abfd = bfd_openr(filename, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	section = bfd_get_section_by_name(abfd, ".gnu_debuglink");
+	if (!section)
+		goto out_close;
+
+	if (section->size > size)
+		goto out_close;
+
+	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
+				      section->size))
+		goto out_close;
+
+	err = 0;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+#else
 	int fd, err = -1;
 	Elf *elf;
 	GElf_Ehdr ehdr;
@@ -658,6 +716,7 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	close(fd);
 out:
 	return err;
+#endif
 }
 
 static int dso__swap_init(struct dso *dso, unsigned char eidata)
-- 
2.26.1

