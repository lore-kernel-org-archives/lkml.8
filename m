Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942D9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653BE217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWL92tOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCBMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:53:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51221 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCBMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:53:26 -0500
Received: by mail-pj1-f65.google.com with SMTP id l8so878850pjy.1;
        Mon, 02 Mar 2020 04:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVlIC+o1X5elmxMJP01HUn8upQiGdfU1sajDVIWbpjM=;
        b=YWL92tOaLSZeNycLdLFxyiYmZMgQecJvctiYRM5E2vH1K2tV1g9ns3RtWySc7VDcVB
         lu+I4DHw1AQLcMmiYpGfikkJAvWt1qn7EHh6VfvVcRye9+kWerZ7rtCvpfJYCzxl0ADu
         NALgrdqJNF6zkOn8LWHmNdZ2ECtjgynPfqOyiIHkWw2bXXhomNFCHlkdovnPNQgSduZJ
         SODLphzf3FGoIkbY6cygVsPUEHkEsZmf7MQZ5SZqaoxLpeiaS/2jw+KeSAL5PyQgoOe4
         3SGO2mtSja/mE9lUxr/ltkOlX7xW/tpKp0CD22DG2XK9eAYzZ06UbLs5Jx7imW9YdzK9
         LIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVlIC+o1X5elmxMJP01HUn8upQiGdfU1sajDVIWbpjM=;
        b=dxkUUJ4NojSRGvhbNd0G/o5ahQf8Ty7yyW293U/zay6pN9VyVAWC2AGVN3hjknuLDa
         BXAwYYo5ZIY9Q2oaIpHrM6vNJmrR+yy5FsbESllGyIP3e4J3xEJTsw04ccoRRoTEM9F2
         aq2GNEqZk1V3g3fHK8llyyJ1s6f1/2LaoFEe+VtTh3+ch01YgnHpWp4O1JwzwofgKQEz
         hdD+vkJDhH+4O57+v9H2epehJC6S+9QlciDx2N1Cmw8nkU/r4irF9Mhqx/nORsmZqlmA
         MOhkod3cuj9KoirXsvPE63/WjGC1UoPRNoBFdSAGsXLBKAYLMyiye6MjarA4Ogyde8L9
         TF3Q==
X-Gm-Message-State: APjAAAXnoy5rHhBHJpk9o8WPBxC8WGa8iD1xxgfCcCN+nPU1bTdrMxUu
        wNCz7o6m2efglS45XuuIOdY=
X-Google-Smtp-Source: APXvYqya77N8AIuo7S/nQDOfsridOc39JQclxt2ko2cBQ4x1i6EExyxwGxTkdNnrd8pZDKP8I4C6Hw==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr20963620pjb.125.1583153605167;
        Mon, 02 Mar 2020 04:53:25 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id p2sm2138238pfb.41.2020.03.02.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:53:24 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv2 0/2] Odroid N2 failes to boot using upstream kernel using microSD card
Date:   Mon,  2 Mar 2020 12:53:07 +0000
Message-Id: <20200302125310.742-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we try to boot the device from microSD card, the board will
stall in between, on suggestion from Martin, Jerome and Neil it was
narrowed down to clk not getting enable.

Fix the clk driver help booting of the kernel.
Any more suggestion or inputs are welcome.

Changes since PATCHv1:
	[1] https://patchwork.kernel.org/cover/11384523/
            drop the patch as it was not being parsed correctly.
            https://patchwork.kernel.org/patch/11384533/
            fixed the subject and message for core patch.
            https://patchwork.kernel.org/patch/11384537/
Changes since RFCv1:
	[0] https://lore.kernel.org/linux-amlogic/20191007131649.1768-1-linux.amoon@gmail.com/
	 drop some patches and fix the clk driver as suggested by Neil.

-Anand

Anand Moon (2):
  arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator
    to FLASH_VDD
  clk: meson: g12a: set cpub_clk flags to CLK_IS_CRITICAL

 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
 drivers/clk/meson/g12a.c                             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1

