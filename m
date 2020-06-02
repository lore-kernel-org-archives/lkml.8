Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9992072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgFBTv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:58 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728386AbgFBTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:05 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:02 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 037FF40BED;
        Tue,  2 Jun 2020 12:51:02 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 21/32] objtool: mcount: Only keep ELF file size
Date:   Tue, 2 Jun 2020 12:50:14 -0700
Message-ID: <735f431969b4ffb21251ce7f491a262dff9293bc.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
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
index 6feb4e6b4113..85e95e1ea6f6 100644
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
 
 	lf = elf_open_read(fname, O_RDWR);
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

