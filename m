Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA4C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6D724655
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828652;
	bh=EdaxlxNioT7INiZrUk3Gj5CiZ2MoNSzxkO3BpJhuZm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbjWzpnmdHwJ35Z6F4N+7GZwvMU/9F5DeFj48LLRPtAIYpgspEnB7aPFipUBiGgFE
	 jlohuambhC5ZN+8H6XFYL4CYhRgJzE/zBLthH6sWNATEsLgTIOa5MXP6/3pzXvpGut
	 Dig8YD3gGnLOK7//Ggze+r4VVdlvd6vzE2QtFhIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgAXBRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbgAXBR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CFA22464;
        Fri, 24 Jan 2020 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828648;
        bh=EdaxlxNioT7INiZrUk3Gj5CiZ2MoNSzxkO3BpJhuZm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KknBhClq6CrjwY5qY9jQKuJhxkiBuDHrOsKIF2nKjQ+fSgXFzUDzO0nICBbswnB23
         JCHYuzcdByzcdunuq6jhqECypW2S3ieEdKh5psAnlb8+Bhr5mfe/tCUdl8udwxjOxG
         hlGCW0OEWuCZbhvJjlDsXgvpkDa6XvN7Uk02mt0E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 17/33] mfd: intel-lpss: Add Intel Comet Lake PCH-H PCI IDs
Date:   Thu, 23 Jan 2020 20:16:52 -0500
Message-Id: <20200124011708.18232-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit dd047dce3a6f5233b98e792e2287cc549da35879 ]

Intel Comet Lake PCH-H has the same LPSS than Intel Cannon Lake.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1767f30a16761..b33030e3385c7 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -140,7 +140,7 @@ static const struct intel_lpss_platform_info cnl_i2c_info = {
 };
 
 static const struct pci_device_id intel_lpss_pci_ids[] = {
-	/* CML */
+	/* CML-LP */
 	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
@@ -153,6 +153,17 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x02ea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02eb), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&spt_info },
+	/* CML-H */
+	{ PCI_VDEVICE(INTEL, 0x06a8), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x06a9), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x06aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x06ab), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x06c7), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x06e8), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06e9), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06ea), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06eb), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06fb), (kernel_ulong_t)&spt_info },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x0aae), (kernel_ulong_t)&bxt_i2c_info },
-- 
2.20.1

