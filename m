Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B16C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20FC218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="M/H3SK/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEIB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 21:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEIB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 21:56:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 18:56:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f13so3313755qkh.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6aNrpLgarISzda+xo8JJ01KVr07p8YFJB55nCgXOUg=;
        b=M/H3SK/QI764fDKa50a73fqtS9IfCk2173bwOb54DjMcvfCK4GJaMddC2pZSoiOCr5
         gaVYd+CZW+bvd014XbtNGcPkHvUesahxWTXu83v9h8GQy9pD7YA+/VtygJNkLVwKwu2W
         3mH1DQX5JNaz5btdocptRtiPjjLnfIWUF29feDg5W391AbWPx6kh3APuZ1gJXdD+Cpp8
         60jvnS+n3jEEDx01NHqBIAFIQCUwdTsCN2KddgcruNvZARMc1lQfjDuZG2Z3IsZZfrCO
         DLNLqufNpnhd6fsZx81smmmtpWa8+Kj1A9YLe17udKkeIM31Uwizpwzf6S9dqGNmBQsW
         UO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6aNrpLgarISzda+xo8JJ01KVr07p8YFJB55nCgXOUg=;
        b=oGIr9JXbG8g07xpFoozpaKTiOOPzR6l8aQFIoVaH+3cJzJYwL9OdCwy4aK2nzbV+gJ
         I4SYx6EE9DtlqKNu7RSfeURNRWZYUo5I6UfQDWOZb8H9NEXGiWgKdxSMEF1WQC76M/Wu
         gO0zjm8wb0V854uWdOM4SSWHL7Nizi5KtVjoku71PmjtZvZ84V0gAwcA0WRzc6vjQtKl
         XxFT7pymMFTjdrSvbPUt/4gbUSy55dnNestxyTDZg9b+eHZc9+vRwwymCW0RTcG/3Mh1
         J7Gs3yMjbmFWa0O3fwKQxS9Bx2j8sXRuBzb9xeIsGjAeo7yHo9L5j7RnprU2THmM/WuE
         eK1A==
X-Gm-Message-State: AGi0PuYlVI0Cnq+aWnBHWg7vo2rzXjt83AfMfVjixfmCsao5pb23ATgo
        6/Ad36vge6v7446vDnx64YVyqg==
X-Google-Smtp-Source: APiQypLkpVuPG2duq9fDZJmd5Lg1XiTR/9OSoq/UcFdtjZrghmKWDw1/OYWw2ix1GTyeRKcCizl09A==
X-Received: by 2002:a37:7ac2:: with SMTP id v185mr5419583qkc.386.1588989412051;
        Fri, 08 May 2020 18:56:52 -0700 (PDT)
Received: from ovpn-66-195.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p22sm3079186qte.2.2020.05.08.18.56.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 18:56:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] iommu/amd: fix variable "iommu" set but not used
Date:   Fri,  8 May 2020 21:56:45 -0400
Message-Id: <20200509015645.3236-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit dce8d6964ebd ("iommu/amd: Convert to probe/release_device()
call-backs") introduced an unused variable,

drivers/iommu/amd_iommu.c: In function 'amd_iommu_uninit_device':
drivers/iommu/amd_iommu.c:422:20: warning: variable 'iommu' set but not
used [-Wunused-but-set-variable]
  struct amd_iommu *iommu;
                    ^~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fef3689ee535..2b8eb58d2bea 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -419,15 +419,12 @@ static void iommu_ignore_device(struct device *dev)
 static void amd_iommu_uninit_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
 	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
 
-	iommu = amd_iommu_rlookup_table[devid];
-
 	dev_data = search_dev_data(devid);
 	if (!dev_data)
 		return;
-- 
2.21.0 (Apple Git-122.2)

