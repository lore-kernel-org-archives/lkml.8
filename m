Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E46C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2147A20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgEEONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:13:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgEEONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:13 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mrwnt-1ikU0n0FhF-00nxqr; Tue, 05 May 2020 16:13:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Torsten Duwe <duwe@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] arm64: disable patchable function entry on big-endian clang builds
Date:   Tue,  5 May 2020 16:12:36 +0200
Message-Id: <20200505141257.707945-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rkN2hFA/4F6NEnM1J64C8Aoib8T4jOG+siBiFVT9WROwOdH7x9t
 4WH888TrHbFW/FHpjxq3U7UIYxkq42gZJvGVmzWSKCE/CP5xLY+4t0fiBxQKzBPqACB4Rxu
 Ppew9ALCOA7Zl3kFJwrRLZlpqi3jMRixTt0nmQPz31Umnk3BLwwh/1zbLQKb3mod0qsnKR/
 rNXzfBEB11Ep2dBi8d6QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cdva0oxEiZM=:FQRtrzAr9rWx5IUwkwoKVU
 4+edO8zLchzG0t3lP2T3zLl0VcO/vDceZ7U8gqo0szcf3UGrnp8cqm3RsThr2qeuZDCnoxmJO
 veqZajiQ7CWyp2xDqmSubJR9bg6if5TOtLgEJ48h50YQHo2owT1RleKCLy76qLfmwy4xRXVkR
 XKLca5YQpwBnghGgN/jyJE2KrT/TKk+TsK/QDz2CRA77IiqjaVSB2akJo9+zH0ilrj/1TUj2D
 beLTyKsIsE1xxTZGlLlp66kd5pROyDWGCL1CJIrsmQdcqPBJv0vfcntLO68w61O8bNp6iWhCh
 ANwWYVWBfMwiIl2qwGJw3ZgjIySZ8wCqK5wU1YqOl26ial/nrVdcbrkixCFkG6atDKTbdZv5o
 lM6FuDHZ2WAl5ilc09yi8pu+sn3P1/m+UcpcsxxEpqJQxNKYQsIzCTZ3uyuC3Uz9PD7HjK32B
 0Bx+Tcgsyya3G5pIone2mmBYxaClBltnbMnWQZJtTIlVpk3MIxLlrORfTCXPpOiqfOTzqNz3J
 D9zb8xppaQvpQHwp81dh1mJh7SVz99Du3S+zZy35Syk9ovW1Te6tM60nT1aUZa9TYRgScSyJ6
 fTfaB8IpMAB8iJV/RjgmGLPR9q4/q9fWr7cd7f+JQwWvmp3H9ACLTum5FFlc6OKxiAo+S0W6V
 Qe2JeJswxsdeh+GNiwZBcsq5GwonmV950Wpccx0cOX/zGJEK3kzxhV6CFJaN+pV9Ae2jku1w2
 9INoLYGGsrvr8JLgpirpXlAifwJgXoorZG035wf4Nt+ZqQ7+8lCCAdPFhzkSnTRkqZ59sCG5x
 v/JSrNAdWm8DfWvw+w/viI7QyCBKfg1VXkZ7O+ztIiSTuzh++8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang only supports the patchable_function_entry attribute on
little-endian arm64 builds, but not on big-endian:

include/linux/kasan-checks.h:16:8: error: unknown attribute 'patchable_function_entry' ignored [-Werror,-Wunknown-attributes]

Disable that configuration with another dependency. Unfortunately
the existing check is not enough, as $(cc-option) at this point does
not pass the -mbig-endian flag.

Fixes: 3b23e4991fb6 ("arm64: implement ftrace with regs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4b256fa6db7a..a33d6402b934 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -151,7 +151,7 @@ config ARM64
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
-		if $(cc-option,-fpatchable-function-entry=2)
+		if $(cc-option,-fpatchable-function-entry=2) && !(CC_IS_CLANG && CPU_BIG_ENDIAN)
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
-- 
2.26.0

