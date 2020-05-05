Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0437C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78580206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEEN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:56:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEEN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:56:06 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MAxPb-1jP4Hl36TZ-00BIW3; Tue, 05 May 2020 15:55:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] bitops: avoid clang shift-count-overflow warnings
Date:   Tue,  5 May 2020 15:54:57 +0200
Message-Id: <20200505135513.65265-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BiSQj1YLbY/CRWKicFaaFMBElVVvRY9U5E+P2ZVt/EQnQS7Iiz8
 5s17kUqWTn8PdXT8cr1iN7ynO0bvtGxc9R2tF19Z7ZcKg1HtUXsHwB75LIm2d6fGNJKaHOF
 Y9c/7XJQ7nvzhPkdl7XHpTsbgxlO267dmTtvSigxCbHiiuiay3zpEdmMi1Av2QbsIadoAlX
 DBV4/H6YDAcF4cdvJvi3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xJB1mQosZZc=:uTAUDwbFciv0vIToh8Se3v
 u66nD+WooNufSWVYPx6EP0Dv45Item0Y82oh57iB6ENOrVQDUM1efgqIG3nbYrG9GsNDRXylo
 ufQOqnJH36rTqYbhUB7r/8JAJaDxrr6j0AOY16mYQ/2Cn4WfFtRZsHfmSw7qU+YnTINVurqec
 G2JurhcjR2+DsN7JrrFcrwmo5/qhAAKcQAhLuXcJGs61b0ddEF6dUfMf/dirOZKtEY6lECheE
 RsIfztgIapkSvP+YOirMiytEXFpYIMwy385AgTALgyfiRCojACKrxU8SW10H0OAhgpstZGM8X
 DkmqMU9qvdlxQJfna4tV4Sy/7CNkRhP3Fl6U8uCoFDUKpNYrGZz9bmABS0XVpEmTpw3tEk22g
 BbORpLZ0VICrmi29qkTrZW7L/QUoAivPh6HVoISVb4iCOx9YYO6VZ+gxhiT+MrAMBjx80MToX
 qgdtEH5b6QUthnpdXdznxraGaDmgnrJwfcpiMP+RMpfsBvCbwUoH36RWNrPLZcMgTqloKV48t
 gkCTFbfB4eSATJPghVICy08UQhH3rp/HsQyR/nHEJ0YNVjPECgzuaHoO2/JTRGdPNIusFr2VS
 psar5BZRBbt/WwlE8CzNc6jiFX0anczwdblziFl1n0WDMrkh8oB3CiUqY74ityD0G1/J8lOKu
 LhtuPCd3puiOHQrdicXCRHxt5SLoBhJ3a0oGP8EWe8+4k557leFT2Zs0WogRpiFJCfqH0LCc9
 d1WczhTSThLBUYzRYCRpy2BTWtTe+iDNrjJfE0g2Up70ncAC3kOkEA4cT4HsUiLxctLuIfJMm
 fDf63ut2/+mk2uTnmMgR0RzgP+B7wdpgd74N8ePkSg2mdC/5FQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang normally does not warn about certain issues in inline functions when
it only happens in an eliminated code path. However if something else
goes wrong, it does tend to complain about the definition of hweight_long()
on 32-bit targets:

include/linux/bitops.h:75:41: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
        return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
                                               ^~~~~~~~~~~~
include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
 define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
                                                ^~~~~~~~~~~~~~~~~~~~
include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from macro '__const_hweight64'
 define __const_hweight64(w) (__const_hweight32(w) + __const_hweight32((w) >> 32))
                                                                           ^  ~~
include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from macro '__const_hweight32'
 define __const_hweight32(w) (__const_hweight16(w) + __const_hweight16((w) >> 16))
                                                ^
include/asm-generic/bitops/const_hweight.h:19:72: note: expanded from macro '__const_hweight16'
 define __const_hweight16(w) (__const_hweight8(w)  + __const_hweight8((w)  >> 8 ))
                                                                       ^
include/asm-generic/bitops/const_hweight.h:12:9: note: expanded from macro '__const_hweight8'
          (!!((w) & (1ULL << 2))) +     \

Adding an explicit cast to __u64 avoids that warning and makes it easier
to read other output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 9acf654f0b19..99f2ac30b1d9 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -72,7 +72,7 @@ static inline int get_bitmask_order(unsigned int count)
 
 static __always_inline unsigned long hweight_long(unsigned long w)
 {
-	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
+	return sizeof(w) == 4 ? hweight32(w) : hweight64((__u64)w);
 }
 
 /**
-- 
2.26.0

