Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9FCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4389420707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omh317KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHaGH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgHaGHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:07:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1BC061573;
        Sun, 30 Aug 2020 23:07:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so4186696wmk.1;
        Sun, 30 Aug 2020 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z7mwICOsTSTk8hmlKiJXKOQS+E+K2QedirkvwqkFtog=;
        b=omh317KQBC6uXvsjwXrrei7AXTavsyNq318sCHmtgXascdVih1L5vxjj78dpNFGu8M
         jFCxqf7uZAF+6Zb5H8x+BP4FtFcV2bwuaCJ8neNXoPr0oci0NKTVi4blGJK8zmPBfQnq
         9xcYlm/lP3SYR5e9Idx0ONYQz1/vGcb3DxSqMRCKmUOViOIEbqx5jR3hYCGijFIkhqiM
         s5LJXvVFqXYAbPhIUFqjZr+lyC7cMnaFHOrs/mCD70TT6N+brJpo8uzcTKSKAYXYaboG
         FxpGIWvHuAoM1PDAji+BkovX7FFUrFuh3m7viu62mV2pvNSKQSoKw/uEvhlBvrkQJkde
         nz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z7mwICOsTSTk8hmlKiJXKOQS+E+K2QedirkvwqkFtog=;
        b=bMx9CGy2JwNssX0LGxtwZbLKGZh+yKODg/s54YCKuRY4kKQismudRZIlPpjNQu2VKR
         tycbhRfHqIpdKp13bzLVw5Gb7w718PoZSWJszIBPAs0Z22FL97J1U6cLEJ7KUfQpuShv
         yUnDjPK5WHY47M4xlShDiH8ZYbWX/aVXT4cRF6IVD1aUdl7tkw+2KZY3lvPvwTrF2lYb
         WwI7dPVneAFsLBif75TWZumZeqgF4qSu7u5DAew1P0/J3hYdX0RAhVoT/CjqE3YupC+F
         eQv8HVEgqwZ94XpmYUOAj4DPCOSp7uBGCps3V90bX4WB7U/8FAPV5nBw2xSyJlheETo4
         NDkA==
X-Gm-Message-State: AOAM532B+PpVGYdhz7oyz/l67qzKGzPkkAkBu2uV8j5FUSM2Ph/DCDuA
        CgBLIqA0MQomObRXF0lIQsajILdatZsA27Ad
X-Google-Smtp-Source: ABdhPJy2mi09OkLTQzsVzN9ZiIN8rdVkae5wdpKepg598PQtPa4RNqQNFMHIXorspAvqLQuWQ9ZI4w==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr184801wmi.95.1598854072100;
        Sun, 30 Aug 2020 23:07:52 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de1:2200:9c37:36bb:80e7:91d])
        by smtp.gmail.com with ESMTPSA id v9sm10387897wru.37.2020.08.30.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 23:07:51 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add headers and doc to SCHEDULER
Date:   Mon, 31 Aug 2020 08:07:30 +0200
Message-Id: <20200831060730.17461-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various files in include/linux/sched/ and include/uapi/linux/sched/ are
identified as part of THE REST according to MAINTAINERS, but they really
belong to SCHEDULER.

Add those headers and Documentation to the SCHEDULER section.

This was identified with a small script that finds all files belonging to
THE REST according to the current MAINTAINERS file, and I investigated
upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
RFC v1: https://lore.kernel.org/lkml/20200308174931.9118-1-lukas.bulwahn@gmail.com/
  - no feedback.

RFC v2: https://lore.kernel.org/lkml/20200413112603.5257-1-lukas.bulwahn@gmail.com/
  - RFC v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
    ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
    ("MAINTAINERS: sort field names for all entries").
  - does not need to reorder entries anymore.
  - applies cleanly on v5.7-rc1
  - no feedback.

v1:
  - rebased to v5.9-rc3
  - minor wording: s/SCHEDULER entry/SCHEDULER section/
  - increase recipients to all scheduler maintainers to get some feedback

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987..36c8e7671b70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15359,10 +15359,13 @@ R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
+F:	Documentation/scheduler/
 F:	include/linux/preempt.h
 F:	include/linux/sched.h
+F:	include/linux/sched/
 F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
+F:	include/uapi/linux/sched/
 F:	kernel/sched/
 
 SCR24X CHIP CARD INTERFACE DRIVER
-- 
2.17.1

