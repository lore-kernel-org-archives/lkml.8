Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78931C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC22064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgD2TB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:01:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2TB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:01:56 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MumVX-1jCKwh27ud-00rpSG; Wed, 29 Apr 2020 21:01:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: fix another section mismatch
Date:   Wed, 29 Apr 2020 21:01:29 +0200
Message-Id: <20200429190135.66411-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Szb2DZmVbsi9zjRUpDEH7akgew64KiBCpb3bqi+G1E8EOw0LQH+
 TlGePCThpd30p+6jKUM6y8jmbDwOE6e9BfTt7O9LjHUEY1cHuT3IFuVIcPCmSy99Y86+j2g
 8G6pgeey9wEKCGkd8smGL2z/cHRq4WVKWKts21hPxjl3DbpnTRNRCLrnqYFm55S8AuFt82f
 anFT93iEsS8s5/jsxgjoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9pmxs2rWbc=:2vcMAoEgtdbCJo7EjwQKVY
 iTVmiHOkHgdmh2/o5x5Mb3DgZXizfSSM45oQ2rw9eziCvspfh669eA2RCkOVzcSZq3TZLRPni
 ss6VwGeGatYVo6F/KmHqPxlTvFIU1Ex1W/Tp165NK3d+bkP1EY46nOWq3RoX+NrjWyWh1UG6h
 REmjdrAM1rU4UXXsGa1eTB6KTTrXtDEk3xanVCgMe24NOobaitppXeBsleW/AUdlwsWHq/241
 DekvlYVSS0l6vNtnGl5bjnvgxLzu8ITT7xsVHwhFy/K1ZT8oCdoPANfNBPbeUvUxZqV8nRcmq
 tJRbgWfyRpcSF2R3riU7n7rj2b+o0ID2x2IGslElooFF8OgaX1SX63xUz5XBFycrOuhH3eBd8
 9Wm1TX6Hrgl0jm5hGqWZLnF6fOTeuc1yaJgiIDkpjjUZwuA9JbHfklfvdiNcdcYG94OJfee5e
 f8WRpMPi1PHcz7RYLzWEqhgAFy4QmZSN//kDdcW95ZSNhq2xv8SM21ijrr9z5lOke60MeNJWM
 0MyVQ2isjIX38KVE277BtPGjnROsiJsvZn/a1tqucTmq2ycUas5xDp5AE28Kp9J8dsK0GDwqm
 0Whmt/s0NcLYk7md/4APxkqPpFdsJ835gnjVNObUTyp3egE/m6YPbJNqm9qs2p5tcJeS6dLxT
 WPgsivSI2qcvl3ZezMRIobjQ2sRHi8dUe11t5iM+QzLkwbR4zku1KYnsCzm1DPrg1LetHdtMQ
 1EiW3MA4EvF5PizMWVD04g2uQ5xEPgMlOeTBXnn0O2wT4bPJdZc4fFH+oNFv0TLSYBjptT18X
 sli0Z7fzyrf2gUX0XrMeTbHKJ5wPSvKPp1eRkU4rdVRJkeOjEU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with gcc-10 causes a harmless warning, similar to the
gcc-4.6 warning that Geert fixed last year:

WARNING: modpost: vmlinux.o(.text.unlikely+0xe69): Section mismatch in reference from the function kexec_free_initrd() to the function .init.text:free_initrd_mem()
The function kexec_free_initrd() references
the function __init free_initrd_mem().
This is often because kexec_free_initrd lacks a __init
annotation or the annotation of free_initrd_mem is wrong.

Add the missing __init annotations.

Fixes: 4ada1e810038 ("initramfs: fix populate_initrd_image() section mismatch")
Fixes: 23091e287355 ("initramfs: cleanup initrd freeing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 init/initramfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 8ec1be4d7d51..bda77a6c8e50 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -542,7 +542,7 @@ void __weak free_initrd_mem(unsigned long start, unsigned long end)
 }
 
 #ifdef CONFIG_KEXEC_CORE
-static bool kexec_free_initrd(void)
+static bool __init kexec_free_initrd(void)
 {
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
@@ -565,7 +565,7 @@ static bool kexec_free_initrd(void)
 	return true;
 }
 #else
-static inline bool kexec_free_initrd(void)
+static inline bool __init kexec_free_initrd(void)
 {
 	return false;
 }
-- 
2.26.0

