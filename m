Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15200C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6832063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMrJypkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgF2Vmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgF2Sh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73002C00F82D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:47:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so3530528wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rudM74e1Pgb+dgRXbno543NZk9dhJh2T8QURDAwNqxo=;
        b=MMrJypktX2dGwbWK2WJwHSZlgTCxBvMicf8S6HeV+IEHyBd/BsMsD7DMpdBDI83MMv
         QyiPxbAJaQSWycHKbp7oaNquqzwC+4IpMBeTWunKJygLXDTtCouHG6kwzAS2WB0rfUvL
         5sUUgJlP/7u5hxVJQ8kkalGly7nDzvinuu1S6Ow2rv0xN+jughtx7Ou23KzkI16t7Y9X
         ir8XBS6MkFgqtdbkxyPOsNQN/TqvwoD+BQGpXSohEbzVF7hCKT5WgnGh6cM9H9htgNKl
         UqFX7dMSyrL855EudgAl3ujqkL8MW+azJAKRg4/RN+dpJ51bk5lqXzd0ImdK4NFYM5cI
         F/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rudM74e1Pgb+dgRXbno543NZk9dhJh2T8QURDAwNqxo=;
        b=oLQd/bb0PLGtWGTIuHDqyhsFgzTxsbky8M/O4A4EMoKJKkBr9/HuMjIeN4ehiDYXpD
         0DSRGPJneePTuYeA9gdPSA0gJmTXNfji7t/4QSmGtW9vg3G70TVX4E4Dj+AfZlw7niYR
         oOdT4kf4WcjotbhOU3dkpVORIwP/bACN+RE9R+rWoVkwdtyCrxa/NjJwSR8dT5RJcPSl
         zcJpfKSokkCTTxy49FY0lbJnl3Bx10o2vcvpaK4pPNLSCklKrXvFG4sY4yB5DQG8zsDn
         YuaGqR5sH2+MmfwceudrOd7ju/ViahBgrTldwiJhf/LU4J68vQ6IguNanOB5mdWItJxA
         w0Yw==
X-Gm-Message-State: AOAM533RGS91jZrlKiIbZwtbmOQcVVdcVq47fo+sZIwxxezDGoNc8YKU
        qI5I2QR4hCp1PfvDPP/rJ1tw6Q==
X-Google-Smtp-Source: ABdhPJymTdB7uYUnNxNAvBDg/jFPSHnhR3EKfJTDqrjBJtflMfvEKlNxtCKuRryFRR89Pu116D8EKw==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr16024940wmx.62.1593434875113;
        Mon, 29 Jun 2020 05:47:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/4] Fix a bunch of W=1 warnings in PWM
Date:   Mon, 29 Jun 2020 13:47:48 +0100
Message-Id: <20200629124752.1018358-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (4):
  pwm: bcm-iproc: Remove impossible comparison when validating duty
    cycle
  pwm: bcm-kona: Remove impossible comparison when validating duty cycle
  pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
  pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc
    header

 drivers/pwm/pwm-bcm-iproc.c    | 3 +--
 drivers/pwm/pwm-bcm-kona.c     | 2 +-
 drivers/pwm/pwm-mediatek.c     | 1 +
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

