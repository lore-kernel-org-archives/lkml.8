Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E8C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD3E2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581748464;
	bh=6RlS6eKm0NFSMB3TYCkELt0wwMa+pkblkKEGCkE6pnA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JGdf8SEUqhKIs1pKg9M+l8RPThv2NTWRf5imTJ40KHXrV3BybkAkCDFmhz5sS3OzQ
	 euvRpmT5hDXMBNF9k1SE1MvNgy/TYtv5/qurQDZj4NkZCdc+eW/3j5iDxSV0bX6HoW
	 xqANEpHLAxs73AklUJ1uhbDtJsmhJ8FtL103whHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgBOGeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:34:24 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:26901 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgBOGeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:34:23 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01F6Wg5o007887;
        Sat, 15 Feb 2020 15:32:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01F6Wg5o007887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581748363;
        bh=IclY7pROq2vL2OPH7mncc6pGGCJbmdt+12gMSec8nfM=;
        h=From:To:Cc:Subject:Date:From;
        b=G/jnWQ3E4CPiO6bvR7qoHSfhff73tadYBRObpOcc21iDxFvK4F42pAk3eHLPR3PxF
         Plpk55qyb/NTKUdOpehQ2mTWpVaIu4qHjYNE1HGbH1WGs09Ysm2QDoctVUHUn7qyJx
         2c60wRzQtdFxvbDOPzzmsDlJdAZLQ7b6gQksV0mRAzkJgnERsbXFufcAG9fVbbkFcS
         jg7Zs0qKPdH5zgVbPLQW6hm9AV4NP0P5Sklygin9LFGGQPib4VFW4DKMPDOr2Lyv0T
         XKNcXchalVU/u1I5TGcub7MTFuxOjTpdKwLkWMPcXhbMF0pU26AA+vo74NV16LcPDQ
         51v0o00whMcUQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ross Burton <ross.burton@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/build: add cpustr.h to targets and remove clean-files
Date:   Sat, 15 Feb 2020 15:32:41 +0900
Message-Id: <20200215063241.7437-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files in $(targets) are always cleaned up.

Move the 'targets' assignment out of the ifdef and remove 'clean-files'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/boot/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 012b82fc8617..050164ba3def 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -57,11 +57,10 @@ $(obj)/cpu.o: $(obj)/cpustr.h
 
 quiet_cmd_cpustr = CPUSTR  $@
       cmd_cpustr = $(obj)/mkcpustr > $@
-targets += cpustr.h
 $(obj)/cpustr.h: $(obj)/mkcpustr FORCE
 	$(call if_changed,cpustr)
 endif
-clean-files += cpustr.h
+targets += cpustr.h
 
 # ---------------------------------------------------------------------------
 
-- 
2.17.1

