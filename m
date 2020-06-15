Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E258AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE6820714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgFOMJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:09:50 -0400
Received: from smtp.asem.it ([151.1.184.197]:60888 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:09:50 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000318019.MSG 
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:09:46 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 15
 Jun 2020 14:09:45 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 15 Jun 2020 14:09:45 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
CC:     <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] arch: sh: smc37c93x: fix spelling mistake
Date:   Mon, 15 Jun 2020 14:09:40 +0200
Message-ID: <20200615120940.12603-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020F.5EE7650A.0016,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo: "triger" --> "trigger"

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/sh/include/asm/smc37c93x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/smc37c93x.h b/arch/sh/include/asm/smc37c93x.h
index f054c30a171a..891f2f8f2fd0 100644
--- a/arch/sh/include/asm/smc37c93x.h
+++ b/arch/sh/include/asm/smc37c93x.h
@@ -112,8 +112,8 @@ typedef struct uart_reg {
 #define FCR_RFRES	0x0200	/* Receiver FIFO reset */
 #define FCR_TFRES	0x0400	/* Transmitter FIFO reset */
 #define FCR_DMA		0x0800	/* DMA mode select */
-#define FCR_RTL		0x4000	/* Receiver triger (LSB) */
-#define FCR_RTM		0x8000	/* Receiver triger (MSB) */
+#define FCR_RTL		0x4000	/* Receiver trigger (LSB) */
+#define FCR_RTM		0x8000	/* Receiver trigger (MSB) */
 
 /* Line Control Register */
 
-- 
2.17.1

