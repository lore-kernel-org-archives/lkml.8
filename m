Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C071C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4C9206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585984855;
	bh=U3wGVkjYTRHeJBFDIKYpK0zmeJX+yiOJWrr9hXtniIY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=woX0F+L8h2Aqo1rDfPjLl4EvUQqFLQBHXhxsH5VhB0ozs3EjXLypJN0gpFc1tkxmS
	 jbDkHe0koG+BEHbwLJVI1Mr0pHRlSCj1kxcZUrMKtimX20vxwtCxYtYFZnHdhwK2RV
	 ava66nC5psr5J2/KIcvSegrCYA4q0VnuxHRtrerM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDDHUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 03:20:52 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:30630 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 03:20:52 -0400
Received: from grover.flets-west.jp (softbank126093124033.bbtec.net [126.93.124.33]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 0347KcNu020416;
        Sat, 4 Apr 2020 16:20:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 0347KcNu020416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585984838;
        bh=vQOO7N85hXpM+vNvA1qudzQ0tPB0noo15q2Psaauh68=;
        h=From:To:Cc:Subject:Date:From;
        b=oC4Ijy3YJTRA29djl16YM4U4nESrpZI/C4shVNMjFBnHRy4vWEskmDr0kmpIHJ7nj
         UAZ+tn735nfidWuUmvNg/wEGU+dF8irxWw/uKVe4EgkYlo7J0E55x1tv2jKSxL5Sfl
         OqkgW+oJ4t6WzhMR3Hlge+pkQMssjmZcM2bnTmziq5AcMmAQEX8tPCwWtePShXZVS2
         VXhZLmytb6dDPMl42Z6g1s26GgL0GrlATinMGdCZWvfr6502elfDxXOpNq6xDPyRoG
         Pptuy4RXtqVL565gJ9K4MBZ+mFfMrqtBUuTubVrqriv9EqIVhN6HEmMLDltHCQCx4s
         shGNPV8MWBbXg==
X-Nifty-SrcIP: [126.93.124.33]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: remove -I$(srctree)/tools/include from scripts/Makefile
Date:   Sat,  4 Apr 2020 16:20:34 +0900
Message-Id: <20200404072034.15798-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not like to add an extra include path for every tool with no
good reason. This should be specified per file.

This line was added by commit 6520fe5564ac ("x86, realmode: 16-bit
real-mode code support for relocs tool"), which did not touch
anything else in scripts/.  I do not know why this was needed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 5e75802b1a44..da63ba81e9e7 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -5,8 +5,6 @@
 # ---------------------------------------------------------------------------
 # kallsyms:      Find all symbols in vmlinux
 
-HOST_EXTRACFLAGS += -I$(srctree)/tools/include
-
 always-$(CONFIG_BUILD_BIN2C)			+= bin2c
 always-$(CONFIG_KALLSYMS)			+= kallsyms
 always-$(BUILD_C_RECORDMCOUNT)			+= recordmcount
-- 
2.17.1

