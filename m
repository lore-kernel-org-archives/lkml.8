Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A9820717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583514542;
	bh=iDBSFL/JrgLYjgShAoW3V/HC0dDpvZhItZ9MMJMwJUg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tM8rAlfr4hhZ4fcja79R9lIeQ3WukIhoaOGmQw2Q72mbwUlNN/I5bgxffpYsWSOWF
	 +LytqIpuYxj88q8mjfwV0IZdvlzlj/Kc+wW4AjIcDQh9vn1d4aQsJPYw8NGDqVxmGP
	 9UjpAQA3mVeQJYs7aF9K4XI3v2hpCfRZjSOO/9jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCFRJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:09:01 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:31048 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFRJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:09:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 026H8r3X022896;
        Sat, 7 Mar 2020 02:08:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 026H8r3X022896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583514534;
        bh=dX7KkYXULgzx8g5CD/y+Pj6tm++eBD7NUDEAVoHN7Aw=;
        h=From:To:Cc:Subject:Date:From;
        b=ManCIrDUkyS6cD3+B1Zq2T7YG4g8wopZxMxjSn6bFDb1cmAkxMrUe2ixKPGdp6qet
         p8T6b4bHva1Eby0Z3dXlBzKYxr5WyUN56GwQ+8BEO5cuL6yDdOMrscThDnIUW7aIRr
         GJiq5AP2W7zZLs7B/gbG96jj1yqhhHSItfS3+BGJFUOw+7bNWsdTtcFf5baXPenmQ3
         D8aIlTntvNZRB4vLurYBHKe5uadn7NX6WjXCJgW9BNMs0/9tRAtC6qly6K2vWLg+A4
         MLaaccv1Tbf/v9z31av4phSQPROfvY10rQDMqv6iV38/mh17NuTa5GfxuZvvEWp1L4
         V0xMo+uKK8ODQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/2] kbuild: compute the dtbs_install destination more simply
Date:   Sat,  7 Mar 2020 02:08:51 +0900
Message-Id: <20200306170852.17798-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'dtbinst_root' is used to remember the root of the in-kernel dts
directory (e.g. arch/*/boot/dts), but it looks clumsy.

I prefer using two variables 'obj' and 'dst' to track the in-kernel
directory and the install destination, respectively.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 2 +-
 scripts/Makefile.dtbinst | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index f68d05ee2900..be237edd2c7f 100644
--- a/Makefile
+++ b/Makefile
@@ -1253,7 +1253,7 @@ dtbs_check: export CHECK_DTBS=1
 dtbs_check: dt_binding_check
 
 dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
+	$(Q)$(MAKE) $(dtbinst)=$(dtstree) dst=$(INSTALL_DTBS_PATH)
 
 ifdef CONFIG_OF_EARLY_FLATTREE
 all: dtbs
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 7301ab5e2e06..fcd5f2eaaad1 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -13,8 +13,6 @@ src := $(obj)
 PHONY := __dtbs_install
 __dtbs_install:
 
-export dtbinst_root ?= $(obj)
-
 include include/config/auto.conf
 include scripts/Kbuild.include
 include $(src)/Makefile
@@ -26,13 +24,11 @@ dtbinst-dirs	:= $(subdir-y) $(subdir-m)
 quiet_cmd_dtb_install =	INSTALL $<
       cmd_dtb_install =	mkdir -p $(2); cp $< $(2)
 
-install-dir = $(patsubst $(dtbinst_root)%,$(INSTALL_DTBS_PATH)%,$(obj))
-
 $(dtbinst-files): %.dtb: $(obj)/%.dtb
-	$(call cmd,dtb_install,$(install-dir))
+	$(call cmd,dtb_install,$(dst))
 
 $(dtbinst-dirs):
-	$(Q)$(MAKE) $(dtbinst)=$(obj)/$@
+	$(Q)$(MAKE) $(dtbinst)=$(obj)/$@ dst=$(dst)/$@
 
 PHONY += $(dtbinst-files) $(dtbinst-dirs)
 __dtbs_install: $(dtbinst-files) $(dtbinst-dirs)
-- 
2.17.1

