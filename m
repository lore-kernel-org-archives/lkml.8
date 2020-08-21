Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555FEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3412420656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029858;
	bh=KgBhFEvDd4HhOIDlllG/eGKY+sri+AR5ajXaMJEUJ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+HX5pyr9bc9DbZrQZ8roE/yZTIYoeqtCVhr2pNHNbbx3WozpdZp6lJwkqPfWUqM4
	 9TOV+p74gLJreAEqJ7fW3icQt1yBkVZcGeB0S2zYt6QmeVKIw1g3w7WNvb1J59krbG
	 sb+YHpL2KrWG+lP0f6DOvkP1akCigYcdKoC2Aln4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgHURKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgHUQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074D022B43;
        Fri, 21 Aug 2020 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026634;
        bh=KgBhFEvDd4HhOIDlllG/eGKY+sri+AR5ajXaMJEUJ+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeJBVSF4/KQNrDRR5WbuvkwTFbshHXk4SLuY7rjyya+DP8c+btSEWWKVkKa6wi5EU
         xdrQsoMaPBQCOIxY6sNJaX6BsJebquXQHPZ2bw1IpN4YnZLD/RxvvvEY2HyAcoPwEi
         afV4njtI46cn20YozA9w1ACrlOwxdPkxSTA+Ulv4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 08/48] mfd: intel-lpss: Add Intel Emmitsburg PCH PCI IDs
Date:   Fri, 21 Aug 2020 12:16:24 -0400
Message-Id: <20200821161704.348164-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 3ea2e4eab64cefa06055bb0541fcdedad4b48565 ]

Intel Emmitsburg PCH has the same LPSS than Intel Ice Lake.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index b33030e3385c7..bc0f3c22021b7 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -196,6 +196,9 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x1ac4), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x1ac6), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x1aee), (kernel_ulong_t)&bxt_uart_info },
+	/* EBG */
+	{ PCI_VDEVICE(INTEL, 0x1bad), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x1bae), (kernel_ulong_t)&bxt_uart_info },
 	/* GLK */
 	{ PCI_VDEVICE(INTEL, 0x31ac), (kernel_ulong_t)&glk_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x31ae), (kernel_ulong_t)&glk_i2c_info },
-- 
2.25.1

