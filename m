Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4A1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 00:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9437206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587947543;
	bh=Tu1a0Zvu15U3Sg++Y3IQJB7ywKNRmfwbTCLFTWgEf2U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dU8o6K1uamhGO3JHoL6dBN4dbtL23xi7hA1QVqQQYL6KE4LMMGGBoklo4DXxyuQkm
	 qN7e3Tlof0OL97YBJxVqWkrcMl2gp0gK5ykLU2Qo4pm1O+Psc1OeUAE+0z4bla8d76
	 /r5UaIc1sBZYCHYRXWUpMEGjoVspEooTZ2dQVBO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgD0AcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 20:32:23 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33302 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgD0AcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 20:32:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 03R0UU6B004529;
        Mon, 27 Apr 2020 09:30:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 03R0UU6B004529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587947431;
        bh=/hnzYFLI9+qR1davcKYHLKruhyO2aUJ2eWiG1hDurfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=T3RySsHK8hJijhax1EOM8uNKiEbMvrRhOJ9gaeG1NRoey93aTWPkoyqCDgR0XmsHJ
         De4ebIvjWZeobnHaElfetMZoeMmbK6lvP5novgD+JcjdyAQ6KbzLBBcgY90tDqHjDc
         lwkjQSHl1ct++HGoUYlTVNS7JgK3X9OpZrxhS/4EI7tccSZeJk6/NgS84TjhdxDAez
         Gis1QU1rgOW4/otBN2DS45iD6AI8aDrHkw6Qly6o1cDKiIztE8YJ4dbhR5vlwzvWXd
         GVcfJzbQCLETTJxnYUWPC9aygE8t+p9MO0qBPDUlrfDO0pasiMIfyCzpIWXQdioPrF
         bha6OjcZpRuPA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unused AS assignment
Date:   Mon, 27 Apr 2020 09:30:19 +0900
Message-Id: <20200427003019.2401592-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(AS) is not used anywhere, hence commit aa824e0c962b ("kbuild: remove
AS variable") killed it.

Remove the left-over code in arch/{arm,arm64}/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/Makefile   | 2 --
 arch/arm64/Makefile | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7d5cd0f85461..cd28211f1418 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -45,12 +45,10 @@ endif
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
-AS		+= -EB
 KBUILD_LDFLAGS	+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
-AS		+= -EL
 KBUILD_LDFLAGS	+= -EL
 endif
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 85e4149cc5d5..d86cc9137539 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -84,7 +84,6 @@ KBUILD_CFLAGS += $(branch-prot-flags-y)
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-AS		+= -EB
 # Prefer the baremetal ELF build target, but not all toolchains include
 # it so fall back to the standard linux version if needed.
 KBUILD_LDFLAGS	+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
@@ -92,7 +91,6 @@ UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
-AS		+= -EL
 # Same as above, prefer ELF but fall back to linux target if needed.
 KBUILD_LDFLAGS	+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
 UTS_MACHINE	:= aarch64
-- 
2.25.1

