Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB83C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8522C2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="klXxKvjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgHDI6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:58:20 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:46886 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgHDI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kWk7YYX9ivhMeMTk14oHtz92dzVrGFitqhbxv9qx8lI=; b=klXxKvjR7JMntS6GV03asjacwN
        xWhjXGbUJUvlsWCgSHs7GiC0Pv1FywhjOXIlv/9JRi/LjopdSS5e3iSD6vtbyk1a0U6Itx4J/SpJi
        t1aqTgmbcg6xQRQ1D2yJH7Ed9kVzPl2fb6eOXjicVFhcmSVCw0ijzCIoTkazXa2PNgck=;
Received: from lmontsouris-657-1-153-95.w82-127.abo.wanadoo.fr ([82.127.191.95] helo=xps9380.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1k2sm0-00028I-9f; Tue, 04 Aug 2020 03:58:18 -0500
From:   Remi Bernon <rbernon@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Remi Bernon <rbernon@codeweavers.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: [PATCH v2 1/3] perf dso: Use libbfd to read build_id and .gnu_debuglink section
Date:   Tue,  4 Aug 2020 10:57:34 +0200
Message-Id: <20200804085736.385232-1-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wine generates PE binaries for most of its modules and perf is unable
to parse these to get build_id or .gnu_debuglink section.

Using libbfd when available, instead of libelf, makes it possible to
resolve debug file location regardless of the dso binary format.

Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jacek Caban <jacek@codeweavers.com>
---

v2: Commit message reword.

 tools/perf/util/symbol-elf.c | 80 ++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5e43054bffea..2489ca5a2284 100644
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
 
@@ -530,6 +532,36 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 	return err;
 }
 
+#ifdef HAVE_LIBBFD_SUPPORT
+
+int filename__read_build_id(const char *filename, void *bf, size_t size)
+{
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
+	err = abfd->build_id->size;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+
+#else
+
 int filename__read_build_id(const char *filename, void *bf, size_t size)
 {
 	int fd, err = -1;
@@ -557,6 +589,8 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
 	return err;
 }
 
+#endif
+
 int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
 {
 	int fd, err = -1;
@@ -608,6 +642,44 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
 	return err;
 }
 
+#ifdef HAVE_LIBBFD_SUPPORT
+
+int filename__read_debuglink(const char *filename, char *debuglink,
+			     size_t size)
+{
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
+}
+
+#else
+
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size)
 {
@@ -660,6 +732,8 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
+#endif
+
 static int dso__swap_init(struct dso *dso, unsigned char eidata)
 {
 	static unsigned int const endian = 1;
-- 
2.27.0

