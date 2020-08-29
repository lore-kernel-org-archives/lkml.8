Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E489C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1896520825
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkf7UZIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgH2KNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgH2KNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:13:31 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7B0C061236;
        Sat, 29 Aug 2020 03:13:31 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d189so2915448oig.12;
        Sat, 29 Aug 2020 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=g/qBkBixAm5IzDCM7Wp/r22aS2X7KFbRXdhCNpCB+6Q=;
        b=Dkf7UZIHnVtK1kih+cmqwwme7QN7fFkzR6wxDABHbWY7yAFmLommi1YaL7kwXmXeT3
         OPFfevhr+hbpa78uX7G7o02iwG/cZDPRLc5kYhA2/Kogf52wwzul/HoqIJNJWNezL8tQ
         L0XS5eHoEBNsl1pO0NW+U4zg0G7/Ry02hj61UOOmzrn3FPBGU3zwptIEjoj1vhO1znQ9
         A88qWr6WyrS5L447zKJKvUx9MBM+RBa73Hou0ZRtWJochoHcK9tpocz/WcDH+mxiBdfD
         WZgsdjuwu/CHHU17CkX7xn8Kp0nNi79d9GANRPzjdae0Q8aTezoEeIMUo+w8MB/3Hweb
         ALsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=g/qBkBixAm5IzDCM7Wp/r22aS2X7KFbRXdhCNpCB+6Q=;
        b=gPGoktBsRIKoa9eV5+M8l61Kk8BxKLPWgMF+1qF/52gRwUrzx8jv6wCIA+5pf370Dd
         j6mqaRx8XlsrUo3s6+XUbyBV1QJIoJnDKFpM43llmy8izA3NYIXDXZUwhu2CS+Uthb5u
         MHeHUUW8WgJk8NTt432hem6Ob+H5PCMPfaAAOp6vVuBknvjDVkrPTRc+bgTLMNabDtRY
         K4+lOTpnXz2yHIHhtcO+AXpGkvYmfhD3xR2QxkvwGc6nwPl1NlLEq0A9JnA6onB6nZQZ
         JfJTMFNjYFxD2/4GyLEPv241EcRcE493GNK+6N8SGrwy+Si4/w6BZRGQ5I4SIkkRrtqY
         UJ/Q==
X-Gm-Message-State: AOAM532/dbRga+JPrPROssDIbU18rEIv/PFKxfnelBZ8Brl00zv6mQoa
        VJg9nrgZZKNBiCExkXRBqQqaW+Wede0=
X-Google-Smtp-Source: ABdhPJwHQ/6wssRgfNw97vxGZOLKS4yWyOUxqUZ3UscaweSbEslAGBEW53sfjY88uK4s+8L6OscRgw==
X-Received: by 2002:aca:5c55:: with SMTP id q82mr1668256oib.24.1598696011024;
        Sat, 29 Aug 2020 03:13:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y3sm508716ooc.48.2020.08.29.03.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Aug 2020 03:13:30 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.9-rc3
Date:   Sat, 29 Aug 2020 03:13:29 -0700
Message-Id: <20200829101329.147475-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.9-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.9-rc3

Thanks,
Guenter
------

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.9-rc3

for you to fetch changes up to c1ae18d313e24bc7833e1749dd36dba5d47f259c:

  hwmon: (gsc-hwmon) Scale temperature to millidegrees (2020-08-27 12:47:55 -0700)

----------------------------------------------------------------
hwmon fixes for v5.9-rc3

- Fix tempeerature scale in gsc-hwmon driver
- Fix divide by 0 error in nct7904 driver
- Drop non-existing attribute from pmbus/isl68137 driver
- Fix status check in applesmc driver

----------------------------------------------------------------
Grant Peltier (1):
      hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1 telemetry for RAA228228

Jason Baron (1):
      hwmon: (nct7904) Correct divide by 0

Tim Harvey (1):
      hwmon: (gsc-hwmon) Scale temperature to millidegrees

Tom Rix (1):
      hwmon: (applesmc) check status earlier.

 drivers/hwmon/applesmc.c       | 31 ++++++++++++++++---------------
 drivers/hwmon/gsc-hwmon.c      |  1 +
 drivers/hwmon/nct7904.c        |  4 ++--
 drivers/hwmon/pmbus/isl68137.c |  7 ++++++-
 4 files changed, 25 insertions(+), 18 deletions(-)
