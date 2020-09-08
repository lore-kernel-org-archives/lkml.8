Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A83C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841E92087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593223;
	bh=B97NLXDNmXiVAlhX37PNK8zdprVaWzpuhoXhsMeIYVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gae+4prh650sXN8YrGgr11AHDgq1Gc+ScPK79oYj4MJw8aLUVPKOBi+gCyY82ffll
	 l7fTLVot5lCjGtQm8h/pxpQpYRsl1FYA/pWCx7HwMZvO6guoaNBGSN0ux1hfaPlAu4
	 g6WaBHaCpTwLz2MIr/FxIbEHyUlE5MU237/SplDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbgIHT07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5662423BCE;
        Tue,  8 Sep 2020 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579355;
        bh=B97NLXDNmXiVAlhX37PNK8zdprVaWzpuhoXhsMeIYVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pi5OwjHTNeHZ/xGUfXPdiopqmPDvvPho7il2lGxvEbG0CBW4rprYr4uM7OJxekPWP
         NWrKE+OBrcHXOLCuIr0BShmQt6oRX+3Pdl3z+oYSwE01fnMJRd0PC4pODO7ppBGtrt
         nn3SfAslbFvKAI1pJbBUY/W142MKB4aktWw7mVEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 014/186] habanalabs: proper handling of alloc size in coresight
Date:   Tue,  8 Sep 2020 17:22:36 +0200
Message-Id: <20200908152242.345539632@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

[ Upstream commit 36545279f076afeb77104f5ffeab850da3b6d107 ]

Allocation size can go up to 64bit but truncated to 32bit,
we should make sure it is not truncated and validate no address
overflow.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c | 8 +++++++-
 drivers/misc/habanalabs/goya/goya_coresight.c   | 8 +++++++-
 drivers/misc/habanalabs/habanalabs.h            | 2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index bf0e062d7b874..cc3d03549a6e4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -523,7 +523,7 @@ static int gaudi_config_etf(struct hl_device *hdev,
 }
 
 static bool gaudi_etr_validate_address(struct hl_device *hdev, u64 addr,
-					u32 size, bool *is_host)
+					u64 size, bool *is_host)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -535,6 +535,12 @@ static bool gaudi_etr_validate_address(struct hl_device *hdev, u64 addr,
 		return false;
 	}
 
+	if (addr > (addr + size)) {
+		dev_err(hdev->dev,
+			"ETR buffer size %llu overflow\n", size);
+		return false;
+	}
+
 	/* PMMU and HPMMU addresses are equal, check only one of them */
 	if ((gaudi->hw_cap_initialized & HW_CAP_MMU) &&
 		hl_mem_area_inside_range(addr, size,
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 1258724ea5106..c23a9fcb74b57 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -358,11 +358,17 @@ static int goya_config_etf(struct hl_device *hdev,
 }
 
 static int goya_etr_validate_address(struct hl_device *hdev, u64 addr,
-		u32 size)
+		u64 size)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 range_start, range_end;
 
+	if (addr > (addr + size)) {
+		dev_err(hdev->dev,
+			"ETR buffer size %llu overflow\n", size);
+		return false;
+	}
+
 	if (hdev->mmu_enable) {
 		range_start = prop->dmmu.start_addr;
 		range_end = prop->dmmu.end_addr;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 194d833526964..feedf3194ea6c 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1587,7 +1587,7 @@ struct hl_ioctl_desc {
  *
  * Return: true if the area is inside the valid range, false otherwise.
  */
-static inline bool hl_mem_area_inside_range(u64 address, u32 size,
+static inline bool hl_mem_area_inside_range(u64 address, u64 size,
 				u64 range_start_address, u64 range_end_address)
 {
 	u64 end_address = address + size;
-- 
2.25.1



