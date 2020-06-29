Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8246206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467603;
	bh=0RjzG34x4n3ocMS+b94pUtVOFEowTxSu6nALCesgX8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQBnSp1C4HaVMvVDKi4eFmQiUuPtSOr7Z0eIWFlLGyNCaaiJBK9We9c9tEemyOi+A
	 a+hZo2d5ByKUe5vtqqYOtGSwMv97WnDWe5LXxEqtbxNkADbyMPVzVR0p9USmBNsPcX
	 IU8xtavkLT0m0ob3ilBBamHiudr79PB+ZKZK0+jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404626AbgF2VxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgF2Sfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C7F24248;
        Mon, 29 Jun 2020 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443959;
        bh=0RjzG34x4n3ocMS+b94pUtVOFEowTxSu6nALCesgX8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wfwc5suGqvc9kCKRuPU+/dxaDfqXtmXNtwh3SYdLBAhZngjOY7l0Gj9hs68ukOdzd
         EnMahw7Rz1SjDKaoVLP2YR9vnxnDnZ6DwkzKSK0jHeEH/YVcoYwTmmKQ94KI5t7ttk
         udzGsKngxyoL1gxyDKOb1Sp+EXrtydNEr7PTs8Js=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 062/265] Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"
Date:   Mon, 29 Jun 2020 11:14:55 -0400
Message-Id: <20200629151818.2493727-63-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Moon <linux.amoon@gmail.com>

commit ad38beb373a14e082f4e64b68c0b6e6b09764680 upstream.

This reverts commit 07f6842341abe978e6375078f84506ec3280ece5.

Since SCLK_SCLK_USBD300 suspend clock need to be configured
for phy module, I wrongly mapped this clock to DWC3 code.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Cc: stable <stable@vger.kernel.org>
Fixes: 07f6842341ab ("usb: dwc3: exynos: Add support for Exynos5422 suspend clk")
Link: https://lore.kernel.org/r/20200623074637.756-1-linux.amoon@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-exynos.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 48b68b6f0dc82..90bb022737da8 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -162,12 +162,6 @@ static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
 	.suspend_clk_idx = -1,
 };
 
-static const struct dwc3_exynos_driverdata exynos5420_drvdata = {
-	.clk_names = { "usbdrd30", "usbdrd30_susp_clk"},
-	.num_clks = 2,
-	.suspend_clk_idx = 1,
-};
-
 static const struct dwc3_exynos_driverdata exynos5433_drvdata = {
 	.clk_names = { "aclk", "susp_clk", "pipe_pclk", "phyclk" },
 	.num_clks = 4,
@@ -184,9 +178,6 @@ static const struct of_device_id exynos_dwc3_match[] = {
 	{
 		.compatible = "samsung,exynos5250-dwusb3",
 		.data = &exynos5250_drvdata,
-	}, {
-		.compatible = "samsung,exynos5420-dwusb3",
-		.data = &exynos5420_drvdata,
 	}, {
 		.compatible = "samsung,exynos5433-dwusb3",
 		.data = &exynos5433_drvdata,
-- 
2.25.1

