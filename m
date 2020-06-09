Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72391C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C71E20814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724796;
	bh=zB/WZwl5Lv9DzA8ZRU7nN5IaoD3oyLoA2VH4IaYLapk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCGrFdcjrphFeGzLFX4Y9XQDfIKD2cwKC0Dq4CnJrLHyGDPlUTYoN/34P+MCX6Jm7
	 Ic4zyg6RwfIA3QkO2/QgwjWb/xQ3hP5abS0JEDDxanFG7FpZM5+UexZ/XXkHM8sjJ6
	 l3rdgegXGOZjbzhdFklQ7bDJx+CeXRhEDXn1av2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgFIRqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgFIRq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:46:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EB8207ED;
        Tue,  9 Jun 2020 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724789;
        bh=zB/WZwl5Lv9DzA8ZRU7nN5IaoD3oyLoA2VH4IaYLapk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdQNZo0aN68exjtCnoT2m0JhQSlOtoAKFYbPngu16WNzmYrT3nhiIE7C5t7GzwmxG
         iZOgcYve+gR2ONvjteGM7aYQOMH1187GtS4Zd1Cq0e7f+Y3Wl3Zyo5arSrANze0Eq4
         i5O9os4kNCBcMg+EAPxvIj9eciAX5+nWNcmBBlNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Greco <pmgreco@us.ibm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 09/36] ARC: Fix ICCM & DCCM runtime size checks
Date:   Tue,  9 Jun 2020 19:44:09 +0200
Message-Id: <20200609173933.818886101@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
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
index 3013f3f82b95..66e4dc8bce1d 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -12,6 +12,7 @@
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/cpu.h>
 #include <linux/clk-provider.h>
 #include <linux/of_fdt.h>
@@ -308,12 +309,12 @@ static void arc_chk_core_config(void)
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



