Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67864C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DDA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAWnIKC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgBDFfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:35:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDFfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:35:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so9078401pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 21:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yDxEzOkKubOgEgaxiXFZGk+/s3twCjegVTvLoi4kxec=;
        b=BAWnIKC3K2Vf/wj4xU15Xj5aZC1N19QXXylMswEUYDBHsZ8XmkTXyieJoN9N78vI0c
         DNvlP6L91ESULTg262+vU1RxFJwU2VS/8FiNPjqxI4a+6IRuxF4DBDQAKFTJXAtZy7ke
         nsDcgtfEE4/F3jsblfOAUEkmtNwUpTIZ5QBtC+NxfV6Q23lLr2XiKPiSmVFtFoCVJosD
         4ARUGn0iPnivCsqVdLrtB5MOOS0NyuZjT6E4C3xvbeL+0kVCeNDE4B/riXJUiUZ98q21
         kuzegoU+U/xfucD7tY+4BYFXjVFsdnzSKRTxaP7+LF86pMf4p8uus1c5e6IeXqkKCVN5
         LEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yDxEzOkKubOgEgaxiXFZGk+/s3twCjegVTvLoi4kxec=;
        b=B0nKvlwnJ8k6La6uo+RUrsTyMdCNfBuKVQUsy+tOykFQNltPLULkQgeBYvUQl0HKF0
         RjIc+rBn33z+vxXnOv0miI8AjqIB47kwCjvABqM4dUVYZLJ6etcU0yEUk61/AzxbDogs
         M4DxWZSw3R3scZSRrjv9DseuVJIwETP7KdNF0HF3pu1S9T89qu+G4QDhgtbBsRhnNHFP
         wfnG4jKsIc67jn5iqfwlFKghWyDYM3TzXcbIeldoed6+9kdew0LAeySlvlHFbjGVVTnq
         qJDTGB73hwj7PJhILZ6H6GfAKBNLlFwh4rcsCUSXXAjJA/hCPS/WxJiivJd9nA73JW3g
         54cQ==
X-Gm-Message-State: APjAAAXppJF9ygqQU/q5mXcwIeDpz9qh0o9IIza+Tra94XJ338faDcNV
        vt2orZIjLUeDazBDZtAA8WOYmQ==
X-Google-Smtp-Source: APXvYqyTy5OPKQN5nbbZaJ2PXAhUwxG7ur1aECaCG8zlwokLJr4CWDyMyGlf3maXHHAN+DvGF0MC3g==
X-Received: by 2002:a63:fa0b:: with SMTP id y11mr21305094pgh.137.1580794498804;
        Mon, 03 Feb 2020 21:34:58 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i9sm22935845pfk.24.2020.02.03.21.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 21:34:58 -0800 (PST)
Date:   Mon, 3 Feb 2020 21:34:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [GIT PULL] hwspinlock updates for v5.6
Message-ID: <20200204053455.GA130281@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.6

for you to fetch changes up to cb36017a8b1b582bcb7063e44c598c3e36aa0228:

  hwspinlock: sirf: Use devm_hwspin_lock_register() to register hwlock controller (2020-01-21 16:16:36 -0800)

----------------------------------------------------------------
hwspinlock updates for v5.6

This continues the transition of drivers to device managed resources and
removal of unnecessary PM runtime integration, with cleanups to the
SIRF, OMAP and Qualcomm hwspinlock drivers. It also adds Baolin as
reviewer in MAINTAINERS.

----------------------------------------------------------------
Baolin Wang (8):
      MAINTAINERS: Add myself as reviewer for the hwspinlock subsystem
      hwspinlock: qcom: Remove redundant PM runtime functions
      hwspinlock: qcom: Use devm_hwspin_lock_register() to register hwlock controller
      hwspinlock: omap: Change to use devm_platform_ioremap_resource()
      hwspinlock: omap: Use devm_kzalloc() to allocate memory
      hwspinlock: sirf: Change to use devm_platform_ioremap_resource()
      hwspinlock: sirf: Remove redundant PM runtime functions
      hwspinlock: sirf: Use devm_hwspin_lock_register() to register hwlock controller

Yangtao Li (1):
      hwspinlock: stm32: convert to devm_platform_ioremap_resource

 MAINTAINERS                           |  1 +
 drivers/hwspinlock/omap_hwspinlock.c  | 32 +++++++++---------------
 drivers/hwspinlock/qcom_hwspinlock.c  | 28 ++-------------------
 drivers/hwspinlock/sirf_hwspinlock.c  | 46 ++++++-----------------------------
 drivers/hwspinlock/stm32_hwspinlock.c |  4 +--
 5 files changed, 22 insertions(+), 89 deletions(-)
