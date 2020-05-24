Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE4620787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335091;
	bh=Q5Z+tSIvc4OPGc6vRlidRZALMYj4TKYVjPveOjMo2lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTVseIbjphwWftTW3GORTHsjPO5/KOlBhnJCzdwnUcDX3ogfundolFH+TI44o6Rfz
	 AIUffUYb4zpGflLzOFlcKFeNSVTv4jldGI0zSt8RcYZAgn7GKmDSz3WNkxPHuPAHSB
	 6I6Uw1FLYtWH3SPvimpYm3kBv4s/S2CS9jwCYIeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEXPot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:44:49 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19690 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcVB017561;
        Mon, 25 May 2020 00:42:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcVB017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334973;
        bh=kwoq5xpA8F/sctaUPYuQ/4h7HRDZ9Kghbw9a951gG9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zT9GVGUXktFw8aUZWUPGTCkt72SUbCF3HVywE58oWjS/NLoWyaa7YLadQSG1wQvCs
         statZrFohPyKwmz4MAfHPzf2t0tJ2oX80M25uRqm/JOubgGWYDcHwF5fQRav0yare0
         2JmG/RlYKW/eUkImzxiMVSfhuo3aa8GHgizYbGL8WKeVJ81RtyjKkRGO2jX+OPQ8Z4
         Lk8UyrYhIgEkNJA9ARtswZ59/mUQBn8qfm025qWLDsFiJmHT0xI7WleFyReIsPSl5Y
         2WUrApN710tU/hAuU7b7wJfzH4J990Euedb/N5VC4BbNVZGlMm7aPyhQC468q2KVi6
         QS3B/nT25P9XQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/29] modpost: set have_vmlinux in new_module()
Date:   Mon, 25 May 2020 00:42:32 +0900
Message-Id: <20200524154235.380482-27-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set have_vmlinux flag in a single place.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index fdf843323d98..662dc1ca10f8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -191,6 +191,9 @@ static struct module *new_module(const char *modname)
 	mod->next = modules;
 	modules = mod;
 
+	if (mod->is_vmlinux)
+		have_vmlinux = 1;
+
 	return mod;
 }
 
@@ -2012,9 +2015,6 @@ static void read_symbols(const char *modname)
 
 	mod = new_module(modname);
 
-	if (mod->is_vmlinux)
-		have_vmlinux = 1;
-
 	if (!mod->is_vmlinux) {
 		license = get_modinfo(&info, "license");
 		if (!license)
@@ -2462,8 +2462,6 @@ static void read_dump(const char *fname)
 		mod = find_module(modname);
 		if (!mod) {
 			mod = new_module(modname);
-			if (mod->is_vmlinux)
-				have_vmlinux = 1;
 			mod->from_dump = 1;
 		}
 		s = sym_add_exported(symname, mod, export_no(export));
-- 
2.25.1

