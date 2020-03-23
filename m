Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5492C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E98206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4lRwQYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWXeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:34:03 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:36423 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:34:03 -0400
Received: by mail-pj1-f74.google.com with SMTP id np18so1023328pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/RImki6aeT4q5vb9Y/WQiMvUYzgD9NDtY/Eh1UmZ8iA=;
        b=O4lRwQYfbO/ukCbwvjFzGUN4nuu1mInpQKXV5eRdJ5SDplvgn9LcJWm6RfdBFN6F9b
         /yKLvHw0uGBfbxttjiFdwHqZ9w0OJcJOYGxMtH1Ddf2OZXEpdxcwqYAkVGUAGntg/z62
         6EfOjsNJF0y5J2g8blj8p9nWe90nvI/wioQwcpoOr+sNNEMJorrCx/iEQYfeGMq0Bstw
         dYhXRL/U9y8ZQqLZ0JHUfoQGREPiJkV2hm4Q8Qpt9B6l1TcOeI5/TZXT0QpqUyw735Qd
         085QzqfH59RWraXUzemmYVcmKB6yxKyAxfm6cEJxkqalP7XX8QriSOcSsOEUFip1GJVY
         Zq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/RImki6aeT4q5vb9Y/WQiMvUYzgD9NDtY/Eh1UmZ8iA=;
        b=Dc0JE4CiyckZ8DHRDlFS2dezbPuJ/J3Nj7sJ3klXWFxbf+wUlb8COK1dYeBOXmEYpO
         RZbAZf4d5razOPdI54tVJwkSLWPuFIY/862GUrMHKDkbqjavWN/mGSHnsrbd1LYebE8f
         qhOWkr4gPAHoeFrP/p1jCaOxkxOrGo4OkkTj8m8G64FyP7VlIjlGLPWlsKL26zP6Vbpr
         GiwMoxKvT2fDwhbZ/6zmfw1FxUfjYsY/RI7m8lZE0eRlmo97nIFkoWj3HXlnUNomAzSW
         KxxkG6Z8aCzKexH2bsmK/inAhlH+1CCZOySmt2mVl/hTU663xyERQoEy9vftaoAVa49d
         7LUQ==
X-Gm-Message-State: ANhLgQ2AcubVehOJZmq2LhtfiIfFM1dd/Ilg7hv78edKFbtGjp6Nj6Xs
        CJd2KjW4m7Z6gu/r9NcPnxy5z5dV1w==
X-Google-Smtp-Source: ADFU+vuekTP9i4w42Re9frhofj1tKIgwBJ7sai5hL7P0rtEiV2boFrt/rT5lNWcxnH3CEeV3UiBI89FLHA==
X-Received: by 2002:a63:da45:: with SMTP id l5mr23139967pgj.273.1585006441709;
 Mon, 23 Mar 2020 16:34:01 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:33:51 -0700
Message-Id: <20200323233354.239365-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH linux hwmon-next v2 0/3] SB-TSI hwmon driver v2
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        joel@jms.id.au, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds hwmon support for AMD SoC SB-TSI emulated temperature
sensor and related documentation.

v2: rewrote using devm_hwmon_device_register_with_info() API and addressed
    comments received in v1
v1: first version

Kun Yi (3):
  hwmon: (sbtsi) Add basic support for SB-TSI sensors
  hwmon: (sbtsi) Add documentation
  dt-bindings: (hwmon/sbtsi_tmep) Add SB-TSI hwmon driver bindings

 .../devicetree/bindings/hwmon/sbtsi_temp.txt  |  14 +
 Documentation/hwmon/sbtsi_temp.rst            |  40 +++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sbtsi_temp.c                    | 261 ++++++++++++++++++
 5 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
 create mode 100644 Documentation/hwmon/sbtsi_temp.rst
 create mode 100644 drivers/hwmon/sbtsi_temp.c

-- 
2.25.1.696.g5e7596f4ac-goog

