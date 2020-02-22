Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC3C35670
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E091206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUgUbMPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBVB7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:59:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44422 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgBVB7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:59:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so1625515plo.11;
        Fri, 21 Feb 2020 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bPiehA+LSYVdtpwKmbPxHRPfkAKoqTNmaKfdGrk5b7U=;
        b=RUgUbMPx76nesOwYwg8U95GvdQVUMZDaF8Ri6hpN2pj0eQwLDgNpZoXGtia3sNmc05
         s6IkPpSkkjnmPiCSRu2TDiOmY6Sj1rvHxo5IMpqFVTFATHUozTVemYshjKmW6txne039
         qKzORtRkUFyFBsXMV3IJSN28Ox6Jbm6+aKI2IgF3hWEiymJzdSX1W9vRrIGxGVGC+RyK
         HvKUe+W3MsC2XGNQP6UYgqpR4dqDig25+9kToGdxgOIT8aci24dAhUCivo4WsO+SKV+w
         EGlStSVzy0cBlqgFUFnxZRNqKkhe0gpjMWj5LOZ5g72ercxvQifdCPQStTt9mXP+lxRE
         LEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=bPiehA+LSYVdtpwKmbPxHRPfkAKoqTNmaKfdGrk5b7U=;
        b=trlL0E9ffR+T5DNls0O1FEdTqmZeQ1Pb4EU6PMsztfI/ih1D/v1AM9ux4EcNRy6AN9
         gOZ69a69+UBAh+6CZLdgR4DuDoD0yrM1conu3kzHxjFTspErGtA6EXxp/G6qZClNKGBg
         g1RMq3UpSCYQQPr/oTaJn+trbKfoiT4P7D5VSgSiASFFRYR/ra2MSBc95RSqz5+wrxLx
         wS99bbEHHloTIE8gr8geuZUK3XlDxFvKFLLYSXqKEHXLMKRJjbb0MV87/1qx22fNiSGy
         GwiqjpQeEQd0HKMT3l7s9jPviYGu2XbV1kFx3F38bZFCMPM1uoDHyST+LOIR6jUJtIJY
         Pqcg==
X-Gm-Message-State: APjAAAW4RWLnXajBCJzxyDLNybbA2LPUvx/k9Xg0SYiNKk4vkenocd0G
        j+ZeVkSYQoWbrhTZjXA49h2bebiR
X-Google-Smtp-Source: APXvYqzHqlPWFKL2Gx43Aewag9UkaxrEpwfprte15UMgFsWUB/gITeDIsLd5nKb9uK1W+86RhxcrVA==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr31810562plq.244.1582336779978;
        Fri, 21 Feb 2020 17:59:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g72sm4263183pfb.11.2020.02.21.17.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 17:59:39 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.6-rc3
Date:   Fri, 21 Feb 2020 17:59:37 -0800
Message-Id: <20200222015937.3949-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.6-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6-rc3

Thanks,
Guenter
------

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.6-rc3

for you to fetch changes up to e61d2392253220477813b43412090dccdcac601f:

  hwmon: (w83627ehf) Fix crash seen with W83627DHG-P (2020-02-21 09:16:24 -0800)

----------------------------------------------------------------
hwmon fixes for v5.6-rc3

- Fix crash in w83627ehf driver seen with W83627DHG-P
- Fix lockdep splat in acpi_power_meter driver
- Fix xdpe12284 documentation Sphinx warnings

----------------------------------------------------------------
Guenter Roeck (2):
      hwmon: (acpi_power_meter) Fix lockdep splat
      hwmon: (w83627ehf) Fix crash seen with W83627DHG-P

Randy Dunlap (1):
      Documentation/hwmon: fix xdpe12284 Sphinx warnings

 Documentation/hwmon/xdpe12284.rst |  1 +
 drivers/hwmon/acpi_power_meter.c  | 16 ++++++++--------
 drivers/hwmon/w83627ehf.c         |  7 ++++++-
 3 files changed, 15 insertions(+), 9 deletions(-)
