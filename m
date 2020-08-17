Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66104C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490EA2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689113;
	bh=rsrKN8/Zq2kTiieVqJx9AAitOPFHZwp5YN/wsqrv6uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyN5O51ja4qv834ECtHcL5HXUqxm6aQnkXKoZr+bId60zU6iAUy8/XBuUkOub/eoH
	 hUAR3vC6UoZJP4eAxokxt16o70vR3bIBIITT1V1iATjJZir+mevja1E6nPhS3Hhmtf
	 mn5szfMjRn7wzuxS/HpveY4cHM7ybIfBVLV8M5i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbgHQSbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387808AbgHQQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:00:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3D7207FF;
        Mon, 17 Aug 2020 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680058;
        bh=rsrKN8/Zq2kTiieVqJx9AAitOPFHZwp5YN/wsqrv6uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/ZHfAbMtlZYoWd1/Xhru9McQV+PRuPMKYl8Jlm+2c/cNaRHA3UvxoRq+gG6r9+i8
         hfwn1/wpqf/OjEphm5sttD4aR8r0fDLG6d22tGYMoPKBHN9osc+q5XknkRLSZ2h1PH
         JlApKS5++FKwtOZfG+ZpYkjDuWQomkHAPew7yiTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/270] ARM: socfpga: PM: add missing put_device() call in socfpga_setup_ocram_self_refresh()
Date:   Mon, 17 Aug 2020 17:13:58 +0200
Message-Id: <20200817143757.642855276@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 3ad7b4e8f89d6bcc9887ca701cf2745a6aedb1a0 ]

if of_find_device_by_node() succeed, socfpga_setup_ocram_self_refresh
doesn't have a corresponding put_device(). Thus add a jump target to
fix the exception handling for this function implementation.

Fixes: 44fd8c7d4005 ("ARM: socfpga: support suspend to ram")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-socfpga/pm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
index 6ed887cf8dc9a..365c0428b21b6 100644
--- a/arch/arm/mach-socfpga/pm.c
+++ b/arch/arm/mach-socfpga/pm.c
@@ -49,14 +49,14 @@ static int socfpga_setup_ocram_self_refresh(void)
 	if (!ocram_pool) {
 		pr_warn("%s: ocram pool unavailable!\n", __func__);
 		ret = -ENODEV;
-		goto put_node;
+		goto put_device;
 	}
 
 	ocram_base = gen_pool_alloc(ocram_pool, socfpga_sdram_self_refresh_sz);
 	if (!ocram_base) {
 		pr_warn("%s: unable to alloc ocram!\n", __func__);
 		ret = -ENOMEM;
-		goto put_node;
+		goto put_device;
 	}
 
 	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
@@ -67,7 +67,7 @@ static int socfpga_setup_ocram_self_refresh(void)
 	if (!suspend_ocram_base) {
 		pr_warn("%s: __arm_ioremap_exec failed!\n", __func__);
 		ret = -ENOMEM;
-		goto put_node;
+		goto put_device;
 	}
 
 	/* Copy the code that puts DDR in self refresh to ocram */
@@ -81,6 +81,8 @@ static int socfpga_setup_ocram_self_refresh(void)
 	if (!socfpga_sdram_self_refresh_in_ocram)
 		ret = -EFAULT;
 
+put_device:
+	put_device(&pdev->dev);
 put_node:
 	of_node_put(np);
 
-- 
2.25.1



