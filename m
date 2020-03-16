Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA6C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C0205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uTtly7AG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgCPMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:38:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63177 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbgCPMfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkr4Lykz9tygV;
        Mon, 16 Mar 2020 13:35:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uTtly7AG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kl9NXhfFwCMT; Mon, 16 Mar 2020 13:35:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkr38x3z9tyg5;
        Mon, 16 Mar 2020 13:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362148; bh=KH3XUMgtMi4a2Lmwnb7mJPyqdkMUvSoWpHXEJYg9UDA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=uTtly7AGgIOaNdLr1X8cM31eBqNFKPBVhX+2WR/4SiuFJ5LnqAxiiE2a3CVIkPrIW
         tspUEilOUfDkgWJ4iDvMVG49DG6Ac1V1HO7/DuwSkulR6gK7ex+XqW55coYobP+wqM
         uwO1WkVg7CmNPuCf7BaQJ35rgli+vIGyzaf948vA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6846D8B7CB;
        Mon, 16 Mar 2020 13:35:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id b0OA7Uc3gOiN; Mon, 16 Mar 2020 13:35:53 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 398038B7D2;
        Mon, 16 Mar 2020 13:35:53 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 318A565595; Mon, 16 Mar 2020 12:35:53 +0000 (UTC)
Message-Id: <da5b033904c78c1a6c918dd6047c529d5abf9662.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 08/46] powerpc/ptdump: Limit size of flags text to 1/2
 chars on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:53 +0000 (UTC)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
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

