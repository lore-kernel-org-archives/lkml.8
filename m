Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356FEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FE220768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NJ62SxAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgIHUEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9DDC08E817
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:18:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so19582966wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3a/pKfNTcctsi5NMPeYXrn0Dqu/AbgV0+iD767DAkfk=;
        b=NJ62SxAYUNxu4wcmx23rzjC0yurPxVJ86uAMywAwLtKYtunOkXMT5kgoHOR/25NA2R
         vYdYurAJ1EX+InbHWiXPsmj6g8LHhZdY7XCo0ZHf00lyrl1axgUFNprhhjXOkQVwCp1f
         zXXOL8kxE/98FJDIfQqSuGGU0QFzRNrogY7xjpAQ3fzwnjP11rJwvTEBeU6GtDCZ2Zf+
         6GuYjQlqpzeRgOGSZ0RTUuzPde+Dgpfon7qdQFhPz7KpzO5ayMlKTLNyK9JmLeCF0RmS
         KrFS7MfiUwxJF0wm0vyb4kkKCVg0KEIPGStgaWElGD8vwcnf8tKdcBPFPNSg0DrTlyHR
         bmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3a/pKfNTcctsi5NMPeYXrn0Dqu/AbgV0+iD767DAkfk=;
        b=VQ79shilanVehjsCT9hAIrzogD/MzomD3SUrCzyi0sbDvlg9qpBM5lIwVZNSr9jJ/P
         uMvMgggecdx1PtmaNG4ikFb2Og1Y9hfiVTkgJVbtWZu+naQ0OvQnPe3ZtA4PymWfMxyZ
         jmo0Nl+jHa7+cQkCpeYVcXFP/mWAsSCfV+i6PwkVQigrROiwz00ioTQ22yUEfIPU1opx
         joOZuSPIwtf8AzQt7XI8lE1rNyfoa5X06b7VBeYMnm7s0K60ZGiaPvpFQdJaG2nsfJEs
         NvRTBVlpXsYePHIRE1XFF3fHnyyIXb3HBoFfpb5U6yyaFAgSsLPsJApArCN5WH2DmDMz
         +6Yw==
X-Gm-Message-State: AOAM53269M9HDSWNAMVDdi2Qnz7YgWDpwAKO/gapIkpTUXKW8sWqmYZ0
        tTgZQ9qNBcBT30wVXiVN9H09wA==
X-Google-Smtp-Source: ABdhPJxoedfun5a5jObY/rI/dRKE9z7QNbsGMa2l9zbVlFHBZ6rsBniEq+5NHWlHqnC9szuSHALYXg==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr137401wrw.101.1599578337783;
        Tue, 08 Sep 2020 08:18:57 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d25sm10004886wra.25.2020.09.08.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:18:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/5] drm/panfrost: add Amlogic integration quirks
Date:   Tue,  8 Sep 2020 17:18:48 +0200
Message-Id: <20200908151853.4837-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T820, G31 & G52 GPUs integrated by Amlogic in the respective GXM, G12A/SM1 & G12B
SoCs needs a quirk in the PWR registers at the GPU reset time.

The coherency integration of the IOMMU in the Mali-G52 found in the Amlogic G12B SoCs
is broken and leads to constant and random faults from the IOMMU.

This serie adds the necessary quirks for the Amlogic integrated GPUs only.

Neil Armstrong (5):
  iommu/io-pgtable-arm: Add BROKEN_NS quirk to disable shareability on
    ARM LPAE
  drm/panfrost: add support specifying pgtbl quirks
  drm/panfrost: add support for reset quirk
  drm/panfrost: add amlogic reset quirk callback
  drm/panfrost: add Amlogic GPU integration quirks

 drivers/gpu/drm/panfrost/panfrost_device.h |  6 ++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 17 +++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c    |  1 +
 drivers/gpu/drm/panfrost/panfrost_regs.h   |  3 +++
 drivers/iommu/io-pgtable-arm.c             |  7 ++++---
 include/linux/io-pgtable.h                 |  4 ++++
 8 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.22.0

