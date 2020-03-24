Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5037AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3820774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585066556;
	bh=fA1JJKMofWJEx5DohIMNQeXpdvtKHYgV6SRUsJoXH6I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JwxIsGft0pY4SbicHtlyVqHV4Iqrew60oXJHQsaN61Wa67SIA1iPRRFrnGGHFLbQA
	 kE548DKw5IHBVMfsRHG0va298gxOOcY7e1S9QriAnsrYUKaKvg9rCMhvUIJ1auB/Jb
	 H95nnZFiOFytS6d7RT6xMDuLp96fKsHG6Gr9bG/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgCXQPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:15:55 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:42697 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:15:54 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 02OGFI4f014851;
        Wed, 25 Mar 2020 01:15:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 02OGFI4f014851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585066519;
        bh=iERwpFIUsMeWrqbzCfka8i/KOvDD+eMi426uZLpMpHs=;
        h=From:To:Cc:Subject:Date:From;
        b=HXOoZPB4Hwl4LYPMuSbWnvmygN12M5DXYXftprC3eIeSln7gRtCZvphhqcjYmhId/
         xVAFwaTJkW1Xg536IDeBxSf54E5fj+SGrgnTaQLUvqGIAng52OBY9HYgw1HcSY5aNv
         jvB3y1Is+Sopc753kBeDlig5tJiY3fvZZjZnKO0mlcbUy5S10OtXwR2H5yX6dzam8i
         aEg0V8TFeH7F9ylI5yo4UtybZ9lBmF4xcUAXrsULI/Bzqg0m3MICo5pmHcJpMgmjIT
         SOzgRVBqelRi4jitECkgl/NtCL30nFx/mzWc1TQhBuTqr3Hb7Fjg0eoCPZt0qa1hi+
         eIpNkGE0PkvPw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] kbuild: remove AS variable
Date:   Wed, 25 Mar 2020 01:15:07 +0900
Message-Id: <20200324161507.7414-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 5ef872636ca7 ("kbuild: get rid of misleading $(AS) from
documents") noted, we rarely use $(AS) in the kernel build.

Now that the only/last user of $(AS) in drivers/net/wan/Makefile was
converted to $(CC), $(AS) is no longer used in the build process.

You can still pass in AS=clang, which is just a switch to turn on
the LLVM integrated assembler.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 16d8271192d1..339e8c51a10b 100644
--- a/Makefile
+++ b/Makefile
@@ -405,7 +405,6 @@ KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 
 # Make variables (CC, etc...)
-AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
 CC		= $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
@@ -472,7 +471,7 @@ KBUILD_LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 CLANG_FLAGS :=
 
-export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
+export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP OBJSIZE READELF PAHOLE LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
-- 
2.17.1

