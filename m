Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D59FC4345B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9FB206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281479;
	bh=2YIIIe82rhQonM8OSS7nLOwgi3BRrqAqK7yxquHChVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2j76iYI7KYjo2L4BPKaRR9Hl30E2H2reELYL01+51rc3ehnlqyoLhzZlCeVD6q/n
	 hJnjFUOpCYF7kX8/gJ4Ez7qbAOaIUIrM7e5+Ca6tHipqTP6mvMiJk8dzQ6NEaUBJVH
	 G7FnWGhzoqhlInX8U5QE247P881vohzYDZB7niSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgGTVoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgGTVhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D45F22BEF;
        Mon, 20 Jul 2020 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281071;
        bh=2YIIIe82rhQonM8OSS7nLOwgi3BRrqAqK7yxquHChVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzusJQEuKZrW3Bm/OgTBZZt9Stf9RKzMVdvN3Fr3pW5te8z1dwC5mQplh5ClPUIaP
         BunofKoXPepcDdzRahTRvWOHeW6PLNTthL1dIM5Jq678zVDKO4Z7kUDyBrO07jfPQl
         mbhr100SotkmqFzVi01a/+8xQaFeScKWDoUR1sXM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 29/40] platform/x86: ISST: Add new PCI device ids
Date:   Mon, 20 Jul 2020 17:37:04 -0400
Message-Id: <20200720213715.406997-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit e1eea3f839f41368d7cb4eb2d872d5b288677e94 ]

Added new PCI device ids for supporting mailbox and MMIO interface for
Sapphire Rapids.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_common.h   | 3 +++
 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c | 1 +
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
index 1409a5bb55820..4f6f7f0761fc1 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
@@ -13,6 +13,9 @@
 #define INTEL_RAPL_PRIO_DEVID_0	0x3451
 #define INTEL_CFG_MBOX_DEVID_0	0x3459
 
+#define INTEL_RAPL_PRIO_DEVID_1 0x3251
+#define INTEL_CFG_MBOX_DEVID_1  0x3259
+
 /*
  * Validate maximum commands in a single request.
  * This is enough to handle command to every core in one ioctl, or all
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
index de4169d0796bd..9a055fd54053f 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
@@ -148,6 +148,7 @@ static long isst_if_mbox_proc_cmd(u8 *cmd_ptr, int *write_only, int resume)
 
 static const struct pci_device_id isst_if_mbox_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_0)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_1)},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_mbox_ids);
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index 3584859fcc421..aa17fd7817f8f 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -72,6 +72,7 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 
 static const struct pci_device_id isst_if_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_1)},
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, isst_if_ids);
-- 
2.25.1

