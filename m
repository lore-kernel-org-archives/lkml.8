Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77968C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5404620767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="Z0FKEEs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGXKiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgGXKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8710C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:38:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so894221wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tmCdaz8BOl0xduEDd+WbFqDaYK/wTJhp8v3Tb2E2TM=;
        b=Z0FKEEs+iHhe7WnG9f17lbA3+BhvgYoS942m2eZ7tZ7G2zhYwOXxVT6Yw3tzIp6Fpo
         OGbh0T4fLWbxwcmk2X3YaZAKi8lgU3EGYK9NPmKFa/dYrSJ2yjLvPwNZrB3z/t4fHvmM
         pttHwHeT2UNIyQSpZub2SumaRqF2mEpSUuHOBwUmQyjMLlHsbhwtD6NBP+QRE6kYWrPA
         jZVDjxdtEF6vIO9H1xaR9amVxpKammDMWdalvAFT+JvLmrBKBLe7s4CSDQAjDVKC6Si3
         nqztHM5lGN4Sw4KQyXa5LxUFEt2nrpAqT2R/9WGEYtBdphpQwDoG6o6yjKAzGNJ/uiJW
         /L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tmCdaz8BOl0xduEDd+WbFqDaYK/wTJhp8v3Tb2E2TM=;
        b=EEqMJWrOeQXGw1Rt0qLdDkXfDcEZFmJaeaCfJ71zPsZtSy6s2feMRCe16bIzwHtWsw
         oCSW7PwR/yuh7lmPldb7WbIaHua62e2EyleLNfT7Q/F05QV136X+YnEbvzlVhAe51TJT
         IAlKeETTwQ/NP0pt370yqefRbDNnlSBTMbzQBTE7MDqA0jzCtHwwfO0IeQk83npkwh7Q
         FinurXWRqil9AOZ441qdYV+aKLHGYf8LUry9GXO7foLM9hppBsT8o0fPJl/t9zdH3Y8Q
         3e6AGKL5+a0dIMw4gDTpCNX9Z/Fxc/F765Zt4/yfFlZEUU9B7zBP6U1DkwkPJD+gusKr
         d7/A==
X-Gm-Message-State: AOAM5304FkY/BVo9dHpxCze08yLanbZkEUS7fpb4ekPgJ5s0Fx6QeW8P
        3oTaUiEVfotINK9J0FOfFmKSAw==
X-Google-Smtp-Source: ABdhPJydV86axSeppJXyJqRlp5jQnMsGUNm+DZeHqZFR79nB5xRdu6p2Ova3IV80TktFHkrJeORrig==
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr8261504wmj.69.1595587131456;
        Fri, 24 Jul 2020 03:38:51 -0700 (PDT)
Received: from lukakovacicapc.local ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id f186sm6526280wmf.29.2020.07.24.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:38:50 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH 0/4] Add support for a series of MikroTik CRS3xx switches
Date:   Fri, 24 Jul 2020 12:38:36 +0200
Message-Id: <20200724103840.18994-1-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for a series of MikroTik CRS3xx switches
based on the Marvell Prestera 98DX3236 switch chip.

Namely, support is added for:
 -  MikroTik CRS305-1G-4S+ (including the Bit variant)
 -  MikroTik CRS326-24G-2S+ (including the Bit variant)
 -  MikroTik CRS328-4C-20S-4S+ (including the Bit variant)

The Bit board variant is added for each of the boards.
These boards were modified to use a bigger Macronix flash.

Currently only basic board support is added, but the support will
be extended in a new patchset.

Luka Kovacic (4):
  arm: mvebu: dts: Add CRS326-24G-2S board
  arm: mvebu: dts: Add CRS305-1G-4S board
  arm: mvebu: dts: Add CRS328-4C-20S-4S board
  MAINTAINERS: Add an entry for MikroTik CRS3xx 98DX3236 boards

 MAINTAINERS                                   |  11 ++
 arch/arm/boot/dts/Makefile                    |   6 +
 .../boot/dts/armada-xp-crs305-1g-4s-bit.dts   |  43 ++++++++
 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts  |  17 +++
 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi | 104 ++++++++++++++++++
 .../boot/dts/armada-xp-crs326-24g-2s-bit.dts  |  43 ++++++++
 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts |  17 +++
 .../arm/boot/dts/armada-xp-crs326-24g-2s.dtsi | 104 ++++++++++++++++++
 .../dts/armada-xp-crs328-4c-20s-4s-bit.dts    |  43 ++++++++
 .../boot/dts/armada-xp-crs328-4c-20s-4s.dts   |  17 +++
 .../boot/dts/armada-xp-crs328-4c-20s-4s.dtsi  | 104 ++++++++++++++++++
 11 files changed, 509 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi

-- 
2.26.2

