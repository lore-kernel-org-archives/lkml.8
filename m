Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5473AC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qkkU2Hsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCXKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:21:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32883 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgCXKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:20:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so20719924wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GhA9x8hO0OSqZFQSsNcZ2UKUqCG4/t+w/VnuL1kPUHU=;
        b=qkkU2Hsy3KDoPTQpcjYY1qdbEx1TTR+31GrBzsfrej5riME6gzYRij4LFJmmSnTlYn
         uj/LhvVBDDEXQRX7bKMRLx6uC0Arw3UVexvCTGXLLPd0KvtNlZDpQ/iSPPpCvfeD0322
         t5zFFnmBEAjdW2Lm7kugnAuT2aXCMf5miFReQar54A4WiMMmWmqciJhne0zU/qvbqbaG
         W8odiVk5SpXaLfVOXq56uqevXAfUJi96Fz8kjWViOqX0ChuAew4G88CPv2PEnlwMUgKa
         utrQa8uQqj3RjbNG5P9/9SQ2rcPjEpQJ16muoqs9rDaO7yh098l6yDOWeyHiGClZvjIH
         6hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhA9x8hO0OSqZFQSsNcZ2UKUqCG4/t+w/VnuL1kPUHU=;
        b=dmiGCd3rRbhboNGPXBTFsV6vYtYTEybWENxT9i1FsYmdePxWwmYXmFDZ5k1fZUUJ2Q
         IPihjcmPT7oKad/21U1wapNdwnDytKNTMXjjYObrHN1/szAoNOvsfHpVZPhP+ScGKWjz
         j4B43CMptwd+YHjGmaNKPJx11OfiGqqXuY4gO4tCvF+sjhPT0GwjztPkkpfQm1IW7UM1
         q3V/rhZvqpyhigmmCL1T5Xfxv+RK+8RUxo0PVKNKwFK6saFs0ovlQqEl4wBEJpSeGefu
         dSPtxuAgXkFg0TBi5jzVnkqmKDQNlmr9JdbEfPEP+sdI0esjOu8aGts0/txTKNDw4Sig
         D+KA==
X-Gm-Message-State: ANhLgQ3mEe4KhHvFwPQ70dztxYSDkgfuuQn8uef0xZ9Hk2Vlod+S3IBW
        o/eosw9mJo7b+pcF58UuiaFnrg==
X-Google-Smtp-Source: ADFU+vsOUkcfU1BNDYfhQfb1PA6CgnmWBbxotLsJb0kQIO5yklTREcusHubmGOMO+cINekbgUIW0dA==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr8576233wrx.226.1585045254135;
        Tue, 24 Mar 2020 03:20:54 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h5sm2879527wro.83.2020.03.24.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:20:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] dt-bindings: usb: dwc3: remove amlogic compatible entries
Date:   Tue, 24 Mar 2020 11:20:29 +0100
Message-Id: <20200324102030.31000-13-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now a dedicated driver for these SoCs making the old compatible
obsolete.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a47ad85..2ef0bcc30648 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -14,8 +14,6 @@ Required properties:
 Exception for clocks:
   clocks are optional if the parent node (i.e. glue-layer) is compatible to
   one of the following:
-    "amlogic,meson-axg-dwc3"
-    "amlogic,meson-gxl-dwc3"
     "cavium,octeon-7130-usb-uctl"
     "qcom,dwc3"
     "samsung,exynos5250-dwusb3"
-- 
2.22.0

