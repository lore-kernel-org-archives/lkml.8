Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0865C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5E920775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="DymTGaOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896149AbgDOKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:06:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32691 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896141AbgDOKGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:06:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 492J0L1h7rz9tyL2;
        Wed, 15 Apr 2020 12:06:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=DymTGaOS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7JeZM0syd1tt; Wed, 15 Apr 2020 12:06:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 492J0K6Xg5z9tyKn;
        Wed, 15 Apr 2020 12:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586945169; bh=hkKFu8sRpCUMXlHi4pfwxQk9xCM6GrmMLh79FA+H4VM=;
        h=From:Subject:To:Cc:Date:From;
        b=DymTGaOSUGHMez5hZSMw2s+fHEnCnX98xDcqO2/KRXf0+LGRlkpmXwGY0LwJ+wmzT
         s0O2Jz2fO0puohDRUAJ4JE8BGK/gpME8CN8M0ncam5zX2FtU7fwA/5ycw1lp6/1Eru
         r0NIG4xUrZvyrwW9vS6gB22meZXOz4YZqlzupRC8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 19ACA8B977;
        Wed, 15 Apr 2020 12:06:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5lJGUnSjmWgq; Wed, 15 Apr 2020 12:06:11 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FBB18B978;
        Wed, 15 Apr 2020 12:06:10 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E158B65789; Wed, 15 Apr 2020 10:06:09 +0000 (UTC)
Message-Id: <57425c33dd72f292b1a23570244b81419072a7aa.1586945153.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Reduce time spent in allow_user_access() and
 friends
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 15 Apr 2020 10:06:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable/disable kernel access to user space, the 8xx has to
modify the properties of access group 1. This is done by writing
predefined values into SPRN_Mx_AP registers.

As of today, a __put_user() gives:

00000d64 <my_test>:
 d64:	3d 20 4f ff 	lis     r9,20479
 d68:	61 29 ff ff 	ori     r9,r9,65535
 d6c:	7d 3a c3 a6 	mtspr   794,r9
 d70:	39 20 00 00 	li      r9,0
 d74:	90 83 00 00 	stw     r4,0(r3)
 d78:	3d 20 6f ff 	lis     r9,28671
 d7c:	61 29 ff ff 	ori     r9,r9,65535
 d80:	7d 3a c3 a6 	mtspr   794,r9
 d84:	4e 80 00 20 	blr

Because only groups 0 and 1 are used, the definition of
groups 2 to 15 doesn't matter.
By setting unused bits to 0 instead on 1, one instruction is
removed for each lock and unlock action:

00000d5c <my_test>:
 d5c:	3d 20 40 00 	lis     r9,16384
 d60:	7d 3a c3 a6 	mtspr   794,r9
 d64:	39 20 00 00 	li      r9,0
 d68:	90 83 00 00 	stw     r4,0(r3)
 d6c:	3d 20 60 00 	lis     r9,24576
 d70:	7d 3a c3 a6 	mtspr   794,r9
 d74:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 76af5b0cb16e..6aa3464a88ed 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -37,16 +37,16 @@
  * Therefore, we define 2 APG groups. lsb is _PMD_USER
  * 0 => Kernel => 01 (all accesses performed according to page definition)
  * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
- * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
+ * 2-15 => Not Used
  */
-#define MI_APG_INIT	0x4fffffff
+#define MI_APG_INIT	0x40000000
 
 /*
  * 0 => Kernel => 01 (all accesses performed according to page definition)
  * 1 => User => 10 (all accesses performed according to swaped page definition)
- * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
+ * 2-15 => Not Used
  */
-#define MI_APG_KUEP	0x6fffffff
+#define MI_APG_KUEP	0x60000000
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
@@ -117,16 +117,16 @@
  * Therefore, we define 2 APG groups. lsb is _PMD_USER
  * 0 => Kernel => 01 (all accesses performed according to page definition)
  * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
- * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
+ * 2-15 => Not Used
  */
-#define MD_APG_INIT	0x4fffffff
+#define MD_APG_INIT	0x40000000
 
 /*
  * 0 => No user => 01 (all accesses performed according to page definition)
  * 1 => User => 10 (all accesses performed according to swaped page definition)
- * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
+ * 2-15 => Not Used
  */
-#define MD_APG_KUAP	0x6fffffff
+#define MD_APG_KUAP	0x60000000
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
-- 
2.25.0

