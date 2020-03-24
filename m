Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4341C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD8F208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585039872;
	bh=m+am+kmwiawifnUnuxkCkvSvL5zjZ1qL8TV5YJi4c8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c9ru2BlAIWPdaX3xlwnErwWM9Oi7zvViKOYO7PdA0k+CWv+xhnycJ/gkDY22ysTJY
	 6eeycs/0gCZLa6u9vWjsENeecM6L9tKEuzE928IZYNOGejpFW8JBf8bqkslX2dz1HQ
	 3m90lJs4oXj5dRx6FkQqFEqlpeWnyZJfmFuq9kwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCXIvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:51:11 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:17161 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCXIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:51:08 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 02O8mgsZ011219;
        Tue, 24 Mar 2020 17:48:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 02O8mgsZ011219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585039726;
        bh=FqNgRiTBfIYxlDlBeZgqdHunw+p1cDDhJa4wa3yG6eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqipl7rHpgfewAF8qKP3Fx2de752MeQHBSlVcQf8AsK4S8FpDU3wZfcFuTlfByEqf
         NjdRNvKg3Z8xkl2s60Q8konSwKXakg007f59kSEfIVNrmW2+gSnO5h9L4iEQNaO3yN
         0C0lkCcavEgwL0Kff4oaDUOqdLN4+m0orKooREUi1IUWKY6H2/wP9UGmCkIPEUturd
         ybuKXOrfa/y04z9D946j0BkioO2+BV63wx7mJpPZp1wCLdo1BZP4Rpxo9/RsHJxDzK
         kYUwQ9JCZABcYPbvTl++NZxBU17Et0hgPRYnCR1DPN/9OEZQrWZfXZ7GCvMthpB9h2
         0uXS583Fngn6Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 02/16] x86: remove unneeded defined(__ASSEMBLY__) check from asm/dwarf2.h
Date:   Tue, 24 Mar 2020 17:48:07 +0900
Message-Id: <20200324084821.29944-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324084821.29944-1-masahiroy@kernel.org>
References: <20200324084821.29944-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file has the following check at the top:

  #ifndef __ASSEMBLY__
  #warning "asm/dwarf2.h should be only included in pure assembly files"
  #endif

So, we expect defined(__ASSEMBLY__) is always true.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
---

 arch/x86/include/asm/dwarf2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index ae391f609840..5a0502212bc5 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -36,7 +36,7 @@
 #define CFI_SIGNAL_FRAME
 #endif
 
-#if defined(CONFIG_AS_CFI_SECTIONS) && defined(__ASSEMBLY__)
+#if defined(CONFIG_AS_CFI_SECTIONS)
 #ifndef BUILD_VDSO
 	/*
 	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
-- 
2.17.1

