Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230EE2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="OWAio0EV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgG3MbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgG3MbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:31:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4341FC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:31:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so6151606plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2/Qj6Nif9luQnMoOt9a8mrvFC5Crqzoun3Ynrgcf3k=;
        b=OWAio0EVE8Zgna0JT5rqNJsAkAbqjuKbMzYPxqZT+4WXTITdAj4tjm7jvhltrJsfy6
         5etZrdaxdfB+aqS5QGIDlN0JV0cdd/VyBwwHMRcBZ7gPLHlrExYku1M3+auZcbUQWaWV
         e/r8TESWPpnnO0smWiytbTi1+9e5GQcignhc47touLNCTStNNhbdqK/8dE7QMh1Uq3K9
         5dM6cI9fKEKF23tpgi+8OZOqSi4fO/KN33K3rhOWb6y7iyZXfu2hafjY9NhU+MtRyRLX
         wijdzeCHFt9hf5GH3cfZG+/K+lNZc93FYkPstD36iWUZkVS3FnyzU+PmmjteTuPzHCqF
         M76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2/Qj6Nif9luQnMoOt9a8mrvFC5Crqzoun3Ynrgcf3k=;
        b=le0KHjFVBL3HggGT5hRkL1MpbgitLFYyQ0bKhXkWuiO5WRH5jmuvhrG3jIIEkFhk51
         h3CqgD7HkEXA+eQ/YH5PYHwFPGqsMk/+ljYsC+8uscbjJPPu8YmtGiSIO6T8dCQ/hT7k
         nkGPCsrspfB+DFCfLhYtHlXvFmKYFd5oegplsLxInUpS8ADpfKXjADQeQjSMBT0AOMvW
         UpKuVcjjTjRXjLyUZPqhFCYA9lWqgSinX65BkSyR+juUdTw7rcPnpXNjEJRDFm/EHtAz
         XPWzqg6ksbpxE198SG4Cl1IMje6NANrYieYzwQ27KfMqnnAw/qqltBogBRpxq9UMRZOG
         sH+Q==
X-Gm-Message-State: AOAM531y3nU3wJoxC8/IvOc5sf3peZQJjqrCc77vMDJD+pi4pZ4quzIo
        d54JNoz+lQLOTdAixAB5VMB1ZA==
X-Google-Smtp-Source: ABdhPJyXXciFDG3sTgPDpLaBVzQTsqI5Uepkwj5R7Cn5B3vGo1qSU35zyr8PUXkxlP03xRooiOHklg==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr33491433pgb.356.1596112275826;
        Thu, 30 Jul 2020 05:31:15 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id m4sm6364896pgh.9.2020.07.30.05.31.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 05:31:15 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com
Subject: [PATCH] iocost_monitor: start from the oldest usage index
Date:   Thu, 30 Jul 2020 20:31:04 +0800
Message-Id: <20200730123104.27023-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iocg usage_idx is the latest usage index, we should start from the
oldest usage index to show the consecutive NR_USAGE_SLOTS usages.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/cgroup/iocost_monitor.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 3c21de88af9e..f4699f9b46ba 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -173,7 +173,7 @@ class IocgStat:
         self.usages = []
         self.usage = 0
         for i in range(NR_USAGE_SLOTS):
-            usage = iocg.usages[(usage_idx + i) % NR_USAGE_SLOTS].value_()
+            usage = iocg.usages[(usage_idx + 1 + i) % NR_USAGE_SLOTS].value_()
             upct = usage * 100 / HWEIGHT_WHOLE
             self.usages.append(upct)
             self.usage = max(self.usage, upct)
-- 
2.20.1

