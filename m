Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFACCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB36620729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgHJIs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:48:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60773 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:48:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BQ8kV26qXz9tyjJ;
        Mon, 10 Aug 2020 10:48:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id P-CrVAPqBMYy; Mon, 10 Aug 2020 10:48:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BQ8kV0RwNz9tyjD;
        Mon, 10 Aug 2020 10:48:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 657618B7E8;
        Mon, 10 Aug 2020 10:48:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UHjAhuW1vj7f; Mon, 10 Aug 2020 10:48:23 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 475038B7F4;
        Mon, 10 Aug 2020 10:48:22 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 20CB765C27; Mon, 10 Aug 2020 08:48:22 +0000 (UTC)
Message-Id: <5ca1be21fa6ebf73203b45fd9aadd2bafb5e6b15.1597049145.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] recordmcount: Fix build failure on non arm64
To:     Gregory Herrero <gregory.herrero@oracle.com>,
        Steven Rostedt (VMware) <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 10 Aug 2020 08:48:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ea0eada45632 leads to the following build failure on powerpc:

  HOSTCC  scripts/recordmcount
scripts/recordmcount.c: In function 'arm64_is_fake_mcount':
scripts/recordmcount.c:440: error: 'R_AARCH64_CALL26' undeclared (first use in this function)
scripts/recordmcount.c:440: error: (Each undeclared identifier is reported only once
scripts/recordmcount.c:440: error: for each function it appears in.)
make[2]: *** [scripts/recordmcount] Error 1

Make sure R_AARCH64_CALL26 is always defined.

Fixes: ea0eada45632 ("recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.")
Cc: Gregory Herrero <gregory.herrero@oracle.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 scripts/recordmcount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e59022b3f125..b9c2ee7ab43f 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -42,6 +42,8 @@
 #define R_ARM_THM_CALL		10
 #define R_ARM_CALL		28
 
+#define R_AARCH64_CALL26	283
+
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
-- 
2.25.0

