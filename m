Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B8C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8862083E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956153;
	bh=UqJi1Cd1ki/EcIWIXcChXTjP/XpNmsjxdc58Fdu+XQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xy4brA3L92720Dp+VwAeYF9SB4W+4q8WptGn3VSuzLlX/Mzv2EdS3W7d6NgDS7/A3
	 d58TTDkwBuQl0c6+xSZmJZBV089mwYF0zPxDNGPfcyfrOU8FLxtn9Et+FAkk4LrJDS
	 JvQEPODBu9erl9jtlas8ZXrLvYo1jsP0gzN5ubmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgG1RJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgG1RJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:09:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD73207F5;
        Tue, 28 Jul 2020 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956149;
        bh=UqJi1Cd1ki/EcIWIXcChXTjP/XpNmsjxdc58Fdu+XQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fs/MEgnTSxxCi5jA3YzqQTDPVc1zsYyTyPewoVynXtXG436QcvHVNBES/dt+LX63h
         nRyXeUxTKE1IKYMh0KuPqyHnRkagxVZsSKrMRdVTm4q4wZJSXhaxpldwOKBOERXu1c
         1Qmu0h6gsj3CVgNTM/6t8h91s00U9MemBEDjf1Nk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] iommu: intel: Drop kerneldoc marker from regular comment
Date:   Tue, 28 Jul 2020 19:08:58 +0200
Message-Id: <20200728170859.28143-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728170859.28143-1-krzk@kernel.org>
References: <20200728170859.28143-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/iommu/intel/dmar.c:389: warning: Function parameter or member 'header' not described in 'dmar_parse_one_drhd'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93e6345f3414..ba47edf03941 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -380,7 +380,7 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
 	return NULL;
 }
 
-/**
+/*
  * dmar_parse_one_drhd - parses exactly one DMA remapping hardware definition
  * structure which uniquely represent one DMA remapping hardware unit
  * present in the platform
-- 
2.17.1

