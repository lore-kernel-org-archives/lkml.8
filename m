Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F618C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092A420678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8EnH2Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgDMLep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgDMLeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:34:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6212C008769;
        Mon, 13 Apr 2020 04:26:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so9023104wmj.1;
        Mon, 13 Apr 2020 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E9gKS0aLx/dN6WOsH21xjxRHRrDTUSuyvEQfHIY2zUE=;
        b=k8EnH2XlPIgFLTq8Kd1IeXoNfmLrb8FV90H0m3xvqZ3Qg4zgLhGDk/ldL+XaoAAaZE
         bb8FROY9p3+PIVCAermxDm4ojx7VsP7qr60+hpLYO7FZJIqKIZuwZ7Px0Wj1SxzbVfAi
         yvVwVy+9tOqBw1vItQU7ao62MGW9CXYef2ZIGsD7yL4csxTzNQu1JG7LMOydEJzyn4Fh
         scZV+UV0hKF1OHjJx0C4fdWfWKxEx4UwUjEHcuYyDt+GXAT0YJKvH9JertNdyJTAVRdg
         fOe4zQcOhKNXeG9m8VN8tTqXs6+T2xl9zObQYQ6LCzuMPdH7hv4XGn8w3a8e6wjtQjHs
         7f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E9gKS0aLx/dN6WOsH21xjxRHRrDTUSuyvEQfHIY2zUE=;
        b=RMutIYlWeHJQ2kXAGSsNRGeAUWTTpRteQ1rudn+fraLDJcwNyErQWb7Vxu9fHsnjS7
         jynlQIaJTw86yuKYC011O9yJQNJ+C8LCm5roVyOlWmMe9QQrSSV5rik9faBnKUMrJpaE
         Pp6Y1NYSn3mtnUVJPxCkmMhbt3LIdrtyCw/3D4J2oLd4h9mQF3OkCiT6z/B95NcEZsGG
         QY8LgdfmmNTsyx0oQpBD8a6/wsgkmjzasgcJMeWkAMjL8Y3po/Fjotgoa15jzJ6PH3j3
         g8pBZY1MFT5uPlPLjp+lGdjrtWE7G+pxLDQeh8kjEW+bfe167u6Nt4EZmEWgKjRwec3c
         391g==
X-Gm-Message-State: AGi0PubvV7k3WHEEl+WL9+exjOelLTIrxnQQrAoOeW7HAgztyn4DnYMg
        CYEo0a1abn5XBhVEg17Wbio=
X-Google-Smtp-Source: APiQypIMdVL3KR2SMkYkC4jJZSxngZnkiVynUBtLFJ/LfyzHcGY3cDM4BrItamm6lD6gS9WhQNvwMw==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr17236290wmg.96.1586777173455;
        Mon, 13 Apr 2020 04:26:13 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:3165:1687:284f:4993])
        by smtp.gmail.com with ESMTPSA id k184sm14012725wmf.9.2020.04.13.04.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:26:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RFC v2] MAINTAINERS: add headers and doc to SCHEDULER
Date:   Mon, 13 Apr 2020 13:26:03 +0200
Message-Id: <20200413112603.5257-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various files in include/linux/sched/ and include/uapi/linux/sched/ are
identified as part of THE REST according to MAINTAINERS, but they really
belong to SCHEDULER.

Add those headers and Documentation to the SCHEDULER entry.

This was identified with a small script that finds all files belonging to
THE REST according to the current MAINTAINERS file, and I investigated
upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
RFC v1: https://lore.kernel.org/lkml/20200308174931.9118-1-lukas.bulwahn@gmail.com/
  - no feedback.

RFC v2:
  - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
    ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
    ("MAINTAINERS: sort field names for all entries").
  - does not need to reorder entries anymore.
  - applies cleanly on v5.7-rc1


 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..8546910db0ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,10 +14905,13 @@ R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
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

