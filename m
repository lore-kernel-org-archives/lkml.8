Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16575C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E83206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIdv6qQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgERCZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgERCZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:25:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F1C061A0C;
        Sun, 17 May 2020 19:25:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so5864340lfd.1;
        Sun, 17 May 2020 19:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5rfhPys2btHBP3bO1j73TJDJbaY1/Lc3Z3m/cpPLQBs=;
        b=hIdv6qQcebc249xLUdQL6uLE5N+tSqfaElBQ+qolVIzlD15FiWmnC++UjW1CiHtpeA
         1Vfsc0JqlB8BBowqlHNKqcbYnFIRJLu5bOYJ23qPAwAzNoDkzRk/kLlMrOmJeKp9dMvk
         btJJj304foMsxB1h+mrPSXYJzq8QuJ5mMMl2CxSCDaLUWGWSyyL5x4sLC9yjnYioEZX/
         Du9de/uralDhCVxB3ZDzep/GZXolCoolLZ5iwhHf85vd4Et7WBZ/ysFFpdnH+hK9OkHV
         5VNKhBWk6SWOt4T7rWQinQQJg3Ps2E5aR5QVir0Uc/UVA+ELFO/60P8P4w7w8FXypcDm
         aLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5rfhPys2btHBP3bO1j73TJDJbaY1/Lc3Z3m/cpPLQBs=;
        b=Jeczerg+Q+FuUHdEu1iJb8qdck08b35LWBUtl+6AqEvhqmCO/7gnAvP8Nrlw9vH9x4
         UjDXLsnMk/QFGr3r37nGmJM89r9c4qh9IEts6hrSsNaS6H5KiIaHvfCRxXwmPYId6skT
         XOKcJGrs7cBGDLamxqmmxslhXUfKAqel3nCpozPTfKP62HyswA+Uc/UWy5SFpRwfEGry
         rUNppJibRg3s7iAm6CxrJKIqu24tbqTkdB8lwggJ3z4+LQN9UTW2i9A+yreXPv20TnHk
         7NQPgpo6XTAQDTtMzDzDS8N38jMBpZivfcobAE37eMuWRiC+cUOs4nOVEN6FAymd+jt1
         kjKw==
X-Gm-Message-State: AOAM533yEVI9a8oxLTQIUfeFAoO51vOXTftOfF+O7zOkpxTQ3R4uClJU
        CNnb5b2tFzAWgDHwT20W1cI=
X-Google-Smtp-Source: ABdhPJx78gamRe3spCIUTVhwN4EhDyWwwJz8Kr6sgvXe69Oqc33iHr4FBtSY2OvT8S+IEyKJt/Hv8w==
X-Received: by 2002:a05:6512:1047:: with SMTP id c7mr3079621lfb.12.1589768736906;
        Sun, 17 May 2020 19:25:36 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m13sm5997306lfk.12.2020.05.17.19.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:25:36 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/5] arm64: dts: meson: add W400 dtsi and GT-King/Pro devices
Date:   Mon, 18 May 2020 02:25:26 +0000
Message-Id: <20200518022531.14739-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series combines patch 2 from [1] which converts the existing Ugoos
AM6 device-tree to a common W400 dtsi and dts, and then reworks the
Beelink GT-King/GT-King Pro serries from [2] to use the dtsi, but this
time without the offending common audio dtsi approach. I've carried
forwards acks on bindings from Rob as these did not change.

[1] https://patchwork.kernel.org/patch/11497105/
[2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=273483

Christian Hewitt (4):
  arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
  dt-bindings: arm: amlogic: add support for the Beelink GT-King
  arm64: dts: meson-g12b-gtking: add initial device-tree
  arm64: dts: meson-g12b-gtking-pro: add initial device-tree

chewitt (1):
  dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-g12b-gtking-pro.dts     | 125 ++++++
 .../boot/dts/amlogic/meson-g12b-gtking.dts    | 145 ++++++
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 410 +----------------
 .../boot/dts/amlogic/meson-g12b-w400.dtsi     | 423 ++++++++++++++++++
 6 files changed, 698 insertions(+), 409 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi

-- 
2.17.1

