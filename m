Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347692087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747117;
	bh=g8iDQnd6Yr9F7M26ThvnaNNeqrJbWLkQXykum1JpWXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIaggMDxifoJUZeJnWssl0QxIwgvG2KMEPufsCpLQsjSKufu/Thq1YF7NTFKkxEij
	 1XBugF58UwISh5HxAG4jWVpSSGjthh3SpW/weddnBGjM1K/CT0+3lYB4ryM+UJyWIY
	 Caw+jorsmm3N07bhojrEM1aVR9DDySzeFa+hGcGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBCQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbgBCQZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:25:12 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27462087E;
        Mon,  3 Feb 2020 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747112;
        bh=g8iDQnd6Yr9F7M26ThvnaNNeqrJbWLkQXykum1JpWXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RD4RJH0gvlltCVDkFr0YWbOT56WMCNeckyluWO8cCiAIfVH6B1al4uZPgstqP9E++
         uyzwYzsImn3tnULrcMs2GFG4C+zgHQp/jzaMhihRq9NK1JCJzr9iderz8Rva2Qz8JQ
         5WhV3KB9/hzPe4No4O5U5/tiI+cuOD49IRyoAofU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>,
        linux-snps-arc@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 17/68] arc: eznps: fix allmodconfig kconfig warning
Date:   Mon,  3 Feb 2020 16:19:13 +0000
Message-Id: <20200203161907.915759199@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 1928b36cfa4df1aeedf5f2644d0c33f3a1fcfd7b ]

Fix kconfig warning for arch/arc/plat-eznps/Kconfig allmodconfig:

WARNING: unmet direct dependencies detected for CLKSRC_NPS
  Depends on [n]: GENERIC_CLOCKEVENTS [=y] && !PHYS_ADDR_T_64BIT [=y]
  Selected by [y]:
  - ARC_PLAT_EZNPS [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/plat-eznps/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/plat-eznps/Kconfig b/arch/arc/plat-eznps/Kconfig
index 1d175cc6ad6d3..86f844caa405d 100644
--- a/arch/arc/plat-eznps/Kconfig
+++ b/arch/arc/plat-eznps/Kconfig
@@ -7,7 +7,7 @@ menuconfig ARC_PLAT_EZNPS
 	bool "\"EZchip\" ARC dev platform"
 	select ARC_HAS_COH_CACHES if SMP
 	select CPU_BIG_ENDIAN
-	select CLKSRC_NPS
+	select CLKSRC_NPS if !PHYS_ADDR_T_64BIT
 	select EZNPS_GIC
 	select EZCHIP_NPS_MANAGEMENT_ENET if ETHERNET
 	help
-- 
2.20.1



