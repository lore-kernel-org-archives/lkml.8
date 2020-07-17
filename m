Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F9FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B544B20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNmyeu4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgGQLD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgGQLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:03:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DECC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:03:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 207so5235018pfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oMcGbx2imE1XCRTD2EZEX5mjUc+WOEiUyZtFTlxo4O0=;
        b=FNmyeu4xyTkRfDEyFX4wGUU5+9+PYRiCQaYeErluUVNWUYAFqnSKulZN0Ye3xuum/2
         Mmf9YcoM7OHWgHMt4n0SalCM2DNzqdclxxCQVNnuLRj8tqq6ss/JcprPHVLXJkidvlFB
         9jQSOAhNKX/nyHqjzAM8zkn8iKGtP9KY9K/F++s7Ny8AL+GmzcXGdcKvMU4TrpGDZN07
         2eB4hl3V57YpEBf6l3tg5GNS0LLqJH/VTNanywdis1p5Cze4rfDekjPCtS84gE8Hy+CK
         SSuk2V35BpiBcp597sZmuY7KbDhKK3W30AEhueAvCpFoK2oi4Dhd5u9OlfuEs1bKlyn2
         b5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oMcGbx2imE1XCRTD2EZEX5mjUc+WOEiUyZtFTlxo4O0=;
        b=HnKiAbio+j7p/68kCGssJ+s+RvwrSp4X4HExN3GTL4AzFYoZwEN0SaoJJrbRHMHIEl
         JYnsmfIAFhQO1zcK1NQYFXgLZ2vdXXvK1i9UN3BjR8e2pqYwNGnJVPPq2RJLUqAPeW1f
         pdyiTU0OAGOK2FBSaHKzGhjkNz2TD9w9tIWwcLmoW5kmCtuzEC1TdZZkc8BIs6vG5fZD
         VQ2gEIh5efFOaIUvGWL1YDExPZ2tBd8typsV2kkP3nu4C0616ShDPmjLuzMvMiu/8MGL
         LPkZVhb79qiTJo/eM/LrPO1ft2zYBRrhGwSgvo/tNmd2gIuhdztCrz3GuRxHV1tmXp97
         Xefg==
X-Gm-Message-State: AOAM532uL/GnkG6huKy8lEVVBZXU919VxZVt/8fiZRK8twIfSMBZKGSW
        uc9O1bPW8dTuj7alA4HLGuU=
X-Google-Smtp-Source: ABdhPJy4XikVZpT4czM2m+AMaLPvDOKAAcWfZkSjcSKGw8h5dUgGJ2t2TX6qspjn4BTSQ0O8t5TnCg==
X-Received: by 2002:aa7:9303:: with SMTP id 3mr7486112pfj.108.1594983836163;
        Fri, 17 Jul 2020 04:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:03:55 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 0/9] mfd: mt6360: Merge different sub-devices i2c read/write
Date:   Fri, 17 Jul 2020 19:03:22 +0800
Message-Id: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series merge different sub-device i2c read/write into one regmap and
fix coding style for well-organized.

Gene Chen (9)
  mfd: mt6360: Rearrange include file
  mfd: mt6360: Remove redundant brackets around raw numbers
  mfd: mt6360: Indicate sub-dev compatible name by using
  mfd: mt6360: Combine mt6360 pmic/ldo resouces into mt6360
  mfd: mt6360: Rename mt6360_pmu_data by mt6360_data
  mfd: mt6360: Rename mt6360_pmu by mt6360
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge different sub-devices i2c read/write

 b/drivers/mfd/Kconfig       |    1 
 b/drivers/mfd/mt6360-core.c |  532 +++++++++++++++++++++++++++++---------------
 include/linux/mfd/mt6360.h  |  240 -------------------

