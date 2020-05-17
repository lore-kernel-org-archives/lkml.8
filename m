Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D6720727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589709016;
	bh=69IfyMxmqLWw1M1ODAJ3vLhgv97DFdamqW/cj2cJ6Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EDAHD0wtf4ep1/MokVl/MnLFj0+8QMuMN2xoa+WCewWCo0Ro7Z4bTF0ql/OPAbMsW
	 /MSs1mOBlHyJRKl/6TfYUZBN3tqy+stt8Vc64rG4YETLpEFFPE6JJ57j9A/UCLtVs2
	 5Yk77FzTgLH4Y9jdE1yiEmw+8x2qBCzYYxYkKKXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgEQJuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:50:16 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39055 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgEQJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:50:02 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4LP018560;
        Sun, 17 May 2020 18:49:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4LP018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708962;
        bh=d4uuccwg4a1AZnetOeClGOO3V+MmtQaBZS3DQjl2oq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Obe1PHqjQe7nvWTOAB1LGaVXbXr0CJU6ACHRLxqQkK04vMZGFJRX+xLUnyIWbUDmL
         F3iB9euXSfYo38EGqT7WohE6IjJ3d2hKDD1wRf300aiC8M4eeseGBslyVN45rqu/yl
         1ig4hoL3IbpV83qB5WYNXTQ1BOyjuZN6n7ioJUWMOUNm7aye0H9V3oph4Yg+Rz7QAZ
         FIyhkZXTyhI1cc378FwiBOm+8B0QPedGOQISp3MNDtRUlkmFAdqoOb6DhZqtZVP0lQ
         XDEuSU/vaPzuWuC0rdr/HazQTcMLiGB7NC0NuvRBBmzyWNnf3x8NRYHNttl3DoOEag
         ZplneFZ9UBY4g==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] modpost: remove is_vmlinux() helper
Date:   Sun, 17 May 2020 18:48:58 +0900
Message-Id: <20200517094859.2376211-29-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
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

 scripts/mod/modpost.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6669b3ace968..bcab010f09ce 100644
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
@@ -170,7 +156,7 @@ static struct module *new_module(const char *modname)
 
 	/* add to list */
 	strcpy(mod->name, modname);
-	mod->is_vmlinux = is_vmlinux(modname);
+	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
 	mod->gpl_compatible = -1;
 	mod->next = modules;
 	modules = mod;
-- 
2.25.1

