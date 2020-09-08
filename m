Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E62FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE629206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+xmTgpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgIHP7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbgIHPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B07C06138E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:33:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l17so15751320edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CbHAntwE/i/0aOcErfQq5jTQMnZZWtdKrAQxbD+Urlc=;
        b=J+xmTgpWIz9Bfj8KndmtxBj1SCYkernBnfaLUVEZ1RBJMr2xge19uixrG4oQBxWmxE
         wlcVcXZsavOQxg4sIEhXmDFiYybKnat/o+TLE5MGXzt663viuveYHsIaoT7VX/+k0Sxb
         dmsYrI4+WU3ck1uTe4hy+JbTz2wcuufFscmSCxrcRxFst9HEzxpsuMxMuF1wXZpg1jt6
         FkIqMsDT/Cm2vCccRKFUz7St6nLxmBuWa+u0DPge8QTUdOqNslY518gM4zEem1PYnC7/
         odBsMsJQMswlXhDy1m+xg3viqA4ZteEcF4gs6E5YhPBg/KlxCGcfN6LbGUP7ncOv15md
         NX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CbHAntwE/i/0aOcErfQq5jTQMnZZWtdKrAQxbD+Urlc=;
        b=G5jOW7JOl4GKpSM94+Ks3fQtbENENOMk3XW4v1/esvvF3gStgmXfNvLFmhvzEd+J+S
         QEKqEBm2gaeCC/iY2I+2eB4uuyAk80opfSaA7YpwQQM2dAA1FydGO+uhynEO552iaAHn
         BIVh3m9RWxc0rqKqX9irQeaOdt2rscJrGzQMsh+hj23QxygNYertp7oQFkUV2u5r7UuF
         TJvkk7NvquKSGUzaTp5uyDiKg4ma7FddojuVWwoUIqnCW/JiGHzjBlF4Tyf+mYsmr85U
         HIcJN7qz3dyZNMA6E5J4CZF2B/Y/JLZt5PuKciA2m3RMHqXeuppmL4Ik9dfHUz4YihYD
         iC/w==
X-Gm-Message-State: AOAM531Im56bj0tMQ6H+RO4HWLmc/Tt+SuWVlYvtysKQD5X8pFP6FObI
        wWxrn3Bm3Ck+O2yJcdKM1zPobA==
X-Google-Smtp-Source: ABdhPJyire6a1xGmOn/Oizs1+bSA9Zj7VgW0Nwa4xh6mFyM9pB0RqkBU2ggzqp6YMpsH7c/DBqKZXg==
X-Received: by 2002:a50:c182:: with SMTP id m2mr26187244edf.70.1599568403518;
        Tue, 08 Sep 2020 05:33:23 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id y9sm17499744edo.37.2020.09.08.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:33:22 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        nicolas.dufresne@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 0/6] Add VP9 codec levels
Date:   Tue,  8 Sep 2020 15:32:15 +0300
Message-Id: <20200908123221.2793-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This new v3 now contains the implementation for VP9 profile and levels
in the Venus driver as has been requested by Nicolas at [1].

Comments are welcome!

regards,
Stan

[1] https://patchwork.kernel.org/patch/11717307/

Stanimir Varbanov (6):
  v4l2-ctrl: Add VP9 codec levels
  venus: hfi_helper: Add VP9 profile and levels
  venus: helpers: Add a helper to map v4l2 ids to HFI ids
  venus: vdec: Set/Get VP9 profile/level
  venus: vdec: Use helper to get profile and level
  venus: venc: Use helper to set profile and level

 .../media/v4l/ext-ctrls-codec.rst             |  43 ++++
 drivers/media/platform/qcom/venus/core.h      |  13 +-
 drivers/media/platform/qcom/venus/helpers.c   | 239 ++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h   |   2 +
 .../media/platform/qcom/venus/hfi_helper.h    |  18 ++
 .../media/platform/qcom/venus/vdec_ctrls.c    |  31 ++-
 drivers/media/platform/qcom/venus/venc.c      | 159 +-----------
 .../media/platform/qcom/venus/venc_ctrls.c    |  14 +-
 drivers/media/v4l2-core/v4l2-ctrls.c          |  21 ++
 include/uapi/linux/v4l2-controls.h            |  17 ++
 10 files changed, 370 insertions(+), 187 deletions(-)

-- 
2.17.1

