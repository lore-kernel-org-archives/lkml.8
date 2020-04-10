Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB3EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E809E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDJTir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:38:47 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28734 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgDJTiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:38:46 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:38:42 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 1A263B2C9B;
        Fri, 10 Apr 2020 15:38:46 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 26/36] objtool: mcount: Only keep ELF file size
Date:   Fri, 10 Apr 2020 12:35:49 -0700
Message-ID: <3bc0af0d3ba3ab8f9582e4aaf54c85be9ebfbea5.1586468801.git.mhelsley@vmware.com>
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

Since we're no longer writing to the ELF file mapping and we're
not appending to it we don't need to keep more information from the
stat structure. At the same time we can give the smaller global
variable a better name.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 95b93767d6eb..6de744aaf4c8 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -48,17 +48,17 @@
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
-static struct stat sb;	/* Remember .st_size, etc. */
 static const char *altmcount;	/* alternate mcount symbol name */
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 static void *file_map;	/* pointer of the mapped file */
+static size_t file_map_size; /* original ELF file size */
 
 static struct elf *lf;
 
 static void mmap_cleanup(void)
 {
 	if (!mmap_failed)
-		munmap(file_map, sb.st_size);
+		munmap(file_map, file_map_size);
 	else
 		free(file_map);
 	file_map = NULL;
@@ -93,11 +93,13 @@ static void * umalloc(size_t size)
  */
 static void *mmap_file(char const *fname)
 {
+	struct stat sb;
+
 	/* Avoid problems if early cleanup() */
 	fd_map = -1;
 	mmap_failed = 1;
 	file_map = NULL;
-	sb.st_size = 0;
+	file_map_size = 0;
 
 	lf = elf_read(fname, O_RDWR);
 	if (!lf) {
@@ -129,6 +131,7 @@ static void *mmap_file(char const *fname)
 		}
 	} else
 		mmap_failed = 0;
+	file_map_size = sb.st_size;
 out:
 	fd_map = -1;
 
-- 
2.20.1

