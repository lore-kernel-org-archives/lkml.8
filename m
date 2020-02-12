Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02848C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D4120873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgBLJLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:11:52 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:52386 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgBLJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:11:51 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 1lBp220055USYZQ06lBpcE; Wed, 12 Feb 2020 10:11:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1o3h-0000Zh-0j; Wed, 12 Feb 2020 10:11:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1nf5-0002PR-IQ; Wed, 12 Feb 2020 09:46:23 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] s390/pkey/zcrypt: spelling s/crytp/crypt/
Date:   Wed, 12 Feb 2020 09:46:22 +0100
Message-Id: <20200212084622.9219-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in a comments.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index d4caf46ff9df1559..2afe2153b34e32e9 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -887,7 +887,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	/* empty pin tag */
 	*p++ = 0x04;
 	*p++ = 0;
-	/* encrytped key value tag and bytes */
+	/* encrypted key value tag and bytes */
 	p += asn1tag_write(p, 0x04, enckey, enckeysize);
 
 	/* reply cprb and payload */
@@ -1095,7 +1095,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 
 	/* Step 1: generate AES 256 bit random kek key */
 	rc = ep11_genaeskey(card, domain, 256,
-			    0x00006c00, /* EN/DECRYTP, WRAP/UNWRAP */
+			    0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
 			    kek, &keklen);
 	if (rc) {
 		DEBUG_ERR(
-- 
2.17.1

