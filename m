Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9824C208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgFRUkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:09 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731271AbgFRUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:21 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:11 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8E8F7B265A;
        Thu, 18 Jun 2020 16:39:14 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 20/51] objtool: mcount: Use objtool ELF to write
Date:   Thu, 18 Jun 2020 13:38:06 -0700
Message-ID: <c3c6f089fef15a250a029cb255a66e0cb25193bf.1592510545.git.mhelsley@vmware.com>
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

Rather than modify the pseudo-mapping of the ELF file directly,
which is the recordmcount way of operating, use the objtool
section list and generic ELF functions to modify the ELF file.

This eliminates a bunch of code -- the ulseek() and uwrite()
functions -- because it's used to patch the ELF data. Instead
we rely on objtool's ELF code to handle updating the ELF file.
This means a bunch of the odd bits in append_func() also go
away since they did things like update the ELF header, add
to the section table, and append the new section names to the
string table -- all handled by objtool's ELF code.

Since we no longer use the get/set_shnum() functions to
determine the next section to allocate and set how many new
sections there are we can also eliminate those two functions.

One unusual part, with respect to objtool is the way we handle
writing nops. Objtool is not designed to modify the an ELF
text section directly (or at least I could not find and example
to base this work on). So we break layering to access the
"data" of the text section via the section's "data buffer".
This is still cleaner -- we can now pass in the section struct
and offset as separate parameters.

Note that this patch does not move the associated parts out
of the wrapper file. We postpone that cleanup for later so that
it's easier to see the changes to the functions rather than
obscuring them with the move.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 161 ++++-----------------------------
 tools/objtool/recordmcount.h | 167 ++++++++---------------------------
 2 files changed, 53 insertions(+), 275 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 2225479157e5..c015091a8a8c 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -52,24 +52,9 @@ static struct stat sb;	/* Remember .st_size, etc. */
 static const char *altmcount;	/* alternate mcount symbol name */
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 static void *file_map;	/* pointer of the mapped file */
-static void *file_end;	/* pointer to the end of the mapped file */
-static int file_updated; /* flag to state file was changed */
-static void *file_ptr;	/* current file pointer location */
-
-static void *file_append; /* added to the end of the file */
-static size_t file_append_size; /* how much is added to end of file */
 
 static struct elf *lf;
 
-/* Per-file resource cleanup when multiple files. */
-static void file_append_cleanup(void)
-{
-	free(file_append);
-	file_append = NULL;
-	file_append_size = 0;
-	file_updated = 0;
-}
-
 static void mmap_cleanup(void)
 {
 	if (!mmap_failed)
@@ -82,72 +67,11 @@ static void mmap_cleanup(void)
 	lf = NULL;
 }
 
-/* ulseek, uwrite, ...:  Check return value for errors. */
-
-static off_t ulseek(off_t const offset, int const whence)
-{
-	switch (whence) {
-	case SEEK_SET:
-		file_ptr = file_map + offset;
-		break;
-	case SEEK_CUR:
-		file_ptr += offset;
-		break;
-	case SEEK_END:
-		file_ptr = file_map + (sb.st_size - offset);
-		break;
-	}
-	if (file_ptr < file_map) {
-		fprintf(stderr, "lseek: seek before file\n");
-		return -1;
-	}
-	return file_ptr - file_map;
-}
-
-static ssize_t uwrite(void const *const buf, size_t const count)
-{
-	size_t cnt = count;
-	off_t idx = 0;
-
-	file_updated = 1;
-
-	if (file_ptr + count >= file_end) {
-		off_t aoffset = (file_ptr + count) - file_end;
-
-		if (aoffset > file_append_size) {
-			file_append = realloc(file_append, aoffset);
-			file_append_size = aoffset;
-		}
-		if (!file_append) {
-			perror("write");
-			file_append_cleanup();
-			mmap_cleanup();
-			return -1;
-		}
-		if (file_ptr < file_end) {
-			cnt = file_end - file_ptr;
-		} else {
-			cnt = 0;
-			idx = aoffset - count;
-		}
-	}
-
-	if (cnt)
-		memcpy(file_ptr, buf, cnt);
-
-	if (cnt < count)
-		memcpy(file_append + idx, buf + cnt, count - cnt);
-
-	file_ptr += count;
-	return count;
-}
-
 static void * umalloc(size_t size)
 {
 	void *const addr = malloc(size);
 	if (addr == 0) {
 		fprintf(stderr, "malloc failed: %zu bytes\n", size);
-		file_append_cleanup();
 		mmap_cleanup();
 		return NULL;
 	}
@@ -173,8 +97,6 @@ static void *mmap_file(char const *fname)
 	fd_map = -1;
 	mmap_failed = 1;
 	file_map = NULL;
-	file_ptr = NULL;
-	file_updated = 0;
 	sb.st_size = 0;
 
 	lf = elf_open_read(fname, O_RDWR);
@@ -210,8 +132,6 @@ static void *mmap_file(char const *fname)
 out:
 	fd_map = -1;
 
-	file_end = file_map + sb.st_size;
-
 	return file_map;
 }
 
