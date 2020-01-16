Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF334C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E42072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201461;
	bh=LYNpR484DPPn0EQwZovPvoMildHHBmqnttNUBD+W6As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrRGugxf4wmHq/DT/rwfTYHS7bQzEQ4U7P8uK62GK/qywilyqqpRTlHSxDc7hDyzK
	 ziEIrWhWoVgDtMoi1noNJ7NII1TJaoXkeBA+dB1MLBg40wynxPh2O6ipnYNYfh5mt3
	 KPihfu4iambhMLT4yK4Ibm6NyyFXySFJmEOP1xlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407296AbgAPTET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:04:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388349AbgAPRCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:02:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EEC62073A;
        Thu, 16 Jan 2020 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194143;
        bh=LYNpR484DPPn0EQwZovPvoMildHHBmqnttNUBD+W6As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XniqBRCAQxEhMIQ1YhOdHRzw7gDLlKwQxp/WoRMz+4P+s6VXX1B8pbd6gM67rXz+
         PmTr91KMetWynBxHDZu40J+LbS+LZBbc0by6zQrA3aSAaqcFRz5gqELSZ8loxD0OOW
         aVMTjheN4zE5Tf48C7Bl6wYJIfH7U0GqEXyaMTfw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 229/671] iommu/vt-d: Fix NULL pointer reference in intel_svm_bind_mm()
Date:   Thu, 16 Jan 2020 11:52:18 -0500
Message-Id: <20200116165940.10720-112-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit c56cba5daf45d2d091ef1cfe2f1d6a930446687b ]

Intel IOMMU could be turned off with intel_iommu=off. If Intel
IOMMU is off,  the intel_iommu struct will not be initialized.
When device drivers call intel_svm_bind_mm(), the NULL pointer
reference will happen there.

Add dmar_disabled check to avoid NULL pointer reference.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reported-by: Dave Jiang <dave.jiang@intel.com>
Fixes: 2f26e0a9c9860 ("iommu/vt-d: Add basic SVM PASID support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 188f4eaed6e5..fd8730b2cd46 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -293,7 +293,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (!iommu)
+	if (!iommu || dmar_disabled)
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
-- 
2.20.1

