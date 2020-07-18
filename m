Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E335C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484FE20657
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hibdbRlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGRPW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:22:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B4C0619D2;
        Sat, 18 Jul 2020 08:22:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so6703720plm.10;
        Sat, 18 Jul 2020 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LpksvDwvh+E98AF9FHS/KSswn5m/F4GAbBymIkXYtNg=;
        b=hibdbRluOMnua7bZUPY+pDmcx6NBFHx1HYgocfzwHeDgmKp0bsMuP8hO32WIi2/qXk
         Vrsm0XPVHkI5Mfo8JMP73IyFF5zuBqAnpHSHcVKGZTwlNQZe6EmHnXYmFt+17gBwOe+c
         MsYQY2Z/Svqu+1pNk/eiyrykUHdIZfOlj68yl4CVO0I/AdDcj4ElR9ESxBrHRWFsIX9d
         frMNvd0J+GWPrrCdJvMgE6UtwopVwol2Lna/CncS2KjeogCWaxEJLfVbftnRU1lD2LBh
         ud/v7AOwdOStig05dyFs0+LNYyz+SanyEtwBmdSxUyk/WUcQ3y4oRmeorrF8gQl6G2GZ
         93Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LpksvDwvh+E98AF9FHS/KSswn5m/F4GAbBymIkXYtNg=;
        b=lbz5ol0sMcUckRVz5Ne3DtZ0O8M0mZMMb1CWm3nN4IUle2Xffbl7Vw9vZ3YH/28BgI
         lvXYT+CItwttpg/3T7aRXOJJ1u4mpJWYawroYZIGGRvJOzU3Oi2s5n0fNd7SJEGRyvUa
         HNbtvGbqSjL+EGyO3FIb4ntLosQb238Lo91S08Lu8rfjdewx6m8K7McCEinb3GCUpR5x
         g/rYNFQWmXVUJMAHXAyl1hWd1wMOwO8apPjKNL1lUNLDUk9+P32flk4gVf1enIZw5oHu
         L4s/lQbfThM51qSsvpU2OmL6CUrbWdxmOLBoWsilUzC41XRf0oyZMBr1IFVWYZpzsHy8
         tMYw==
X-Gm-Message-State: AOAM532ib5vg0q5ZiZ2nSVYY6BrGO/mFAo4AmsS0UqdnTWVMM39zPQVG
        ygRuR315sPNWhXuPfmrboddF7Jm7
X-Google-Smtp-Source: ABdhPJzfbn09mzrehPqsO3QuRNM+ZJRjcpjDWrbwFjfN4J8GaydotdlfltdXBjCleq1CoPbQSU1AAg==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr15762045pjb.170.1595085777459;
        Sat, 18 Jul 2020 08:22:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j26sm10624637pfe.200.2020.07.18.08.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:22:56 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.8-rc6
Date:   Sat, 18 Jul 2020 08:22:55 -0700
Message-Id: <20200718152255.175469-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.8-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8-rc6

Thanks,
Guenter
------

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.8-rc6

for you to fetch changes up to c66ef39eb27fe123ee05082b90eb2985c33c7715:

  hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA family drives (2020-07-18 08:11:44 -0700)

----------------------------------------------------------------
hwmon fixes for v5.8-rc6

- Using SCT on some Tohsiba drives causes firmware hangs.
  Disable its use in the drivetemp driver.
- Handle potential buffer overflows in scmi and aspeed-pwm-tacho driver.
- Energy reporting does not work well on all AMD CPUs.
  Restrict amd_energy to known working models.
- Enable reading the CPU temperature on NCT6798D using undocumented registers.
- Fix read errors seen if PEC is enabled in adm1275 driver.
- Fix setting the pwm1_enable in emc2103 driver.

----------------------------------------------------------------
Chu Lin (1):
      hwmon: (adm1275) Make sure we are reading enough data for different chips

Cristian Marussi (1):
      hwmon: (scmi) Fix potential buffer overflow in scmi_hwmon_probe()

Evgeny Novikov (1):
      hwmon: (aspeed-pwm-tacho) Avoid possible buffer overflow

Guenter Roeck (1):
      hwmon: (nct6775) Accept PECI Calibration as temperature source for NCT6798D

Maciej S. Szmigiero (1):
      hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA family drives

Naveen Krishna Chatradhi (1):
      hwmon: (amd_energy) match for supported models

Vishwas M (1):
      hwmon: (emc2103) fix unable to change fan pwm1_enable attribute

 drivers/hwmon/amd_energy.c       |  2 +-
 drivers/hwmon/aspeed-pwm-tacho.c |  2 ++
 drivers/hwmon/drivetemp.c        | 43 ++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/emc2103.c          |  2 +-
 drivers/hwmon/nct6775.c          |  6 +++---
 drivers/hwmon/pmbus/adm1275.c    | 10 ++++++++--
 drivers/hwmon/scmi-hwmon.c       |  2 +-
 7 files changed, 59 insertions(+), 8 deletions(-)
