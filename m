Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1AEC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B2220857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581864527;
	bh=q7uLioUirz9IpheA+V1S8A3wQLiIkV3Pdj5y1bZLRaY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OK1gzmWUFfvUnqz4zLlhP4eonUU9zWJ0AH5gWto/Bzr/sHqVuFAgdtbC6fmTP8oAz
	 EzNPK5W3vEijZR8YzYHPJF2VeErCEYSMOk66dJdcXNh4MChi5Ce27CHLxP5IguRx2V
	 MVGjlDZR5bQEe0flEF2Mp5kupCMa49GdSbavUFLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBPOsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 09:48:46 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:49712 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgBPOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 09:48:46 -0500
X-Greylist: delayed 38353 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2020 09:48:45 EST
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01GEmYZQ015037;
        Sun, 16 Feb 2020 23:48:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01GEmYZQ015037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581864515;
        bh=Vyd5JSxTjrLPvL01Bjfr560Ppmt5369wS3qADK9v3Eg=;
        h=From:To:Cc:Subject:Date:From;
        b=qAISoSDFYOXFp1FxN+1NZr/i8b13VRQfOetmyvkGy35aCkEf+JhyPOKEvcLxj2bPW
         LpUMCsJb+yncdArQ71y6ZN1wxS7X+gDxthY73/VyrB/qwSne5aFZIGkVzeZHQ9nU9X
         v28pOamqOUdLo5MpCoq5BdGeSG5D3Ehi762kemHxrRhBdeU4Iuf1acyn+SDAGwyiIc
         tcr19Yldk7gaeJS2KI5sBwZkehI51KekEHwADpzAPWtCUniHav8QEyaR0wwhFdzIeV
         kpY6p+6LKrnHyYAMR+JiBxPYD8qUUkxcajRjBlSrwH5oot2yNvyMbI+7I1SMK3psNz
         tacTV4isaDarA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: make 'install' not depend on vmlinux
Date:   Sun, 16 Feb 2020 23:48:29 +0900
Message-Id: <20200216144829.27023-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the same reason as commit 19514fc665ff ("arm, kbuild: make "make
install" not depend on vmlinux"), the install targets should never
trigger the rebuild of the kernel.

The variable, CONFIGURE, is not set by anyone. Remove it as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/Makefile      | 2 +-
 arch/s390/boot/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e0e3a465bbfd..8dfa2cf1f05c 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -146,7 +146,7 @@ all: bzImage
 #KBUILD_IMAGE is necessary for packaging targets like rpm-pkg, deb-pkg...
 KBUILD_IMAGE	:= $(boot)/bzImage
 
-install: vmlinux
+install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 bzImage: vmlinux
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index e2c47d3a1c89..0ff9261c915e 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -70,7 +70,7 @@ $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
 $(obj)/startup.a: $(OBJECTS) FORCE
 	$(call if_changed,ar)
 
-install: $(CONFIGURE) $(obj)/bzImage
+install:
 	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 	      System.map "$(INSTALL_PATH)"
 
-- 
2.17.1

