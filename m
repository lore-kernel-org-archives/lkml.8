Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F02C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C2C20578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUn3fkBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGIXZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:24:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AEFC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 16:24:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n26so4069315ejx.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jxud1hqdMmV/qCt2C7zfseg2iYNEHL7rYBMl6P7UfQc=;
        b=IUn3fkBdgS+l4vyQjqXhn34mDo3/pT4DKGGV+X5dJ/hizNZyykKlOrvCAuPZUrFUYq
         OazDEHjhUOyb+KIdEw33VWlaG6yqJXgmNfVf5Kqcyk2p5GpPVorKzuxd0hYHUhnvhaOS
         MhUu6yyjVamg9pHwjbdI++gkrN4n+0ymsePOtMhriIKncxE624qh/IW0xJacl3tdnqxR
         DGsRiwbb10lGtFqW6E5T3RfIxhZpjlmC8j5uiwz9DTl+hHhLxGDoPnGFcqiYKiNkgKqf
         okaafQYlAwtBmwW7bfBLbs26ksaiX8qpikNdpqIE+ojHtBJygCFT19mH/lRkPE8q7+tv
         0vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jxud1hqdMmV/qCt2C7zfseg2iYNEHL7rYBMl6P7UfQc=;
        b=EdefQtwCJJMNNCyAhe17YDBqc5FYifaDmRk1bmrRxaNU5h1Ivuqy9vo0wco6cpG7zO
         zighHeyzQELqLPwVbh9gCHygfDXbily423tP/Tc2217zXXwQdhxKde6153r2qJCDLsZq
         gz9HLn9E/6blGwtXCmYpT90ZTJ3sATlJoEDhjbK+ykIICZCL6+M1q2y+kXIbU+VckayZ
         w3uIGmUYc+ufgmhbeDKLqeh1gpEP5dqdkO3XmIixtSLIbG24Fsid+wL9OyQyIi58OVcq
         umqKttnPjKQ67wDncu0bHUnzcLZ/BE0v1bwzbR+ab3csqkdGTdX+SqfvzJyejIDAoWqa
         D9UQ==
X-Gm-Message-State: AOAM532mSu0xwZUGQUsFYxOzvjisZzHRy2ONvNhlDHzIiN0Qq1BhBVVm
        JCy9FIhkepJXMyS5J6OLS5jpbYe/
X-Google-Smtp-Source: ABdhPJyrwMAr2UkSl/bX4ouc5VhNmi4Uo88liim0YIQ01nPQ8H8KDoHRqE+gBY9nK4NW/OQIwKzE2A==
X-Received: by 2002:a17:907:20b0:: with SMTP id pw16mr4846840ejb.551.1594337097847;
        Thu, 09 Jul 2020 16:24:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id cc9sm3134654edb.14.2020.07.09.16.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:24:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Justin Chen <justinpopo6@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: brcmstb: Add debug UART entry for 72614
Date:   Thu,  9 Jul 2020 16:24:45 -0700
Message-Id: <20200709232447.5902-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 132a20c4a676..79223209d3f4 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -32,6 +32,7 @@
 #define UARTA_7271		UARTA_7268
 #define UARTA_7278		REG_PHYS_ADDR_V7(0x40c000)
 #define UARTA_7216		UARTA_7278
+#define UARTA_72164		UARTA_7278
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
 #define UARTA_7366		UARTA_7364
 #define UARTA_74371		REG_PHYS_ADDR(0x406b00)
@@ -84,17 +85,18 @@ ARM_BE8(	rev	\rv, \rv )
 		/* Chip specific detection starts here */
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
 21:		checkuart(\rp, \rv, 0x72160000, 7216)
-22:		checkuart(\rp, \rv, 0x72500000, 7250)
-23:		checkuart(\rp, \rv, 0x72550000, 7255)
-24:		checkuart(\rp, \rv, 0x72600000, 7260)
-25:		checkuart(\rp, \rv, 0x72680000, 7268)
-26:		checkuart(\rp, \rv, 0x72710000, 7271)
-27:		checkuart(\rp, \rv, 0x72780000, 7278)
-28:		checkuart(\rp, \rv, 0x73640000, 7364)
-29:		checkuart(\rp, \rv, 0x73660000, 7366)
-30:		checkuart(\rp, \rv, 0x07437100, 74371)
-31:		checkuart(\rp, \rv, 0x74390000, 7439)
-32:		checkuart(\rp, \rv, 0x74450000, 7445)
+22:		checkuart(\rp, \rv, 0x07216400, 72164)
+23:		checkuart(\rp, \rv, 0x72500000, 7250)
+24:		checkuart(\rp, \rv, 0x72550000, 7255)
+25:		checkuart(\rp, \rv, 0x72600000, 7260)
+26:		checkuart(\rp, \rv, 0x72680000, 7268)
+27:		checkuart(\rp, \rv, 0x72710000, 7271)
+28:		checkuart(\rp, \rv, 0x72780000, 7278)
+29:		checkuart(\rp, \rv, 0x73640000, 7364)
+30:		checkuart(\rp, \rv, 0x73660000, 7366)
+31:		checkuart(\rp, \rv, 0x07437100, 74371)
+32:		checkuart(\rp, \rv, 0x74390000, 7439)
+33:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.17.1

