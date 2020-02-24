Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4EDC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C12A20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="iVRInhr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBXIY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:24:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:24:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so4746907pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lhlKxXAIvhacc2714cSl7CgN47VyLjNdXE5+TJ+pWfc=;
        b=iVRInhr+0XNetO76iReb1HcqRUj2veJmpOz2VGFnl2Wxi+8TPSjiu/xM/adgh6XmCK
         8Vk6u/EjOINY+qvQ7ISa91IkBrWENxEMunIgH0aMBekN48kC+rBPr5JyAEUo45egz+Tp
         cAfVlus1c+zANML1yovm8FDV01jcNS6RpGQajOVBDCK+/Jjc/UJNt13m1yDXbJXfPS4M
         QAqcA/H6ZQ2ZJC+3y7NBZgnRHOcGHpQmT90FXX4cLkHmg4AhWA2om8knIKC7EegqlEK1
         HwC07FQ6y/BIblr71lhZuxonaXOkd4NCVQG97jtEN56rZ5z7djSpq3XiLZDJB2BvC/Ns
         iMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lhlKxXAIvhacc2714cSl7CgN47VyLjNdXE5+TJ+pWfc=;
        b=R10nCbZSxNEkyNfjpYp1p29NFyJtgcX3dzQZ0PgX1AqJGnCZoVgMmLrMJ0e53WmCch
         7oYffyV3r5jKWuvXsbjrx54pMi0gjAPW6LmWhhFfo4AlBKJVNgdl91yHP9FWMNH649MS
         Gl+DrfMH0XRh5QARvbduvKM5qVgFUj0NHqFtrxtp/Ietf8FsFdN7wS6b6AI+R3yndMb5
         GC4LUdfAB+bMjENzyCvcZw/2TYSl/pu2L1qCarnHAjqn2soHGJ9YsKrEqlxaaDYwGkYZ
         gc646CRfDWLknwctXvBmnybu5nOtjWCLNDdJb9bukCt/jnAkwBjzoNHHhTzn1rggfmXC
         W/aQ==
X-Gm-Message-State: APjAAAX0/nak44pBjojHIwpvnOq5cU9yJ2tWQUG3d+SYCmBaK4SlAHL+
        KMXe5aDHN32MbZWoW/Bw24Wv1/5Oheo1GjIM
X-Google-Smtp-Source: APXvYqw7fF7F0dn1XMTNUKU+SpQUH74ObcV+LpB7LmVe/J4gIU4K/TSo0CCwfrQ6XOBMin29oU+CKw==
X-Received: by 2002:aa7:84c4:: with SMTP id x4mr50338458pfn.144.1582532696231;
        Mon, 24 Feb 2020 00:24:56 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id g12sm11515210pfh.170.2020.02.24.00.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 00:24:55 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:54:48 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: qlge: emit debug and dump at same level
Message-ID: <20200224082448.GA6826@kaaira-HP-Pavilion-Notebook>
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
changes since v3: Remove prefix string.

----
---
 drivers/staging/qlge/qlge_dbg.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index c7af2548d119..0c5f6859e645 100644
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
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET,
+		       32, 4, qdev->mpi_coredump,
+		       sizeof(*qdev->mpi_coredump), false);
 }
 
 #ifdef QL_REG_DUMP
-- 
2.17.1

