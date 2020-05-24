Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E72C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9A8207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335010;
	bh=KnZ2/QwltKFQM/nedfV0aMwFJJvT8wHZu2vE3JfcFag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CydQ60JUqU2iXTM/iMJMYSzXI6BOwPXtoln6I2MfyBmqwQ23qdxcJ07ekwYPGWgrS
	 dsV6kZgaCKVTLtigKT5VBEjrovEBEIJCYI329/0or2J+4aS6W/mRf6xkrX8dDQmeU7
	 7OhyRSOLT0vjlFe4YXkNQR4zANzb5x2Of5MdwXxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgEXPn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:43:29 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19694 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcVE017561;
        Mon, 25 May 2020 00:42:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcVE017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334974;
        bh=G869loiYVAwAkrK3b+xUggAjxNzU2jDd+CxSJ9Mmwlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIzMju7p45f/YK9ERCHG9QeZcnuhStUm/9X4Cs2KsyNAIIR7yebG0FhXhHYejv156
         ITyNboW/upHn5IWwK2ZtzZbzywm3WGln0xvgDBbGm3pvkuun4u8C6kceFFK+goT3I8
         VCMEea74hdIv4NJAztoUFiflb1Qg2BwYNgF7H4nFB1tClXlqTO20adanvuOwyFohGv
         ttDqlV+aaEs6a4WoV77ZzhGO5c60hhJ92GknBxf9ZeK632hvAVSzGYP4xKqtFZy6FD
         w49smWiSNrOw1BIjFAoTaVqG5rJw1tY46cpsZ+lx5bzLqMrSG522XvL7t8c8XdQOUp
         oa5ZZb/TFJkdg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/29] modpost: change elf_info->size to size_t
Date:   Mon, 25 May 2020 00:42:35 +0900
Message-Id: <20200524154235.380482-30-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align with the mmap / munmap APIs.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 9 ++++-----
 scripts/mod/modpost.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 527f71b662b0..a0e44991a525 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -439,7 +439,7 @@ static void sym_set_crc(const char *name, unsigned int crc)
 	s->crc_valid = 1;
 }
 
-static void *grab_file(const char *filename, unsigned long *size)
+static void *grab_file(const char *filename, size_t *size)
 {
 	struct stat st;
 	void *map = MAP_FAILED;
@@ -461,7 +461,7 @@ static void *grab_file(const char *filename, unsigned long *size)
 	return map;
 }
 
-static void release_file(void *file, unsigned long size)
+static void release_file(void *file, size_t size)
 {
 	munmap(file, size);
 }
@@ -517,9 +517,8 @@ static int parse_elf(struct elf_info *info, const char *filename)
 
 	/* Check if file offset is correct */
 	if (hdr->e_shoff > info->size) {
-		fatal("section header offset=%lu in file '%s' is bigger than "
-		      "filesize=%lu\n", (unsigned long)hdr->e_shoff,
-		      filename, info->size);
+		fatal("section header offset=%lu in file '%s' is bigger than filesize=%zu\n",
+		      (unsigned long)hdr->e_shoff, filename, info->size);
 		return 0;
 	}
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1df87d204c9a..efb74dba19e2 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -133,7 +133,7 @@ struct module {
 };
 
 struct elf_info {
-	unsigned long size;
+	size_t size;
 	Elf_Ehdr     *hdr;
 	Elf_Shdr     *sechdrs;
 	Elf_Sym      *symtab_start;
-- 
2.25.1

