Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DB0218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLdfO9Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgIHH5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgIHH5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29772C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:57:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so160312pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ITdkk36tx9oBNoeh+htptP26+GpLBLf3As2BXQ4eM1k=;
        b=CLdfO9RzXJzpfk8lmE2Wst3FdItUkCfAYmuowNuE88a7a1WPiN6S9D5Z3S/rzKmDLM
         haVL+hkxhNc+BfT6GpMVG4VRBJTFkKHn6vsyrMuSKCO241m+QripjjpGjtO8IABKQDI6
         7T/IJbulr09PZ59rrhIa4yASomd9RbTXUD8b1R5Hw8orz8J8Q+Ella/jW9+o+LhszXYf
         fhidD76Q8Tr+DXLcTeCxUj+F2HJJCXx1QmoYQokl+ziA+k0xaUrLEA96WofYQaS+xqG0
         /ESezN1Pf0+wA6FkZrXvYkVYhUqZpzxHymCNtZuaoJiP8PjTI/ZflhvJ/f/AAcWSTz6I
         mchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ITdkk36tx9oBNoeh+htptP26+GpLBLf3As2BXQ4eM1k=;
        b=nPa1QupKmOiGwMJbk5uKVeT8YQ2R1V3V2W5bIcxtRIY15fDvX0YZVE/kMDc943fk66
         hRhu/yNTC3IC4DNXF2tE1MNLcYNIIbnGXrDyis/I7uwNqv7sMgFhFyngJUQDBYiQzO++
         +lpc6MHvhylcO4f3n0S04r7PWD7rLsgXeDZJS9bfH8BxFKUM+BPcouW8XZrQrnelCUyn
         ephRDBqoGqrlHV/kQXzG6/6fPkn/OZ9xPFph6/ro8NpanIeUDN5Mj7jRN41Q8WQp1pdB
         y3q11KEpjWkOVx5x2I3naCCT1wuXnoML24dLN7Rgk98MpxEEhKw0ABCmwYzOXFY9P+ji
         30LA==
X-Gm-Message-State: AOAM530LqxYI4c/XCmr9GTpigJ8DCiIieS8Ndqu54tEFXHlzdvqDSgjg
        4emR7XivlwocEP4gWzBtHHQS
X-Google-Smtp-Source: ABdhPJxQqQutMxwbopIVDuWQ82nAqur0M9bIpK2rrrtnp1TxBVoi90q3P+vr1rg4AlMOCvDjvycO5Q==
X-Received: by 2002:a17:902:6945:: with SMTP id k5mr2325037plt.131.1599551850609;
        Tue, 08 Sep 2020 00:57:30 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/7] Add CPUFreq support for SM8250 SoC
Date:   Tue,  8 Sep 2020 13:27:09 +0530
Message-Id: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds CPUFreq support for Qualcomm SM8250 SoC. The existing
qcom-hw driver is reworked to support the EPSS block on this SoC which
handles the CPUFreq duties.

The EPSS block supports additional features for which incremental patches
will be submitted on top of this series!

Thanks,
Mani

Bjorn Andersson (1):
  arm64: dts: qcom: sm8250: Add cpufreq hw node

Manivannan Sadhasivam (6):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8250 compatible
  cpufreq: qcom-hw: Make use of cpufreq driver_data for passing pdev
  cpufreq: qcom-hw: Make use of of_match data for offsets and row size
  cpufreq: qcom-hw: Use regmap for accessing hardware registers
  cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC
  cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify
    code

 .../bindings/cpufreq/cpufreq-qcom-hw.txt      |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  22 +++
 drivers/cpufreq/qcom-cpufreq-hw.c             | 160 +++++++++++++-----
 3 files changed, 143 insertions(+), 41 deletions(-)

-- 
2.17.1

