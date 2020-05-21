Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEEBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056D6206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIK4ZnT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEUBVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgEUBVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:21:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97944C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so2490619pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rg9l5ozOZpLTZwGJd6lPleCwU4Ff0Q749YYJ3OhvIuw=;
        b=VIK4ZnT7t+sq+aV1O/eTvjikSgDISFIaNBCXJziHC+LUQoNCV4t5SIS+jNrXt5Fgvt
         UudQbH2K4iK3Svax6ypVeHa6TLwfFqZiHgUVNFIpmHbb6WqgjWkHLI0CUcDYh3upaDSZ
         l74yHDPBasgCiKeZK3lnhe54IrWh+BqWOGlZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rg9l5ozOZpLTZwGJd6lPleCwU4Ff0Q749YYJ3OhvIuw=;
        b=hvqhAWRaELLXOjQbwibtjXmrSgY1020DUAR7Crvs2zjxaOwQlPzZOaXFoOnEAkFM/t
         AULi3BApn7xXdzPWrxiOQq+4+np3Sovxxi6kpPOYipQxdPZ92Yo1GlkzqagnYTldot6x
         71XscNPP/jQwmWJ3R+p3Xfr1GoRoRncHWwmAP7PwNJQltBm0xXNlubLXMtLGzGN/CmH2
         sEdEwgWnVqT3cQMCq3ehMe/cyPkECoe5Wiw9Cy0OzBnegX9yOWnxmk5jvUpCqkuMpGn4
         o0HLZ2INQv1vC7gkc2V/xmFGNRRsVc658dLOkeCV+1Vcw2hgSyPVePiSPmJyJ+z6HVB8
         24FA==
X-Gm-Message-State: AOAM5314x3DmBNCY6BltDhRwkaqeOaIi3ZnHWF8U6eqVwsu2HUEFuySW
        SYfvHZsNCIZy5rRkaOG/nPexQQ==
X-Google-Smtp-Source: ABdhPJxw6z0ZnPz6Owai2RQzOlIuxErIPT4YFmd2gs4euqe51xYtt2JqEKYALVjvUJlG6brVWjUhVg==
X-Received: by 2002:a62:6d03:: with SMTP id i3mr6711085pfc.249.1590024081026;
        Wed, 20 May 2020 18:21:21 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm3081020pfa.111.2020.05.20.18.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 18:21:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/3] Even moar rpmh cleanups
Date:   Wed, 20 May 2020 18:21:16 -0700
Message-Id: <20200521012119.238270-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We remove the tcs_is_free() API and then do super micro optimizations on
the irq handler. I haven't tested anything here so most likely there's a
bug (again again)!

Changes from v2:
 * Went back in time and used the v1 patch for the first patch with
   the fixes to make it not so complicated

Changes from v1:
 * First patch became even moar complicated because it combines
   find_free_tcs() with the check for a request in flight
 * Fixed subject in patch 2
 * Put back unsigned long for bitmap operation to silence compiler
   warning
 * Picked up review tags

Stephen Boyd (3):
  soc: qcom: rpmh-rsc: Remove tcs_is_free() API
  soc: qcom: rpmh-rsc: Loop over fewer bits in irq handler
  soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition

 drivers/soc/qcom/rpmh-rsc.c | 65 +++++++++++++------------------------
 1 file changed, 22 insertions(+), 43 deletions(-)

Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>

base-commit: 1f7a3eb785e4a4e196729cd3d5ec97bd5f9f2940
-- 
Sent by a computer, using git, on the internet

