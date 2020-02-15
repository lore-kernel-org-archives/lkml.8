Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED83C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEF92083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 17:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx8IMrHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBORsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 12:48:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45234 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBORse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 12:48:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so5072529pls.12;
        Sat, 15 Feb 2020 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=i2NDDgAdUuAw5YVXyPfzY9L+iTThjwMB3K1n+T+kYKU=;
        b=bx8IMrHVWahtQZo6X9CEw/bd3uwyxztC3+SPHdWOI8UoeeoRJDTRKfu2Cx8F4KB7nH
         xyIXXXR3UxHzAzKc4AwpM8rt4z5JyBd9dNeQUIBbap1QbvyZXl9bSg+5SFCcMBgfup+P
         pNYMd2E0hzuzREBE3ZB8QZxBp83SiE0x07ZceOUYPRnfRljMRFOQPBGGQgo1yOJjc8ky
         R//oUIVhmp1/csVnqi1BZcu7LXcDzwlHdEiou8M8r7nH1PoirHLmFVs42H6D2ExKICCw
         PAMB/W2JeDrcUED0um1SPtZR3NBC7UcBgnwQseYTdbTwPyakIKgebfLJfjNbXATzWLb5
         rn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=i2NDDgAdUuAw5YVXyPfzY9L+iTThjwMB3K1n+T+kYKU=;
        b=MM6uLb6MBhXU9VmoxB11+svxBp2oHI/HCzFrPEbZu5sERXWU4jmKDKM3vXt9srPyng
         NzYtgLWKfVRjMRygzQfuyD6rlbB6laCBq2FkSsPRpA0p+YryQtBUlvwqSgVadI3XYyEn
         jU4hHpUP90GS9fyKYpQ5pthoW3S1iDkvnTlzJlAJfOhr2i9YyyTT/w89K5d63JZKtaKV
         lmYlJzaxjJOAVN7y32rwK0ai8/2Ji3B9+Uar4XzIG66k+l33bZXJKfxpF4fwBGEqvlbZ
         Ytg/hRHOpMZ+ra7LHRTwbZD5DiQbNT4+9PCV79Z9BWTaC46mrqOYa3kqY9mlrbt1C2sd
         +JXQ==
X-Gm-Message-State: APjAAAXglGUusNoRdxlMIs7CQJ6Az/ecljb7AZ16eQx+QDROYd03+Dae
        aN8zTlRx0kJqFTPc9CfyOMZSBNJP
X-Google-Smtp-Source: APXvYqzUCAXv6kO7oY6Fctgd/EXfsNHidTC213Rvj0zuOViXTFfPLgbk6Z6zKHtAxV7VP1Ma17Y9xQ==
X-Received: by 2002:a17:902:528:: with SMTP id 37mr9160092plf.322.1581788913908;
        Sat, 15 Feb 2020 09:48:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9sm11201338pfm.150.2020.02.15.09.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Feb 2020 09:48:33 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.6-rc2
Date:   Sat, 15 Feb 2020 09:48:32 -0800
Message-Id: <20200215174832.26950-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.6-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6-rc2

Thanks,
Guenter
------

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.6-rc2

for you to fetch changes up to 205447fa9e0a44cc42a74788eb2f6c96f91d5cd6:

  hwmon: (pmbus/xdpe12284) fix typo in compatible strings (2020-02-12 12:43:01 -0800)

----------------------------------------------------------------
hwmon fixes for v5.6-rc2

Fix compatible string typos in the xdpe12284 driver, and a wrong
bit value in the ltc2978 driver.

----------------------------------------------------------------
Johan Hovold (1):
      hwmon: (pmbus/xdpe12284) fix typo in compatible strings

Mike Jones (1):
      hwmon: (pmbus/ltc2978) Fix PMBus polling of MFR_COMMON definitions.

 drivers/hwmon/pmbus/ltc2978.c   | 4 ++--
 drivers/hwmon/pmbus/xdpe12284.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
