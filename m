Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1BAC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768AB206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr+3eOtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCHTkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:40:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40910 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:40:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id 19so4882893ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BeCbMDE5Qb36tzuFUmgLMq1+7o7hv+/kBaBt4+UcvY=;
        b=Mr+3eOtqt4IUtQSURITcoqw2eSftZjOYJhg42ZKw4HGaIdHn64Q/j+n0GvOVwyfkZe
         JCvZvO42LrD+KuYEoIHrgkW/bQa+YxBK1Miwy+PASUsEgdGYyRi3PyuH5Jj/FAqSBd4z
         KICURKk7ex9+XUhhvp4XUVhXDXJoJUFkpcisuvg3Z87nD6Zihp2fVzGtAw+HwBoiVh64
         NcFTqbPRTMY1pGmrb2PpD8i4y+8L3DHRgvYmnltZr5BXvASum7ftLGO2Jrw8tsXcvkGv
         kzwYEUfa45bBG1Log1DbONfcy6M+q1iD4bsnXsqt2p8Tv1pSOSTB2dnwvpWvJpv8KoBF
         vsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BeCbMDE5Qb36tzuFUmgLMq1+7o7hv+/kBaBt4+UcvY=;
        b=ObPctYQybE0lFdUb/pJi1/VyDHGy2JVJK/Ka5KXGeUyoZ6eh4g145w7VbXXSyvruQw
         FZx/O3oa5bsgpgNfltMUCYMupkJT1LUlQ7YBb/4JklEcrJL6bnNsmXd1dD7IDZqIKy/I
         c4gEchFiC9Xj8uoGdxZHSRF7caLu3uaBlpmJ5Y0qHqvxvSw2IqijA18KhDxXAGX9gT4/
         enIEFbgQlXd3YFvvLtjS+34hveOJPcqUa6zD+Q3sgfGdIxsv2XZBNkxPOfuxWihuZo5K
         bJkrJpLO4w25XGPwVp/tVknwdm5wDBm2JHo9tOCy49eZxyV+l42Zh1kfoncIX6e36CTy
         o1rA==
X-Gm-Message-State: ANhLgQ32HTSfkL934j1/8lzKDG+OxKRRs3rI8iGh4H+Ftl5TMWMHLYNG
        P+WAaZPNCREt+aGrOKU4GCg=
X-Google-Smtp-Source: ADFU+vsznsV9+V5Tm89tkotEaM5hqPIi+Sz1w+UN5iiN1sqLMPDF+BaUw2iTKd9qTeGONkFKAu6ybA==
X-Received: by 2002:a2e:9182:: with SMTP id f2mr7635048ljg.110.1583696410263;
        Sun, 08 Mar 2020 12:40:10 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-78.NA.cust.bahnhof.se. [158.174.186.78])
        by smtp.gmail.com with ESMTPSA id r21sm4911236ljp.29.2020.03.08.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 12:40:09 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, geert@linux-m68k.org,
        haren@us.ibm.com, joe@perches.com, johannes@sipsolutions.net,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, yamada.masahiro@socionext.com
Subject: [PATCH v5] linux/bits.h: Add compile time sanity check of GENMASK inputs
Date:   Sun,  8 Mar 2020 20:39:54 +0100
Message-Id: <20200308193954.2372399-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20191101212857.GA889092@rikard>
References: <20191101212857.GA889092@rikard>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
as the first argument and the low bit as the second argument. Mixing
them will return a mask with zero bits set.

Recent commits show getting this wrong is not uncommon, see e.g.
commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
macro").

To prevent such mistakes from appearing again, add compile time sanity
checking to the arguments of GENMASK() and GENMASK_ULL(). If both
arguments are known at compile time, and the low bit is higher than the
high bit, break the build to detect the mistake immediately.

Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
used instead of BUILD_BUG_ON().

__builtin_constant_p does not evaluate is argument, it only checks if it
is a constant or not at compile time, and __builtin_choose_expr does not
evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
does only evaluate x++ once.

Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
available in assembly") made the macros in linux/bits.h available in
assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
checks if the file is included in an asm file.

Due to bugs in GCC versions before 4.9 [0], disable the check if
building with a too old GCC compiler.

[0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
Another attempt to get this merged. I've test built allmodconfig for
i386, x86_64 and arm64 for linux-next 20200306 without issues. Also, the
last known GENMASK issue was just merged into Linus tree [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96b4ea324ae92386db2b0c73ace597c80cde1ecb 

Changes in v5:
  - Added Masahiros Reviewed-by
  - Waited for bugfixes to get merged

Changes in v4:
  - Disable the argument check for GCC < 4.9 due to a compiler bug.

Changes in v3:
  - Changed back to shorter macro argument names
  - Remove casts and use 0 instead of UL(0) in GENMASK_INPUT_CHECK(),
    since all results in GENMASK_INPUT_CHECK() are now ints. Update
    commit message to reflect that.

Changes in v2:
  - Add comment about why inputs are not checked when used in asm file
  - Use UL(0) instead of 0
  - Extract mask creation in a separate macro to improve readability
  - Use high and low instead of h and l (part of this was extracted to a
    separate patch)
  - Updated commit message

Joe Perches sent a series to fix the existing misuses of GENMASK().
Those patches have been merged into Linus tree except two places where
the GENMASK misuse is in unused macros, which will not fail to build.
There was also a patch by Nathan Chancellor that have now been merged.

 include/linux/bits.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..f108302a3121 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
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
-- 
2.25.1

