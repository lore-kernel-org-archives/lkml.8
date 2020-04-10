Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65423C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376392083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzUgex3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDJWM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:12:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54593 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:12:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2so3899022wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=n0j9wZcTTuZxD8KB3QqeYLTyhy9LHC9Hq6D7wBVGa6s=;
        b=wzUgex3eNYXux6ovvi5zRsXXAqoWgMfymJ+w9Y9kEI8KMuutY/mBlnFlAJbxZDSylg
         XB436cK8+fQ+58Gppq5HJ5ZTgDRUodQGFZEJu5SOW9iZZN+V9Q50522ncHZY4sE7mb6j
         PmymPAOq0k2VQmZ/v0njlz8EA5m9556gzq01itNFTbDObU2vpoLHP6ju70iQV3yRmbc8
         iu3DIzFJqBvZA4LlJU5gQizYJIlH+gMFvwjlaiX3NF9xLs8KNlBBmuqTtGzrs8XcJko5
         tIHAg7wrm5f7pyEI+ej1WHSJYMuk6GIi3yLOHvvvYlk/T3fFhzDFWsV4o+0cxGpxvFcG
         NZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n0j9wZcTTuZxD8KB3QqeYLTyhy9LHC9Hq6D7wBVGa6s=;
        b=NKMwOOvf/JzjHb/TWpQ7whYsN8DJMZ++ZzkPX6b3SvG4hz1NpKfOjm+ceiFDsrkBG7
         fxY7H1Y1X1FzwOYoSqADquf9yogh/sirkQwXVtG7fbgxhKa9JcDFt7GjyrInRmVeYaLZ
         oULkyOQLiW8S1/2XJHy75GqusngksB7c3EnGwPA4T90+vF4cs6025ajPOblrHcPYiiRY
         gqyDWu8X4y4eDza2kXEtoOPeqJpocLc8fhx8uDVxhcKvMJjQJ0is2DqEf3Dgzq/QjsR9
         HYnB3LsDSVDx1el0acURNkftTX3L8vWxvcfagr7GQIpAvO75c7RgWJXjanVNY58LpbLv
         oUDQ==
X-Gm-Message-State: AGi0Pua3bUJlvehH17wJLSYTdRcARXfOJ8lrWOuaMr0t3VMy19Wc+hz2
        Jmrh7CezW4fDhRGBj6oQ+mAHsA==
X-Google-Smtp-Source: APiQypK4Hjmut4SJ1rdJrW/veFL1RencVupxCubgzD4EzX1jGgV/usBIg2qokGceKFUYkkR4Xo/iWg==
X-Received: by 2002:a1c:2942:: with SMTP id p63mr7374059wmp.183.1586556776440;
        Fri, 10 Apr 2020 15:12:56 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:12:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Consolidate the thermal_cdev_update() function
Date:   Sat, 11 Apr 2020 00:12:29 +0200
Message-Id: <20200410221236.6484-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does the following changes:

 - Moves the calls to thermal_cdev_update() in the throttle governor's
   path

 - Reduce the scope of the function to the thermal framework internals

After these changes, all the calls to thermal_cdev_update() are located
in the throttle governor path, setting the scene to move the call to a
single place, close to the concentrator function thermal_zone_device_update().

The micro optimization to not invoke multiple times the cooling device
update is lost at the moment but it will be regain when the call will
be moved to the core.

Daniel Lezcano (6):
  thermal: hwmon: Replace the call the thermal_cdev_update()
  thermal: core: Move thermal_cdev_update next to updated=false
  thermal: core: Remove pointless 'updated' boolean
  thermal: power_allocator: Remove useless test
  thermal: core: Move the call to thermal_cdev_udpate() to the power
    allocator
  thermal: core: Make thermal_cdev_update private

 drivers/hwmon/pwm-fan.c           |  3 +--
 drivers/thermal/fair_share.c      |  3 ---
 drivers/thermal/gov_bang_bang.c   | 13 +------------
 drivers/thermal/power_allocator.c | 10 ++++------
 drivers/thermal/step_wise.c       | 13 +------------
 drivers/thermal/thermal_core.c    |  5 -----
 drivers/thermal/thermal_core.h    |  1 +
 drivers/thermal/thermal_helpers.c |  6 ------
 include/linux/thermal.h           |  4 ----
 9 files changed, 8 insertions(+), 50 deletions(-)

-- 
2.17.1

