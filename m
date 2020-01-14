Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A2EC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EAC222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579014744;
	bh=75Qd8C/3vuCDQUhPR4q3BDnlMSsYtO6sfIxAk6Pl4bI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NNV0qC4tpwM8qNcsZwxdXPFMxCxAte+1B1LqVi5Eg19VuOycrJomGmysTSRk3EkNa
	 Mg68fPT+Jb/GUOtl+J97MMO0Zw973Q8YMIRXynWy5aveu3GbXeg7jjmBMNbbbPbzsU
	 wjpy1Yr8JzqiA9kPQprHF2MG4dOMLR5hxP0TfzW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgANPMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:12:24 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39849 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgANPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:12:23 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so14162803ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkGZG7SrCg/dkC5ag7U6FC/+BJoAtyAPaz4N+sK3NTU=;
        b=UXrUv4mDNhE+LH+9At0LmtyxUu2Z40+9NS0Ktltdfw4q6iyq6yksNKateEPraVHvkM
         b9GWB7C4mBdDiOES6HOfWXBe/0MMUg5+9nNgoB52WFEDKHAt8UkdzxeI+IadsQBCsBd5
         EArO0SwQWXOGFiXKu7oun4s5rm2kd2HdlRlto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkGZG7SrCg/dkC5ag7U6FC/+BJoAtyAPaz4N+sK3NTU=;
        b=FFTEJ51fIXcBaXoJm3L06CwCI1J1hZewLUkoFF5Yw+dDWKc5o7K/TaLK9BNmDxt5e1
         I7LqrgBpVFIc7WmluKxE/0tMq75UG+OGiY5xYG0yGUF+kKjMXcyvz/xs7C+ieeHxqeAb
         Z0S3KLRkqQRc1B3Qg93XH9LpR43Wt/Ee9I6DDlgv2kBnoA0lkDlBdCfzFCFvPTjvg0hv
         UQ9eWMgKlTNDRyjxcB2Hdg3cMbzwVCg/RtGerH/kbv5BDVCfgf3BM2cXw9qoVggYxC2K
         UYu3WP6FcbSLwpHaYfC4viCHLND3Rc85qsm4PnhNBr90s6LLe6WhZ3gAsphq/fK2RtY6
         70qg==
X-Gm-Message-State: APjAAAVIBtJV+gzQWW4fGPbVujiTgOHXtyflVJ3pv2C37CkIkpT3fZdr
        QgCQ+ajs2a+PmUApWleXeh3ZFQ==
X-Google-Smtp-Source: APXvYqx7NRi22leRc5ddyOl/X7SLLbpIm7rIxKyIP+F/4ZOOcaI37n9oV2Ou7EI/V2rDZItw6s/SwQ==
X-Received: by 2002:a05:6602:235b:: with SMTP id r27mr17579379iot.51.1579014743030;
        Tue, 14 Jan 2020 07:12:23 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a9sm4958922ilk.14.2020.01.14.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:12:22 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     joro@8bytes.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
Date:   Tue, 14 Jan 2020 08:12:20 -0700
Message-Id: <20200114151220.29578-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_iommu_perf_ctr() clobbers the register when it checks write access
to IOMMU perf counters and fails to restore when they are writable.

Add save and restore to fix it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..c0ad4f293522 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1655,27 +1655,37 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0;
+	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
 
+	/* save the value to restore, if writable */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
+		goto pc_false;
+
 	/* Check if the performance counters can be written to */
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2)) {
-		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
-		amd_iommu_pc_present = false;
-		return;
-	}
+	    (val != val2))
+		goto pc_false;
+
+	/* restore */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
+		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
 	iommu->max_counters = (u8) ((val >> 7) & 0xf);
+
+pc_false:
+	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
+	amd_iommu_pc_present = false;
+	return;
 }
 
 static ssize_t amd_iommu_show_cap(struct device *dev,
-- 
2.20.1

