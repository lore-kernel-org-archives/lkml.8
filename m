Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B2AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128D221775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RW/ZXqPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGSAaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:30:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C892C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SXPXCMlgtv7FhVDYaDQccKxyyABbPWgemQfLgRdVzZI=; b=RW/ZXqPvJe8Tx21a6v6iO7/hPn
        +3qpvJIG4huVCAARMRwjygXiK6QvCgQWimaDesTxZdpjw1TCcwxaoubYmcojM8dbJUKXDbEawKUAD
        PenUqfHE8x5zQD1Sznob6Z9zn9crn4CekbQI2zWzhKZAadlbrg3qmYX9IXmgMSCiiAdj+sORWhXs1
        Zr6TuBqI6B6OVVw28RN7pDJ+kd63d59on+YN1YmsodM40T0ksRp432Xcs/Gz+bVtruL8IR002WMXk
        xG2Nhs5VQG7AOQ+ykuUmtVW9jH2mey4s8lvo6WCYAGynPDR8CVYobHXqff2uU1knilqQ+w23cl3sW
        RbZy9p/Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxDL-0002mI-29; Sun, 19 Jul 2020 00:30:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] MTD: pfow.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:29:54 -0700
Message-Id: <20200719002954.20674-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "can" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 include/linux/mtd/pfow.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/mtd/pfow.h
+++ linux-next-20200717/include/linux/mtd/pfow.h
@@ -19,7 +19,7 @@
 /* Identification info for LPDDR chip */
 #define PFOW_MANUFACTURER_ID			0x0020
 #define PFOW_DEVICE_ID				0x0022
-/* Address in PFOW where prog buffer can can be found */
+/* Address in PFOW where prog buffer can be found */
 #define PFOW_PROGRAM_BUFFER_OFFSET		0x0040
 /* Size of program buffer in words */
 #define PFOW_PROGRAM_BUFFER_SIZE		0x0042
