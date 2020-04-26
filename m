Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB93EC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865C0206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgGSQ3vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgDZS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbgDZS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:58:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A915C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c21so5218741plz.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuhy6+UvC2aZCI8jEGanuJkbuaQTzx/LeqqBb0/lOXs=;
        b=GgGSQ3vkuWOePQBjt3G7TfBokCk2s9i0Z/ZhVNrUnFenlI88fwqM9v8M1DKugotU0Y
         99U3UQGOOiSnNqKNDAOA0xouYx5rLfzGfGdlAuHMQSOoHDXN/hxL6IiIhzXCxI1QZMur
         AhKo21zgOl/BV+gZSWV7b4BYWf4FNZg/9VE+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuhy6+UvC2aZCI8jEGanuJkbuaQTzx/LeqqBb0/lOXs=;
        b=l/UlsqQ0OJDjjuQntDhbhlJ/geCXkxM6UwrjZze3+gTd+h+aulAz8qtlIoXUEryxeM
         Qo1QkekZU+wWk81GHg/nKpGOHvFxwWnoqtN1ZAdt579FCgdffuKHan3tr67H/SdC8ATb
         enMNsUfSBsqlr+qZtLke4dhWACc/NK5zV0+YMAYKpcC5//IxwFALMvhEaoZrmWpSItGv
         WvkmL/CXjr9gx0CVtNKUEW3ylY05PHHXbQvNLXumoJKdkQj4wOYAXIlsTwpZ2a15d/rr
         RAYB/GUp/VZAJRujRyrckokWMOOJB0ntMzErTxZe2moS1H1tyl5Czr4K8svAshenEGG3
         TqvA==
X-Gm-Message-State: AGi0Pub5b5URiBjgkZK+PUaWDAhXTEU91zXkEwSbE2o/JZ4M7YPPGFMP
        f6lUJYysA83ZBh0d0m9/h0M8wA==
X-Google-Smtp-Source: APiQypLHX0oiKi3Ea3EfbnPXETuY5F51bl9kiV8kC7ToakI66ch9tzV2WSIjhnTB3uhZSGFpA4QU2A==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr19944816pjb.49.1587927486861;
        Sun, 26 Apr 2020 11:58:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h27sm9425153pgb.90.2020.04.26.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:58:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/5] coresight: Minor sparse and style fixes
Date:   Sun, 26 Apr 2020 11:58:00 -0700
Message-Id: <20200426185805.14923-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a report that kcalloc() didn't exist in coresight-cti-platform.c
on arm builds and that looked like we didn't include very many headers
to get prototypes of functions like kcalloc(), etc. The first patch fixes
this problem by including the headers and then the rest of these
patches fix minor sparse and style issues that I saw while looking
through the coresight directory.

Pathes based on v5.7-rc1.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com> 
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>

Stephen Boyd (5):
  coresight: Include required headers in C files
  coresight: Mark some functions static
  coresight: Don't initialize variables unnecessarily
  coresight: Initialize arg in sparse friendly way
  coresight: Avoid casting void pointers

 .../coresight/coresight-cti-platform.c          | 11 ++++++++---
 .../hwtracing/coresight/coresight-cti-sysfs.c   | 17 ++++++++++++-----
 drivers/hwtracing/coresight/coresight-cti.c     |  6 +++---
 drivers/hwtracing/coresight/coresight-cti.h     | 10 +++++++++-
 drivers/hwtracing/coresight/coresight-etb10.c   |  2 +-
 drivers/hwtracing/coresight/coresight-etm3x.c   |  2 +-
 drivers/hwtracing/coresight/coresight-etm4x.c   |  2 +-
 .../hwtracing/coresight/coresight-platform.c    |  4 ++--
 drivers/hwtracing/coresight/coresight-priv.h    |  9 ++++++---
 drivers/hwtracing/coresight/coresight-tmc.c     |  2 +-
 10 files changed, 44 insertions(+), 21 deletions(-)


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
Sent by a computer, using git, on the internet

