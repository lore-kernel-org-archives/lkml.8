Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF3FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDE5207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335027;
	bh=luGqgXoz+9aXSGUcehDez2W+/tGohLA4JkXsAw2HaEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQOSgQ0iTBjh4NTSmdPyhR37oXSrHcgZ89+DuyEYfpEeJ9g8c3b5UxJMYF8W/3phK
	 Ecejsh4GPfzrIrWFrs4D3SD+/I3pT33CTiVsmPU9Swn3B7bgvXI0SI5wtAf1ylAfvM
	 F72bS6xy59K8+0YSJJ8HSTCjwH1sT6JHwSSoL1uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgEXPnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:43:47 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19711 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgEXPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:24 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcV8017561;
        Mon, 25 May 2020 00:42:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcV8017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334971;
        bh=qzT9+tolI6nR6eDZTwWqFMLcC8eYszA2DAKwYhqQWRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NId0ZJySIg0JjB4k634jpPF3/WdzFtT1Q3hBlQACpf0tBECbZv17bG5drmRP7sGuS
         sBx+ec1eHjaIYz/RlYhgFhIlAKpLp/p2rxNoYiKHETxRbei9GnSH9V1e4UIA0pYpj2
         E2vmak2C+yQkkkot3xygBlNU6me94jLGbQqga7vOwG2MTm4ftkZhIwV2WuwM84LHlz
         /h9rzqOqaHMFdv0xE4DqwwNa9gDBZQNo3CkXsTFjPHYfgO3HodkXXl4skQvaSrXOoE
         F+rs8zjICWTRqRBdHSLMOa3oHx9RlzarJYDLj6Ncv9bUXih4RZaEwpi7yhh1lJPUF5
         1FJur30pCSQxw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/29] modpost: remove is_vmlinux() call in check_for_{gpl_usage,unused}()
Date:   Mon, 25 May 2020 00:42:29 +0900
Message-Id: <20200524154235.380482-24-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_exports() is never called for vmlinux because mod->skip is set
for vmlinux.

Hence, check_for_gpl_usage() and check_for_unused() are not called
for vmlinux, either. is_vmlinux() is always false here.

Remove the is_vmlinux() calls, and hard-code the ".ko" suffix.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 94404374262a..c0bc8a2ea026 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2144,20 +2144,18 @@ void buf_write(struct buffer *buf, const char *s, int len)
 
 static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 {
-	const char *e = is_vmlinux(m) ?"":".ko";
-
 	switch (exp) {
 	case export_gpl:
-		fatal("GPL-incompatible module %s%s "
-		      "uses GPL-only symbol '%s'\n", m, e, s);
+		fatal("GPL-incompatible module %s.ko uses GPL-only symbol '%s'\n",
+		      m, s);
 		break;
 	case export_unused_gpl:
-		fatal("GPL-incompatible module %s%s "
-		      "uses GPL-only symbol marked UNUSED '%s'\n", m, e, s);
+		fatal("GPL-incompatible module %s.ko uses GPL-only symbol marked UNUSED '%s'\n",
+		      m, s);
 		break;
 	case export_gpl_future:
-		warn("GPL-incompatible module %s%s "
-		      "uses future GPL-only symbol '%s'\n", m, e, s);
+		warn("GPL-incompatible module %s.ko uses future GPL-only symbol '%s'\n",
+		     m, s);
 		break;
 	case export_plain:
 	case export_unused:
@@ -2169,13 +2167,11 @@ static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 
 static void check_for_unused(enum export exp, const char *m, const char *s)
 {
-	const char *e = is_vmlinux(m) ?"":".ko";
-
 	switch (exp) {
 	case export_unused:
 	case export_unused_gpl:
-		warn("module %s%s "
-		      "uses symbol '%s' marked UNUSED\n", m, e, s);
+		warn("module %s.ko uses symbol '%s' marked UNUSED\n",
+		     m, s);
 		break;
 	default:
 		/* ignore */
-- 
2.25.1

