Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE502C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE211207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335030;
	bh=Jbnr0myTiMWsMUmCwq8bRYwt6i1Ih9hFBGVvavr6QaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C15EnHUtICqu/aR1LSIugYyOkGbjVa31zGG1Aj2GYe3y/i+0gdvpeMWhWclj0Bx1p
	 MsoxQuqQtPVXSfIlEEwYZwn8HCNufcZFXsjxmEDRKRciANgtoVMXt9CnAxY0OjyXY5
	 7ZAixOSOxlKyV/49jVOq1e6KPSgJy0lmFWsLzxN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgEXPnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:43:49 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19709 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgEXPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:24 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcUw017561;
        Mon, 25 May 2020 00:42:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcUw017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334966;
        bh=Pe8hfxDjRGUZwydN8j8H7B1RhdHPopr2dmjeMw9MlSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUIhpfd+chEgZcG0avG81gcQ7wrL+fAhRJPj25CpVNt9dEpZpspYCKgb7Tom4L7He
         FYeH4tK7O4QR+2GAGwINgIK1Xp3ESbsSggR9qVigLRUF8OXs3rbjE3WiGmK4w4mYjz
         fgmHV6TQK+6B9qf6JVITWH+wL7Gq0o+4fdFEIMGxCOkQBt+bRKG8XOvdm1sDowt+BO
         90YqdAA50kTl/mKNswt/H479vbpkHncj2BIUS9PA/1zhSi+mxkgqA9xOlaxXcfQEyX
         gYNfYxv3eSCmpO/5AGKrxef9ZZhG9NTVt10vgRtTVHy7RBTdhmpXk3w3dkCgYkGsGO
         R83dVAZMIrDDQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/29] modpost: load KBUILD_EXTRA_SYMBOLS files in order
Date:   Mon, 25 May 2020 00:42:19 +0900
Message-Id: <20200524154235.380482-14-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, modpost reads extra symbol dump files in the reverse order.
If '-e foo -e bar' is given, modpost reads bar, foo, in this order.

This is probably not a big deal, but there is no good reason to reverse
the order. Read files in the given order.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 33cdb78a4ba1..2f5fab40d859 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2569,8 +2569,8 @@ int main(int argc, char **argv)
 	int opt;
 	int err;
 	int n;
-	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
+	struct ext_sym_list **extsym_iter = &extsym_start;
 
 	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awENd:")) != -1) {
 		switch (opt) {
@@ -2580,11 +2580,9 @@ int main(int argc, char **argv)
 			break;
 		case 'e':
 			external_module = 1;
-			extsym_iter =
-			   NOFAIL(malloc(sizeof(*extsym_iter)));
-			extsym_iter->next = extsym_start;
-			extsym_iter->file = optarg;
-			extsym_start = extsym_iter;
+			*extsym_iter = NOFAIL(calloc(1, sizeof(**extsym_iter)));
+			(*extsym_iter)->file = optarg;
+			extsym_iter = &(*extsym_iter)->next;
 			break;
 		case 'm':
 			modversions = 1;
@@ -2624,10 +2622,12 @@ int main(int argc, char **argv)
 	if (kernel_read)
 		read_dump(kernel_read, 1);
 	while (extsym_start) {
+		struct ext_sym_list *tmp;
+
 		read_dump(extsym_start->file, 0);
-		extsym_iter = extsym_start->next;
+		tmp = extsym_start->next;
 		free(extsym_start);
-		extsym_start = extsym_iter;
+		extsym_start = tmp;
 	}
 
 	while (optind < argc)
-- 
2.25.1

