Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDAAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8320787
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BowF3PwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQAQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgGQAQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8CFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u5so4497848pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sl4GNsmArDLipzZLi4IQVk0TOodt16D37OUgWF5KbPo=;
        b=BowF3PwOju4VnW5jUNBztNr1QHxUEqy6HgjuXfuKh5dztvWW9CDzCYmzt53X4es9xV
         RlSOQ69RWaykSCNTQqfIuQTyahoqTJ1Qq+wjNd4t3mq49H33azZSu94Wo3tTp/EzNMSV
         Y7UAuPuqAEvl7l9bkXQPh6qsQiSrCiD4TjJykBMTSgncyJJM0WV9KQ+tzStfHur3Qed+
         yW2tN0Ig6kRObfnuHsbUU6oHen8rYu7+FKCPneQuomx9XugKY1Jzu2LOxVUi+TupWX+z
         MIKZFc9U6nQIH+p0hDJ+v8GeWcFYgfr4eM2FCi1Loloh4liZ0bxGo7kKE1bkyL7CHWQ+
         kJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sl4GNsmArDLipzZLi4IQVk0TOodt16D37OUgWF5KbPo=;
        b=H7tTmXY1lqL0ty/3/GXkAKId4D2YO3i0llUiGP9l8EO5MsvzeVATez1be+bt4SKTLK
         BZbA5RJuk4f0tD1e54V9ox/q6ER/EoW+Nqb6fIeM4TrOPY9hu1Cfdf61wvZ2B+DYMiGI
         8gSKZFIPvkMZShY7qoF6w35H14GdPZyCXEWK6h1QATUz6lnNkGZ+Hk9HDyvV46PXYeQA
         EveUl4OugvS19rQmVHPPLjI65Ayzh7tV0aQPUvKp6DzfH5Ryp14EkdSbwrOhaa4C1M35
         bnCCi5dqUYVGMJpU4IlKBWKTZXpfYqumawEww2cIXp6vGihyvjDI9yxxV16cBcTCw/OX
         ZzTA==
X-Gm-Message-State: AOAM530aMl5SD1dnHo6H3kSyocW0JcEEW7z6lU7WFBWSyvsh8gAMJfLY
        Di8ZBUcmwr53K6B5tsiaEVxK9g==
X-Google-Smtp-Source: ABdhPJyyEAViHTA6jZ1fWkKlx3Fq/q+F6yP4gOxKkTTTvDCGA+QkPdiuE8amuhBa7Q2HIfcbSX2LeA==
X-Received: by 2002:a65:6089:: with SMTP id t9mr6633639pgu.236.1594944981548;
        Thu, 16 Jul 2020 17:16:21 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/5] iommu/arm-smmu: Support maintaining bootloader mappings
Date:   Thu, 16 Jul 2020 17:16:14 -0700
Message-Id: <20200717001619.325317-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on previous attempts and discussions this is the latest attempt at
inheriting stream mappings set up by the bootloader, for e.g. boot splash or
efifb.

The first patch is an implementation of Robin's suggestion that we should just
mark the relevant stream mappings as BYPASS. Relying on something else to set
up the stream mappings wanted - e.g. by reading it back in platform specific
implementation code.

The series then tackles the problem seen in most versions of Qualcomm firmware,
that the hypervisor intercepts BYPASS writes and turn them into FAULTs. It does
this by allocating context banks for identity domains as well, with translation
disabled.

Lastly it amends the stream mapping initialization code to allocate a specific
identity domain that is used for any mappings inherited from the bootloader, if
above Qualcomm quirk is required.


The series has been tested and shown to allow booting SDM845, SDM850, SM8150,
SM8250 with boot splash screen setup by the bootloader. Specifically it also
allows the Lenovo Yoga C630 to boot with SMMU and efifb enabled.

Bjorn Andersson (5):
  iommu/arm-smmu: Make all valid stream mappings BYPASS
  iommu/arm-smmu: Emulate bypass by using context banks
  iommu/arm-smmu: Move SMR and S2CR definitions to header file
  iommu/arm-smmu-qcom: Consistently initialize stream mappings
  iommu/arm-smmu: Setup identity domain for boot mappings

 drivers/iommu/arm-smmu-qcom.c |  48 +++++++++++++
 drivers/iommu/arm-smmu.c      | 123 +++++++++++++++++++++++++++++-----
 drivers/iommu/arm-smmu.h      |  21 ++++++
 3 files changed, 174 insertions(+), 18 deletions(-)

-- 
2.26.2

