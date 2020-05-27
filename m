Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF3AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02A7207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbgE0Ny2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:54:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbgE0NyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:54:24 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYLqs-1jYsGf049q-00VMV5; Wed, 27 May 2020 15:53:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] x86: math-emu: fix up 'cmp' insn for clang ias
Date:   Wed, 27 May 2020 15:53:46 +0200
Message-Id: <20200527135352.1198078-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bSrmojBkHTfwlBXgReUiC68L/lv6zZjqVNBUHsNFg+IGhZRhrGV
 GkkV8WpHw22LMwMARAYsoD5KYA3pBnHFcoLH5dp/x2hSAMrGJi8dChPbY792apwXWnZd7qZ
 jIjJEhxCW7TyMCWq6e4TF4u20TGSW1z/lfJGlEqVJu6zfglnwR4k+xll6LtQsZjRrt0AYNY
 lMD3pl0DIQ5Nn1RISeDUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lnX7E2HrOZE=:FQJKTfvN7qUyJoPZ/9XhYF
 BHoBketx+AjcNfu8zISxSCiEuFElld5XxsZKyouO4UuxkVJX5UJbUSRBNSS2zPdcx1tqe1eYr
 5lLfUjgr6K+z1suXLLiiJEWbR6VNaa90S33XThu00XuzJ4ZUfRW7i2A9WwwigAR3oR5jjnl0S
 8qAzdChCzOarZwq1EmYdcZw5EYnrkNBgHLqnQurRz2wk3+XSDaJyF+AoXW1im396iIrM6XeyZ
 pim7zL+SIdCRqnCynq0Y0gqppBcselctb9eb4GldF8BznfGXzlWrzC0NDHjypcSZ+UF0aJ5SE
 mzqyq8Ut3RKvELOYDAEofKljsX7hcSP1wQWDutZn2pmadfNyg/5+bRwCV9xierE6Hl0KeKvPI
 B+p3ZQrTPf4wTxead11PdWu0QX4gxK6ie1cWxtKYF78QqZUY/RMiHQy8/IvB8BHPDoZez0kQS
 I8VBI3DtBqLDXR8Zr9j81ppkoEE9pNetsYgxp5RaRxxM9klNgnWm0xKKBDh8ea8mvTSH/d+iA
 RSbvbtp0x9Dsc1IJ2SIdSRcrwrsdHfe/cjdMnjoDkbq3FweSgHg/pvnIylD4Q1+kvH4yZ4tqO
 cdzTFxVzNauQka5xtd/67AW4eRtN05mA4mf2R3e+4S9az6jn6bYtdEia6AnMfY0Fa1FLQd9se
 YMi3qZvuywzqlFAuFEDjFs/lWWnyjyNyq9w1moyIlPNdWNE8xLijzCyxxZXJ1qloHg3Pp9kLo
 o35PzC6xAQXDjcxzCx3i7meueFIaU8Woyz3uad7d6wOb74hFhme11d1kd5mAfq2szTKiapUum
 9s0OMIfFXXp18flKMpOEKpJlSZam6A25qkIIAEuKL8pCC7m/mI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang integrated assembler requires the 'cmp' instruction to
have a length prefix here:

arch/x86/math-emu/wm_sqrt.S:212:2: error: ambiguous instructions require an explicit suffix (could be 'cmpb', 'cmpw', or 'cmpl')
 cmp $0xffffffff,-24(%ebp)
 ^

Make this a 32-bit comparison, which it was clearly meant to be.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/math-emu/wm_sqrt.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/math-emu/wm_sqrt.S b/arch/x86/math-emu/wm_sqrt.S
index 3b2b58164ec1..40526dd85137 100644
--- a/arch/x86/math-emu/wm_sqrt.S
+++ b/arch/x86/math-emu/wm_sqrt.S
@@ -209,7 +209,7 @@ sqrt_stage_2_finish:
 
 #ifdef PARANOID
 /* It should be possible to get here only if the arg is ffff....ffff */
-	cmp	$0xffffffff,FPU_fsqrt_arg_1
+	cmpl	$0xffffffff,FPU_fsqrt_arg_1
 	jnz	sqrt_stage_2_error
 #endif /* PARANOID */
 
-- 
2.26.2

