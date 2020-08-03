Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79961C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AD22064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYMArt+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHCMxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:53:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60346 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727897AbgHCMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596459156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=MSngICgia1pK9aI580EBIPySPVS0zT0GBc5XA54Jllw=;
        b=ZYMArt+/3l8elVnt8xj4/NygKmtk0gp0UDQ3gGUb6LkiG0WHa2tjVppYAxWoLaniKk8xq8
        GiHGuWvN0tZEOcf78RexEgpXSc990Qviak4v4wuPx0GLyZAQ09LFpul/EM8fcpz9IczP7j
        E/WhE0gJtjQ1dEBpL99m6qF8LRMENms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-sUK9d3eWPryTnDAsiv7wGA-1; Mon, 03 Aug 2020 08:52:31 -0400
X-MC-Unique: sUK9d3eWPryTnDAsiv7wGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6EEE1005504;
        Mon,  3 Aug 2020 12:52:30 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4E4D1001B0B;
        Mon,  3 Aug 2020 12:52:29 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     luto@mit.edu
Cc:     hpa@linux.intel.com, linux-kernel@vger.kernel.org,
        jstancek@redhat.com
Subject: [PATCH RESEND] selftests: vdso: hash entry size on alpha,s390x is 8 bytes
Date:   Mon,  3 Aug 2020 14:52:15 +0200
Message-Id: <93a07b1808e61babef3a20542cbeb4565d3c8410.1596458924.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse_vdso.c is crashing on 5.8-rc5 s390x, because it wrongly reads
nbucket as 0:
  Program received signal SIGFPE, Arithmetic exception.
  0x0000000001000f3e in vdso_sym (version=0x1001280 "LINUX_2.6", name=0x100128a "__vdso_getcpu") at parse_vdso.c:207
  207             ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
  (gdb) p vdso_info.nbucket
  $1 = 0

Per readelf source:
  https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=binutils/readelf.c;h=2406304fe35a832ac53aa7b1a367f3f7afed4264;hb=HEAD#l10027
and objdump output hash entries are double size on 64bit s390 and alpha:
  0000000000000120 <.hash>:
   120:   00 00 00 00             .long   0x00000000
   124:   00 00 00 03             .long   0x00000003
   128:   00 00 00 00             .long   0x00000000
   12c:   00 00 00 07             .long   0x00000007
   130:   00 00 00 00             .long   0x00000000
   134:   00 00 00 01             .long   0x00000001
   138:   00 00 00 00             .long   0x00000000
   13c:   00 00 00 05             .long   0x00000005
   140:   00 00 00 00             .long   0x00000000
   144:   00 00 00 06             .long   0x00000006
	  ...
   16c:   00 00 00 02             .long   0x00000002
   170:   00 00 00 00             .long   0x00000000
   174:   00 00 00 03             .long   0x00000003
   178:   00 00 00 00             .long   0x00000000
   17c:   00 00 00 04             .long   0x00000004

Do similar check in parse_vdso.c and treat hash entries as double word.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 48 +++++++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

Resend with original author CC-ed.

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..e23efcbd1c88 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -47,8 +47,9 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
-	ELF(Word) *bucket, *chain;
+	void *bucket, *chain;
 	ELF(Word) nbucket, nchain;
+	bool hash_ent_is_dword;
 
 	/* Version table */
 	ELF(Versym) *versym;
@@ -69,6 +70,28 @@ static unsigned long elf_hash(const unsigned char *name)
 	return h;
 }
 
+/* return value of hash table entry */
+ELF(Word) get_hash_val(void *ptr, ELF(Word) idx)
+{
+	if (vdso_info.hash_ent_is_dword) {
+		ELF(Xword) *table = ptr;
+		/* for vdso assume all values fit in Elf Word */
+		return (ELF(Word)) table[idx];
+	}
+
+	ELF(Word) *table = ptr;
+	return table[idx];
+}
+
+/* return pointer to hash table entry */
+void *get_hash_ptr(void *ptr, ELF(Word) idx)
+{
+	if (vdso_info.hash_ent_is_dword)
+		return &((ELF(Xword) *) ptr)[idx];
+
+	return &((ELF(Word) *) ptr)[idx];
+}
+
 void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 {
 	size_t i;
@@ -84,6 +107,14 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 		return;  /* Wrong ELF class -- check ELF_BITS */
 	}
 
+	/* 64bit s390 and alpha have hash entry size of 8 bytes */
+	if ((hdr->e_machine == EM_ALPHA
+		|| hdr->e_machine == EM_S390)
+		&& hdr->e_ident[EI_CLASS] == ELFCLASS64)
+		vdso_info.hash_ent_is_dword = true;
+	else
+		vdso_info.hash_ent_is_dword = false;
+
 	ELF(Phdr) *pt = (ELF(Phdr)*)(vdso_info.load_addr + hdr->e_phoff);
 	ELF(Dyn) *dyn = 0;
 
@@ -149,11 +180,11 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	if (!vdso_info.verdef)
 		vdso_info.versym = 0;
 
-	/* Parse the hash table header. */
-	vdso_info.nbucket = hash[0];
-	vdso_info.nchain = hash[1];
-	vdso_info.bucket = &hash[2];
-	vdso_info.chain = &hash[vdso_info.nbucket + 2];
+
+	vdso_info.nbucket = get_hash_val(hash, 0);
+	vdso_info.nchain = get_hash_val(hash, 1);
+	vdso_info.bucket = get_hash_ptr(hash, 2);
+	vdso_info.chain = get_hash_ptr(hash, vdso_info.nbucket + 2);
 
 	/* That's all we need. */
 	vdso_info.valid = true;
@@ -204,9 +235,10 @@ void *vdso_sym(const char *version, const char *name)
 		return 0;
 
 	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+	ELF(Word) chain = get_hash_val(vdso_info.bucket,
+		elf_hash(name) % vdso_info.nbucket);
 
-	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
+	for (; chain != STN_UNDEF; chain = get_hash_val(vdso_info.chain, chain)) {
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
 
 		/* Check for a defined global or weak function w/ right name. */
-- 
2.18.1

