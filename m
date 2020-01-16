Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1406C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200506;
	bh=ds3K/+Shpqm/cw3bLKGdAoAuyM1oYw+f5Ag3IkVPWAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IY349nLW8X/D3g83CPSprAIO+4InSne5Mix0Ezn0p9W9jEprFhMX85XIBj55T+rrg
	 qF29QtpAG2VqUDYmoFmlsNcLgruTVvZjS7Dg1ref5JKZO/R5vbBFZ+kP9mhcrTJhB9
	 yAwhjFyGW4QZGiqnBYYQyxptPilXtmXIsqmyPi80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395467AbgAPSsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389752AbgAPRJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231B8206D9;
        Thu, 16 Jan 2020 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194588;
        bh=ds3K/+Shpqm/cw3bLKGdAoAuyM1oYw+f5Ag3IkVPWAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quaA4PiILbj4XbPKVWBigMMPc08Pe4KpkTeztuF/UZu3Az989FRY4eWyJsvdY0uNY
         P2wL9OIZ/X9ZqPyoG4jRZ767Cy9SwVJ7xjlZk+uDkyF436qk0d92QD6yh2luylNMEZ
         VY9MtUFpTMyNBFv8CjYWixWRdYGi/759EmUqGwBg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 460/671] x86/pgtable/32: Fix LOWMEM_PAGES constant
Date:   Thu, 16 Jan 2020 12:01:38 -0500
Message-Id: <20200116170509.12787-197-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 26515699863d68058e290e18e83f444925920be5 ]

clang points out that the computation of LOWMEM_PAGES causes a signed
integer overflow on 32-bit x86:

arch/x86/kernel/head32.c:83:20: error: signed shift result (0x100000000) requires 34 bits to represent, but 'int' only has 32 bits [-Werror,-Wshift-overflow]
                (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
                                 ^~~~~~~~~~~~
arch/x86/include/asm/pgtable_32.h:109:27: note: expanded from macro 'LOWMEM_PAGES'
 #define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
                         ~^ ~~
arch/x86/include/asm/pgtable_32.h:98:34: note: expanded from macro 'PAGE_TABLE_SIZE'
 #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)

Use the _ULL() macro to make it a 64-bit constant.

Fixes: 1e620f9b23e5 ("x86/boot/32: Convert the 32-bit pgtable setup code from assembly to C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190710130522.1802800-1-arnd@arndb.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index b3ec519e3982..71e1df860176 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -106,6 +106,6 @@ do {						\
  * with only a host target support using a 32-bit type for internal
  * representation.
  */
-#define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
+#define LOWMEM_PAGES ((((_ULL(2)<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
 
 #endif /* _ASM_X86_PGTABLE_32_H */
-- 
2.20.1

