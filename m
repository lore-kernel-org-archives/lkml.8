Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555A3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240D5207BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929910;
	bh=rsrKN8/Zq2kTiieVqJx9AAitOPFHZwp5YN/wsqrv6uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B7nb6dmnAF54u+/0CPrXB9koL3FmxGuZtA1yomrnGYBrAdL39p31tX3eRBbJGaDNR
	 vWbtNq5MPljKbn9ecLAaFysKYNX13TlnxnROGPPcinRfDJtzsYutV43BqFbKJ1MTBI
	 5qjhSvmTE/Fw+rV9ebMM3xtCMkBfcvG3wB3L+D4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgHHXi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgHHXi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8F220748;
        Sat,  8 Aug 2020 23:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929907;
        bh=rsrKN8/Zq2kTiieVqJx9AAitOPFHZwp5YN/wsqrv6uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUXHkCB7zRbHXrOsXjzKD9SJOOhO75Qz7U5K2cnJYWCVl7pQ6tYXfNklrf3lcGdaF
         Is0KWH2+EXn/qQBpyw/qbaHXcARdA+VRoHUVAtuVAEEF/1bBEQrJaKuLeBfjYB7OzQ
         1SSSBhpSViqo6Ef9RXW4fF2f4YkX8A9ghT7lD+KQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 45/58] ARM: socfpga: PM: add missing put_device() call in socfpga_setup_ocram_self_refresh()
Date:   Sat,  8 Aug 2020 19:37:11 -0400
Message-Id: <20200808233724.3618168-45-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

