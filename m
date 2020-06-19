Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801DA207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582636;
	bh=liyTA4Cwj4/z7SvWprlbVSALIDf+Z2si5KgMeueUxGQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NkggVI68ZGaR8G1cq8NRqozQHH+rS1n+XkBSkWj4DJBN3CN3TpVxBj72y/qzP+SEr
	 o8G2pbFhQTyjfHG56mOrMQT4A3Cg2Vs+jz6ZavDnk3RwK6X8vQ7vBEW2HEACQXn4p7
	 m/8PYAfMksDh6B7lpf+bE5u1+971/ijm4WvITy5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392090AbgFSPLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:11:15 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:53361 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391351AbgFSPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:11:05 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 05JFA0TO003778;
        Sat, 20 Jun 2020 00:10:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 05JFA0TO003778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592579401;
        bh=+TnARtnceYuO5resxwSI80CrcBwzGNK3O4AoiEU1u1I=;
        h=From:To:Cc:Subject:Date:From;
        b=1cPNYMFjZC2GqfERRfi1r/aXkaHG3jYk3jvmIGqIPk0duuZ7tJp33kWmLrSQP49iC
         STLxvC+m/ml7tBoBOAq82q5ldYJDCWo7nl/krw/0slr7rDhzrG+cBmoE1ulBSCJxMD
         Pk8TzXkjpPUW2JDw+ht3IbqKDxvh/lQLdqC+uBmEPpIzDBBjE0VEuP7I0L3cE6s3fb
         Unm3+qfynk0tv27kHre8oos7AH+NObK3Ziu6wMS3ACgK7EQCCCaRpBHereJssV7kgA
         7pQwlDoa3P215oOZ6sLrZKebVpCLtlIwEqnA0Mljn1jucdaXsfWCowdyQojC44XXx5
         Z+Ir36/KZxp3g==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "Makefile: install modules.builtin even if CONFIG_MODULES=n"
Date:   Sat, 20 Jun 2020 00:09:55 +0900
Message-Id: <20200619150955.13417-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e0b250b57dcf403529081e5898a9de717f96b76b,
which broke build systems that need to install files to a certain
path, but do not set INSTALL_MOD_PATH when invoking 'make install'.

  $ make INSTALL_PATH=/tmp/destdir install
  mkdir: cannot create directory ‘/lib/modules/5.8.0-rc1+/’: Permission denied
  Makefile:1342: recipe for target '_builtin_inst_' failed
  make: *** [_builtin_inst_] Error 1

While modules.builtin is useful also for CONFIG_MODULES=n, this change
in the behavior is quite unexpected. Maybe "make modules_install"
can install modules.builtin irrespective of CONFIG_MODULES as Jonas
originally suggested.

Anyway, that commit should be reverted ASAP.

Reported-by: Douglas Anderson <dianders@chromium.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - add more commit description

 Makefile | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 29abe44ada91..9880e911afe3 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,16 +1336,6 @@ dt_binding_check: scripts_dtc
 # ---------------------------------------------------------------------------
 # Modules
 
-# install modules.builtin regardless of CONFIG_MODULES
-PHONY += _builtin_inst_
-_builtin_inst_:
-	@mkdir -p $(MODLIB)/
-	@cp -f modules.builtin $(MODLIB)/
-	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
-
-PHONY += install
-install: _builtin_inst_
-
 ifdef CONFIG_MODULES
 
 # By default, build modules as well
@@ -1389,7 +1379,7 @@ PHONY += modules_install
 modules_install: _modinst_ _modinst_post
 
 PHONY += _modinst_
-_modinst_: _builtin_inst_
+_modinst_:
 	@rm -rf $(MODLIB)/kernel
 	@rm -f $(MODLIB)/source
 	@mkdir -p $(MODLIB)/kernel
@@ -1399,6 +1389,8 @@ _modinst_: _builtin_inst_
 		ln -s $(CURDIR) $(MODLIB)/build ; \
 	fi
 	@sed 's:^:kernel/:' modules.order > $(MODLIB)/modules.order
+	@cp -f modules.builtin $(MODLIB)/
+	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
 
 # This depmod is only for convenience to give the initial
-- 
2.25.1

