Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D0C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E735F21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgBYKSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:18:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgBYKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:18:21 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j6XIA-0002Rd-SL
        for linux-kernel@vger.kernel.org; Tue, 25 Feb 2020 10:18:19 +0000
Received: by mail-pf1-f199.google.com with SMTP id v14so8848652pfm.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 02:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+pTBMgNSyaWEJEV8vOsVhnaFO3AzlXBJYTusRgM9dWk=;
        b=c07Pi8WYfdfX4M+P/RRmXBJwjhSsGHi8633RUl9+FcorhqNjtogdKsK2jaZwqwFvek
         9VG0j5dS9GiZZRAcUprtWh2lv9yDIZQAZB7T76Rjy6Ym1ecEphVu3c32DvLuiZykknl2
         xlUCwdHpLr2ljFZiuxfAUvzSKxXfGvSsgbV6fl4+zBmnRhRh3W4DLa9obLC49fwVj0pF
         IO6PMfJAyD7eHhmyG8AaILv4IgArRcanb61yWit+U82UcmWzD7W9TIGKpooZtLOXWyTb
         K+QGjjNJu4A7pE3nhMYdNR3KxiMKg2cVYIX668NfzG3hHkqfbzv6s+c+kSw/8Vxsrpis
         5mow==
X-Gm-Message-State: APjAAAXTiCd5Tk6y7yd3du6YiWxAeaFHbIc8xmkfYaBaw0YKO93whvfe
        SQ+Q2f7t1UHHpu0FPS1K0bPxiAUZrBpfFZFl6R8aNj/11h7dEj1JUhtYoIOt2TaBpHZka9UYY03
        gTYPBmkElS4S903oPK+w6kVZ5xjPWBABMtOwWbbXI
X-Received: by 2002:a63:354d:: with SMTP id c74mr23102384pga.234.1582625897554;
        Tue, 25 Feb 2020 02:18:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqw32U8UJaAFKSu2igL+Ekf4jExX3nYSTtO0z6U+Ccmd+biRlFPNdgDC/4yTVAeys7G/igMjVg==
X-Received: by 2002:a63:354d:: with SMTP id c74mr23102359pga.234.1582625897225;
        Tue, 25 Feb 2020 02:18:17 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id v4sm15770025pff.174.2020.02.25.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:18:16 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, john.stultz@linaro.org
Subject: [PATCH] selftests/timers: Turn off timeout setting
Date:   Tue, 25 Feb 2020 18:18:09 +0800
Message-Id: <20200225101809.9986-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests in timers especially nsleep-lat, set-timer-lat,
inconsistency-check and raw_skew these 4 tests can take longer than
the default 45 seconds that introduced in commit 852c8cbf
(selftests/kselftest/runner.sh: Add 45 second timeout per test) to run.

Disable the timeout setting for timers instead of looking for an proper
value to make it more general.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/timers/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/timers/settings

diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/timers/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4

