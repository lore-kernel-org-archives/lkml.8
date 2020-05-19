Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34900C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E68C206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgESNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:14:10 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:14:07 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLhwM-1jJMgm1Wuu-00HfcK; Tue, 19 May 2020 15:13:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: include linux/time_types.h for sockios
Date:   Tue, 19 May 2020 15:13:13 +0200
Message-Id: <20200519131327.1836482-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZzSBkp1oHrCNIXzAF1NuoPpvoa6TIn1Nifxi2otujO89+1FUOUT
 yRAJvNkAj23ss9X6/6RNC0OTtXqC2zBhctD2Oz1JxNJlG/aR3IJHyMcyDOVQcVqHlLS/sVa
 Uh0eg/yWoSBj5gf6EHj0CIQSi32j8/ADRbZc3+YMN1U5B85dkYFzqtaybbXNhyvr1tBYy54
 Z8G3sDliCi0w+3AOllvIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GytPdhjM1K4=:TgZKiIgJOBuOV0S/MjSmEJ
 MZ29EINcvg6Rc9hmIf8hwo3U8JbjUysfYpqUj+RZgGvXalDGLjdIVXSp7kq2pnGY60O4T87pB
 F4L2G4UbD5oTR+jxD+3zn5R9ZCnGcC6rJ/jUtF3CdVK0bNI/Da7nnrFxALvOym0Xoafi6f8si
 BCrv6rcdzJoJaw2yTHrMQvjJSaExQMKFD1h0NOssN4r/InzABohqcLv+rYk38kS1LVm5rQBdn
 7U4mnvWZ1qSslQ2JSindWiOV3UbVfHja58EKsN22tSbxGsn2GlUXoOCzD7tbnsCTcv97b6mlw
 FEe2bKWQCpWVEATUM8k1W6bctYqacZLMhCDUbdDV9oeBSGSI9Xl482ifBOOHb1p3nHRtbfUjx
 CWiDnid/R/RNO7bkp6hBKUQ86nmDKNR9V51gw+rqYWQZ3qjXwZzk7LWhuXHgGMTjbH2hCFnPT
 wogwVFe2x3wnnkPOuQnN8gqn5roca8CN1Egofx5j3HHkSSYGc3At3cA1R5LbdGDUOT9ZY2sP6
 KORkn4q+9rdcls1WGq+EJG0/ta5Y+UvPHeOCNnwAavYQP5eEwXQyR0aOduUP5MoxE0/eAEX72
 zodLf81N+Ee3pJDhsrnECIXTbV0DhMP94NlM6gXA+oyxkj12Tp1Q2vtIbzZAG8HRUe2VNp85v
 eyTICJ46wtZ08xuTrJdGyeRkU+4HRl82N0ObTmvCHftRxp8xqmO3u9AChCUjHWFwL7Xh+yCYm
 JYHR5W5IZ6R0zBjnjqrfsBbSin49mXl3LHTTlg2MWO2Z+NBqmF4VwPKts2fB4/GYGF11Uje39
 dg0Mm7+lqNtxddbdI7+lLDaK+RMf8yGCA0mJT/Qafjs+ZHQZTM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the socket ioctls on arch/sh (and only there) causes build
time problems when __kernel_old_timeval/__kernel_old_timespec are
not already visible to the compiler.

Add an explict include line for the header that defines these
structures.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/uapi/asm/sockios.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
index 3da561453260..ef01ced9e169 100644
--- a/arch/sh/include/uapi/asm/sockios.h
+++ b/arch/sh/include/uapi/asm/sockios.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_SH_SOCKIOS_H
 #define __ASM_SH_SOCKIOS_H
 
+#include <linux/time_types.h>
+
 /* Socket-level I/O control calls. */
 #define FIOGETOWN	_IOR('f', 123, int)
 #define FIOSETOWN 	_IOW('f', 124, int)
-- 
2.26.2

