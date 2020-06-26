Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE75C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7172207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FT+pN0bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgFZG5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so8366200wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mfkXUaLpnMxZlSEJdhFVt18d74h2IL60WdheI/gMRo=;
        b=FT+pN0bkkgDMaHY7DJ+MXjf93gjIOsUROc7aOAachwo6+12RkYqupo/vU6pOwk/dsQ
         SgYuWK3OmXcItQ98arjhHHbbbR+kdQwb+/SYjVusLM/EEcY9daFkmKixB3TVFVtYvxgo
         2ppRghXjInlJ6u5/PiUkGk5xHM9PZb0fIpcBoB1bMbMaRYI9OL8fkNcXbZcF2F6V07uy
         Xp53o3taL9z4xFguPGZSn6UHrcQINsXSdNwq39Qi7ieJzZf8fzb4JHk5x3BYV0PckFvu
         zlg9ab9MYPeWxoZyZ1W5RJgkOEcddk48zit1NCaYe1sIuUqhA1TaycrXQt8bhra3Zgrd
         cyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mfkXUaLpnMxZlSEJdhFVt18d74h2IL60WdheI/gMRo=;
        b=mLFJxdrrKJKlBQ3NzC10U01O87rzv/4hAel2JcVOPFhqFFs9yIgZ6TTNenObI0e0+D
         yDCOx74qCgoCqpA9+xXSivm1j7RyMhhhcFS68ol2hnALyt3dGB5CUD97ZgzM8wPTfiCT
         XFMEsUUNkHY6S59cdpUX74zOt9jcrWUvKioEFatlY0RQ+ks1Miy3XtFF404/WzqYakRq
         CJD89LdTKyx1gtGir80vMggmjAprywtO2YhlyMcLAsBik9ZX+zq9wpWKhqqj2LZgK9wF
         rDNEA2T8QtzG933VrxkHFd9y+S2BgHYgN5/sL/EirCiFtvix0XiGGcX1Ngn5YAQxG8Hh
         mZkw==
X-Gm-Message-State: AOAM532j381Yh5VnpziSsmyt9n1djE6rvfTLuwrAlYwsSutkBtfs6At7
        X+uArXZI75ZVHo5dhibNXQxtGyYZAZc=
X-Google-Smtp-Source: ABdhPJxXjV8tT8YeYETkVZp0Bc43hTtJEwNUZt5QnIbtRGl0/YHTgVlfuDnAK7znArNXHffmpTN8KQ==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr2009870wrx.332.1593154662112;
        Thu, 25 Jun 2020 23:57:42 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/9] Fix a bunch more W=1 warnings in Regulator
Date:   Fri, 26 Jun 2020 07:57:29 +0100
Message-Id: <20200626065738.93412-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

This is the last of them.  Once applied, drivers/regulator will
be clean of W=1 warnings.

Lee Jones (9):
  regulator: max8998: Staticify internal function
    max8998_get_current_limit()
  regulator: qcom-rpmh-regulator: Repair dodgy kerneldoc header
    formatting
  regulator: pwm-regulator: Demote kerneldoc header to standard comment
  regulator: stpmic1_regulator: Properly document 'struct
    stpmic1_regulator_cfg'
  regulator: tps65217-regulator: Remove pointless 'is unsigned int <0'
    check
  regulator: tps65217-regulator: Use the returned value of
    tps65217_reg_read()
  regulator: tps65218-regulator: Remove pointless 'is unsigned int <0'
    check
  regulator: wm8400-regulator: Repair dodgy kerneldoc header formatting
  regulator: qcom_smd-regulator: Remove unused 'struct regulator_desc
    pmi8994_boost'

 drivers/regulator/max8998.c             |  2 +-
 drivers/regulator/pwm-regulator.c       |  2 +-
 drivers/regulator/qcom-rpmh-regulator.c | 14 +++++++-------
 drivers/regulator/qcom_smd-regulator.c  |  9 ---------
 drivers/regulator/stpmic1_regulator.c   |  2 +-
 drivers/regulator/tps65217-regulator.c  |  7 +++++--
 drivers/regulator/tps65218-regulator.c  |  4 ++--
 drivers/regulator/wm8400-regulator.c    |  6 +++---
 8 files changed, 20 insertions(+), 26 deletions(-)

-- 
2.25.1

