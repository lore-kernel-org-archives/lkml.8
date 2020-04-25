Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205BAC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B2320748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587791922;
	bh=j1K62S8pEucAn03WC6C0hd7b4fKQOKT/CAfD5fewpt8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uCmYbbLXL2MwBte8rbJtgPzOQ13WkS/OF5rgPsYMun3zddCg3qa/Ca3k3uGMtEPeI
	 HhXlEQYegwvhBjoWQ6WcEPP0tDQFGjqowUR6aIoGbGEH8AbHdalHRUSANgSlcWAGeL
	 z2hJ/QixU/o8SaReb394q0//v48KttVj3xL4h5+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDYFSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:18:41 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:62627 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDYFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:18:41 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03P5IJQP026359;
        Sat, 25 Apr 2020 14:18:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03P5IJQP026359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587791900;
        bh=KgAwBNo7fb6wRf4pOmAZsdrwSddFEDStxa7L0h2/CiA=;
        h=From:To:Cc:Subject:Date:From;
        b=HIgPF6uQMyfXx3eQHwhyHBgXNO8uvrIqtPNGL1m3bxUuhALx4IyIgdNVTz+ZHp+04
         ZZgoqyk7JPx/z7EMJCuqAHJYGXf2oz8l4pumia9yy3wyu9WlmxBeLP/i/KC5eVsMT/
         ZPL8UqK6ha0cbovJPE+iQlb/IFP6HNuu1CjPJdvN/u83UgabNeZfzDOniaxT3mM1FX
         ewV+7oWFEx/jozCoapHcKYIml3BmHCHXZD912qPD3IfxApkOhb/W6e+GXCQ9nRpwao
         zLyUQ49150VhtcHzyCEc+CDhxKx8bbu9QE7meEqsq4kS5BlPZ6X0E6NGKgkf+fiz6B
         BIpzwZTQh3kQA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] h8300: suppress error messages for 'make clean'
Date:   Sat, 25 Apr 2020 14:18:16 +0900
Message-Id: <20200425051816.791423-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make ARCH=h8300 clean' emits error messages as follows:

  $ make ARCH=h8300 clean
  gcc: error: missing argument to '-Wframe-larger-than='
  gcc: error: unrecognized command line option '-mint32'

You can suppress the second one by setting the correct CROSS_COMPILE=,
but we should not require any compiler for cleaning.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/h8300/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
index 9e2701069bbe..5942793f77a0 100644
--- a/arch/h8300/boot/compressed/Makefile
+++ b/arch/h8300/boot/compressed/Makefile
@@ -18,7 +18,7 @@ CONFIG_MEMORY_START     ?= 0x00400000
 CONFIG_BOOT_LINK_OFFSET ?= 0x00280000
 IMAGE_OFFSET := $(shell printf "0x%08x" $$(($(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET))))
 
-LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name 2>/dev/null)
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -estartup -T $(obj)/vmlinux.lds \
 	--defsym output=$(CONFIG_MEMORY_START)
 
-- 
2.25.1

