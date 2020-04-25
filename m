Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CFC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F532074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UpgWcg9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDYRxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDYRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:53:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F37C09B04F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 10:53:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so6261716pgb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxsCUHvJidJhiJJhJNMycjU39aOd/yCTxZfhtIy2qU4=;
        b=UpgWcg9eIyBGCuU1flBlioxSkBNuuizyQvlSNx1MvIPLntXpuLCT6/gnOyi4Q69Il8
         jiMbElEjkB9TYlgkP2MyrFJNKaVP3avr1NidYBSz3HR2XZUoSF7KB1foYIekSTvpzQMt
         XPkv+5EqsvGkb0KD7GTMauLLxJ55e+ZgfOM7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxsCUHvJidJhiJJhJNMycjU39aOd/yCTxZfhtIy2qU4=;
        b=rweb32RVy1LQvCyxkil7khuZ7xTgWOMKZ4TyjTdSbRKTakHZqkMKeNnXxA7lgG/5wO
         DMv3bpCCkb6ZFovYghpTPRXLQYRb/GXlLbjMo7GHxkFbCT2y8e5b8bujta3xoaDUmUpK
         Q6nZrawXMmnlXg2BuvlhmtbcDg3L4o74z44Ud4+/Md4VzPWLBXcHGlEFhxs7AKJo86vS
         P19090TGqqvArQJ5EscjSQ6nPH28fXaqMlPZojn+MY0yCSkcGtdFyy21/cMTBsOp59oL
         0IPl2J6Pvu0+YjZJfCsP7NT1AMvI/mJu/tTMic7QEza2W7aQTtTcId4xJhgp+TvpVOWM
         1RWg==
X-Gm-Message-State: AGi0PuaVzTtCVfWovV7Kflh0UzmZiQoT+DF0m1nyR6XjZlNo3KE45hqc
        h96+7/1hvepHzt4U4/ab9Bq73w==
X-Google-Smtp-Source: APiQypLWC1/oB1xiCcvxiHfUPr1phpNzdnJKfr8nfxRQ3K6A4nRs9gSTe2ahMKHe/bAreT3IAEEGNw==
X-Received: by 2002:aa7:985e:: with SMTP id n30mr14586895pfq.163.1587837194732;
        Sat, 25 Apr 2020 10:53:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v127sm8342148pfv.77.2020.04.25.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 10:53:14 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/3] Even moar rpmh cleanups
Date:   Sat, 25 Apr 2020 10:53:09 -0700
Message-Id: <20200425175312.124892-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches based on Doug's latest series[1] on top of linux-next. We remove
the tcs_is_free() API and then do super micro optimizations on the irq
handler. I haven't tested anything here so most likely there's a bug
(again)!

Changes from v1
 * First patch became even moar complicated because it combines
   find_free_tcs() with the check for a request in flight
 * Fixed subject in patch 2
 * Put back unsigned long for bitmap operation to silence compiler
   warning
 * Picked up review tags

Stephen Boyd (3):
  soc: qcom: rpmh-rsc: Remove tcs_is_free() and find_free_tcs() APIs
  soc: qcom: rpmh-rsc: Loop over fewer bits in irq handler
  soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition

 drivers/soc/qcom/rpmh-rsc.c | 115 ++++++++++++------------------------
 1 file changed, 39 insertions(+), 76 deletions(-)

Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20200424094610.v5.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid

base-commit: 02d8ecc18b8f392389ac9e7b785b0230ecb80833
prerequisite-patch-id: 0d383ea46ef52ab4044886a7d88d85c3c506f4ed
prerequisite-patch-id: a02b0b018404d1a0c79270ab567051656f123b23
prerequisite-patch-id: e59d990462b004a9f8335e87c2d0d747afec49ea
prerequisite-patch-id: 20cd04c9dbed8937de5d61f486616c5961b8ef99
prerequisite-patch-id: bb479b9adbe28c58b3ac8f363a306de80b6dcb74
-- 
Sent by a computer, using git, on the internet

