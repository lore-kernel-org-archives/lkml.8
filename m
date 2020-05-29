Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B32C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3172074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE2McD10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgE2Kcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Kce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:32:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE3C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 03:32:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u16so992875lfl.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUsASV2qevDpaTIODIKhB0T3yPkNMeRLmnhehfGPDPo=;
        b=ZE2McD10j3rpPW+srhAM5CQLoE5IWRIsQFVOKyQKATTntubzhUeEQszymH+lSU4ZQx
         YbU6MoPJ3yNoN3SfNzhJpx5+/fAs/yrO6xeHArYLmxoUL6UY80G3c0KM6x96tzbnwJXE
         u/aKtw2sgH296T6rc0JqWpvFPXb97DgztLIPo/o9J8RB7lg1yb4UP8RnMg+rxCehf4Tp
         U1It1EjCRGmtNsX83rOfs5oOBke3gsDbc6LXagVdZdikSq7lIKPANh7s/rR0In+kRa8r
         8oUOyTJgegiuVv6nC3o9qMQhJFVDplCIRRIdQzg8k2RJitC2uf9dO2VOPIUUj2nNNUh4
         GcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUsASV2qevDpaTIODIKhB0T3yPkNMeRLmnhehfGPDPo=;
        b=hROtXXLl9sYA9KLHIHN6goDC3P/hjKqULfvdRWWEq+aXqDTLY/tsNb54sCNAmjfN0q
         twGUr52qYGvspbJoXVujFsVAfSeBT+BNW4EsxhI5IVbwO03VRAymAbOkfq04lj4W6hBj
         uBvkiaf+MVxAxXpknN4HpdcSSlwkbe4wlF+TptROXYO0Lb+lB86M/2gyy02KmzgaR5OL
         INtmmEYofUJul9vDOSbz+CXRNM2M5XON0hfKY8jAH0sVr5NHTqciFsA9IOIj6ln0/7HR
         akfBFY8lxzUQkdiEDQ2LS3RblCG61KHiGicNtsbA25MnWQ5o4af/hHRnxQaDG0ig8tE3
         pnRw==
X-Gm-Message-State: AOAM530olEu1rzTvqmOZV/MyPMAZaRPUuZiAXR4JJOpuHnsREAbjd8U0
        aUN3ZCF3kO/R+Agjk3b8Fr8ONA==
X-Google-Smtp-Source: ABdhPJyomo5KZulw68tEyajivVTXQYIeJ+eK908jzIRxTB7Iu8gjMDZ676KNF6yYNXfUqPrE721eeQ==
X-Received: by 2002:a19:c8e:: with SMTP id 136mr3995874lfm.72.1590748352738;
        Fri, 29 May 2020 03:32:32 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id l2sm1919348ljg.124.2020.05.29.03.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:32:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.7-rc8
Date:   Fri, 29 May 2020 12:32:30 +0200
Message-Id: <20200529103230.13171-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.7-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc6

for you to fetch changes up to 202500d21654874aa03243e91f96de153ec61860:

  mmc: block: Fix use-after-free issue for rpmb (2020-05-25 10:45:17 +0200)

----------------------------------------------------------------
MMC core:
 - Fix use-after-free issue for rpmb partition

MMC host
 - Fix quirk for broken CQE support

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix SDHCI_QUIRK_BROKEN_CQE

Peng Hao (1):
      mmc: block: Fix use-after-free issue for rpmb

 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/host/sdhci.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)
