Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E6AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3439C206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="qfGV6Kya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgBLI6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37864 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgBLI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so1225529wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTqRW37ZLR6od2QUdreH7KhM1duNKLl7Hn5wfFcZ2P4=;
        b=qfGV6KyaP47LsMtH+a0NetLwNali11oFrqd5qEgy/3M8UgS/lqFbSNj8k4C68Jas1X
         Ffwgh1W37SvTjz61P9FUjwYPIbmx8tVq7PCmL+1s3y/TN4imhaonpHZi/dOHegkpGLSQ
         GGo3N63wdIZ1zBPSykZbivrgHsPNwtY2LXZT0CAuD8jDZVkfmgLblulJ4nfWTryZWKFo
         I/LJqO/TAeTKnYFwDUZkYXWqOtSBBedSgP90d8GoGcxrZtkluQETfGTcLb4FwVu1cPa+
         EWKnny8u56W70atIeMGx/NSEBGa8z9+p4DVpBHPVepJW9FhxFDezslMUYZzUH0dt6pQA
         bxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QTqRW37ZLR6od2QUdreH7KhM1duNKLl7Hn5wfFcZ2P4=;
        b=tJ/OTdp4wK3wGwvHzgVwvU6oCqjcMrN3aMSoooGVC0MMKHfpgK6qASoKJCyZ4MkuNE
         GFRYCjLyyk02M4XMBkj2d0zKhFwKPNJUix4Dd1X+s1YHK30ZPktQWKO7foh91IMkV64I
         +D2bMGmFd9yJhQQ80SbPxwxuCbZKyLH8xezlPS9EDDJsdD8MTqU2N95ANKGsE6y+YKYP
         pc3XMSQnpAZ2S2kDsQ/JJblR83AB7gOmYyYj2RuhEJRN/345GfKznllPNu47Yfofs03h
         8otqVZFTsAZXlR/FVPlaVb8eo2kH4UOpPnGWCA1a3Ddp21iCjNL5qCJp0BllfmTux+Su
         Y+iQ==
X-Gm-Message-State: APjAAAXqfZjjrFWt234/2ckIIShaNtSIYpceSwDjpzgwwxYENZEXXTwP
        0X0SLlDSJ3qzkyipo0TfhODmDXd0vMFQ5Q==
X-Google-Smtp-Source: APXvYqzm5+HrOHkCHTNWLPMHAKaLN5plj69c6q/7JJ+6abQQDQbPqp2C0hp9N+Gk5HAM/btVRX1APw==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr11511803wmf.106.1581497899718;
        Wed, 12 Feb 2020 00:58:19 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i2sm7469722wmb.28.2020.02.12.00.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:19 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 06/10] microblaze: Add sync to tlb operations
Date:   Wed, 12 Feb 2020 09:58:03 +0100
Message-Id: <c3d70f467907944e2680678f8aacb6d04def3f20.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

Do the real sync by using mbar instruction.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/misc.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/misc.S b/arch/microblaze/kernel/misc.S
index 6759af688451..1228a09d8109 100644
--- a/arch/microblaze/kernel/misc.S
+++ b/arch/microblaze/kernel/misc.S
@@ -39,7 +39,7 @@ _tlbia_1:
 	rsubi	r11, r12, MICROBLAZE_TLB_SIZE - 1
 	bneid	r11, _tlbia_1 /* loop for all entries */
 	addik	r12, r12, 1
-	/* sync */
+	mbar	1 /* sync */
 	rtsd	r15, 8
 	nop
 	.size  _tlbia, . - _tlbia
@@ -58,6 +58,7 @@ _tlbie:
 	blti	r12, _tlbie_1 /* Check if found */
 	mts	rtlbhi, r0 /* flush: ensure V is clear */
 	nop
+	mbar	1 /* sync */
 _tlbie_1:
 	rtsd	r15, 8
 	nop
-- 
2.25.0

