Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9AAC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151B20656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="lMUystim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBVVvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 16:51:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37096 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgBVVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:51:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so2386474plz.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HBCqjg0a+bhil4nBIBy5bJmpduFEbhGT3Aouisb2vJA=;
        b=lMUystimAw6OmezUONtF3S/Asq3N5V4IfXfMbTiTTOHzas3ksvIBM+MpZNJM5D9JF7
         74eDu8fC9jCAlBLpsUZODamJ5JRFAp7hSz8uZXzc5N3logQGnFRr2fFjtkdbzDpNezW5
         Cuj36DdAOEfpYeklXAJZEq93ks8JMbwTjTpMcEYiPYNnvN507bag4Xc0Ey/08+uF2kzM
         xZoawnbhTv+AP3wPizcMp+YIh2GuuSWsg3OcAlnsB4xYw7Ye05cizQWymJeIr3pCQ027
         65/M3m9cotB7cTGXxVDlHVfx+ZyOM2JgRBirjDs0SpEYjH16RTRPISvdKexmaBZxdrJS
         G/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HBCqjg0a+bhil4nBIBy5bJmpduFEbhGT3Aouisb2vJA=;
        b=YRv5y5onHJuFMO9AZ+5DzsGQU35NuqOAyZzknvFC9JdxmcZcOpeYjq23Pn46dMJkaM
         33ThHN6AMt1F6Q0Fg06zPJPIrxOMAmebHOhnwdQkPMaNtu/huUEnoWTqjlwGaQGJGoZm
         YtC/lIvlGHBxVDgZc1+hmhjNMOpulYmZRcXGhkI+nGon3R1+QekDD+DO5blNn3E7lnZa
         gIoCjPcQ18h0GDH9lPQdzD2kAyzo3glX6Z3h3lUk2sWEZ19HSNpsSnxDJBHe3qdsMLgv
         Am1tSyW5JAEmByDFA5ZfO1i8g+U+zBIB+YSTZCwUvUX06E4M/He/nSINJC+RVBmfurF9
         YtiQ==
X-Gm-Message-State: APjAAAU3+DXQgwqQ6H0PX6pbdCo4w2tjcw1DXhyw93nSutkm4SQWixcY
        /tAYZHrBJau7XU75P/x+dPVg2A==
X-Google-Smtp-Source: APXvYqzEs91Ql9UUx7rtBSIQ+QLy850ElKz8CsOBfYyqFaA2Jjc3JnMQqsgpkfrU1HGw11ilZP0vkQ==
X-Received: by 2002:a17:90a:a617:: with SMTP id c23mr11647984pjq.32.1582408277086;
        Sat, 22 Feb 2020 13:51:17 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id f3sm7384821pfg.115.2020.02.22.13.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Feb 2020 13:51:16 -0800 (PST)
Date:   Sun, 23 Feb 2020 03:21:09 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: qlge: emit debug and dump at same level
Message-ID: <20200222215109.GA18727@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write a macro QLGE_DUMP_DBG having a function print_hex_dump so that
the debug and dump are emitted at the same KERN_<LEVEL> and code becomes
simpler. Write a macro instead of calling the function directly in
ql_mpi_core_to_log() to go according to the coding practices followed in
other drivers such as nvec and vc04_services.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---

changes since v1: make code of ql_mpi_core_to_log() simpler.

----
---
 drivers/staging/qlge/qlge_dbg.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index c7af2548d119..f4440670bc46 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define QLGE_DUMP_DBG(str, buf, len)			    \
+	print_hex_dump(KERN_DEBUG, str, DUMP_PREFIX_OFFSET, \
+			32, 4, buf, len, false)
 
 #include <linux/slab.h>
 
@@ -1324,27 +1327,9 @@ void ql_mpi_core_to_log(struct work_struct *work)
 {
 	struct ql_adapter *qdev =
 		container_of(work, struct ql_adapter, mpi_core_to_log.work);
-	u32 *tmp, count;
-	int i;
 
-	count = sizeof(struct ql_mpi_coredump) / sizeof(u32);
-	tmp = (u32 *)qdev->mpi_coredump;
-	netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
-		     "Core is dumping to log file!\n");
-
-	for (i = 0; i < count; i += 8) {
-		pr_err("%.08x: %.08x %.08x %.08x %.08x %.08x "
-			"%.08x %.08x %.08x\n", i,
-			tmp[i + 0],
-			tmp[i + 1],
-			tmp[i + 2],
-			tmp[i + 3],
-			tmp[i + 4],
-			tmp[i + 5],
-			tmp[i + 6],
-			tmp[i + 7]);
-		msleep(5);
-	}
+	QLGE_DUMP_DBG("Core is dumping to log file!\n", qdev->mpi_coredump,
+		      sizeof(*qdev->mpi_coredump));
 }
 
 #ifdef QL_REG_DUMP
-- 
2.17.1

