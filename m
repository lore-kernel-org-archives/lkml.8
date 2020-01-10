Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF5C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C4120838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FtvT0qd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgAJRRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:17:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51669 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgAJRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:17:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so2826217wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikg7/D3RIJnL4WW31mJDXYflyJd4Gt4lq8m0Udaafsk=;
        b=FtvT0qd7GMFZH4XVs6mjUKmTAu8KEsSy14OMsKrjBYPRnR1KyKHvOKT4rC2gdjxSzB
         1WqFP/dRmkXI3I3QSorfAY//jFnZS5GbuiO4k6JmGPIXW/tcFdGKR7AwE2JYCzFEL6fv
         Ewk9bwPnMjj4thU85YPw5QxFtacZmoe1nCff/fvLIm0VCfCGuha2rJWhn5mjoDg5OZ46
         HGKmr+MXfs/sFyaqhsXY13BRZtuGADBEMsDHp6GACykKSnCAdZBYiazK8yvPYIx73KRV
         GbwUpOsICU11mwFdl77RNBbjATp76jI/gFR9eEyitiseUYbqN3znVKpw9v9QQSsDo7JU
         aZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikg7/D3RIJnL4WW31mJDXYflyJd4Gt4lq8m0Udaafsk=;
        b=WOe5R1WxSS5BrjF9mEO9g5ASozkzedRGSK9B+BsKPUJdW+vKxEYKAvWgcl1qoabi7/
         PiA5pYt1zPzHACsIsA2Ai91G1Q/RmQin/kMGUwyLTFPPpjj6IjE3go+ivefrqmoBdhw4
         cmwgMutTFflzG3HqPYq6grOw+hPpidpFUJKEJfpzH2JXa/Q+ybDji8jN8jJWc9Ogg9oG
         tw+E95pjQxVLZ1gXjzURd0Ft31QxtFWjmcWAzdmzYV+/ihXyK4pv2RS8sXHrmow/8Z/y
         8axGwFn+5gWjZZCZmJF24x4VVs8uBzcjwvGnI+E6EfKJQkFdVkoIgF56MEg2bOdZcwld
         qDzg==
X-Gm-Message-State: APjAAAWbw2R0rCBzBw67TUkW8mVPRsBw/UGGgyKOX6hI1/6a+yzmmROj
        fAAbuR7C1CdGw4oXMzRqO0XDkA==
X-Google-Smtp-Source: APXvYqzQJsMgqTHq6X0mWLemADZwjQXVEd3suMxwkP0Wa9td3m4/HufEJ1evDQKl2F9VK7FYC4Aygg==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr5123132wma.64.1578676622292;
        Fri, 10 Jan 2020 09:17:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:b0ec:c83d:aa26:b93])
        by smtp.gmail.com with ESMTPSA id z123sm3072725wme.18.2020.01.10.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:17:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/3] ARM: davinci: convert dm365 to using the new clocksource driver
Date:   Fri, 10 Jan 2020 18:16:40 +0100
Message-Id: <20200110171643.18578-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the big series converting DaVinci to using
a proper clocksource driver. Last time we couldn't merge the entire
series because of a bug that only appears on dm365 Soc when using
ancient u-boot.

This series contains a workaround for this problem, a patch finally
converting the platform as well as a removal of all obsolete code.

v1 -> v2:
- simplify patch 1/3 by using a boolean flag instead of caching the
  value bits for TIM34

v2 -> v3:
- simplify patch 1/3 even more as advised by Daniel Lezcano: simply
  register clockevents only after tim34 is initialized

Bartosz Golaszewski (3):
  clocksource: davinci: only enable clockevents once tim34 is
    initialized
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm365.c               |  22 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  33 --
 arch/arm/mach-davinci/time.c                | 400 --------------------
 drivers/clocksource/timer-davinci.c         |   8 +-
 8 files changed, 20 insertions(+), 483 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c

-- 
2.23.0

