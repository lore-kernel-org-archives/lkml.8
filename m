Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358CA2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LQ7iQVlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgEUVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:50:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2AEC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:50:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so8809582qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0JGejAkD+7qrrtavSgAF90fR3bzb3rcFP1ihXQ8LxTY=;
        b=LQ7iQVlbYxCXH3hmKUL/SJehnc2Ik5GGdDuWeTT9p/roUvarRoeY7kzVbH95FSKxLJ
         TXbsKBA5iNFt3ZxRkFpY6A1f3avdB3OrQMJMwr9OqoZ5gfmerP/SDx34E35N2JZ3PeBC
         YpA9DUuJpQq9GRSfIbol/+2wXVsFJm7lQQBH3qfJkCbdgzIN3LKUAUNltQAOxTkDVjMW
         NNAVMN28x2H2RdgRPchhpxWYj/6b1UOZtVY/RjuX2GO3vYn9dUtbpyoLaJy1S7SsEMkw
         mSSkezM4FSF1mvWAbDBSamTp5Lirz+tS7KmhrqGZgUOwwUYkPToRDvsL2EiZZzC0GE6C
         Mrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0JGejAkD+7qrrtavSgAF90fR3bzb3rcFP1ihXQ8LxTY=;
        b=P8OuqVsB20WmYPY4FoTgezjJFgk4TzlVc7IyCCqUlzEkJM9ogvLRlImGgfxIN2jXjb
         riwytU0UkRm/P4RQO16lWoXwwEJ9bMQPf77XYPMh3WYirprddNaJaOCCj2M6wYlL/Zv0
         dPRrKMAG0fuwUbXVk+oXl5RbnyJQ57yx8tsUmioobeAEn/l86yNRh1vaAeOWNITOoJrS
         T5+AYN+cjPAaGDHx8iiRSamO+RNGGq6Bm0GbmJ5D3x5y0cjJmu7bSvHOaVUNQ73D25v0
         oCQmZyuthtYzxxUVFAmxfThUkIUjdsuZ+dxaaP1b0LlTIyjx8PVmAvmBniCTpqM/lmLJ
         7a2Q==
X-Gm-Message-State: AOAM531mzGP85a9FVs1Mibpo3Bn4Y8lzhkue/o4mQ9LXFV1jk6ESR1T9
        Mwdr0jh+f71BoaVz0kU2Kv2UeA==
X-Google-Smtp-Source: ABdhPJzEVmJYgUyMq25WuP/d5wyqW/jaKxMoP0xw4pkSX2jhBu33EjHjLJ/QbjVmE+CfXVldi1v5+A==
X-Received: by 2002:a37:a1c7:: with SMTP id k190mr12288348qke.166.1590097841090;
        Thu, 21 May 2020 14:50:41 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m33sm6334180qtb.88.2020.05.21.14.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 14:50:40 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] iommu/vt-d: fix a GCC warning
Date:   Thu, 21 May 2020 17:50:30 -0400
Message-Id: <20200521215030.16938-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
introduced a GCC warning,

drivers/iommu/intel-iommu.c:5330:1: warning: 'static' is not at beginning of
declaration [-Wold-style-declaration]
 const static int
 ^~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f75d7d9c231f..ff5a30a94679 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5327,7 +5327,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
  * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
  */
 
-const static int
+static const int
 inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
 	/*
 	 * PASID based IOTLB invalidation: PASID selective (per PASID),
-- 
2.17.2 (Apple Git-113)

