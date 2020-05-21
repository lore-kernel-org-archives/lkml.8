Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4AA20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4eqdMGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgEUGE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgEUGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:04:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D0C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k22so2417547pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqZNNCwraQG3DufLiaAWTHDtBPB7vJAuN049dNeWG7w=;
        b=R4eqdMGjaw2EyVbaOywCgxYajMNw0NCD3I+k0OdIjoHib6dMg1W7vBSiP83p+cfBcV
         dJbHRF3eALRT+4pIEAUzf4ItpVkH0YL6bnjWsU6mYBeYY1lf4k5mIOy1I5mG3U8uWDRp
         vbgKMhcT17954+UB7LGl1OVtxVdxT/GMm43q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqZNNCwraQG3DufLiaAWTHDtBPB7vJAuN049dNeWG7w=;
        b=P+Zv+3S7ht1SKinDwYReWkAZN+C9uZ5pupBD44gAX/HbhnNBe/DmsEuU4l7+j3nR/q
         9grGqmtXGS+jRs5BKxk45YfTJBBKdY5jMGm8mWLwg11Ppcg/erWH7A00ol8Hb5BHhA3D
         6QjqfPLdAYUtyq6B53q8FJ1JiywAHVexbpm7BlfNpcSuLsG+R5s4MG9L8RwrYE/VdAod
         fbNQ5U8d2lM2HmigtFHhzhy6vHP9DZaXcuylE+Sp3/Veaq2YZ8fIlfaPmb9c3W3WSza0
         MVHafv8X4Tw7g5q2aoi/mBuhGs+6du/GchgSC0OcDQJpbTdYEDjXYLpyk88Ax4IYg/tR
         JGbQ==
X-Gm-Message-State: AOAM533aXhAeRncwH/EnpqJiqGhgEOOronWjz8XQpLoBxHxqBTPkWGIx
        rmkySfAvaupC4jskmwJ7xvCxuA==
X-Google-Smtp-Source: ABdhPJxEAYeVa9n3nR+7QkogEGUYWOfoC8AAfmkafGH8EBG4lJMs7GwiSqdKleFsw6yoIR1mwzV4uw==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr8886374pjb.236.1590041068007;
        Wed, 20 May 2020 23:04:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k18sm3590146pfg.217.2020.05.20.23.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:04:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3/RESEND 0/3] Even moar rpmh cleanups
Date:   Wed, 20 May 2020 23:04:22 -0700
Message-Id: <20200521060425.24285-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resent with more Ccs and To lines)

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

