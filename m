Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C492D2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wd0rykDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404369AbgFYQg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404064AbgFYQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so6612558wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKhxAYLcK1OWpezH2GZRnraYb/4zrSVc4ykfScpn8zk=;
        b=wd0rykDoFDRN1TLDacv6YMzXLXXW7nrqzLS8OOr4ai+twsPATbkAx4DIRrdYcOXCHp
         WP5V5bzsw5eVEgEuUIom6wCwViYl8tglzyaN2e4CGPR4ggcFscyeekW+7iDg2AG5zhZG
         Ea/R8fbkThp8/tpcqD4o1u3xTyjFIY+UFybgLALILRrkcfsTvvc5p4NSADfYA2PZdsb8
         OIbrjy0gAUecXTH9IbohzKwOHZXcjHhqRYGTUmGutS3fLwY4oGY3QJZVvxanpZbEyV6t
         GGL4QNEoBkDZ8HR3npk9lpDu187nVloUDCw3hjYGGfRjY2PtCAiybaaYukvOmig9cwRs
         hq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DKhxAYLcK1OWpezH2GZRnraYb/4zrSVc4ykfScpn8zk=;
        b=Jm0hTY6lR3htTSyHYlVgQjBLwH8r9SSIhUQWTZDd7Ken5AkPuFWeVK1USliFYoGOYW
         pIpYyXw8wsk2CIxpdiRNj5hk5ZJ0mdTr9CAkBAduUK/R78+CYVMYUPvzuh1FxmwkxZzw
         Hk/GZEmz4b51AZ4MGhotyOca7WB5Ok7taPbShnWZcEJlUgZQEYKytyaf/8c5z6t6AM+/
         OsukMzkjRbMYwhCKHoTYOWymzjda6adq0iRXISDYQrAwUBqPXt+vSf816wI3Jh5rPCKg
         8rx3TRLspqEl2NqQdDlD69P7R0PR+OYRPid33EFOZ6xZIs3GtcpjtXbAN4XP8qjGgue8
         TshA==
X-Gm-Message-State: AOAM5339lxsM8Wnqm7VKa1xxNsPs5ac4jMuQhUFBSxNifWZytp8wdK+x
        R3c6aAuQ7OyhQouOwYR7MB4Xiw==
X-Google-Smtp-Source: ABdhPJxuLncPUEMpBum2kdsCfeKYpgkk8gkVwLCetbj7Az5tRzWNJPfoJ1UenyrKzEFmcyJBa5j5yw==
X-Received: by 2002:a7b:c381:: with SMTP id s1mr4530291wmj.25.1593102983825;
        Thu, 25 Jun 2020 09:36:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/10] Fix a bunch of W=1 warnings in Regulator
Date:   Thu, 25 Jun 2020 17:36:04 +0100
Message-Id: <20200625163614.4001403-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (10):
  regulator: consumer: Supply missing prototypes for 3 core functions
  regulator: devres: Fix issues with kerneldoc headers
  regulator: of_regulator: Add missing colon for rdev kerneldoc argument
  regulator: dbx500-prcmu: Remove unused function
    dbx500_regulator_testcase()
  regulator: ab8500: Remove unused embedded struct expand_register
  regulator: wm8350-regulator: Repair odd formatting in documentation
  regulator: cpcap-regulator: Remove declared and set, but never used
    variable 'ignore'
  regulator: cpcap-regulator: Demote kerneldoc header to standard
    comment
  regulator: da9063-regulator: Fix .suspend 'initialized field
    overwritten' warnings
  regulator: max14577-regulator: Demote kerneldoc header to standard
    comment

 drivers/regulator/ab8500.c             |  7 +------
 drivers/regulator/cpcap-regulator.c    | 16 ++++++++--------
 drivers/regulator/da9063-regulator.c   |  1 -
 drivers/regulator/dbx500-prcmu.c       |  8 --------
 drivers/regulator/devres.c             |  4 +++-
 drivers/regulator/max14577-regulator.c |  2 +-
 drivers/regulator/of_regulator.c       |  2 +-
 drivers/regulator/wm8350-regulator.c   | 10 +++++-----
 include/linux/regulator/consumer.h     | 10 ++++++++++
 9 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.25.1

