Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715FC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B33D2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580885548;
	bh=Pz7yOFCk8uvaR5fC9HvpCZaDNCpKkJdjj6S/BYXw3FU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BtcRVmsq0EPr0nSCD/cAQAZUVR01Tc2vySmd922E3FVkelcdrLc9z5gsTcP8NOLWb
	 ICKPGYIARzF3VzgA1gSkb7y7hiD4NSilmivsU8ZJ2CMxcNJ0db5+kY/sUxxucgdpXj
	 b67rfflPLPAcboaT3WdQqJOMJU6l5gqcm9qeaxls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgBEGw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:52:28 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:24774 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgBEGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:52:27 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0156pvIw013204;
        Wed, 5 Feb 2020 15:51:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0156pvIw013204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580885518;
        bh=SQLIo/CN+y8L0OepweOpNyV3Tsh+znSRoDYXyHAL2bc=;
        h=From:To:Cc:Subject:Date:From;
        b=jrzonPyH54xW+kntgU6q1kD4t7esoeqlX/P+JEVJ4PxUBV4oLckYFU8JOLrfN/jgW
         1WK05cGazownMi2SeWzvvatFE1HWtDS220NOdQF3b59bTJdkEPN2PWBozgccNC/wIf
         nTbmRMGeHvHV9+dLMIGcBu0Rvp22UtOFQmyK/+SI9z2rVwWmSjOOrxIyQ8EhSolEEj
         TnMZfsgxBuNmodgVnpbdjA5qyMAstnEETYWj/vvo6W8CK73enNef0B5uJQunmzC9w5
         xF2D0kyIeVLSSBPGip3M5XDLLS5cP8pLQGVC6U0xKImH1r5BaDnUMB6uDGcEIgnb+Z
         X/WxsQPwuyfNA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: make multiple directory targets work properly
Date:   Wed,  5 Feb 2020 15:51:52 +0900
Message-Id: <20200205065152.873-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the single-target build does not work when two
or more sub-directories are given:

  $ make fs/ kernel/ lib/
    CALL    scripts/checksyscalls.sh
    CALL    scripts/atomic/check-atomics.sh
    DESCEND  objtool
  make[2]: Nothing to be done for 'kernel/'.
  make[2]: Nothing to be done for 'fs/'.
  make[2]: Nothing to be done for 'lib/'.

Make it work properly.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Linus,

If you want to use this patch soon (seems useful since
you are travelling), please feel free to apply it directly.

If you wait for my next pull request, I will apply it to
my tree.

Either is fine with me.



 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 65a5dc653deb..ef8913a8eb2a 100644
--- a/Makefile
+++ b/Makefile
@@ -1679,7 +1679,7 @@ PHONY += descend $(build-dirs)
 descend: $(build-dirs)
 $(build-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@ \
-	single-build=$(if $(filter-out $@/, $(single-no-ko)),1) \
+	single-build=$(if $(filter-out $@/, $(filter $@/%, $(single-no-ko))),1) \
 	need-builtin=1 need-modorder=1
 
 clean-dirs := $(addprefix _clean_, $(clean-dirs))
-- 
2.17.1

