Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A3C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C81E20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgBYQ6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:58:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42138 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:58:05 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j6dX0-0000Pe-PI
        for linux-kernel@vger.kernel.org; Tue, 25 Feb 2020 16:58:02 +0000
Received: by mail-pl1-f198.google.com with SMTP id 91so7778952plf.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tmq5/QscEAlIKXHg+Ug+knf6u6cqRVBxVv3NqJuFm50=;
        b=boJLdgBANprUxgXis8kUw+nd4thrUvYk8anHyxVODTwYOVjvw4/pTnbqPNW6cZwPPk
         ijU6hlUx8nLvvwQ7X+KJOFZ98fynwk/nIcnwhBinqI6eIqtKicl5UpdlN5Xp2IejQ+SQ
         DptP340EAf9NWzNJSFBBj1kR7OcFSu28CCYP5BYTXvNkp2HmlT64MRyNumQwFjGFKYRr
         BCWk+OpO0v2kH9HroUDQowvSH8YThJENduNr3IR3+mw8Yb5QhmxCVKmfV6g0LauCtUrl
         d12umRTudm+511lmPGuXiX35FNnkArYGLJ52JBTFsuVxxEoD8jZUAjB9DRK3xjWoWa08
         GnHg==
X-Gm-Message-State: APjAAAWy1PX4DXZaRDbCQT+83UP2dlY5FXusv6e8xkJxFAHL0qmXlVZs
        6Amaz/1/O55MTaq4XcnYPSYeYXYjiwcWJZgQlR7VCUE32DIX6+7MpdOOMZ9X3ZdSH3tq3F7ikUK
        VC3GoSNtONx9qQZE9Vh++Bbp9kHvXnJ6VUp/PTxkg
X-Received: by 2002:a63:7d46:: with SMTP id m6mr56273069pgn.38.1582649881488;
        Tue, 25 Feb 2020 08:58:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDCUsO23WLo7Kej+kPuOKSIr5NpcgPj7a/xYcGbZxHSW4SNQ4GSRF97BOQStSuVJhPvD3Zbg==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr56273040pgn.38.1582649881092;
        Tue, 25 Feb 2020 08:58:01 -0800 (PST)
Received: from localhost.localdomain (223-137-37-84.emome-ip.hinet.net. [223.137.37.84])
        by smtp.gmail.com with ESMTPSA id i22sm3558212pgi.69.2020.02.25.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 08:58:00 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, sboyd@kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] selftests/timers: Turn off timeout setting
Date:   Wed, 26 Feb 2020 00:57:49 +0800
Message-Id: <20200225165749.6399-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following 4 tests in timers can take longer than the default 45
seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
Add 45 second timeout per test) to run:
  * nsleep-lat - 2m7.350s
  * set-timer-lat - 2m0.66s
  * inconsistency-check - 1m45.074s
  * raw_skew - 2m0.013s

Thus they will be marked as failed with the current 45s setting:
  not ok 3 selftests: timers: nsleep-lat # TIMEOUT
  not ok 4 selftests: timers: set-timer-lat # TIMEOUT
  not ok 6 selftests: timers: inconsistency-check # TIMEOUT
  not ok 7 selftests: timers: raw_skew # TIMEOUT

Disable the timeout setting for timers can make these tests finish
properly:
  ok 3 selftests: timers: nsleep-lat
  ok 4 selftests: timers: set-timer-lat
  ok 6 selftests: timers: inconsistency-check
  ok 7 selftests: timers: raw_skew

https://bugs.launchpad.net/bugs/1864626
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/timers/Makefile | 1 +
 tools/testing/selftests/timers/settings | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/timers/settings

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 7656c7c..0e73a16 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 
 TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
 
+TEST_FILES := settings
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/timers/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4

