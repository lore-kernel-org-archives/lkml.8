Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2095EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10A42065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589708984;
	bh=9LI3JIVQiKmqDC/p6tUdDJL8PK7qoZyG8zRAVS3e36Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tOk5qxRh0ZUojjWR0fcfXt/eXsI78M5T2rmvWFInBCRQb13XDYsE7RKO18XdDj6iX
	 2aKjMQ25Fm+cm/lFKHysVvpHemNgweXql/QN8P/F+Az6Ix0JgPhhuP2H17rhXysSVa
	 Lk0oNlK7KoJzCikEPtpUyFav8ltcvlvu8nCAFFkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEQJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:49:38 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38300 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgEQJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4L8018560;
        Sun, 17 May 2020 18:49:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4L8018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708952;
        bh=FlAOnLT1LqdsWObR2ysUopltjBbbvrDg4vQLoWIKAiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15HD2aatotT/Wjw8EgUJG1wCfqw3VQiTGoP2bj8XBPxv6XR3djsRvTp2yL7CZvcF7
         /XHrt/3ZHj+fUMyXt7uyQlDk4xAIxp5sXvs1LjwPkeph13YAhKHKBuwruMTJRa40VX
         OgMkooKQB6EWdPyVom8bM0BWFd7xH12Y4p2duU7mPw8ZVoA2+jiI17S22mkNx1mviy
         pOoi9wllTF+OVgbn4/Y9VOTjGAqHxgUSpWRIIHR/nXa3VyRdoaIk1aw6bWNWs8k4BW
         DmiAo87ktf34SFg1idzcBZUTdDONFniFvPnxn1hlmnTcsu3xTNucMgPclPp+l+ZJIt
         S817cL6f1YiQA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] modpost: pass -N option only for modules modpost
Date:   Sun, 17 May 2020 18:48:41 +0900
Message-Id: <20200517094859.2376211-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
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

