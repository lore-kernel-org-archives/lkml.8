Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47865C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EA9208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgFRUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:44 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4267 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731295AbgFRUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:21 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:15 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 33CFAB2656;
        Thu, 18 Jun 2020 16:39:19 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 26/51] objtool: mcount: Remove unused file mapping
Date:   Thu, 18 Jun 2020 13:38:12 -0700
Message-ID: <79d29ed011f2afda285691a47b157363ab547204.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELF data is now accessed completely through objtool's
ELF code. We can remove the mapping of the original ELF
file and propagate elf_open_read(), elf_close(), and malloc()
up in place of mmap_file(), mmap_cleanup(), and umalloc()
respectively. This also eliminates the last use of the
umalloc() wrapper, reduces the number of global
variables, and limits the use of globals to:

	The struct elf for the file we're working on. This
	saves passing it to nearly every function as a parameter.

	Variables set depending on the ELF file endian, wordsize,
	and arch so that the appropriate relocation structures,
	offset sizes, architecture quirks, and nop encodings will
	be used.

	One command-line option

Note that we're still using the recordmcount wrapper to change
variable sizes and structure definitions we use to build the
mcount relocation data and call instruction offsets.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 99 +++---------------------------------
 tools/objtool/recordmcount.h |  4 +-
 2 files changed, 9 insertions(+), 94 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index f8699e52e7e5..a263062c9c64 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -41,104 +41,14 @@
 #define R_AARCH64_ABS64	257
 #endif
 
-#define R_ARM_PC24		1
 #define R_ARM_THM_CALL		10
-#define R_ARM_CALL		28
 
-static int fd_map;	/* File descriptor for file being modified. */
-static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
 static const char *altmcount;	/* alternate mcount symbol name */
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
-static void *file_map;	/* pointer of the mapped file */
-static size_t file_map_size; /* original ELF file size */
 
 static struct elf *lf;
 
-static void mmap_cleanup(void)
-{
-	if (!mmap_failed)
-		munmap(file_map, file_map_size);
-	else
-		free(file_map);
-	file_map = NULL;
-	if (lf)
-		elf_close(lf);
-	lf = NULL;
-}
-
-static void * umalloc(size_t size)
-{
-	void *const addr = malloc(size);
-	if (addr == 0) {
-		fprintf(stderr, "malloc failed: %zu bytes\n", size);
-		mmap_cleanup();
-		return NULL;
-	}
-	return addr;
-}
-
-/*
- * Get the whole file as a programming convenience in order to avoid
- * malloc+lseek+read+free of many pieces.  If successful, then mmap
- * avoids copying unused pieces; else just read the whole file.
- * Open for both read and write; new info will be appended to the file.
- * Use MAP_PRIVATE so that a few changes to the in-memory ElfXX_Ehdr
- * do not propagate to the file until an explicit overwrite at the last.
- * This preserves most aspects of consistency (all except .st_size)
- * for simultaneous readers of the file while we are appending to it.
- * However, multiple writers still are bad.  We choose not to use
- * locking because it is expensive and the use case of kernel build
- * makes multiple writers unlikely.
- */
-static void *mmap_file(char const *fname)
-{
-	struct stat sb;
-
-	/* Avoid problems if early cleanup() */
-	fd_map = -1;
-	mmap_failed = 1;
-	file_map = NULL;
-	file_map_size = 0;
-
-	lf = elf_open_read(fname, O_RDWR);
-	if (!lf) {
-		perror(fname);
-		return NULL;
-	}
-	fd_map = lf->fd;
-	if (fstat(fd_map, &sb) < 0) {
-		perror(fname);
-		goto out;
-	}
-	if (!S_ISREG(sb.st_mode)) {
-		fprintf(stderr, "not a regular file: %s\n", fname);
-		goto out;
-	}
-	file_map = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
-			fd_map, 0);
-	if (file_map == MAP_FAILED) {
-		mmap_failed = 1;
-		file_map = umalloc(sb.st_size);
-		if (!file_map) {
-			perror(fname);
-			goto out;
-		}
-		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
-			perror(fname);
-			mmap_cleanup();
-			goto out;
-		}
-	} else
-		mmap_failed = 0;
-	file_map_size = sb.st_size;
-out:
-	fd_map = -1;
-
-	return file_map;
-}
-
-
 static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
 static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
 static unsigned char *ideal_nop;
@@ -527,8 +437,11 @@ static int do_file(char const *const fname)
 	unsigned int reltype = 0;
 	int rc = -1;
 
-	if (!mmap_file(fname))
+	lf = elf_open_read(fname, O_RDWR);
+	if (!lf) {
+		perror(fname);
 		goto out;
+	}
 
 	w = w4nat;
 	w2 = w2nat;
@@ -658,7 +571,9 @@ static int do_file(char const *const fname)
 	}  /* end switch */
 
 out:
-	mmap_cleanup();
+	if (lf)
+		elf_close(lf);
+	lf = NULL;
 	return rc;
 }
 
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 5ca488f3471c..fcc4f1a74d60 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -184,13 +184,13 @@ static int do_func(unsigned const reltype)
 	totrelsz = tot_relsize(&rel_entsize);
 	if (totrelsz == 0)
 		return 0;
-	mrel0 = umalloc(totrelsz);
+	mrel0 = malloc(totrelsz);
 	mrelp = mrel0;
 	if (!mrel0)
 		return -1;
 
 	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
-	mloc0 = umalloc(totrelsz>>1);
+	mloc0 = malloc(totrelsz>>1);
 	mlocp = mloc0;
 	if (!mloc0) {
 		free(mrel0);
-- 
2.20.1

