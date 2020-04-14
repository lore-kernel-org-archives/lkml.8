Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7612072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT7CG0ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438886AbgDNLEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438846AbgDNLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:03:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:03:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so13781677wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kozp6i3Lacgef5+4DSMHoj7MA9dOzLCEz2jUPeMWfbA=;
        b=DT7CG0ssfUne9lNYdPJ9Ecue56wKlgS2k6+ncHI0dPVClo4XpziRxwmp23K8foCmoW
         Ies2xoFcXT9MXxE5iA+V6bHWY+JTD6hewBKACAJeqfyZDKIu8GPbEaLyvgNm+U3awvAt
         mbopGWym3uqalLQSDP58sUntlxfxDSo4HkgjF/Hk+TLm9DQOgxAbf3YLvRuHfd5iQ8LN
         waM/w2GqFMv0wIzsspgGB4Q9OZRyN7XXo9NgIMwnnkJDf5ZLlvpdoJnatqsbTlL1FUGF
         sG2ZBK/c90tuKWrzt4k0obq2TMLvpzB1+Ny8vy/agL4I3jM4rhJ8kO4XAHSm675H/RBU
         4y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kozp6i3Lacgef5+4DSMHoj7MA9dOzLCEz2jUPeMWfbA=;
        b=ARTxq9j6PbhumM5c1BlZ1RxEVO/9w9QBt9f/zSJWItuuZBL9T+hn6zUPaaGX/bYzjb
         2uGBvFdrisFQqSya2fJa/1R+GMxAaey2LmmJ+ht5+xg97j+Nz+Z6NkjqK62JnjsQY0e/
         rIJJptK1qEr6cPnyq/DpFWvKcNGBBlmn20YFuRDsWUwYuQ31so4cihlnAukl6uZ8TeJX
         /tst2T/6XsVvEgmNOwrsl1XMhEYoCv5jhREcsCAvY/GYYhqc/WoaMKU2EhIfnw4OPLeq
         Il0QeKFR44gGIO9Ehi5qedDY5hkAFnpUcoG5qPxUcGWYBm6GBDFVsEDqnySYayxdXf2w
         ed4A==
X-Gm-Message-State: AGi0Pua09nBBz9jNIaGe1C130EBPXMEjMnTbUZKlre7wQLklJakdF8FV
        V4ccX6j0AP3XKpCTuWGophQXbw==
X-Google-Smtp-Source: APiQypLnFggHzw40uCeOKStfMH7DEa3ix/MQQT+27B0+i0Gpd4CjYgAioKfmQb4l8jR9Raq4nljbAA==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr22603091wrw.72.1586862235663;
        Tue, 14 Apr 2020 04:03:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 5sm17989784wmg.34.2020.04.14.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 04:03:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH] ASoC: wsa881x: mark read_only_wordlength flag
Date:   Tue, 14 Apr 2020 12:03:47 +0100
Message-Id: <20200414110347.23829-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WSA881x works in PDM mode so the wordlength is fixed, which also makes
the only field "WordLength" in DPN_BlockCtrl1 register a read-only.
Writing to this register will throw up errors with Qualcomm Controller.
So use ro_blockctrl1_reg flag to mark this field as read-only so that
core will not write to this register.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Mark,

For some reason this patch was missed during last merge window,
Other patch in this series is already in mainline.
Without this patch audio is not functional on DB845c and other SDM845
based platforms.

Can you please take this for next possible rc.

Thanks,
srini

 sound/soc/codecs/wsa881x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index f2d6f2f81f14..d39d479e2378 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -394,6 +394,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}, {
 		/* COMP */
 		.num = 2,
@@ -401,6 +402,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}, {
 		/* BOOST */
 		.num = 3,
@@ -408,6 +410,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}, {
 		/* VISENSE */
 		.num = 4,
@@ -415,6 +418,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
+		.read_only_wordlength = true,
 	}
 };
 
-- 
2.21.0

