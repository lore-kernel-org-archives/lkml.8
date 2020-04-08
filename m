Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38430C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687F2074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586311285;
	bh=QFmgRRYScngDWN/BRZ4rGh+aJPvUq10rRqBozbwbslg=;
	h=Date:From:To:Subject:List-ID:From;
	b=dF3U/gDWXGF6dLqF+nZtrbSfNAwz+AqCJAL1AyW1kTDsbGd0K52Hk1jeVJDUeSRy4
	 x95Tozu94atekdrXAFvZWVDv4cYQggt1Y1DqzfHT+KTh2sXoPcXkjXGZ+HN1FchhWr
	 razIGRQD8Vx/FrdfRA7eol5Ga8J+A8UI23OcSyQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDHCBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgDHCBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:01:24 -0400
Received: from localhost.localdomain (c-71-198-47-131.hsd1.ca.comcast.net [71.198.47.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A42320730;
        Wed,  8 Apr 2020 02:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586311282;
        bh=QFmgRRYScngDWN/BRZ4rGh+aJPvUq10rRqBozbwbslg=;
        h=Date:From:To:Subject:From;
        b=XXkeiu290GJjRbYf+xpsGlDenUPCrS7GgFmj2TduI0qwK+UyKLLnMp/DxsgNx8bpn
         qvbjXr/pA8C3oVKOrj9DRXJs/bb3yIRUvknOjSXvW5tzurV/6THzpJDsCFNlvcb/Xp
         o/KEddqMa1yX2A3kHrTgtBlEy4/wYGHEvqbXXWhA=
Date:   Tue, 07 Apr 2020 19:01:21 -0700
From:   akpm@linux-foundation.org
To:     bp@alien8.de, geert@linux-m68k.org, haren@us.ibm.com,
        joe@perches.com, johannes@sipsolutions.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        mm-commits@vger.kernel.org, rikard.falkeborn@gmail.com,
        tglx@linutronix.de, yamada.masahiro@socionext.com
Subject:  [merged]
 linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs.patch removed
 from -mm tree
Message-ID: <20200408020121.INZFbuTGR%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch titled
     Subject: linux/bits.h: add compile time sanity check of GENMASK inputs
has been removed from the -mm tree.  Its filename was
     linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: linux/bits.h: add compile time sanity check of GENMASK inputs

GENMASK() and GENMASK_ULL() are supposed to be called with the high bit as
the first argument and the low bit as the second argument.  Mixing them
will return a mask with zero bits set.

Recent commits show getting this wrong is not uncommon, see e.g.  commit
aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and commit
9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK macro").

To prevent such mistakes from appearing again, add compile time sanity
checking to the arguments of GENMASK() and GENMASK_ULL().  If both
arguments are known at compile time, and the low bit is higher than the
high bit, break the build to detect the mistake immediately.

Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be used
instead of BUILD_BUG_ON().

__builtin_constant_p does not evaluate is argument, it only checks if it
is a constant or not at compile time, and __builtin_choose_expr does not
evaluate the expression that is not chosen.  Therefore, GENMASK(x++, 0)
does only evaluate x++ once.

Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
available in assembly") made the macros in linux/bits.h available in
assembly.  Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
checks if the file is included in an asm file.

Due to bugs in GCC versions before 4.9 [0], disable the check if building
with a too old GCC compiler.

[0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

Link: http://lkml.kernel.org/r/20200308193954.2372399-1-rikard.falkeborn@gmail.com
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Haren Myneni <haren@us.ibm.com>
Cc: Joe Perches <joe@perches.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/bits.h |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/include/linux/bits.h~linux-bitsh-add-compile-time-sanity-check-of-genmask-inputs
+++ a/include/linux/bits.h
@@ -18,12 +18,30 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#define GENMASK(h, l) \
+#if !defined(__ASSEMBLY__) && \
+	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
+#include <linux/build_bug.h>
+#define GENMASK_INPUT_CHECK(h, l) \
+	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+#else
+/*
+ * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
+ * disable the input check if that is the case.
+ */
+#define GENMASK_INPUT_CHECK(h, l) 0
+#endif
+
+#define __GENMASK(h, l) \
 	(((~UL(0)) - (UL(1) << (l)) + 1) & \
 	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
 
-#define GENMASK_ULL(h, l) \
+#define __GENMASK_ULL(h, l) \
 	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
 	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
 #endif	/* __LINUX_BITS_H */
_

Patches currently in -mm which might be from rikard.falkeborn@gmail.com are