@@ -222,12 +142,16 @@ static unsigned char *ideal_nop;
 
 static char rel_type_nop;
 
-static int (*make_nop)(void *map, size_t const offset);
+static int (*make_nop)(struct section *, size_t const offset);
 
-static int make_nop_x86(void *map, size_t const offset)
+static int make_nop_x86(struct section *txts, size_t const offset)
 {
 	uint32_t *ptr;
 	unsigned char *op;
+	void *map = txts->data->d_buf;
+
+	if (offset < 1)
+		return -1;
 
 	/* Confirm we have 0xe8 0x0 0x0 0x0 0x0 */
 	ptr = map + offset;
@@ -239,10 +163,7 @@ static int make_nop_x86(void *map, size_t const offset)
 		return -1;
 
 	/* convert to nop */
-	if (ulseek(offset - 1, SEEK_SET) < 0)
-		return -1;
-	if (uwrite(ideal_nop, 5) < 0)
-		return -1;
+	memcpy(op, ideal_nop, 5);
 	return 0;
 }
 
@@ -266,12 +187,13 @@ static unsigned char push_bl_mcount_thumb_le[6] = { 0x00, 0xb5, 0xff, 0xf7, 0xfe
 static unsigned char push_bl_mcount_thumb_be[6] = { 0xb5, 0x00, 0xf7, 0xff, 0xff, 0xfe }; /* push {lr}, bl */
 static unsigned char *push_bl_mcount_thumb;
 
-static int make_nop_arm(void *map, size_t const offset)
+static int make_nop_arm(struct section *txts, size_t const offset)
 {
 	char *ptr;
 	int cnt = 1;
 	int nop_size;
 	size_t off = offset;
+	void *map = txts->data->d_buf;
 
 	ptr = map + offset;
 	if (memcmp(ptr, bl_mcount_arm, 4) == 0) {
@@ -290,21 +212,19 @@ static int make_nop_arm(void *map, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	if (ulseek(off, SEEK_SET) < 0)
-		return -1;
-
 	do {
-		if (uwrite(ideal_nop, nop_size) < 0)
-			return -1;
+		memcpy(map + off, ideal_nop, nop_size);
+		off += nop_size;
 	} while (--cnt > 0);
 
 	return 0;
 }
 
 static unsigned char ideal_nop4_arm64[4] = {0x1f, 0x20, 0x03, 0xd5};
-static int make_nop_arm64(void *map, size_t const offset)
+static int make_nop_arm64(struct section *txts, size_t const offset)
 {
 	uint32_t *ptr;
+	void *map = txts->data->d_buf;
 
 	ptr = map + offset;
 	/* bl <_mcount> is 0x94000000 before relocation */
@@ -312,52 +232,7 @@ static int make_nop_arm64(void *map, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	if (ulseek(offset, SEEK_SET) < 0)
-		return -1;
-	if (uwrite(ideal_nop, 4) < 0)
-		return -1;
-	return 0;
-}
-
-static int write_file(const char *fname)
-{
-	char tmp_file[strlen(fname) + 4];
-	size_t n;
-
-	if (!file_updated)
-		return 0;
-
-	sprintf(tmp_file, "%s.rc", fname);
-
-	/*
-	 * After reading the entire file into memory, delete it
-	 * and write it back, to prevent weird side effects of modifying
-	 * an object file in place.
-	 */
-	fd_map = open(tmp_file, O_WRONLY | O_TRUNC | O_CREAT, sb.st_mode);
-	if (fd_map < 0) {
-		perror(fname);
-		return -1;
-	}
-	n = write(fd_map, file_map, sb.st_size);
-	if (n != sb.st_size) {
-		perror("write");
-		close(fd_map);
-		return -1;
-	}
-	if (file_append_size) {
-		n = write(fd_map, file_append, file_append_size);
-		if (n != file_append_size) {
-			perror("write");
-			close(fd_map);
-			return -1;
-		}
-	}
-	close(fd_map);
-	if (rename(tmp_file, fname) < 0) {
-		perror(fname);
-		return -1;
-	}
+	memcpy(map + offset, ideal_nop, 4);
 	return 0;
 }
 
@@ -683,8 +558,7 @@ static int do_file(char const *const fname)
 			reltype = R_MIPS_32;
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
-		if (do32(ehdr, reltype) < 0)
-			goto out;
+		rc = do32(reltype);
 		break;
 	case ELFCLASS64: {
 		Elf64_Ehdr *const ghdr = (Elf64_Ehdr *)ehdr;
@@ -703,15 +577,12 @@ static int do_file(char const *const fname)
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
-		if (do64(ghdr, reltype) < 0)
-			goto out;
+		rc = do64(reltype);
 		break;
 	}
 	}  /* end switch */
 
-	rc = write_file(fname);
 out:
-	file_append_cleanup();
 	mmap_cleanup();
 	return rc;
 }
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 19bff5a7c8ce..1f14c64ed484 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -23,11 +23,7 @@
 #undef nop_mcount
 #undef has_rel_mcount
 #undef tot_relsize
-#undef get_shnum
-#undef set_shnum
-#undef get_shstrndx
 #undef do_func
-#undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Rel
 #undef Elf_Rela
@@ -36,7 +32,6 @@
 #undef fn_ELF_R_INFO
 #undef uint_t
 #undef _w
-#undef _align
 #undef _size
 
 #ifdef RECORD_MCOUNT_64
@@ -45,13 +40,8 @@
 # define nop_mcount		nop_mcount_64
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
-# define get_shnum		get_shnum64
-# define set_shnum		set_shnum64
-# define get_shstrndx		get_shstrndx64
 # define do_func		do64
 # define mcount_adjust		mcount_adjust_64
-# define Elf_Ehdr		Elf64_Ehdr
-# define Elf_Shdr		Elf64_Shdr
 # define Elf_Rel		Elf64_Rel
 # define Elf_Rela		Elf64_Rela
 # define ELF_R_INFO		ELF64_R_INFO
@@ -59,7 +49,6 @@
 # define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
 # define _w			w8
-# define _align			7u
 # define _size			8
 #else
 # define append_func		append32
@@ -67,13 +56,8 @@
 # define nop_mcount		nop_mcount_32
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
-# define get_shnum		get_shnum32
-# define set_shnum		set_shnum32
-# define get_shstrndx		get_shstrndx32
 # define do_func		do32
 # define mcount_adjust		mcount_adjust_32
-# define Elf_Ehdr		Elf32_Ehdr
-# define Elf_Shdr		Elf32_Shdr
 # define Elf_Rel		Elf32_Rel
 # define Elf_Rela		Elf32_Rela
 # define ELF_R_INFO		ELF32_R_INFO
@@ -81,7 +65,6 @@
 # define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
 # define _w			w
-# define _align			3u
 # define _size			4
 #endif
 
@@ -93,35 +76,8 @@ static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_E
 
 static int mcount_adjust = 0;
 
-static unsigned int get_shnum(GElf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
-{
-	if (shdr0 && !ehdr->e_shnum)
-		return w(shdr0->sh_size);
-
-	return w2(ehdr->e_shnum);
-}
-
-static void set_shnum(Elf_Ehdr *ehdr, Elf_Shdr *shdr0, unsigned int new_shnum)
-{
-	if (new_shnum >= SHN_LORESERVE) {
-		ehdr->e_shnum = 0;
-		shdr0->sh_size = w(new_shnum);
-	} else
-		ehdr->e_shnum = w2(new_shnum);
-}
-
-static int get_shstrndx(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
-{
-	if (ehdr->e_shstrndx != SHN_XINDEX)
-		return w2(ehdr->e_shstrndx);
-
-	return w(shdr0->sh_link);
-}
-
-/* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
-static int append_func(Elf_Ehdr *const ehdr,
-			Elf_Shdr *const shstr,
-			uint_t const *const mloc0,
+/* Append the new  __mcount_loc and its relocations. */
+static int append_func(uint_t const *const mloc0,
 			uint_t const *const mlocp,
 			Elf_Rel const *const mrel0,
 			Elf_Rel const *const mrelp,
@@ -129,85 +85,44 @@ static int append_func(Elf_Ehdr *const ehdr,
 			unsigned int const symsec_sh_link)
 {
 	/* Begin constructing output file */
-	Elf_Shdr mcsec;
+	struct section *mcount_loc_sec, *reloc_sec;
 	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
 		? ".rela__mcount_loc"
 		:  ".rel__mcount_loc";
-	uint_t const old_shoff = lf->ehdr.e_shoff;
-	uint_t const old_shstr_sh_size   = _w(shstr->sh_size);
-	uint_t const old_shstr_sh_offset = _w(shstr->sh_offset);
-	Elf_Shdr *const shdr0 = (Elf_Shdr *)(old_shoff + (void *)ehdr);
-	unsigned int const old_shnum = get_shnum(&lf->ehdr, shdr0);
-	unsigned int const new_shnum = 2 + old_shnum; /* {.rel,}__mcount_loc */
-	uint_t t = 1 + strlen(mc_name) + _w(shstr->sh_size);
-	uint_t new_e_shoff;
-
-	shstr->sh_size = _w(t);
-	shstr->sh_offset = _w(sb.st_size);
-
-	t += sb.st_size;
-	t += (_align & -t);  /* word-byte align */
-	new_e_shoff = t;
-
-	/* body for new shstrtab */
-	if (ulseek(sb.st_size, SEEK_SET) < 0)
-		return -1;
-	if (uwrite(old_shstr_sh_offset + (void *)ehdr, old_shstr_sh_size) < 0)
-		return -1;
-	if (uwrite(mc_name, 1 + strlen(mc_name)) < 0)
-		return -1;
 
-	/* old(modified) Elf_Shdr table, word-byte aligned */
-	if (ulseek(t, SEEK_SET) < 0)
-		return -1;
-	t += sizeof(Elf_Shdr) * old_shnum;
-	if (uwrite(old_shoff + (void *)ehdr,
-	       sizeof(Elf_Shdr) * old_shnum) < 0)
+	/* add section: __mcount_loc */
+	mcount_loc_sec = elf_create_section(lf,
+		mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"),
+		_size, mlocp - mloc0);
+	if (!mcount_loc_sec)
 		return -1;
-
-	/* new sections __mcount_loc and .rel__mcount_loc */
-	t += 2*sizeof(mcsec);
-	mcsec.sh_name = w((sizeof(Elf_Rela) == rel_entsize) + strlen(".rel")
-		+ old_shstr_sh_size);
-	mcsec.sh_type = w(SHT_PROGBITS);
-	mcsec.sh_flags = _w(SHF_ALLOC);
-	mcsec.sh_addr = 0;
-	mcsec.sh_offset = _w(t);
-	mcsec.sh_size = _w((void *)mlocp - (void *)mloc0);
-	mcsec.sh_link = 0;
-	mcsec.sh_info = 0;
-	mcsec.sh_addralign = _w(_size);
-	mcsec.sh_entsize = _w(_size);
-	if (uwrite(&mcsec, sizeof(mcsec)) < 0)
+	// created mcount_loc_sec->sh.sh_size = (void *)mlocp - (void *)mloc0;
+	mcount_loc_sec->sh.sh_link = 0;
+	mcount_loc_sec->sh.sh_info = 0;
+	mcount_loc_sec->sh.sh_addralign = _size;
+	// created mcount_loc_sec->sh.sh_entsize = _size;
+
+	// assert mcount_loc_sec->data->d_size == (void *)mlocp - (void *)mloc0
+	memcpy(mcount_loc_sec->data->d_buf, mloc0,
+	       mcount_loc_sec->data->d_size);
+	elf_flagdata(mcount_loc_sec->data, ELF_C_SET, ELF_F_DIRTY);
+
+	/* add section .rel[a]__mcount_loc */
+	reloc_sec = elf_create_section(lf, mc_name, rel_entsize,
+					      mrelp - mrel0);
+	if (!reloc_sec)
 		return -1;
+	reloc_sec->sh.sh_type = (sizeof(Elf_Rela) == rel_entsize) ?
+						SHT_RELA : SHT_REL;
+	reloc_sec->sh.sh_flags = 0; /* clear SHF_ALLOC */
+	reloc_sec->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
+	reloc_sec->sh.sh_info = mcount_loc_sec->idx;
+	reloc_sec->sh.sh_addralign = _size;
 
-	mcsec.sh_name = w(old_shstr_sh_size);
-	mcsec.sh_type = (sizeof(Elf_Rela) == rel_entsize)
-		? w(SHT_RELA)
-		: w(SHT_REL);
-	mcsec.sh_flags = 0;
-	mcsec.sh_addr = 0;
-	mcsec.sh_offset = _w((void *)mlocp - (void *)mloc0 + t);
-	mcsec.sh_size   = _w((void *)mrelp - (void *)mrel0);
-	mcsec.sh_link = w(symsec_sh_link);
-	mcsec.sh_info = w(old_shnum);
-	mcsec.sh_addralign = _w(_size);
-	mcsec.sh_entsize = _w(rel_entsize);
-
-	if (uwrite(&mcsec, sizeof(mcsec)) < 0)
-		return -1;
+	// assert reloc_sec->data->d_size == (void *)mrelp - (void *)mrel0
+	memcpy(reloc_sec->data->d_buf, mrel0, reloc_sec->data->d_size);
+	elf_flagdata(reloc_sec->data, ELF_C_SET, ELF_F_DIRTY);
 
-	if (uwrite(mloc0, (void *)mlocp - (void *)mloc0) < 0)
-		return -1;
-	if (uwrite(mrel0, (void *)mrelp - (void *)mrel0) < 0)
-		return -1;
-
-	ehdr->e_shoff = _w(new_e_shoff);
-	set_shnum(ehdr, shdr0, new_shnum);
-	if (ulseek(0, SEEK_SET) < 0)
-		return -1;
-	if (uwrite(ehdr, sizeof(*ehdr)) < 0)
-		return -1;
 	return elf_write(lf);
 }
 
@@ -259,13 +174,10 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
  * into nops.
  */
 static int nop_mcount(struct section * const rels,
-		      Elf_Ehdr const *const ehdr,
 		      const char *const txtname)
 {
-	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
-		+ (void *)ehdr);
 	struct reloc *reloc;
-	Elf_Shdr const *const shdr = &shdr0[rels->sh.sh_info];
+	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
 	struct symbol *mcountsym = NULL;
 	int once = 0;
 
@@ -277,7 +189,7 @@ static int nop_mcount(struct section * const rels,
 
 		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
 			if (make_nop) {
-				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + reloc->offset);
+				ret = make_nop(txts, reloc->offset);
 				if (ret < 0)
 					return -1;
 			}
@@ -331,12 +243,8 @@ static unsigned tot_relsize(void)
 }
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int do_func(Elf_Ehdr *const ehdr,
-		   unsigned const reltype)
+static int do_func(unsigned const reltype)
 {
-	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
-		+ (void *)ehdr);
-
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
 
@@ -395,15 +303,14 @@ static int do_func(Elf_Ehdr *const ehdr,
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
 			 */
-			if (nop_mcount(sec, ehdr, txtname) < 0) {
+			if (nop_mcount(sec, txtname) < 0) {
 				result = -1;
 				goto out;
 			}
 		}
 	}
 	if (!result && mloc0 != mlocp)
-		result = append_func(ehdr, &shdr0[get_shstrndx(ehdr, shdr0)],
-				     mloc0, mlocp, mrel0, mrelp,
+		result = append_func(mloc0, mlocp, mrel0, mrelp,
 				     rel_entsize, symsec_sh_link);
 out:
 	free(mrel0);
-- 
2.20.1

