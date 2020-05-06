Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A073C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E0D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn0gc1Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEFVKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbgEFVKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:10:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F2C061A0F;
        Wed,  6 May 2020 14:10:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so4078821wmc.0;
        Wed, 06 May 2020 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3rbQKHu7o2im/e5E3RSPiMp5YHJ3tSxbniLGmCUMFg=;
        b=Hn0gc1Yj3U4MfSjnTPtlQqD91CNqRVHtTeIYjJJtg1dNUAaviMdzem5K2AbzXiRltb
         67fpDh0gFjfWVaPMuFIjd2fCrb5sieAgs3Kb0QemO+p6FRXeQs7Wp7s3dG19Nd7/i0f3
         5patmQKG37+XwjnpLHYlyaQGNim4vMfjld9njGuaZKM/33Kbvqe1seY0JXRFw3YYEsvY
         5WLAjuaBz3apwNTv/atOpnR4o8BQOt1rV3xaviWp0lTSS2zUzd5j0MVTvubhLEkpremD
         zXP0Ptc3SV+snKil6G46sEgc+iqYLSTQHxdYEESyeSjov5U2M5Qi6c8zErDnmH+hexR0
         0eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3rbQKHu7o2im/e5E3RSPiMp5YHJ3tSxbniLGmCUMFg=;
        b=DS5gj9l4/Ez8gF5bI4xd5cYRsSYtZqDiC4//R2bwKAgojworZS3bOr1gsvDz2gcDHU
         i5l+RjsIjUvQg79d9ejG5HvH9Kz6dVnNuEm450iU45upFlVUI7t0qtENPbItGSQNTEHR
         7m4KtvtqVaAsZcmPHqs4YClgJKZQh8FTEnov2aG8LcpRHQ/mfUdFihqhWTcbMQGO7Dxb
         EoOnsVAvHzjiu/o56wOET5A+CcXmEKNepRqTzaKehWGRWuahZuxEXlFExqDWIc3jmtmi
         FUOJcUZ6v5LUsFmqyzo5i9sgXECoDz2F07NCXLKaiAu6wuTZ8wrxU62CRGxKVOp0tVRV
         X/PA==
X-Gm-Message-State: AGi0PuaycWuTf1saPoPvrbzme8FTJqaO+KYn1+ONEoVF55+wYaByBQGg
        eO0/959LypYAzGRi304FOI8=
X-Google-Smtp-Source: APiQypIqMBN1Bt9aSmemGVfbQ5HnoKxiEkTWnPreIzJg3/Rmkj4e86n21tqDW0PdqQL2Pwmm8fS8xw==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr6364478wmj.136.1588799402510;
        Wed, 06 May 2020 14:10:02 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id b191sm5135056wmd.39.2020.05.06.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:10:01 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 0/2] Add support for ASUS Z00T TM5P5 NT35596 panel
Date:   Wed,  6 May 2020 23:09:54 +0200
Message-Id: <20200506210957.344590-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v3:
- fix dt-bindings issue

changes since v2:
- fix Kconfig indentation

changes since v1:
- make `backlight_properties props` constant
- a couple of line breaks
- change name and compatible to reflect ASUS being the vendor
- remove a redundant TODO

Konrad Dybcio (2):
  drivers: drm: panel: Add ASUS TM5P5 NT35596 panel driver
  dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel
    compatible

 .../panel/asus,z00t-tm5p5-nt35596.yaml        |  56 +++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 367 ++++++++++++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c

-- 
2.26.2

