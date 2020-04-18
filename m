Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F6C21BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naDBULIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgDRTtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:49:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274AC061A0C;
        Sat, 18 Apr 2020 12:49:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x3so2881405pfp.7;
        Sat, 18 Apr 2020 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Y/SzlNPnbUm7h0G2Yfc4g6XizOL6O0F1JAvmhHKZVeM=;
        b=naDBULIbe3M5HUGt3xmozZ71nP1DE0go78SIXXjh0Vgli8hsNBtuLvKCTMJzDBC1PU
         5VseFyLEzap45gv9EjhrZsDZIprgs7CylPVus1KQuXdRufjAFdOBiE9WXbr0eTwEOtfM
         DNRhBMKgvURiv1xQPq4WxIrgenU+CExLbmGHgl7hmtoGhZ5IghnDHBTCIeuBp26MIqYK
         LdZ9AfFOVpEg0VEKqONCpnUuB55Xzp5qdnqkukAyr56gPj9oNHgUopIRVbHpHu2iAq0d
         gVUs7z1M2pInHcLNm44u8+4vL2kkxxtrlxvk9PAsYU2JiKN3qq+aStC0FOihV0WNcFjW
         Gn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Y/SzlNPnbUm7h0G2Yfc4g6XizOL6O0F1JAvmhHKZVeM=;
        b=r3gmMfalrY8/tpLIXtAIOpGZn1d+w8s8qczJKzgA75pjDmU5NL/GsehemLsZEa+NpK
         T42+HghcHi6wriUku6P546K1FP1FR4VOWw0PPRgzz7M8EAjfCSJVDTgM5fas7MbUav9p
         T2OXVfxQlAQ1VzkRnHRxyDn/Z5XCb2T+6j7vius+hM2YfYV/VVVAsnsX2kSorRj47sSr
         yrrp0tIQYcGHmEmlUAZJu/fK+eYjHF80ztWCPXH4opGIhUps5BmalsdqlDNwmNrx1COv
         pq52I7gjIUcQgdwfNMczkxJlbTG5ztkHMCHEIId+f//IzTemVy1o7Y8dIsn24T4CJ1m5
         WjNw==
X-Gm-Message-State: AGi0Pub+IF46r/NnUc185iH7biNLT0h+HV/c3S4ouYFsW9mgkCg6Ed6c
        Eum7aD5GYabWTIqLe4H6iKvgAnSY
X-Google-Smtp-Source: APiQypJcUt0Zv6YK1+BJROfQVMlRousdmqPvjcMziFa4YR5PMHcqEyEW6FLfdhjorsj2wH9Cam3D9A==
X-Received: by 2002:aa7:864e:: with SMTP id a14mr9593864pfo.67.1587239379708;
        Sat, 18 Apr 2020 12:49:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8sm9210745pja.26.2020.04.18.12.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Apr 2020 12:49:38 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.7-rc2
Date:   Sat, 18 Apr 2020 12:49:37 -0700
Message-Id: <20200418194937.5589-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.7-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.7-rc2

Thanks,
Guenter
------

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.7-rc2

for you to fetch changes up to c843b382e61b5f28a3d917712c69a344f632387c:

  hwmon: (jc42) Fix name to have no illegal characters (2020-04-18 10:13:07 -0700)

----------------------------------------------------------------
hwmon fixes for v5.7-rc2

pmbus/isl68137:
    Fix up chip IDs
drivetemp:
    Return -ENODATA for invalid temperatures
    Use true module name
k10temp:
    Fix static symbol warnings
jc42:
    Use valid hwmon device name

----------------------------------------------------------------
Ann T Ropea (1):
      hwmon: (drivetemp) Use drivetemp's true module name in Kconfig section

Guenter Roeck (2):
      hwmon: (pmbus/isl68137) Fix up chip IDs
      hwmon: (drivetemp) Return -ENODATA for invalid temperatures

Jason Yan (1):
      hwmon: (k10temp) make some symbols static

Sascha Hauer (1):
      hwmon: (jc42) Fix name to have no illegal characters

 Documentation/hwmon/isl68137.rst | 76 ++++++++++++++++-----------------
 drivers/hwmon/Kconfig            |  2 +-
 drivers/hwmon/drivetemp.c        |  6 +++
 drivers/hwmon/jc42.c             |  2 +-
 drivers/hwmon/k10temp.c          |  6 +--
 drivers/hwmon/pmbus/isl68137.c   | 92 +++++++++++++++++++++++++++++++++++++---
 6 files changed, 134 insertions(+), 50 deletions(-)
