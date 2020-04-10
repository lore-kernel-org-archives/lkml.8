Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66599C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB7320732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDJTg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:56 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:55144 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgDJTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:56 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:51 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 76B76B2C6E;
        Fri, 10 Apr 2020 15:36:55 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 08/36] objtool: recordmcount: Start using objtool's elf wrapper
Date:   Fri, 10 Apr 2020 12:35:31 -0700
Message-ID: <8c03636a45b927add190a5c229a1bd2fc84971e4.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct elf to grab the file descriptor. We will later
move these calls into other functions as we expand the
lifetime of the struct elf so that it can be passed to
objtool elf.[ch] functions.

This creates the libelf/objcount data structures and gives
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
index f9844166fdaf..69da5339575f 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -33,6 +33,8 @@
 
 #include "mcount.h"
 
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
+	lf = elf_read(fname, O_RDONLY);
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

