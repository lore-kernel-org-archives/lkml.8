Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367C320678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnN5gFBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHKFcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgHKFcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:32:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFCC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:32:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so6252908plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zxgy/RHetC/4Nqu0lkQtNXp/G1p8MLNQpVdRfU81oI8=;
        b=LnN5gFBn0YM7ROSuSslomQjiSqItycEFq8rE+kvUmchUX8GXlKDYIZIBZg2j36y2yB
         D2/1iPoqyLs660E80F8GOSZh5yK9Lcqp6vvZByKtruN2HmE8Mntt6nNi7YhYHoXz2rPj
         w/mwJIo2kbpDqHoJan7XiFVjClWfoNj/XMi0UL+GELyldKuoLP5Xm2EzA3oLUcdGJuO/
         1SwnYCSHBUmhn1FE8qfLChx5iU6gtJd3g1gbW07LxUsqS2HprYDxcXd8uU0o5ySp5u4Z
         vFy87GWxy3xwXv6rGOexBUg4uScvJGoT0Mfz/Fqu4sxL9Go0EAYqdCW3efOhjZbaHHhq
         jqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zxgy/RHetC/4Nqu0lkQtNXp/G1p8MLNQpVdRfU81oI8=;
        b=AegI16kb94/aZ88mQEHE6b4BipXPosRn0ftMteSb+YB9P0lNq2ITYvG59xsL8EwTLS
         Iu5GfK6QklhW9LgX1jKzzyxge+d14S+5vDeJYjd7lWzhYrndoVdUMHmV7/5rmOaQpvlE
         sOYYkgGzXYjD558judIohUUfF1/a2pKBmAhZw+cA9hPM+8z9vcGn35sn4eopBi92N9MG
         fFl/k58f6IZTitKndhWwVHWYn071dQXYO9ZvS3OJpsyI6Ij4dgmp/AzfnCRBaxAGCwJ5
         rj3GVHIlGX5Rpgscx2sWF49lVoGbcK6KZZlArDmPd3ht6OQgCABhh/C0oaR3FdAolyFn
         ShnA==
X-Gm-Message-State: AOAM531ZwxPKFwYpvvqv4r7laF28/UR3GwSxBuvE4hhy5rqBDH1iZE+q
        Pfo/xDFJ6usZ65aO1qJlzpL3Oy8eeg4=
X-Google-Smtp-Source: ABdhPJzq3NKR2h5JnBJ8Rc91MFXcqN64qilmaX43GZVXhuLQcz1+okMtGU6RKrb6Fp5+V3rHDHa97Q==
X-Received: by 2002:a17:90a:3627:: with SMTP id s36mr3123058pjb.70.1597123951165;
        Mon, 10 Aug 2020 22:32:31 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id na16sm1348389pjb.30.2020.08.10.22.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 22:32:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [GIT PULL] hwspinlock updates for 5.9
Date:   Mon, 10 Aug 2020 22:29:00 -0700
Message-Id: <20200811052900.404638-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.9

for you to fetch changes up to 35efb0e1d5c60e334ea719586ff2509fde2e613b:

  dt-bindings: hwlock: qcom: Remove invalid binding (2020-08-04 20:21:45 -0700)

----------------------------------------------------------------
hwspinlock updates for 5.9

This introduces a new DT binding format to describe the Qualcomm
hardware mutex block and deprecates the old, invalid, one.

It also cleans up the Kconfig slightly.

----------------------------------------------------------------
Bjorn Andersson (4):
      dt-bindings: hwlock: qcom: Migrate binding to YAML
      dt-bindings: hwlock: qcom: Allow device on mmio bus
      hwspinlock: qcom: Allow mmio usage in addition to syscon
      dt-bindings: hwlock: qcom: Remove invalid binding

Ezequiel Garcia (1):
      hwspinlock: Simplify Kconfig

 .../devicetree/bindings/hwlock/qcom-hwspinlock.txt | 39 ------------
 .../bindings/hwlock/qcom-hwspinlock.yaml           | 42 +++++++++++++
 drivers/hwspinlock/Kconfig                         | 10 ++--
 drivers/hwspinlock/qcom_hwspinlock.c               | 70 +++++++++++++++++-----
 4 files changed, 100 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
