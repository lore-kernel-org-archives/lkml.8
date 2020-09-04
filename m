Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ACC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E94620772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZadVWzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgIDPzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:55:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B1C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:55:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so6738432qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4q/8n4d9Oz9Vv/K5aJK8Mp8Y2lRkWj0qSrttp/CroxE=;
        b=oZadVWzKzjT6kVlQDdSaTMxHoRTYYXuhfeHAqu6JmmOp3XCU0blzfKn1tJhWzX2HeS
         sK1QUgw4eOALlLrqiIa5mJ5RjG5DDMC/GfAoKvUlju9deCt1Z1cQt3mFi6Jp8dh8eAcL
         b47lB644qnhBgKdHPTa65f3vcbqa8pR/OGmGhW1uCRNIq0IP9XUGZp7dua1GTQzH7pbj
         3kOSW84l/lOtcT1dCSPEMna3Qn0g0ssFDfacD5B1snlLor1iC7Zmm6UoHviENlQKr4s3
         lC89jtyARRDB8fr0n/NnuYQLdQ/YywQuWqkj40BnJg+qClOjhyEKiVWTZ/r3SCq8UT/u
         +arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4q/8n4d9Oz9Vv/K5aJK8Mp8Y2lRkWj0qSrttp/CroxE=;
        b=EBu0TgnU2lV0VzvbRqGcPrjyHzvBygEDaqxn3F1nQctO6VoAUiku7JeKW1ado+qvP4
         HKY2eeV/J0dIiAjYAwGaUo/wJcA80Ab4JNKO+0l9IaxEijink3SM/1rrLtc2R7+Wm2Db
         9UO9p9YTk9gIe8gdfnoyOH2loe8/QHOD50GnozjhwS7ZZ+p9QenU6aeb2TBGOprgVv0h
         moE6Wt5YkP6uW3DeIR9hKsN0FF3GGYCAN1EQNCglfJVCH5cuLxNT+PoLEzymYPk6ssn2
         CK0VDiYIccBwa6VOy+NUTe/NL4/okHReIJngwfktHpPnjR+SFaCRpAStgcxPBaTR85k+
         R8sA==
X-Gm-Message-State: AOAM5331OjIXiAzBGRejBezSrU51r61lX/FG9ZHhBmh4XoF/vyV6MAX2
        8kCUN3DMHoviJO3IF9okA4yu6Q==
X-Google-Smtp-Source: ABdhPJxHXnDF5Yz7KMj3dP1Wot9aBwDE24PK5PObq0P6DKGWMzJC3jbF9SemUpoG0/uTgsf96ikT4Q==
X-Received: by 2002:a37:314:: with SMTP id 20mr8208333qkd.274.1599234915063;
        Fri, 04 Sep 2020 08:55:15 -0700 (PDT)
Received: from localhost.localdomain (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:55:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader mappings
Date:   Fri,  4 Sep 2020 15:55:05 +0000
Message-Id: <20200904155513.282067-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on previous attempts and discussions this is the latest attempt at
inheriting stream mappings set up by the bootloader, for e.g. boot splash or
efifb.

Per Will's request this builds on the work by Jordan and Rob for the Adreno
SMMU support. It applies cleanly ontop of v16 of their series, which can be
found at
https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/

Bjorn Andersson (8):
  iommu/arm-smmu: Refactor context bank allocation
  iommu/arm-smmu: Delay modifying domain during init
  iommu/arm-smmu: Consult context bank allocator for identify domains
  iommu/arm-smmu-qcom: Emulate bypass by using context banks
  iommu/arm-smmu-qcom: Consistently initialize stream mappings
  iommu/arm-smmu: Add impl hook for inherit boot mappings
  iommu/arm-smmu: Provide helper for allocating identity domain
  iommu/arm-smmu-qcom: Setup identity domain for boot mappings

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 111 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 122 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  14 ++-
 3 files changed, 205 insertions(+), 42 deletions(-)

-- 
2.28.0

