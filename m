Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF21DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AD920890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgFRUnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:43:24 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730883AbgFRUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:07 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:38:58 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id BBCD4B2656;
        Thu, 18 Jun 2020 16:39:01 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 04/51] objtool: recordmcount: Start using objtool's elf wrapper
Date:   Thu, 18 Jun 2020 13:37:50 -0700
Message-ID: <a6de39fe2f7f6c641e28305bb5522d90c9e82795.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct elf to grab the file descriptor. We will later
move these calls into other functions as we expand the
lifetime of the struct elf so that it can be passed to
objtool elf.[ch] functions.

This creates the libelf/objtool data structures and gives
us two separate ways to walk the ELF file -- the libelf/objtool
way and the old recordmcount wrapper way which avoids these
extra data structures by using indices, offsets, and pointers
into the mmapped ELF file.

Subsequent patches will convert from the old recordmcount
accessors to the libelf/objtool accessors.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 601e83840085..b2c606eb269b 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -33,6 +33,8 @@
 
 #include "objtool.h"
 
+#include "elf.h"
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183
 #define R_AARCH64_NONE		0
@@ -57,6 +59,8 @@ static void *file_ptr;	/* current file pointer location */
 static void *file_append; /* added to the end of the file */
 static size_t file_append_size; /* how much is added to end of file */
 
+static struct elf *lf;
+
 /* Per-file resource cleanup when multiple files. */
 static void file_append_cleanup(void)
 {
@@ -73,6 +77,9 @@ static void mmap_cleanup(void)
 	else
 		free(file_map);
 	file_map = NULL;
+	if (lf)
+		elf_close(lf);
+	lf = NULL;
 }
 
 /* ulseek, uwrite, ...:  Check return value for errors. */
@@ -170,11 +177,12 @@ static void *mmap_file(char const *fname)
 	file_updated = 0;
 	sb.st_size = 0;
 
-	fd_map = open(fname, O_RDONLY);
-	if (fd_map < 0) {
+	lf = elf_open_read(fname, O_RDONLY);
+	if (!lf) {
 		perror(fname);
 		return NULL;
 	}
+	fd_map = lf->fd;
 	if (fstat(fd_map, &sb) < 0) {
 		perror(fname);
 		goto out;
@@ -194,14 +202,14 @@ static void *mmap_file(char const *fname)
 		}
 		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
 			perror(fname);
-			free(file_map);
-			file_map = NULL;
+			mmap_cleanup();
 			goto out;
 		}
 	} else
 		mmap_failed = 0;
 out:
-	close(fd_map);
+	elf_close(lf);
+	lf = NULL;
 	fd_map = -1;
 
 	file_end = file_map + sb.st_size;
-- 
2.20.1

