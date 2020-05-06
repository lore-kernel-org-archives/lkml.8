Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06CBC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96585206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QDOkJjkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgEFIHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgEFIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:07:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC6C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 01:07:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so1020308wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUoKNxV4vqNDiSef+ICdZkoAIRUHcuIito46USVrX6M=;
        b=QDOkJjkIqKcQFKzMtVFjf9SjZTn75nCiyUVtEd6/RVU7pmbDF53lIX6A6pzHESbBQn
         EaBb90lnUbW8TJE9AwRJnT5uWamLTS+P+d9dXTNafMthB2LP746m4B6OyFprwbAxVfJc
         zYIItU2Fb7iUBdzQ+s2XmdsDkuh38HfV3EpwQzWyWRuRTBMcOSfaC0OJN+NCoqMMnc6V
         z0eTeuse+KwoI6EIc2PB+rvwEmmczcyElkBHX0Kaq5SoBQVnPRgUUz3Mu35CYVOdsc77
         c/EABh02rWBGO/NX33BtZ61A/lMERYWNfW07Qqd2DPxFr6k7Gx2d4166hYWlXG6Jf9A9
         PXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OUoKNxV4vqNDiSef+ICdZkoAIRUHcuIito46USVrX6M=;
        b=QVCIHuJ+Ourt1coLysdhQAPVbDv7WXgnEjMsp8oZl45qpx/BINKrfS3wt5rOOdbtt+
         /mwBUmmQzH902WWSHJdmovevrCV5dVarFdOPLhZeHkcxy4+tZNzN4YLuzqPTAT7qEY6M
         ODXEitRH36lfQIlMgWst+Qv0HJhoArsE11NOKEQAVTB9D9ofTvpek3engA5u6Ut4k8Hg
         QUlnIMFqdeJ77BVgV1IqWvYmRtZ39Gefnf/NkHDx/Wc6GBylMKku4v3n9rFmlWCmPrX4
         RhSt7Wi/2xNE1zHby/g8dPxfV8vOqwIJswI+6IXAN6HwTQwoPbRiSt6NP8RwQkmxr/IA
         GcCw==
X-Gm-Message-State: AGi0Pua2hdbzaAI5SqVh5nVDdYCV0AohssNnrkd9fkJjAabXeBkhZ1V7
        n50P3qgsKiz5Nb2oblnUWKPZsg==
X-Google-Smtp-Source: APiQypLFXloAanL5BZXsPuyvyXKqG7TKKwVlSQtxJg0wIvbD0RxyshxpV59rlJmEtRwk/c2IWPXQcA==
X-Received: by 2002:adf:a1cb:: with SMTP id v11mr6651006wrv.39.1588752426703;
        Wed, 06 May 2020 01:07:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id 185sm1872098wmc.32.2020.05.06.01.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:07:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] arm64: meson-sm1: add support for Hardkernel ODROID-C4
Date:   Wed,  6 May 2020 10:07:00 +0200
Message-Id: <20200506080702.6645-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds support for the Hardkernel Odroid-C4 single board computer.

The Odroid-C4 is the Odroid-C2 successor with same form factor, but using
a modern Amlogic S905X3 (SM1) SoC and 4x USB3 ports.

Fully functionnal:
- USB2+USB3
- USB2 OTG
- eMMC
- SDCard
- HDMI
- DVFS
- Gigabit Ethernet with RTL8211F PHY
- ADC
- Debug UART
- Infrared Receiver

Missing:
- HDMI audio

Changes since v1 at [1]:
- Add missing IR node

[1] http://lore.kernel.org/r/20200424124406.13870-1-narmstrong@baylibre.com

Dongjin Kim (1):
  arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4

Neil Armstrong (1):
  dt-bindings: arm: amlogic: add odroid-c4 bindings

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 402 ++++++++++++++++++
 3 files changed, 404 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts

-- 
2.22.0

