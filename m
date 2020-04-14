Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B3FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD302074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AK0N3ggC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634319AbgDNW5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730783AbgDNW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:57:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC43C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:57:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a201so15988167wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vooTJvyFAnPbScrQeeG7htKJp3u+s5oV7UHU8KzmuKI=;
        b=AK0N3ggCwVVjw8vJCEJg2fJ7U1jUfdyBQLz8LSefqbdulyTMTAypZ9TAalEGmhxbf9
         dl/D81VhhEdv2Ojd1DXCuhsfWdEMI+qAm/5/mtBMyf2weI6PjdTa4z2wE2RN6SAiKItX
         NIZMQPRgBTADdpwlGfv+f+HEEoXNnDcSXQQKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vooTJvyFAnPbScrQeeG7htKJp3u+s5oV7UHU8KzmuKI=;
        b=FckyT7rNMpHF9aH5Lxc7ej7fPYygIvqTGFC9fqHcf1+hJCOoylf0XlAZrmhs4LbBzy
         q0rdXoRL+dipxNLX2+fw0EMBElfTIgiEBdeDHUvDG9xNPBtkyFEtEKq6ks4ix1WXWmeK
         r4S5YRo2Pco+nZtBGykOkcNt1QTNG4Qf/7rvWfPafQYqd8v0muNJSdGJf5Ut/kUe1lSO
         +dea9iJLC5cUz0YbggzUxWpvrUdbzIzGm9yDztgSvr+D5gzBK0JFqGagVIk8AHtYzy0l
         kGsoYCeZDA7ue8qYg+dp2mSktF/Z5EGwHM5c41qMfdV7v4CXnb+sfD7NPrlwarL8xiUh
         d4Jw==
X-Gm-Message-State: AGi0PuZnfNUFO7p0Lg1TbZiCAZgYL4rlflbXm4KgyPI76+qDgEOA603U
        RXUCUEbP/8QaX3NJ9jEdZoXZZ99wZQA=
X-Google-Smtp-Source: APiQypL6LUAaOgq/6MgIQWo7Jm4L7Zhon4Yu1g5ubxGqF+bjdELGRuneWI62PKOM+IbvLdt33DE5OA==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr2195765wmg.183.1586905027360;
        Tue, 14 Apr 2020 15:57:07 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id x18sm19784515wmi.29.2020.04.14.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:57:06 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib: Add might_fault() to strncpy_from_user.
Date:   Wed, 15 Apr 2020 00:57:05 +0200
Message-Id: <20200414225705.255711-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

When updating a piece of broken logic from using get_user to
strncpy_from_user, we noticed that a warning which is expected when
calling a function that might fault from an atomic context with
pagefaults enabled disappeared.

Not having this warning in place can lead to calling strncpy_from_user
from an atomic context and eventually kernel crashes/stack corruption.

Cc: Jann Horn <jannh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 lib/strncpy_from_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 706020b06617..16e78d0bb5d4 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -98,6 +98,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	unsigned long max_addr, src_addr;
 
+	might_fault();
 	if (unlikely(count <= 0))
 		return 0;
 
-- 
2.26.0.110.g2183baf09c-goog

