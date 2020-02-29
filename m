Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9743C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB9D246A3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8Mzf5jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgB2M0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:26:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46486 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgB2M0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:26:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id h18so6226949ljl.13;
        Sat, 29 Feb 2020 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G4M7No0W7MlL6TGtf4siKf2g8xY+Dklf+axbxbiJtTM=;
        b=B8Mzf5jH+dGcmmB32lLf6PcfY7xrq2dnjVslNctEFHFHtid9N3MIcmvzITB/HW4V9w
         ZSo+BneUIKjF2w3ojjf4IAi7GWZjbp760ajBn+xK6oKhQxSr5LEmWRs+9dHnjGe4ppLC
         /Bw+2q29meF0WzIj2aLgpBMKnO0qZN54Nn2vlLUp2/6mCUQFXd171mjswBuGHNFxtuA6
         lod978M/F9lY1lGGFDOtz4o+m18pXbpF3VUDYcoYTGuITrmmF0pkgga8U0VX9apwMSOk
         0eC5YlwG/yh1LdDiLCs47zpAOPGNgItWZ7SsGbvZniAOFWOq9HuEjjyOFO15GLe4K/uF
         3FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4M7No0W7MlL6TGtf4siKf2g8xY+Dklf+axbxbiJtTM=;
        b=nHVnAMglAl0llmAVy5AVli+0V3EPTawG1ZdvAacxWeqjNvDkBy1i5qpS3x5p53LCGv
         sDDZy4CaKq7lDXn/msnJ0pBTFxXnw7vU14l21O8IVTUKVrk4ozDt/x2yDgjmGj2H/nAH
         fYotk3Rn+VYEu1VjJzKXT8uEYUrehHI8Qr4wKZ+p3Ge8dBXRs2xSrbsD1gMXEO0CM6hC
         Prf8ZflzBSo8lO8Z9ijz76X06IcwNbUjuBzFxB3TCy997L1+2jY6Vld6biA2zWafhoPe
         g1sBQ17FTBXdOhEnaqCEVH+e0E2Q+RxKkzMSr3eC89A+/qgnJLm9pq1EJjGIfbgaD6kN
         GTKA==
X-Gm-Message-State: ANhLgQ2MmWrVoPCewrz+pFwyZHj3e7hsIgiyKCojEZNBk5IGdp/mvPu/
        xZ82C8YK5213FxwL4A/BAHg=
X-Google-Smtp-Source: ADFU+vsYAIbCafT2eJws1CSvVzOBOCk8/7EjzjX/TM+KJJihzuOclMzduIzohsc0yHhQSxT1+d9IMg==
X-Received: by 2002:a2e:6a12:: with SMTP id f18mr6049058ljc.71.1582979175387;
        Sat, 29 Feb 2020 04:26:15 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r10sm8950775ljk.9.2020.02.29.04.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 04:26:14 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v5 0/3] arm64: dts: meson: add dts/bindings for SmartLabs SML-5442TW
Date:   Sat, 29 Feb 2020 16:25:21 +0400
Message-Id: <1582979124-82363-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box. The previous v3 attempt [1] was 15-months ago
but nothing has really changed apart from a change to yaml bindings. I
have checked and the hci_qca driver does not provide QCA9377 bindings
so there is no alernative to the gpio-hog for enabling BT support.

It would be good if Jerome would check the audio card config. It looks
correct from dmesg output but the driver is new and there's currently
no upstream prior-art to copy. I've cribbed node details from his WIP
gitlab branches.

v5 - typo in card name

v4 - typos/corrections from Andreas
   - add sound node back
   - confirmed gpio-hog is necessary

v3 - change to Smartlabs LLC
   - removed sound node

v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

[1] https://patchwork.kernel.org/cover/10674939/

Christian Hewitt (3):
  dt-bindings: add vendor prefix for SmartLabs LLC
  dt-bindings: arm: amlogic: add support for the SmartLabs SML-5442TW
  arm64: dts: meson: add support for the SmartLabs SML-5442TW

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 386 +++++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4

