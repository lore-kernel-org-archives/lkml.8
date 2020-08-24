Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8BBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E182075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261762;
	bh=KZ2BHr07enCjNMSNg4VFxmSoSjAQSayzoOOA9Gb1oIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0mhDXniDfVGyITuRNNjzWk7Pyt2MFpdajlXm/C8Z0wiPLg7WjMhyC2vHHMAhB78k
	 SsbFkFSDjVlR26xYNlEoguNUYS2ewTqhoJhpoMUlnJMamINVRNBklLOXKVwgwgMUns
	 8tcHb8ovKjMMjlJDjcLcT3slg2k5JvChui++OqZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgHXJgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbgHXIsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:48:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADD7204FD;
        Mon, 24 Aug 2020 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258931;
        bh=KZ2BHr07enCjNMSNg4VFxmSoSjAQSayzoOOA9Gb1oIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejdRWHlz0G8PnS45eM1lHdL79wiA07mU1McIHuUlSYFxLLZMeW/C9yR9eaznRrOtm
         G8EaFZsOySwp5X6AwzgqYnNmZj1C+WIMcrc16pvTti5dPecTNBe7/lOHkOeEGMm620
         Q8RMAcspwZ4cZ6lCjm+PrkW353R1ePr58Nj1FCvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/107] ARM64: vdso32: Install vdso32 from vdso_install
Date:   Mon, 24 Aug 2020 10:31:02 +0200
Message-Id: <20200824082409.850105593@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 8d75785a814241587802655cc33e384230744f0c ]

Add the 32-bit vdso Makefile to the vdso_install rule so that 'make
vdso_install' installs the 32-bit compat vdso when it is compiled.

Fixes: a7f71a2c8903 ("arm64: compat: Add vDSO")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20200818014950.42492-1-swboyd@chromium.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Makefile               | 1 +
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d65aef47ece3b..11a7d6208087f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -146,6 +146,7 @@ zinstall install:
 PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 $@
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 76b327f88fbb1..40dffe60b8454 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -190,7 +190,7 @@ quiet_cmd_vdsosym = VDSOSYM $@
       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
 # Install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
+quiet_cmd_vdso_install = INSTALL32 $@
       cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
 
 vdso.so: $(obj)/vdso.so.dbg
-- 
2.25.1



