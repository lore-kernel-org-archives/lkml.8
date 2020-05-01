Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FBFC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 06:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECB32070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588312935;
	bh=fjxO29s3fMRS8RHF3y7tjdoDNW7QReg78iJ8tzaU9ZE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iIvH3qotaPSE5yf4tH/eGbrZwo33fvZhE1g9XmV4TKHEtgaxmZr4kpDti8eLOuIgb
	 artp8gB0Wpaksz9z3R6/2MdU54vyL8UVkCd0PBV5ry+ojm0dpr331ImEFaZRuUSEfB
	 cwB0hZDQmJy/7lhKvCu2RVJC+a7n6hVur+yaKtn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgEAGCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 02:02:15 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:37642 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 02:02:14 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 04161hVg014581;
        Fri, 1 May 2020 15:01:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04161hVg014581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588312903;
        bh=yTZNYHQtPbMeCpcIyjfdklxtVVJs41vlWoODKcjffw4=;
        h=From:To:Cc:Subject:Date:From;
        b=ntNjf0qCPCGGztpWKkm7EiPzZ2Swvw/EagQYh5g2jRHT/x+bGAajjM2RVTgXiuWFC
         q7gzLLZub3t3yXCMh7LooIkR8FtAuS/dj2r2hqS6mb1qBw8AT9T24z1eyDL1VGScWq
         GKD/unkont9M9z2+D1nMNDHrx4SnqO32YZIDY69zbQ7UFXuVA3oOUYIGeYXGnQdyhh
         xjEQG6gSRWRai/WPaXc5NvapFkIcvTjTpXuAKpvEOUPvNTEHCFnI8Nlg7AAxSLXcVa
         7nzbXRK7SjZkEKVqtplAlqZpaYlzQsHPufw/edoFhWcNhF4NPre5NfwBVUktSJm+0x
         jNyhq0n6YQ6rw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: invoke syncconfig if autoconf.h is missing
Date:   Fri,  1 May 2020 15:01:41 +0900
Message-Id: <20200501060141.1924489-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If include/generated/autoconf.h is accidentally lost somehow,
there is no clear way to fix it. Make it self-healing.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9ff00bfe0575..f0b6f9fd5d25 100644
--- a/Makefile
+++ b/Makefile
@@ -698,7 +698,7 @@ $(KCONFIG_CONFIG):
 # This exploits the 'multi-target pattern rule' trick.
 # The syncconfig should be executed only once to make all the targets.
 # (Note: use the grouped target '&:' when we bump to GNU Make 4.3)
-%/auto.conf %/auto.conf.cmd: $(KCONFIG_CONFIG)
+%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
 # External modules and some install targets need include/generated/autoconf.h
@@ -1141,7 +1141,8 @@ scripts: scripts_basic scripts_dtc
 PHONY += prepare archprepare
 
 archprepare: outputmakefile archheaders archscripts scripts include/config/kernel.release \
-	asm-generic $(version_h) $(autoksyms_h) include/generated/utsrelease.h
+	asm-generic $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
+	include/generated/autoconf.h
 
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
-- 
2.25.1

