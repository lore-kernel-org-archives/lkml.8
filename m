Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D185C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF002084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="voTRoxcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXPIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:08:19 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51914 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgBXPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:08:19 -0500
Received: by mail-wm1-f42.google.com with SMTP id t23so9325986wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NiC0UNxjupTM8Jt/XePNuhi1RMoWOcMCY69tR/Q99UY=;
        b=voTRoxcqwaJF1S0FoJwsA/sFZaHPk88meZzPGjzsHJZy39PoFRGkVnQhzwrI122iQg
         549+tw/6DBzTH5iWgwzV4tkOf6IVUYno0YAoMPjYXYfPYnshTomYWu1mj245/x2qlVIU
         IvxAG5ObkcrdkmqInH/bkqwMkeYU2zMQCCBTAKvgYW5BSXKeOH4nlfKQAlUk49cMOCkn
         1WoKbNXvbZ65T1DDyHkWpJfheB6JCjblvdBdcloSbjL99Xcqg0+1Np517fDvRkHpdE0L
         tb/+GpQPKKvAiXTO2lc3ERc3RhJMchwEFjdhSjBdmnuxTt/ONIslPJXZPH9YtpVPdTRn
         5xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NiC0UNxjupTM8Jt/XePNuhi1RMoWOcMCY69tR/Q99UY=;
        b=BsSnUkdAmSs/PPM8TFPyQ7K5aISQzREhFKdlzzE2o9X7fiWTAjkFedwk1XCZ/tjbTX
         bPDJrxr38umvbi4ktMw9tw4R4Mnkk2kbdQ63Peg67VIOuULvv/qf0QHs2k5l24sjjdsu
         ZzLT5cyOGPaXujBBVbaVSSxL+6VvcIyExh7njgsQpcC6uMAn9cIzvziA3VqjV4Q4YDnt
         pUeMY5nVoduPL3ZYHuOjXOqG2nCnbSYliPTpo2tFBVXsSFO0pA1Mf5tZqI+n3+JZIl5I
         7B3NX2EZS2F8qCyq5RbPknfFgb4TRz8/p71zP437g4fkuLzqA7UMhOObJZ4b7GNrWnVF
         EZAQ==
X-Gm-Message-State: APjAAAWvnXD1SJ9dGO2FGrmuwz33FPHWzqOYSOUkYDj/U34TU29R5+o6
        G8sPCkrqwzn3dSpoFcz60OV5oA==
X-Google-Smtp-Source: APXvYqzvcmberQ5l9nmdoppBhLeUg4S5HsFfNYSmYNZ2n4XKzlabx2Ja5WbW3NBF9NZEBsg9CimSdw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr23255620wmg.92.1582556897336;
        Mon, 24 Feb 2020 07:08:17 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c15sm19074794wrt.1.2020.02.24.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:08:16 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson: audio fixups
Date:   Mon, 24 Feb 2020 16:08:09 +0100
Message-Id: <20200224150812.263980-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides 3 minor fixups related to Amlogic audio devices.
While related to the same topic, these fixups are independent.
They just improve the compliance with DT spec and schema,so no functional
change is expected.

Jerome Brunet (3):
  arm64: dts: meson: add pdm reset line
  arm64: dts: meson: s400: fix sound card codec nodes
  arm64: dts: meson: sei510: fix sound card codec node

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts    | 6 +++---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi        | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.24.1

