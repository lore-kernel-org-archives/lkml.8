Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51528C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C8820787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335102;
	bh=GEn50ZqSj70RL5+2LuZKVFCwXcmdPQISzM7/zU2Po98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XojB77A3KyugdD3mPDrIM531lNjfgzYEro7cMHuRBFSEeNzJHh3UEDST+0D327SEo
	 pQ0NC8rKZTfJvQbMs90G8QDuSsGY4+NY6sNQbOCLCd3AgUJWI/80sxfKYcSf3I/lCT
	 S5QROR+fduEQFtAtapMBnHMIQXsWtAtJCaDSaseI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEXPo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:44:57 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19699 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcUu017561;
        Mon, 25 May 2020 00:42:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcUu017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334964;
        bh=+QWobT3EgOenGYNYTgdtjHSb52oUpu7V4hA//icuG9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCZpQj+XxTMvU3MjtmUECGGNNIxeSv+7S41E1+thOGFHCAjrl+LDHccMrt7kd1LsX
         xDriAvGwaa6UP5Ko/cNYsgzPMS+beH3qK2FrCekTeS469WT9852QuIHZdFR2IhifEX
         VQhWh44ZBawRWmu5+b9nyWQs4/tbtcdagBey/YBFC2EqV3oucsWTBUAC+7GHYezwq7
         qHhie8eC5wetyo+79mrQ++ZsaAkAvCKddgt2gpglpRZH3fRQ6oo0H7eY80GvT35Lin
         2joGskQDUPXAL6uRJ7W+hHcKKibn5DGac0OttWrKQP795+g1KXrAgJmYS1728BEWdZ
         RhpsFBhrK+MZg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/29] modpost: pass -N option only for modules modpost
Date:   Mon, 25 May 2020 00:42:17 +0900
Message-Id: <20200524154235.380482-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The built-in only code is not required to have MODULE_IMPORT_NS() to
use symbols. So, the namespace is not checked for vmlinux(.o).

Do not pass the meaningless -N option to the first pass of modpost.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/Makefile.modpost | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index da7730a43819..bc5561aedb24 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -53,7 +53,6 @@ MODPOST = scripts/mod/modpost								\
 	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))			\
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
-	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N) 	\
 	$(if $(KBUILD_MODPOST_WARN),-w)
 
 ifdef MODPOST_VMLINUX
@@ -66,7 +65,9 @@ __modpost:
 
 else
 
+# modpost options for modules (both in-kernel and external)
 MODPOST += $(subst -i,-n,$(filter -i,$(MAKEFLAGS))) -s \
+	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N) \
 	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))
 
 ifeq ($(KBUILD_EXTMOD),)
-- 
2.25.1

