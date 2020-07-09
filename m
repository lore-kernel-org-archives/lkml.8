Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8665820708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlSEx1k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGIOD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgGIOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B2C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so1943955wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bst64xxtOjncsP7b3inl0oVV1GqFfKwarO1dVnIGUg=;
        b=RlSEx1k/0RDEcv7F8hmNo57u4SHIIMMlUeNJqyvpmORrfQKbSDRu0qFxXB4tthwLrH
         HE3hQtIm/nuFUnIaZuPs4dKydk36y5IaHnr7vlMN4XBj7aqdVy+x3PkkwOJ/UDp66aPE
         w8ofsVjx5cYdcUY2qwsMX6Cem+K1dEijvZSYtUSMR243HYuGBYkmGE/P2eiHiJcuMjXR
         UvxBA7zepgD8oCBKYqUTpX7p0SSW4MDUnEGp5kM6MO2iSpVbj3c9LXNOmeYcV4S3U+V8
         X+8MrB3iT+qpkTp4tIUOVBBhl57g/MO64lrm4cwAFSxwv10PnNA1nUPy8OW9F2pP2xlx
         WJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bst64xxtOjncsP7b3inl0oVV1GqFfKwarO1dVnIGUg=;
        b=pbX1XW7MD92uGx9YCfaxnfi53zHyGOCjBVTyR6ZCumskPDfK4zCTb2JGYrHvKrN1XX
         UpyLjqU9UFvM1PhnKIY9H089oOmdlgTfIeZs/Sc7fQDNxmdnFcBpAIGscvytG3In4FJ0
         lA7TkmEgYlpVavxAgqNtPHTjj8G53uIHv6yogP95ph6MXJOfAzC3KEe5B0bcJD8it0o9
         3auk/rNY7dMOtrguaIydWYVrjkqXTuIlD503L8LWpD4Zzr5acP13OWieEdIZO0YiTOUf
         tdh/D8zaAuB2F7rOWFNBhPRUAQ2uW0NZ/Cp1Vvt2KI/uOZGBAV63sV+VXZfQfWAMVWo0
         mcAQ==
X-Gm-Message-State: AOAM531V9Tij9td66dW+kkqAv6OUiDrQQG+2IaA9FpqxQ5hefWUHtUYT
        N38whpRkGJYwUTa+J+NQSN8=
X-Google-Smtp-Source: ABdhPJw35y9hjR9Q2C+hP3Mo3vFj7fwqv6ZE43ESMYHi/sMQPswl2G73WQQZmMcjvlmstaGg4mM9PA==
X-Received: by 2002:a1c:345:: with SMTP id 66mr150233wmd.31.1594303405926;
        Thu, 09 Jul 2020 07:03:25 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:25 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 00/14] Add regulator devfreq support to Panfrost
Date:   Thu,  9 Jul 2020 16:03:08 +0200
Message-Id: <20200709140322.131320-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie cleans and adds regulator support to Panfrost devfreq.
This is mostly based on comment for the freshly introduced lima
devfreq.

We need to add regulator support because on Allwinner the GPU OPP
table defines both frequencies and voltages.

First patches [01-07] should not change the actual behavior
and introduce a proper panfrost_devfreq struct.

Regards,
Clément

Changes since v2:
 - Collect Alyssa Rosenzweig reviewed-by tags
 - Fix opp_set_regulator before adding opp_table (introduce in v2)
 - Call err_fini in case opp_add_table failed

Changes since v1:
 - Collect Steven Price reviewed-by tags
 - Fix spinlock comment
 - Drop OPP clock-name path
 - Drop device_property_test patch
 - Add rename error labels patch


Clément Péron (14):
  drm/panfrost: avoid static declaration
  drm/panfrost: clean headers in devfreq
  drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
  drm/panfrost: introduce panfrost_devfreq struct
  drm/panfrost: use spinlock instead of atomic
  drm/panfrost: properly handle error in probe
  drm/panfrost: rename error labels in device_init
  drm/panfrost: move devfreq_init()/fini() in device
  drm/panfrost: dynamically alloc regulators
  drm/panfrost: add regulators to devfreq
  arm64: defconfig: Enable devfreq cooling device
  arm64: dts: allwinner: h6: Add cooling map for GPU
  [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
  [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 ++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 175 ++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 ++-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  61 +++---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
 9 files changed, 296 insertions(+), 113 deletions(-)

-- 
2.25.1

