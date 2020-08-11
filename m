Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF37C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3021B20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4nNtp5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHKFbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgHKFbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:31:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A0C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:31:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so6170754pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GUK6wepr4yUdaqTzAXUTHb0IYklWza8loFfYwomVV0M=;
        b=t4nNtp5s9Gek4YbX8hYOsQuXIRmVOVpUnGuoucz4y4dnrLtYltXNlFDW/P5kPu8Gli
         mmhU3LIdw0oUKSVWD2bWY5P+3/JO4hk5G40YvhvoJlnuro8+iiI2TPRmbBVwTHo73ZDp
         qmRRM54JzFx1S9kjrBuh+Y09WYzLxwOnKhFHb8lo+dzdFbocGEV7uqIGSntQkfwlqNOD
         DpuPVj53M5xYzaQKavuUWsxrP841SyTU3y0gHxiZW3Cpy9eaU2PmonLQwROrQA9J/map
         jS/CZUvpkPHLXHP6KSU2tmZ4J7VqGyoA7UyTn3lrnOIM+E+5QTpKaOuQVucnj+k46wLA
         NsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GUK6wepr4yUdaqTzAXUTHb0IYklWza8loFfYwomVV0M=;
        b=VlzcS8g0mshoLLBQiXSXsbTZvoc+Q59UwAyTqzoyNY35L/te7bAnjjD8QKSHnFY9h/
         yLITPUctAY6RTTGZTXQ86KhfLCe2lK/v/pktGaCOOrpRlKqR2K5Zaysf8RQKDueclDZx
         cHjzWDChREgECT+YBVvk+W2WtCb18DJp5TQ2duX8RI10MX6Rs/KxgqcVWX2vL3oyaq3O
         k/vSPbn27NJaGWhUqBPGS77oUwBRzHY3JeCXocddio2sM2e1j3eHUiFnVlSFXrBwRVg2
         4YdsJ6NW8GzhOUFjNpOIiyY6hhnvakGp6KF3ZYtZpqvoKi6wT8lbFwL/11CT4eoVay1j
         glGw==
X-Gm-Message-State: AOAM531DgepRUUcPhzrJGybwdl/F47cyiHt6TF+aJ91rwyD/sPD89jUK
        riHJ7o7+CDgPim/jaiGz2fpE2qp3jLE=
X-Google-Smtp-Source: ABdhPJxO9iur4RFCvounihwm5/xm3Tqm/LFdTjIEjls3p+LPz75FcWVkAuG458KLX6C1wNtF4v80fQ==
X-Received: by 2002:a63:1901:: with SMTP id z1mr21951886pgl.97.1597123891654;
        Mon, 10 Aug 2020 22:31:31 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v8sm4172807pju.1.2020.08.10.22.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 22:31:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [GIT PULL] rpmsg updates for v5.9
Date:   Mon, 10 Aug 2020 22:28:01 -0700
Message-Id: <20200811052801.404208-1-bjorn.andersson@linaro.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.9

for you to fetch changes up to 111d1089700cdb752681ef44f54ab6137736f5c2:

  rpmsg: virtio: add endianness conversions (2020-07-21 20:37:16 -0700)

----------------------------------------------------------------
rpmsg updates for v5.9

This ensures that rpmsg uses little-endian, per the VirtIO 1.0
specification.

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      rpmsg: virtio: add endianness conversions

 drivers/rpmsg/virtio_rpmsg_bus.c | 63 ++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)
