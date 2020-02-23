Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A7BC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63E20880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="YFAQUHVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgBWRbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:31:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55304 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgBWRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:31:50 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so3041774pjz.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6dGIVo3UjYXXlVZT0JsSFZVfq9hKCePvJYVI5H5zSQo=;
        b=YFAQUHVf0zt2MyAZu8lM7gR31cJMlyX3gRQMJY4BGR4+Mswf1dI2bGkInLnMWyhcd9
         IyG0rJdifSJViR8u76TSRi0GtlHnoveVNMJ2BfpC1Mg9RwSMs0yvhUI5jJkBhvbYuZvY
         R2E6Z5xWCLNE7XB4Xn6SAF3ENAurHPn96gjVpoU+3zJJvLA8r4cb8avrIFKTAoTwVj9M
         EOGWNljgRdFdExU0MmXpGIyZ5mSPyfRccUxUvqE2nT6643BIb3++Jp/KBnqllEhmsSQ0
         ghG5XZ8q+Ly9u2d5D7dCpy+r2nMSuRO2BHFxGubYrcJCWzYI3UCSj6vxwoHrINAkqWrg
         kMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6dGIVo3UjYXXlVZT0JsSFZVfq9hKCePvJYVI5H5zSQo=;
        b=Cz3j/bLh0c1QZ2iYFv8Uo7XOqRJxAPkh7GxoDRirqP884Q9+VvedBOsdAfmSEVvADC
         K8ETqjOnLK5HmryDMRclmXDGdB1+4vkLLDYB1hSXT/kM/nDPS/mTzwlwDYLP6ABLwEbD
         1JnE2ueTgJiAB6Vf/3O6vxYiKp2TDjHACKwxGRPCQ3VEFTla++/O3XhpFLmBLNHhwsRl
         yvqNruFdHMz1qObIlFy0qWPHYxDDztMamsRgM9guGEHPSpJUSfIMFNEjC+W+YRbFZIgx
         tbPZ8F0vwCDXxyF2yB4pwLrbP9ZDd//Wqtw9QbkNlGNmDhl9LCkqHTOF6Vc1PPF/OJjS
         YgWQ==
X-Gm-Message-State: APjAAAUbxT2S7Ax4P1Is9jz5hQ0StiRBUSKlj+mLbVss56FGi7QAJAxt
        xS+EqK6wTV83UtbuZRORwYWLfw==
X-Google-Smtp-Source: APXvYqyGBBa7ZW0D45+gTA7LVysPbChpy5fRDtiGdXslH4WVte23Qpr+iojvcMjWyPXg+SI34n23Cw==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr48071753plb.268.1582479101749;
        Sun, 23 Feb 2020 09:31:41 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id l5sm9030480pgu.61.2020.02.23.09.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 09:31:41 -0800 (PST)
Date:   Sun, 23 Feb 2020 23:01:32 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: qlge: emit debug and dump at same level
Message-ID: <20200223173132.GA13649@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code in ql_mpi_core_to_log() by calling print_hex_dump()
instead of existing functions so that the debug and dump are
emitted at the same KERN_<LEVEL>

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---

changes since v1: make code of ql_mpi_core_to_log() simpler.
changes since v2: directly call the function instead of defining a
macro.

Also, can you please help me understand how are are numbers 32 and 4
chosen for the function print_hex_dump()?

----
---
 drivers/staging/qlge/qlge_dbg.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index c7af2548d119..44fb3a317b8d 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -1324,27 +1324,10 @@ void ql_mpi_core_to_log(struct work_struct *work)
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
+	print_hex_dump(KERN_DEBUG, "Core is dumping to log file!\n",
+		       DUMP_PREFIX_OFFSET, 32, 4, qdev->mpi_coredump,
+		       sizeof(*qdev->mpi_coredump), false);
 }
 
 #ifdef QL_REG_DUMP
-- 
2.17.1

