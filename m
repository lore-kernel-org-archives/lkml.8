Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00205C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D3720731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVitylsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIKHTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgIKHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:18:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE840C061573;
        Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so1273056pjh.5;
        Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OyHRsDWTwMRTyzulbmLLOJZ2mID3gfkA/ty0RlUCJDw=;
        b=pVitylsmiIGpR7HJJYY+nmTP75Y8dGdivC+iP1craDz+Dt7dNeAW33YhMpCfl/ALzH
         X1NKkc2of3AFerdp6Vp03RAftGPfK/b8FaAqXj6TKEK+xyv+sH1HJxnhwBtECw9YS8sh
         5zddi9kzFe5Rq/mV03md5v8erurxvNYOSvbO9IxeCweylCYSOLw9tkUxnmFF0zYAo7Xn
         lc0eEJIdLYqpX7XBzlMpPli3iE3tOxG3wtFeTWQGgn4si6Nhe9iTnBG98nw++YXXGrSn
         4ndsfHUHjtYIiiho94cByNpq+7dqBuj1PH5FAuQdDMwdMItO4BgRQjcVLrBZ9D0bcFrc
         W+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OyHRsDWTwMRTyzulbmLLOJZ2mID3gfkA/ty0RlUCJDw=;
        b=Rr6/P/76+XqyRhZhZvNQHl4Cly78hr4gXrfOpS3BDUpFmlbvPLjjw2KHCbkE9XQF+/
         trzwCxr+mlKzBjsvRhWkfYxX4rM9nrMuIZnPf1OVPG+xYr6KEtM6J/ZcS4W37oSmgxEs
         oens+sj6tUvj/wZcj5ckBlZd7TNlliJzLwhXatlJ20N1oGgE4V6Yx7X2sh4z5m7a9WuE
         /xOoY12iQSLD8kuOVteZ5xt5WTve4UmXSJXAbOLUW3w5qtgxgV8y7s5jy9Vu0wv3LKsc
         h54CYT9Pqhkc9jkwoGJDJzu7DhIltNKEL1kmpyHw+fZX8XaUDjN6menJawQFGaIfo6cJ
         /3fw==
X-Gm-Message-State: AOAM5327L9NrGXz8QQQdvDckx7tXCM+nDpW4q+yanEsxU7ZYEowoDgJ6
        09+Uk/EknJKcubUPce/c/0g=
X-Google-Smtp-Source: ABdhPJxpn9KKgWHFYtD1mbU4KfkmnA+nP3POOmf8qz3WmWNf6rhS2ojWFubv5+VmZDNXVESJrncxQQ==
X-Received: by 2002:a17:90b:80a:: with SMTP id bk10mr997358pjb.53.1599808738474;
        Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        vdumpa@nvidia.com
Subject: [PATCH 0/3] iommu/tegra-smmu: Some small fixes
Date:   Fri, 11 Sep 2020 00:16:40 -0700
Message-Id: <20200911071643.17212-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a series of small fixes for tegra-smmu driver.
They might not be critial bugs as current mainline does
not enable a lot of clients, but be nicer to have since
we are going to enable the DMA domain for other clients
in the near future.

Nicolin Chen (3):
  iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
  iommu/tegra-smmu: Fix iova->phys translation
  iommu/tegra-smmu: Allow to group clients in same swgroup

 drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.1

