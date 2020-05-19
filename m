Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6865CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28321206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgESWJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:09:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESWJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:09:46 -0400
Received: from localhost.localdomain ([149.172.98.151]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mj8Vx-1j5fUO0KHd-00f6z6; Wed, 20 May 2020 00:09:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pass -msoft-float to gcc earlier
Date:   Wed, 20 May 2020 00:08:55 +0200
Message-Id: <20200519220923.1601303-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wV6x9QxzVEAmfgleaEmiJ1+1+ez2lYlhCOI97T7b7A0kktn7leA
 eBNumwgh0dBbKPKtn+41PyK6S+nmES2j2TmO36+gTiFDUB/N9XddcQFPMmz0U7D1mTzzSNb
 MwAp6ICoc/0TD2RKRnDzTHm40zeWhHHW8hv+m2V0GAYVT2cZple0hKqcb0wjc6uJwUU/wnR
 R7UKIdUdosSPE8YD7owUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GczoRTp8Z20=:oElP6mJ4TmvCNUchkcksR+
 2pwnLqRT4T0zcnrSMOQAFu7G6tdX+3MyhN1+8omC9LGIJxSQiiaexTqh/czy/LPRJBRdnS8ui
 htb14BcwzwvGw2tj1DXBpJKDpevif5iU+0qbrryfIi7NkHIzn0E/e91JmBhkMGpA9aDK7qAOv
 DJDEtKvfFevGRlBnstNBQ+TW7jSjky8y3ZxwG3nbOPiJgHwmP12HXHCfEvkQm1hrIDg1ALQjq
 4L4AdTyNNTb2EQMMZ1QVCAHFXL0NbZCYIwUaHtRnD8gWqqb5wZLwyX+JodAUZW/URv/1NmL5e
 Z/Gg0NdIP0yp/PVRrW9ls+JtzAShB9ZwDjacH3GDnr7JZAquKFKUMGJWJLQ/d+gz9pXrbkkr4
 ykAJZE1qB1c7ih2GorSojElV/e+l3U7bKWmkuhCRsF7zsXTNarcj4fxXT+RG5AsBXQLQUvmkm
 LJdit0f/yLMwg3YKC1kEV5y9/l2pRbyeCpvd5ym72EiXbVVulipUn6zrocaWTC8TcCXRLzzHz
 n/PgxQ2QpySb0I30DTW3/RU2FZFoAq0xp/WouJLJLjQnCT33b+u3U5vDrTwU4aN0Mv9+mSYzz
 vBtTbcE3fC23Mbv5a+PuVXZfS1Z0bTau4l915odZjay8hFi95vPbMpFry8dYWzR+qp19gbWcq
 K/tleul1NYY8t+UU/5rY8skb7kPpeSbyf8cLg0wIOJBIvds1qNbMsGv5kcQXqvUJleNaodBp6
 +Hgj2ERR/vpeJj1hwCpA8rD1xLe+cn8Kw9BHMRo6h5hqQOX80F6d/EmFMwFDNPP89H4d88Q0m
 JVNGe4G5fxQLSpcuvoc6hAabeqVMPMT30WUTInGbL2lHjVL8Hw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Szabolcs Nagy ran into a kernel build failure with a custom gcc
toochain that sets -mfpu=auto -mfloat-abi=hard:

 /tmp/ccmNdcdf.s:1898: Error: selected processor does not support `cpsid i' in ARM mode

The problem is that $(call cc-option, -march=armv7-a) fails before the
kernel overrides the gcc options to also pass -msoft-float.

Move the option to the beginning the Makefile, before we call
cc-option for the first time.

Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87302
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7d5cd0f85461..e428ea6eb0fa 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,8 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+KBUILD_CFLAGS	+= -msoft-float
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
@@ -135,7 +137,7 @@ AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
-KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
+KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
-- 
2.26.2

