Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54CCC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C855E205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CtUHuD2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgEDU3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:29:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69812C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:29:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so6144800pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6DSmsBJKt2DQfLRYsNho1OzzZKZZ7TrpLhucHJGeDU=;
        b=CtUHuD2HM6xhWKDF3wYinVyJ5yfU8h3iMv+4Jgb/2SnYJaXO580t11nnYxa+9FlNDK
         U6TGMzQwU+V7RChMHxwXZtyt+SewvPLvCCLh1uwla15xqrRU0z1ghpA1H7ZH1pJ46AdY
         SEXFhpaX8gu/FTKTebFQeFBwGadqxAUhyR9ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6DSmsBJKt2DQfLRYsNho1OzzZKZZ7TrpLhucHJGeDU=;
        b=K1ygx/FYBl1LgHYUJ7NAkOfu/KpVL7zsO9a4Js6mki24MMKPrLWbg3GjKpaT5Gcj13
         7kfpPkUW6gB96ImnkO5kd6wpeXARYwlSU438fSrQgOZo6/h1AEtA4aGe86NlbZX73TWy
         N2rQPDWNRGtm+5S6jZMypZoxPKL989qbQvhfbKal+beQHA5ibsvirYJshK0Qzv1wY+AS
         9m7LvPfoSCg7TeTziSOmecOOXEoj7iyUuV/EY4vyQfZmFkwcxjNZsmkXeBmV4XuRWNu0
         JXxmMMD5/L+4BaI18Whj9mn5n/XMYCPEmwfEYU6Rt0KfnVHnsIkMftxaZDDyYPsJQPrI
         onFw==
X-Gm-Message-State: AGi0PubuI0gx8or8oFoeB1cQNQzpbaPcmFyFDLQTqBic9B7bSAVEQCs1
        J8gnqlrzfJz2ywtikvGCxjBnm2nOg8j9JA==
X-Google-Smtp-Source: APiQypJFsSvliJI9R20jNekDhiFtU17acQVf014rcrlhyg8R1X6m8Sc86MkUoQNu9jpjNd5H+2HQbA==
X-Received: by 2002:a63:a012:: with SMTP id r18mr30263pge.352.1588624191724;
        Mon, 04 May 2020 13:29:51 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id z23sm9511737pfr.136.2020.05.04.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:29:51 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] Cleanup power_supply_sysfs.c
Date:   Mon,  4 May 2020 14:29:26 -0600
Message-Id: <20200504202930.228453-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few various patches to cleanup the power_supply sysfs implementation.
---
v2: - Don't create attributes for unlisted properties
    - Use a char array for lower case name so no allocations neeed in
      init
    - Fix patch #2 does not compile because of change meant for patch #3

Mathew King (4):
  power_supply: Cleanup power supply sysfs attribute list
  power_supply: Use designated initializer for property text arrays
  power_supply: Add a macro that maps enum properties to text values
  power_supply: Add power supply type property to uevent env

 drivers/power/supply/power_supply_sysfs.c | 471 ++++++++++++----------
 1 file changed, 255 insertions(+), 216 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

