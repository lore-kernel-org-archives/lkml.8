Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B88C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712202080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXF34qfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbgFYTRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbgFYTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so5604568wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whXnsEgNOTwJXKJcncFrRZ5AbqVNF7Bm8DRLf5BkUS4=;
        b=VXF34qfGSVExwztciwU5uWNoJpU0DGwBPMINaNGfv6f+U5pxwk5iox04WrTjKcwuD8
         r2MOpD2mrFx234uWTr7P2h8r2NqkpRO1qN+FhOWwwbm7Z32hBaN849yjpsUOmTeEw+1J
         lP9tHmM6tK0mAds6XvOtMf2j59jlivvvsse9InJrdGjV3Y6I9pLV+qyLf1TdQQPUXwT0
         2gIcyv5S2585JlR3Ti//+IaxyEmbpNzpSjHb8vWzZbeyDIjmF6nZbsfNrXo/3JaSHwYn
         q2zs6xBtSJOmwA40mQ62QHb0u/SdeZBffsg+mDZ8/R/tqMwSh+k5NrfBzPG3wLOVxf1C
         bBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whXnsEgNOTwJXKJcncFrRZ5AbqVNF7Bm8DRLf5BkUS4=;
        b=Y46HG3XvFgbqDhK6Ceo/gDFCK8KJgzESEsGmzxOa+ADQxh7SiOZbtJ1afsEsJ71f5M
         JVB1Jykstpxnybpzvr0vk0BMu76zDQTAXcil4nuxQJVsOyuMX1+bbgzG+6fjyJrOKk2O
         luChYfV3Plb8NiNPIo9MlcDFkyKwrM7WJPHjXIZOpivFMDtTSeTftfPh7lfy4shUWGzp
         lZ9f+hZo+NBj2T14gsn0+jnkxmH8kVZVblEnG9UHnjRvE7F+GrH67wr2a4Lv/ve1KlL9
         nA3yTzFZSz0v8I9MoFsr2jX9nDEPK0GE6j40lyVi+VbLJh4M/+5BVXzSDrYyup/g2shM
         h3SQ==
X-Gm-Message-State: AOAM531W2k69GdxQJrY9R+yZl7+Ep8fyX4+oiFZpHSmHJHZdAahP1LSk
        ZLvbRF674zuROetKd+EmxRD/Yg==
X-Google-Smtp-Source: ABdhPJy9+NzYodqBU/3fCbqaELmtfujRWZAaWAGznB/DDUPslZmCcaR7o0lA6FR/qaNwygUJvNbcEQ==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr5339923wmj.161.1593112632878;
        Thu, 25 Jun 2020 12:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [RESEND 00/10] Fix a bunch of W=1 warnings in Regulator
Date:   Thu, 25 Jun 2020 20:16:58 +0100
Message-Id: <20200625191708.4014533-1-lee.jones@linaro.org>
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

Resent to include patch contributors/maintainers/MLs.

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

