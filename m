Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A787C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BAB20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CIpRiYea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgEFIlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgEFIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:41:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43690C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 01:41:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id a4so804943pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkoYcVU7NbBeJg58Zqc5BWaG09vaVe4UBMU1LZjqb/g=;
        b=CIpRiYea9WavKCCzFUX1KcmqQRqXAUfnUOpK6kYBI47aHAW2q68iHkQwQ9a53C4+mm
         bfI2CWK8Yr2OJlemlrTiq2q/w0fUesykOuoV/uPt11BXPFji9lBmU5tQeBjrbr3Fe8QU
         3U+D2JeKqnISGbxkYsJdYFDrdMSz6AMv3TTmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkoYcVU7NbBeJg58Zqc5BWaG09vaVe4UBMU1LZjqb/g=;
        b=fHyLkvvRO85zQrP53L0xP+vDCS/+LOHcEHYDNUT6T613liCtxS7qp/HwrR1YnntQJo
         6Gr3q+IJToevxI1uDe6wvndX/31kjD+fqZKzjXJR9OyMSvJVJMxV2tBhiBhrxMKLu+7x
         QvjvXQVwK47qhTp18Caedoc3jdqvocMxdDS/I1aE+ikqvnd4ZODL5vcOnS21JeVmLzjl
         BHFPAPug2LR4RAMmrs3PSg+qsFnC2Q2WY5mLm40H+rTxzeWLflZI7eCdaGU06g02fP+8
         yKF3KMLdljyUxcn2MLAZtjl7BfwKdM9CHjNV6Qkvj8+KeOwg+ZIAtIXBNDyGpGqB7IKC
         uggg==
X-Gm-Message-State: AGi0PuZTT02s5fQW8+MvJOM0LGtWHi71aZvg7BKQsw+WWggjKwUlU0hX
        H2pfGzD30OB5Bl8GoLSf/eRY4gZRXIc=
X-Google-Smtp-Source: APiQypI0J1HwXbViVLlYWXD2Y2yI1V6k6VKFQ9zvlAicFXalpNwCJAXSFHp0zsOyvBrN9HZalI3SBw==
X-Received: by 2002:a62:7f07:: with SMTP id a7mr4606572pfd.34.1588754475570;
        Wed, 06 May 2020 01:41:15 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id o21sm3986931pjr.37.2020.05.06.01.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 01:41:15 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] Refactor MDP driver and add dummy component driver
Date:   Wed,  6 May 2020 18:40:37 +1000
Message-Id: <20200506084039.249977-1-eizan@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series depends on all changes in the series:
https://patchwork.kernel.org/patch/11530275/

We are adding a dummy MDP component driver so that all the components
are properly configured with IOMMUs and LARBs. This is required for
us to get hardware video decode working in 4.19, and possibly newer
kernels.

Changes in v2:
- remove empty mtk_mdp_comp_init
- update documentation for enum mtk_mdp_comp_type
- remove comma after last element of mtk_mdp_comp_driver_dt_match

Eizan Miyamoto (2):
  [media] mtk-mdp: add driver to probe mdp components
  [media] mtk-mdp: use pm_runtime in MDP component driver

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 172 ++++++++++++++---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  32 +--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 182 ++++++++++++------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h |   1 +
 4 files changed, 286 insertions(+), 101 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

