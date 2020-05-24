Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54ACC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C778207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335087;
	bh=y4LDN2cptklG/L3OvtbLFAtwBB06/jbLreEh7H/ewyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wrGi1r8DN9U23KdVmh66BCa9BC+MJV4NfexU32RGBZffiyGUYf3YNs9JNF4GCwFu+
	 pGqyV3zX8sF5K/jL3J0vtKam9UBf7PiQEpQaHJDb5rBxslTGn2u0/CG31ijBa9RP7J
	 crBBM5c/xP6GlNPLvI7UpMxjJ8t9eqOdthkEZ1ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgEXPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:44:47 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19707 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcVD017561;
        Mon, 25 May 2020 00:42:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcVD017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334974;
        bh=MpjBywKi5hvRtpRuPaWkkgxcSAed2a9OTbmkoaxhCOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2vNDjNRqakTzs8Gw8isSeCoAbEkvZM631ReC3jWX+3Fzid2JYZcLbRnBx50rS415
         /Une6cVawj2dEv1Gp+/wIZYdo92yDn0tJawcO85V1bCmFOojXr7/jDC0e35NWmhiYd
         6MeKgU3i01VR+r+Zr0CMdQ4kSJeHcrYU2xaN5vJleYlOY6W9W5V8aYQL8Z9FpwyzSu
         hm1FYjmv3T93A/szJT4MRbMv9tnd/HWfw+gNpC3z/pDe59Da08peQmJ7I/bSVP3LEd
         kxumSLprm1EHR8tKkTQu3OFVbD7cZcozlN7TKdwMtLboKjQ2bBW0QF7dDDJxQaKmft
         whDlgFGMr3wFg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/29] modpost: remove is_vmlinux() helper
Date:   Mon, 25 May 2020 00:42:34 +0900
Message-Id: <20200524154235.380482-29-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that is_vmlinux() is called only in new_module(), we can inline
the function call.

modname is the basename with '.o' is stripped. No need to compare it
with 'vmlinux.o'.

vmlinux is always located at the current working directory. No need
to strip the directory path.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c783adbfc34..527f71b662b0 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -90,20 +90,6 @@ static inline bool strends(const char *str, const char *postfix)
 	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
 }
 
-static int is_vmlinux(const char *modname)
-{
-	const char *myname;
-
-	myname = strrchr(modname, '/');
-	if (myname)
-		myname++;
-	else
-		myname = modname;
-
-	return (strcmp(myname, "vmlinux") == 0) ||
-	       (strcmp(myname, "vmlinux.o") == 0);
-}
-
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
@@ -180,7 +166,7 @@ static struct module *new_module(const char *modname)
 
 	/* add to list */
 	strcpy(mod->name, modname);
-	mod->is_vmlinux = is_vmlinux(modname);
+	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
 	mod->gpl_compatible = -1;
 	mod->next = modules;
 	modules = mod;
-- 
2.25.1

