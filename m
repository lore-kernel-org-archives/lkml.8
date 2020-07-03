Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA11C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9742A20739
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvp/tjRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGCWDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGCWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:03:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE6AC061794;
        Fri,  3 Jul 2020 15:03:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f3so15650581pgr.2;
        Fri, 03 Jul 2020 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsKYmi23LgkmDWPpqgT0aNrAUnqbE1vYoDDbm1lMU3c=;
        b=Qvp/tjRXdLv0Exq3MwO/yJSDp2xSfdCiqSrzOUx/gcw+FofzisJRyT1CTxvULH/L42
         39j/hMFQF5qGjbUTDnAgfhwvyx+cW1ZtdECZCqqhuXJw4qRjbduSpA8rVzmpKHDre0pG
         MbJsm+eV4XY6oVucILYuBPfgD9cQBDlPzzkOGU858ykDOTP2qh8VKmaK8BX8YyVLSqMF
         BMVdly3zNOAHMEEtPeAqO4QMZ14K18g2TS90/gNUKQ5TR8aoAfr8vN+WpF0S/TUGkPLm
         zfxB4ZKBfu6vzM6Y9XjE8EREd/UB1UtDxsgCsQFOmSkOY98GxSwU1h01Sprgp6YFmd1W
         wytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OsKYmi23LgkmDWPpqgT0aNrAUnqbE1vYoDDbm1lMU3c=;
        b=EWf41O+50cwf6sjdC+IMi5JaIHnwuuwWQhp6U/LAFfc5LeixY27r+b00Zl2rHlKeDn
         3J11PQDTu/aFDj9F5eb3xtXqYeewjcZZ2X7QOLqDLRfjdutoZ55/alh5/VluPsa/p77s
         eP8H9G6hHoz1P/xNC+h0oMNAQSLJkqHar4As6W0lQ5e/ZlUOCIEt3ynv28EOv/eHjoEP
         xNal1B4W5Sw3tdB1u/Jo2q8sdk0/AP3h+9sT4Y9HzBKdivCsb/B2By5PoW12maHk6mIw
         dAFfGLXyJixP9FzyrjqY5zujTFxIHPl0v7mK6oL/48iKCkMYAV4O1S5MN77UpBAX4pt6
         H1yg==
X-Gm-Message-State: AOAM532lAjpIQCg7kOcAboM62EUF9Ri34yz8Me4kKA5D6SwY8/Okxmy4
        nrwq6Rh4+44WofnQ6d3DuruIDnJjz+I=
X-Google-Smtp-Source: ABdhPJy0jFCO8mfhZbuprvBYwPW7RVPFZpBriMCSU0MHo+VIZgoKejmfh0jL0p8c4YnBeDaDAoiqGw==
X-Received: by 2002:aa7:94bc:: with SMTP id a28mr34822604pfl.94.1593813817929;
        Fri, 03 Jul 2020 15:03:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22sm12672978pgn.91.2020.07.03.15.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 15:03:37 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.8-rc4
Date:   Fri,  3 Jul 2020 15:03:36 -0700
Message-Id: <20200703220336.33100-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.8-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8-rc4

Thanks,
Guenter
------

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.8-rc4

for you to fetch changes up to 0d242479b3e6f7b5aebea3ef07b8a73c4f45b50c:

  hwmon: (pmbus) fix a typo in Kconfig SENSORS_IR35221 option (2020-07-02 17:43:14 -0700)

----------------------------------------------------------------
hwmon fixes for v5.8-rc4

Accumulated hwmon patches:
- Fix typo in Kconfig SENSORS_IR35221 option
- Fix potential memory leak in acpi_power_meter_add()
- Make sure the OVERT mask is set correctly in max6697 driver
- In PMBus core, fix page vs. register when accessing fans
- Mark is_visible functions static in bt1-pvt driver
- Define Temp- and Volt-to-N poly as maybe-unused in bt1-pvt driver

----------------------------------------------------------------
Chu Lin (1):
      hwmon: (max6697) Make sure the OVERT mask is set correctly

Guenter Roeck (1):
      hwmon: (bt1-pvt) Mark is_visible functions static

Jan Kundrát (1):
      hwmon: (pmbus) Fix page vs. register when accessing fans

Misono Tomohiro (1):
      hwmon: (acpi_power_meter) Fix potential memory leak in acpi_power_meter_add()

Serge Semin (1):
      hwmon: (bt1-pvt) Define Temp- and Volt-to-N poly as maybe-unused

Tao Ren (1):
      hwmon: (pmbus) fix a typo in Kconfig SENSORS_IR35221 option

 drivers/hwmon/acpi_power_meter.c |  4 +++-
 drivers/hwmon/bt1-pvt.c          | 12 ++++++------
 drivers/hwmon/max6697.c          |  7 ++++---
 drivers/hwmon/pmbus/Kconfig      |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c |  8 ++++----
 5 files changed, 18 insertions(+), 15 deletions(-)
