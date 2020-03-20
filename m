Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5FAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3931A20724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOaKuUHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCTQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:16:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39605 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgCTQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:16:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id r2so6502638otn.6;
        Fri, 20 Mar 2020 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4siL/QnB5rK41jF0b+PMW35lQYv+liwGyNv1LaXLkvA=;
        b=IOaKuUHUyAWoXIvTFm9CTyUOg3PspNJqP3yD219ml731mn2FZeRJlsS45MHwfwcb2O
         +5htgSBHVHLl0SH87HXi++5ruLquaxguCRFD1YDx8keO95ZhvkzqiPuuOKEuTjI5dYjG
         +tW+wQ8xwffz28DN/dALiYDOzPdu2E2nXroj2RQemnJK5ep/LNRSd6tVJQ5O4QlSlk2o
         7DCoBJloHGLtQFArBXxcxn6nHVkiHBCsKOOCacbQIPn3C5YT1WpOpRNKtvAyZjVNjYX1
         /qoKWFVb8xG+Q3e9aGvTiiarvYrKhrFMcmYLpSFPOcDuPe+hMKRNmAu66DspBxrlS5Mo
         SanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4siL/QnB5rK41jF0b+PMW35lQYv+liwGyNv1LaXLkvA=;
        b=MSo9aD4Gnl3+zJ9xr6J6EnsHEdDhefWKGToKUntxjVXv8TJUN0QJ+gtcav3vBd3bUX
         YwMzdoxTq5jm8dB5cbWfsdzfMFNH4SwotjBSTp74Z2Yi+vzp9gvSXQV//mXid4OZW2tp
         viOETBLMv/1dL22BQtXsdgHRG1m9R1XR2gt44ShglnLMGbNZzXDoKqHinwebgLonOOxT
         TZbvU69JQbAqOHcobKleUX3Z1HUDH+YBDMS+ANI8OWQ67wywJL2qJoWkQig0c3x0m1Lt
         tfcssIVUsxmP8jBB9CQRL1qv+1Nxl1H2u4jCJYnhi5YFc89/gQcQbGAD6ASFVFcCozzx
         QyAg==
X-Gm-Message-State: ANhLgQ1qHlYJDM/kZcfosrpDL1bWT+xm5jwC9evpqsQAvZxcZ1Y/9koH
        O4Ojl8mg0lCYjTULDWr6A01GOoh9
X-Google-Smtp-Source: ADFU+vu7m4s6HC3CFPvhv8PHdn4skuu+PhssReolQPybf+07PloWOvFqJPVtHrmf8vQ9Idy+Ok9evQ==
X-Received: by 2002:a05:6830:1051:: with SMTP id b17mr7607762otp.157.1584720960728;
        Fri, 20 Mar 2020 09:16:00 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id 60sm2024521ott.17.2020.03.20.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:16:00 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:15:55 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com
Subject: [PATCH v3 0/2] hwmon: (pmbus) add support for Gen 2 Renesas digital
 multiphase
Message-ID: <cover.1584720563.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds support for 2nd generation Renesas digitial multiphase
voltage regulators. This functionality extends the existing ISL68137 PMBus
driver.

The series contains 2 patches:
  - patch #1 adds extends the ISL68137 driver to support Gen 2 devices
  - patch #2 adds documentation for the newly supported devices

Grant Peltier (2):
  hwmon: (pmbus) add support for 2nd Gen Renesas digital multiphase
  docs: hwmon: Update documentation for isl68137 pmbus driver

 Documentation/hwmon/isl68137.rst | 541 ++++++++++++++++++++++++++++++-
 drivers/hwmon/pmbus/Kconfig      |   6 +-
 drivers/hwmon/pmbus/isl68137.c   | 110 ++++++-
 3 files changed, 631 insertions(+), 26 deletions(-)

-- 
2.20.1

