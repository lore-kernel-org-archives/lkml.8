Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9241D22208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBJE8KjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGNLQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgGNLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:15:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9FEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so20905799wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dg33bFZj/pX2p8X7OxPHlMst/L5EH8g1IuDjLVgf1/4=;
        b=yBJE8KjJ6NEYCDwv9wNX8ZXYdU6hPPbpWM1MaN9ieShRfvwSuASVoer1Ihb+eIWjtK
         UzSIa+xB0bDjytLVDLErLy7rarcj4dViPg3TEFJdBaaN01b+/Y9rcoi9K13Ya/nLIj2O
         RPJp2p3e2v9tkZ14wLXYfQjwrZNc9oDvFcQDfYiQ3FU4hz7JGF0g2YW/c6qUSTguN7Ft
         AqgzYQccKJ9gjfHQlW+xlUJYVwn+AtRaqQPrJp3t/q7rR3jvYUGRI5X4qdC7RyEbM+Ta
         I5KnfqbFqg2fxEQ4jkstLmZfvDzrZVwlyuSkKPROjYhcVEJ8bDDShUkBejVuRzoQsJEO
         ytgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dg33bFZj/pX2p8X7OxPHlMst/L5EH8g1IuDjLVgf1/4=;
        b=FvbIQSUbD5XKXONpJaoEP7Y+GhyAds0BCeS3oM83rqkYPmBftZcSnxnxHO+vdB2kjg
         I8Py+FelcOefIIJ1Vo8ikMdDjBsSZg6IqhayQdgE5EV9mhUbTRVGq5mg7cFLRHifWu5q
         oyNq7EwL+e7Hd/jZRgcHR5c3/evFxQyGbSBkBMdUvQhA2vlUgPsNLgm73qBv7gZvNmfU
         ioh6yoqHm62PyBRFwUgi1iFbaqFyxUxKzhliAWOKttiaTEaUtdGAYLYqnsZ8DNJDD3Z9
         Xybxx71q7pki53/TDe2aXxdwokdg8HshMWOq2iIvudT5aCwm++ST8Pf8mOCF6IVDUOqs
         BWMA==
X-Gm-Message-State: AOAM530+K70pzjT1uWVb9iSIostPq4abdfDYzxXiwsPk6gimDXFIlHqh
        V3VhL6DWNl7saU7PysVfQbOwhA==
X-Google-Smtp-Source: ABdhPJyc/Cos2QXFAWOsJJhYX0QbQtXR3o/JuBqfk4bb+hio6dotMso+h9vRFegmjWcVlmEDFyXRFA==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr4597136wrr.196.1594725349633;
        Tue, 14 Jul 2020 04:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/17] Rid W=1 warnings in DMA
Date:   Tue, 14 Jul 2020 12:15:29 +0100
Message-Id: <20200714111546.1755231-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/dma.

Hurrah!

Lee Jones (17):
  dma: mediatek: mtk-hsdma: Fix formatting in 'struct mtk_hsdma_pdesc'
    doc block
  dma: of-dma: Fix misspellings/formatting issues in some function
    headers
  dma: ep93xx_dma: Provide some missing struct attribute documentation
  dma: mmp_pdma: Demote obvious misuse of kerneldoc to standard comment
    blocks
  dma: pl330: Demote obvious misuse of kerneldoc to standard comment
    block
  dma: ste_dma40: Supply 2 missing struct attribute descriptions
  dma: altera-msgdma: Fix struct documentation blocks
  dma: at_hdmac: Repair parameter misspelling and demote non-kerneldoc
    headers
  dma: sun4i-dma: Demote obvious misuse of kerneldoc to standard comment
    blocks
  dma: fsl-qdma: Fix 'struct fsl_qdma_format' formatting issue
  dma: imx-sdma: Correct formatting issue and provide 2 new descriptions
  dma: iop-adma: Function parameter documentation must adhere to correct
    formatting
  dma: nbpfaxi: Provide some missing attribute docs and split out slave
    info
  dma: xgene-dma: Provide descriptions for 'dev' and 'clk' in device's
    ddata
  dma: mv_xor_v2: Supply some missing 'struct mv_xor_v2_device'
    attribute docs
  dma: ioat: init: Correct misspelling of function parameter 'c' for
    channel
  dma: ioat: dma: Fix some parameter misspelling and provide description
    for phys_complete

 drivers/dma/altera-msgdma.c      |  6 ++++--
 drivers/dma/at_hdmac.c           |  6 +++---
 drivers/dma/ep93xx_dma.c         |  2 ++
 drivers/dma/fsl-qdma.c           |  2 +-
 drivers/dma/imx-sdma.c           |  4 +++-
 drivers/dma/ioat/dma.c           |  7 ++++---
 drivers/dma/ioat/init.c          |  2 +-
 drivers/dma/iop-adma.c           |  3 +--
 drivers/dma/mediatek/mtk-hsdma.c |  8 ++++----
 drivers/dma/mmp_pdma.c           |  6 +++---
 drivers/dma/mv_xor_v2.c          |  6 +++++-
 drivers/dma/nbpfaxi.c            | 13 ++++++++++---
 drivers/dma/of-dma.c             |  8 ++++----
 drivers/dma/pl330.c              |  2 +-
 drivers/dma/ste_dma40.c          |  2 ++
 drivers/dma/sun4i-dma.c          | 12 ++++++------
 drivers/dma/xgene-dma.c          |  2 ++
 17 files changed, 56 insertions(+), 35 deletions(-)

-- 
2.25.1

