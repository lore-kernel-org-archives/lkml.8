Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ACDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D199020671
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589708981;
	bh=G8Q9sgxbz5P7WT8++b2R0ScBmMxAZBQzNvjqyUcLoe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkOxkTeoTHXx7T1uR2I0f2opvyhzLRreMNL0AxkrjsT12Vrc6u5W6kIwG+4qDDRGO
	 1gh6JvbE+VFeFf6+t0VyrdVqYIvlZsFr1+51EsoGAAGmiAcBJiKZWgpor3b3y7HSL5
	 ZPtGrkGkxce4egzmt5+aFrL+l6nW/nWfU1nQKmS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEQJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:49:38 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38321 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgEQJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:36 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4LD018560;
        Sun, 17 May 2020 18:49:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4LD018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708955;
        bh=q9DY23z18Rjre2W0GdlwfJlDVc8bgB3qqCnPYlhBcEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Erojqq4vQ/kfYMLGO9XAikgELJM07GkAQ2tAwwiUkM/4nllCwZ+w/iureQTabCzUR
         eg1MCdYd8fahWqrcUuWOtzidWrxTut7/iqW5VVWqWjcTGRGdYAprxqjKx4inc8/ne7
         kE5uZEGSIetvzGmPeJP2I3LgYtlQ1knscT4HZMVj1njSbumKxvK5jKsY86OQrIfXxB
         g13mQ6voyJzbu3z5lLzmxutTjM7e56Br22u8a4UcLC/qnpoj8oKAXztXYps10pWwHO
         EOZROXkC9l5nOkTqG5ItZtOBoLVV31BoRiNJU5rEIsxu/MoK9B1qwK9FLT8iWeiUIk
         flWYILhhCmp6A==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/29] modpost: rename ext_sym_list to dump_list
Date:   Sun, 17 May 2020 18:48:46 +0900
Message-Id: <20200517094859.2376211-17-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -i option is used to include Modules.symver as well as files from
$(KBUILD_EXTRA_SYMBOLS).

Make the struct and variable names more generic.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d3141b217b57..a5bac158d344 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2539,8 +2539,8 @@ static void write_namespace_deps_files(const char *fname)
 	free(ns_deps_buf.p);
 }
 
-struct ext_sym_list {
-	struct ext_sym_list *next;
+struct dump_list {
+	struct dump_list *next;
 	const char *file;
 };
 
@@ -2553,16 +2553,17 @@ int main(int argc, char **argv)
 	int opt;
 	int err;
 	int n;
-	struct ext_sym_list *extsym_start = NULL;
-	struct ext_sym_list **extsym_iter = &extsym_start;
+	struct dump_list *dump_read_start = NULL;
+	struct dump_list **dump_read_iter = &dump_read_start;
 
 	while ((opt = getopt(argc, argv, "i:mnsT:o:awENd:")) != -1) {
 		switch (opt) {
 		case 'i':
 			external_module = 1;
-			*extsym_iter = NOFAIL(calloc(1, sizeof(**extsym_iter)));
-			(*extsym_iter)->file = optarg;
-			extsym_iter = &(*extsym_iter)->next;
+			*dump_read_iter =
+				NOFAIL(calloc(1, sizeof(**dump_read_iter)));
+			(*dump_read_iter)->file = optarg;
+			dump_read_iter = &(*dump_read_iter)->next;
 			break;
 		case 'm':
 			modversions = 1;
@@ -2599,13 +2600,13 @@ int main(int argc, char **argv)
 		}
 	}
 
-	while (extsym_start) {
-		struct ext_sym_list *tmp;
+	while (dump_read_start) {
+		struct dump_list *tmp;
 
-		read_dump(extsym_start->file);
-		tmp = extsym_start->next;
-		free(extsym_start);
-		extsym_start = tmp;
+		read_dump(dump_read_start->file);
+		tmp = dump_read_start->next;
+		free(dump_read_start);
+		dump_read_start = tmp;
 	}
 
 	while (optind < argc)
-- 
2.25.1

