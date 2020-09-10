Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E3C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1542821D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3OxTW3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgIJV0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbgIJOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FBBC061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:57:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so142780wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MwCnq7FxTYt4OfQXRTiK+fRY/WmJvx9OFmW7bgtzZM0=;
        b=h3OxTW3NXpvEMOq+NbIAj5X/K4i9qGE9aGqbTmvfZMAHL8RYp/UJta3GwL7enE6ljn
         HiyAwx4ynSHp1yJO09Dd/g5TZPS4jepDxtGBQOaHPByNSVdbcEUDwIwa/a9RFQpNZzQt
         n3ZovD2zm7QZBsM20c/2WFJcaFfeYhuopDf3iqh/TIci/TnNwRAb7zvmAlLd5hMqGjbC
         HZctzh8uL40p1JLrxM1lWGjNVzqYan7014t4bSqAO3F1lgdUoVJqNR9v5TmsZiFjJXxq
         3Vk7uocCBH7r01Xcn9AfrAn5j6coZ8kXGdlwZY+Adi9HUeCn5InqXY5klXrafSlY90Q+
         6h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MwCnq7FxTYt4OfQXRTiK+fRY/WmJvx9OFmW7bgtzZM0=;
        b=G4gaHHb/T4ivhOhmJ+SsIlebG82qk0PhilMYDoQ4gwlHTF2799x869JtHVwiVSEPuv
         jFPsXKwZ0hJdSkj96PitrRwrVXxFKH0J1zYSBDKeAfRPWRLfSHIijYnwXpf+K/GbcwuC
         jYPgPynQ0b4+2LZ4DeQWWNEoDOGF6ytI16GHO3/XzQdqR4sK/pPkYHrZBjYNm7+ITHrE
         YJZq1lGGdAbcYPKLGDmdW/KId5HyC2gcXueI8Hx7x3pSkt4MSwXG572apG2NHT9ad1H/
         XRky94bLTEceNMzEZljr2p8BW8jLMP/FW5hCI+zR0QWYC70qZqyc825nonkrdP4SbKb6
         Cm6g==
X-Gm-Message-State: AOAM5308flJW5icVpfpSkFWI5HOh7kHIPav3wnBg8z6LFfdNP1Q/02j8
        q2DpgRbmCD3oW0ZY8AUlzN5JZg==
X-Google-Smtp-Source: ABdhPJwRnJO2QAzMWY2IwW08545/62SapGFADNSS1K+hkVFBQsS65LXRVZ324BFRXGFRcTOVUUzAtA==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr137190wmb.82.1599746250518;
        Thu, 10 Sep 2020 06:57:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b2sm3786154wmh.47.2020.09.10.06.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:57:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: q6afe: add clocks support
Date:   Thu, 10 Sep 2020 14:57:06 +0100
Message-Id: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6afe already exposes clocks using apis, but not as proper
clock controller driver. This patch puts those clocks
in to a proper clock controller so that other drivers that
depend on those clocks can be properly expressed.


Srinivas Kandagatla (2):
  ASoC: q6afe: dt-bindings: add q6afe clock bindings
  ASoC: q6afe-clocks: add q6afe clock controller

 .../devicetree/bindings/sound/qcom,q6afe.txt  |  23 ++
 include/dt-bindings/sound/qcom,q6afe.h        |  74 ++++-
 sound/soc/qcom/Kconfig                        |   4 +
 sound/soc/qcom/qdsp6/Makefile                 |   1 +
 sound/soc/qcom/qdsp6/q6afe-clocks.c           | 270 ++++++++++++++++++
 5 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-clocks.c

-- 
2.21.0

