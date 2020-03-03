Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6461C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B8F246D9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203960;
	bh=LJQN/i1xcn/izMiQyWEoamWpx6M4xuseQ8kP/lbMldQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/HNReyKJY+Uj6SYYldxxZuw5WEBmf6xjH6x7uogVb1SoVSDSmc6UmQQq1xjCpHqn
	 /46V6IB9s0m218AZArZ6I+ejkGHoUAWsi3M9x5sN3JTmkBv23QZkLVxw+2Khl3rAvq
	 0f83Q4lWY19eWrMSc34/WDpvcc3OmaOWDYNeyriM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgCCCwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgCCCt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:49:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4725F246E3;
        Tue,  3 Mar 2020 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203796;
        bh=LJQN/i1xcn/izMiQyWEoamWpx6M4xuseQ8kP/lbMldQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLTuJHWOK7p+uzN//ISIPNBZdvJxb7sJqIKJa2e98yO85+qvJriH7TU/9PrkV3RKy
         yGafZPrHGb3M9KiqJhp3ked54n5R7yv+DnSynvoRr739dPGjhEju52PsgncW8XqiPP
         fbEnjhLSEA5tnc5lyYoEq67uUJjfBl7I3GfQyaWA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Leif Liddy <leif.liddy@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 17/22] nvme-pci: Use single IRQ vector for old Apple models
Date:   Mon,  2 Mar 2020 21:49:28 -0500
Message-Id: <20200303024933.10371-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024933.10371-1-sashal@kernel.org>
References: <20200303024933.10371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 98f7b86a0becc1154b1a6df6e75c9695dfd87e0d ]

People reported that old Apple machines are not working properly
if the non-first IRQ vector is in use.

Set quirk for that models to limit IRQ to use first vector only.

Based on original patch by GitHub user npx001.

Link: https://github.com/Dunedan/mbp-2016-linux/issues/9
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Leif Liddy <leif.liddy@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3788c053a0b19..06cf0bc944f94 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2573,7 +2573,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
+		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ 0, }
 };
-- 
2.20.1

