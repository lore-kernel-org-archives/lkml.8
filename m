Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09974C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBFF2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726753;
	bh=Ha8hus8kNUcxNjEXYLlcqZknjg8ABCTXWAqD0vvPCzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jd02y6ZPZyTNVHbRVrzNd8LaW5CPk4v37sKH+3zOO4F0ozr3iap86IhryWuNrTKkc
	 nHXfzTUrVoB/PXfV4Yai6c9Kqvt3M3SAxmywtvFS/cFFFRo75TDg7wxBGM3vUj1+Oi
	 qyocOtgrDOvThFqyXgozQIbaKCARmFdASfUPuXZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbgFISTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbgFIRts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E36D207F9;
        Tue,  9 Jun 2020 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724987;
        bh=Ha8hus8kNUcxNjEXYLlcqZknjg8ABCTXWAqD0vvPCzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWXGqHRJLgG9jfZpH8WrEp/Esf0h0n705o3l2S5r5kb5rTqQdZvzD8/8AK4q/nUX9
         lADE2QjRwkpCF7lqRePdxCDTF/PzhbQHzAK9f57rdgHtsE9it1RG1pMrByuljtzT2W
         oytYTUGnVnCYaywlwB02PYVT+poyHRqXq8RLIOKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Greco <pmgreco@us.ibm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/46] ARC: Fix ICCM & DCCM runtime size checks
Date:   Tue,  9 Jun 2020 19:44:23 +0200
Message-Id: <20200609174023.542770029@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit 43900edf67d7ef3ac8909854d75b8a1fba2d570c ]

As of today the ICCM and DCCM size checks are incorrectly using
mismatched units (KiB checked against bytes). The CONFIG_ARC_DCCM_SZ
and CONFIG_ARC_ICCM_SZ are in KiB, but the size calculated in
runtime and stored in cpu->dccm.sz and cpu->iccm.sz is in bytes.

Fix that.

Reported-by: Paul Greco <pmgreco@us.ibm.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 6b8d106e0d53..11c2c4a3fe69 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -15,6 +15,7 @@
 #include <linux/clocksource.h>
 #include <linux/console.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/cpu.h>
 #include <linux/of_fdt.h>
 #include <linux/of.h>
@@ -355,12 +356,12 @@ static void arc_chk_core_config(void)
 	if ((unsigned int)__arc_dccm_base != cpu->dccm.base_addr)
 		panic("Linux built with incorrect DCCM Base address\n");
 
-	if (CONFIG_ARC_DCCM_SZ != cpu->dccm.sz)
+	if (CONFIG_ARC_DCCM_SZ * SZ_1K != cpu->dccm.sz)
 		panic("Linux built with incorrect DCCM Size\n");
 #endif
 
 #ifdef CONFIG_ARC_HAS_ICCM
-	if (CONFIG_ARC_ICCM_SZ != cpu->iccm.sz)
+	if (CONFIG_ARC_ICCM_SZ * SZ_1K != cpu->iccm.sz)
 		panic("Linux built with incorrect ICCM Size\n");
 #endif
 
-- 
2.25.1



