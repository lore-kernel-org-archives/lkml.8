Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A9120671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alW5P+uE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEOPXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726228AbgEOPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:23:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67CC061A0C;
        Fri, 15 May 2020 08:22:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y18so1080045pfl.9;
        Fri, 15 May 2020 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JXjW8Fwqqx8e6N0SOGdmxsBYaPVx0pjA+VT2dzb7g4k=;
        b=alW5P+uETtrTiaACW/tUwzhy3RCwja3lJqg1Lbd4iEe4TEO5mTDUK0tloWjLUiHl8x
         EuKfWC5TaQbe4P6uqsCBiLuQ1Z6lgBPzIv+aBIDGn6yAo554QIpCo/zRfn7Bvb4jHj/S
         pNnDpJC4JBuklJK49L4ydNuy0fEFWW7KI3LtobUmnNOqvT5f8qAW8OkTkgv49KOpnloD
         RTVAsgrcFT3KF8Z0oN5RDmSDriAogUs/k+gAdSwUe1nd8dheJDfMou2ygm8WkHitqXY9
         Oy2a2k4RCo0ruaH/FkbeKHGtDwpGDtIHOkSxK8kp8Qz8B5NJFf7+bP4dEU7Sji6H+Po9
         xdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JXjW8Fwqqx8e6N0SOGdmxsBYaPVx0pjA+VT2dzb7g4k=;
        b=lCI1PNi4t7/8D9ayLuHmt3pd1u4cEA7nOPGi3xNqGWFRyk5LDKGPEkpRVokdteWnVU
         4/mI4JTJmFqeXqPdbpNFUnmtMNZshYnNOXhne4HuRbfxTTAqDDfhgy/RG9HsGmiUeeOc
         gJWuI4vBKK+2Cm5doP2qsa4NV7FeyxoLheVXQs789yuQExXt8gGuAx33sd0wSLXEyx6E
         dsPm2RCy5jEiyB2PCWvBncgzO+0tqnaq6+xkapO7CPCQwPbRMVYu5h19q8Ag23huIupW
         IXw9NDVsW9W/OvtrSSGB5jTrJI06rWmQRUEDdwhwxIa2otoQP1dHI0mBz3oOTrBkfYlV
         M+Ow==
X-Gm-Message-State: AOAM531CP91Oqk0h5B4ywI6BzSVyfTs0Dpn8Ro0C0sdxVNY1vuRNL6yX
        xljE7N0RJkftqj57B3x39I4XUAc+
X-Google-Smtp-Source: ABdhPJy9aGh/4wMhQRWaxXuCWxaoEDf873E7pBLKiaUv4NwXPA1PMgY9TlorzZfhHvs0ynr32C4DSQ==
X-Received: by 2002:a62:6341:: with SMTP id x62mr4494195pfb.289.1589556179070;
        Fri, 15 May 2020 08:22:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7sm1848406pjf.30.2020.05.15.08.22.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 08:22:58 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.7-rc6
Date:   Fri, 15 May 2020 08:22:56 -0700
Message-Id: <20200515152256.175107-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.7-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.7-rc6

Thanks,
Guenter
------

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.7-rc6

for you to fetch changes up to 333e22db228f0bd0c839553015a6a8d3db4ba569:

  hwmon: (da9052) Synchronize access with mfd (2020-05-13 10:06:09 -0700)

----------------------------------------------------------------
hwmon fixes for v5.7-rc6

Fix ADC access synchronization problem with da9052 driver
Fix temperature limit and status reporting in nct7904 driver
Fix drivetemp temperature reporting if SCT is supported
but SCT data tables are not.

----------------------------------------------------------------
Amy Shih (2):
      hwmon: (nct7904) Read all SMI status registers in probe function
      hwmon: (nct7904) Fix incorrect range of temperature limit registers

Guenter Roeck (1):
      hwmon: (drivetemp) Fix SCT support if SCT data tables are not supported

Samu Nuutamo (1):
      hwmon: (da9052) Synchronize access with mfd

 drivers/hwmon/da9052-hwmon.c |  4 ++--
 drivers/hwmon/drivetemp.c    |  2 +-
 drivers/hwmon/nct7904.c      | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)
