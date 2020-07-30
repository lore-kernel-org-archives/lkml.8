Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E93C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FAD20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zt750EJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgG3LrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgG3LrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:47:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3748EC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:47:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so24626188wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tIZ4h1fhX2WCRnbynq3WODdOngNcLlyJs5mtZ1Hut3c=;
        b=zt750EJ2vU5XTvLnTcd3pHK0vw5SOb0ldRbuYnr3ab8Zf4dINgPH7UflqWBIUOh2MA
         gI1ak3nj8MX5XFyP+Qk3S6t8HGEhnoDCmoFM8sY5WmZngoaHRZK953+SF48h1svyS3gS
         /xLwWTYGFhZ7mFZVetLJ7/yD/h7KGI8wFDFkT8rm7yEvNKpuuQLvMyNzKdy3hM12Xa09
         BjqSKgN3suQwBePq013RLb5tToNA73yhMS0e2rQVX/vsly2WYcfaydWFCjNqZfQvEac8
         sTyHni/P2R/jTQJBYg978K6NdNuVtsLXFRAVCwTqJ7Hqrgh5av5Ehx2gvQFSotiqhPD0
         v46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tIZ4h1fhX2WCRnbynq3WODdOngNcLlyJs5mtZ1Hut3c=;
        b=YSffFI4XBKjkFDeZnPI0NUnNDp00oTHXE2A4ZIYSrOA8JWwHVaQm0JSKvw3Z2Hixep
         MsaAOu4UqGwZDaxC6vf/2bL5ifLLbr64KjfMIhV3qgMG5kXKVxU3WyDENWBuT5i7+BPx
         V1xnYV9tgTo/wQtq0eKrBpy/fgLvA4UMUmAcv1JdhKNPebP31di5lKNIH0duvKoxo0Kv
         K2X1T4FmZPgN7a9OdM1F44QojIcN36i6kCjTZVT/Ye0Qgyh0O748U+1PRqlXRz8YWpqX
         fpHHcyQgq6tGMAd+0t0sQjo6HNWQkajEUJKE2rc4B7LlZRBxOU8HUn6ClczWq/rnq5se
         bfvg==
X-Gm-Message-State: AOAM5326tQeg/OF4zsWVVZnS1S/X6icS9a+vpoLlTIqgnhsPaP0BgBow
        gjsEim98hpPs694VbABtvf652w==
X-Google-Smtp-Source: ABdhPJyPiwoyW2cOAjYW4girHCbMu9Tu7U5+ZixtcXyQd7tg+oMUFYhvjMn9nKdgc/TW33ah40YvIg==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr32401711wrh.381.1596109632946;
        Thu, 30 Jul 2020 04:47:12 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id 32sm9636691wrn.86.2020.07.30.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 04:47:12 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/3] Venus - recovery from firmware crash
Date:   Thu, 30 Jul 2020 14:46:29 +0300
Message-Id: <20200730114632.6717-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The intention of this patchset is to correct the recovery sequence
for Venus v4 (sdm845). Recently has been observed various recovery
failures which leads to unreliable behavior in sys_error handler.
To fix that the sys_error_handler is reworked, proper delays has
been added over pmruntime handling to ensure that the hardware and
encoder/decoder drivers are idle. Also a wrong watchdog code in
threaded irq has been removed. 

regards,
Stan

Stanimir Varbanov (3):
  venus: parser: Prepare parser for multiple invocations
  venus: Rework recovery mechanism
  venus: Add new interface queues reinit

 drivers/media/platform/qcom/venus/core.c      | 25 ++++----
 drivers/media/platform/qcom/venus/hfi.c       |  5 ++
 drivers/media/platform/qcom/venus/hfi.h       |  1 +
 .../media/platform/qcom/venus/hfi_parser.c    |  3 +
 drivers/media/platform/qcom/venus/hfi_venus.c | 62 +++++++++++++++----
 drivers/media/platform/qcom/venus/hfi_venus.h |  1 +
 6 files changed, 74 insertions(+), 23 deletions(-)

-- 
2.17.1

