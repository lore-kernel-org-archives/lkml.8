Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90788C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DC920722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEKLZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:25:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20998 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgEKLZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJWq0fPhz9ty3q;
        Mon, 11 May 2020 13:25:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aiZLj6DZYz55; Mon, 11 May 2020 13:25:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJWp6pxZz9ty3p;
        Mon, 11 May 2020 13:25:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A594A8B7B1;
        Mon, 11 May 2020 13:25:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dbub3bcgQ_Ma; Mon, 11 May 2020 13:25:33 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 50F008B7AD;
        Mon, 11 May 2020 13:25:33 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E2BD365A09; Mon, 11 May 2020 11:25:32 +0000 (UTC)
Message-Id: <594874ca405eaa78f1835c372134c9d0fc36dc53.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 07/45] powerpc/ptdump: Limit size of flags text to 1/2
 chars on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have all flags fit on a 80 chars wide screen,
reduce the flags to 1 char (2 where ambiguous).

No cache is 'i'
User is 'ur' (Supervisor would be sr)
Shared (for 8xx) becomes 'sh' (it was 'user' when not shared but
that was ambiguous because that's not entirely right)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/8xx.c    | 33 ++++++++++++++++---------------
 arch/powerpc/mm/ptdump/shared.c | 35 +++++++++++++++++----------------
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index 9e2d8e847d6e..ca9ce94672f5 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -12,9 +12,9 @@
 static const struct flag_info flag_array[] = {
 	{
 		.mask	= _PAGE_SH,
-		.val	= 0,
-		.set	= "user",
-		.clear	= "    ",
+		.val	= _PAGE_SH,
+		.set	= "sh",
+		.clear	= "  ",
 	}, {
 		.mask	= _PAGE_RO | _PAGE_NA,
 		.val	= 0,
@@ -30,37 +30,38 @@ static const struct flag_info flag_array[] = {
 	}, {
 		.mask	= _PAGE_EXEC,
 		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
+		.set	= "x",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
+		.set	= "p",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_GUARDED,
 		.val	= _PAGE_GUARDED,
-		.set	= "guarded",
-		.clear	= "       ",
+		.set	= "g",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_DIRTY,
 		.val	= _PAGE_DIRTY,
-		.set	= "dirty",
-		.clear	= "     ",
+		.set	= "d",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_ACCESSED,
 		.val	= _PAGE_ACCESSED,
-		.set	= "accessed",
-		.clear	= "        ",
+		.set	= "a",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_NO_CACHE,
 		.val	= _PAGE_NO_CACHE,
-		.set	= "no cache",
-		.clear	= "        ",
+		.set	= "i",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
-		.set	= "special",
+		.set	= "s",
+		.clear	= " ",
 	}
 };
 
diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index f7ed2f187cb0..44a8a64a664f 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -13,8 +13,8 @@ static const struct flag_info flag_array[] = {
 	{
 		.mask	= _PAGE_USER,
 		.val	= _PAGE_USER,
-		.set	= "user",
-		.clear	= "    ",
+		.set	= "ur",
+		.clear	= "  ",
 	}, {
 		.mask	= _PAGE_RW,
 		.val	= _PAGE_RW,
@@ -23,42 +23,43 @@ static const struct flag_info flag_array[] = {
 	}, {
 		.mask	= _PAGE_EXEC,
 		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
+		.set	= "x",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_PRESENT,
 		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
+		.set	= "p",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_GUARDED,
 		.val	= _PAGE_GUARDED,
-		.set	= "guarded",
-		.clear	= "       ",
+		.set	= "g",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_DIRTY,
 		.val	= _PAGE_DIRTY,
-		.set	= "dirty",
-		.clear	= "     ",
+		.set	= "d",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_ACCESSED,
 		.val	= _PAGE_ACCESSED,
-		.set	= "accessed",
-		.clear	= "        ",
+		.set	= "a",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_WRITETHRU,
 		.val	= _PAGE_WRITETHRU,
-		.set	= "write through",
-		.clear	= "             ",
+		.set	= "w",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_NO_CACHE,
 		.val	= _PAGE_NO_CACHE,
-		.set	= "no cache",
-		.clear	= "        ",
+		.set	= "i",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
-		.set	= "special",
+		.set	= "s",
+		.clear	= " ",
 	}
 };
 
-- 
2.25.0

