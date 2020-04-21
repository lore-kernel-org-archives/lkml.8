Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7013AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478E8206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d3Xyj4aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgDUQjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgDUQjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869BEC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so4314855wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjTbuYPEFcU0U4OECuT5PrqvnAvjV7VLa//AWxImO1M=;
        b=d3Xyj4ajd+lNe2Yla5AaKccqqcqtk0Iz3EHvzeJjwKUWWHTbdTLdrrY1dcA4V/IMJn
         dThxhXjNPHkiWw9V2dZtJCnITs0dLlPWfX+2MKi4Vl1xY/M7DebBqyzx3dRrc3iq0pDW
         8uRzgxojI25hPvLoV6XsDte/pRZlRXS5tSw9StTaaX/Rg6hfcjB1tBdHwgsQ86e35Oli
         5qNRbf4kA7v824A6jcw7sQXgBkI9W5g5Ti0+0/WHEQ8KK/nuL2dRRerMT/9qC3chEPWx
         Xl8dGMA0xmBzQomeIScJaX5Y/oFKQLbqNQ6BNknocwV9m4KCHUyZCxIog7J6D3L97uF+
         55vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjTbuYPEFcU0U4OECuT5PrqvnAvjV7VLa//AWxImO1M=;
        b=gbd8SNNqzUrAbeXNasoQIodeqtAT8xOqUKfLMrowfWOiDmQamcAPBfbwVVkskof4Nn
         9HDTmgo0rSzVetq+Y81nIb5vH+H2ywlUPoyCnR0zeBm8pcqdTZ8t0PvQvxFkaFGIZwa4
         XB7lbxXlYgbQhmwYwescMFPIFrBuHx9Pu00M8hg5KysHf6ILM5gIxGvGh14izbvuW7LZ
         Lt1G2nd5K08BB+03PDptEbk04Hel+CImnyhxS+sNnUGQpgn2wzH1iD+tjKsBZD96M0nR
         FKtljaI/h4vB89raMXtf7/x6wnUYOV94+pa1aV5xZJm52hreHa2Qi4uMn8Z1o3jKc9k3
         lTXA==
X-Gm-Message-State: AGi0Puacw//z/P/95Uyt7pMYXOzXnFiFFQzKj1NSlp4enqPTrGI2XxHh
        zbyAFR7yXvRveVTO06DcARcYdg==
X-Google-Smtp-Source: APiQypIEYVjjAN5yphfyYI9bU9htSd8C5M9wv71+rqnmDicyNKccfSJtVpI2e+FtpT5ulSrAG71RVQ==
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr5648056wmf.3.1587487181165;
        Tue, 21 Apr 2020 09:39:41 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 33sm4578513wrp.5.2020.04.21.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: defconfig: enable meson gx audio as module
Date:   Tue, 21 Apr 2020 18:39:30 +0200
Message-Id: <20200421163935.775935-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421163935.775935-1-jbrunet@baylibre.com>
References: <20200421163935.775935-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the module config for the Amlogic GX audio card.
This module will imply the internal components usually associated
with it to make a functional sound card on these platforms.

Also enable the simple amplifier module which often used on the
output stage of those cards.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 24e534d85045..71a6e1309b5f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -642,6 +642,7 @@ CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
+CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
@@ -654,6 +655,7 @@ CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
+CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WSA881X=m
-- 
2.25.2

