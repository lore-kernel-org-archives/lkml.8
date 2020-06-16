Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52FC2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX0QyNeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgFPMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgFPMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:36:58 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED96C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:36:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v15so15476541qvm.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LwsvhgSu3llt3znh/vlryiffTNTLDnq/294g1wxgxfQ=;
        b=rX0QyNeYzQQGUM9bfTPJnRkxGRwxyWjLt7O89VwbTaPY8XsMhdB/IYLvwdEsap6aSq
         Deb+Q5/K4jYhW9Xu+4Mk6dUrKeBQHrjcKBjY8yoCYuiwaH/EiTM4SGwlWu6hQ7iTuXo0
         KLcABZdWbrHuQ6QclLECl8Oi1AWGeJxykf5Ul5jBrXKHtx1oj1gdRsD2+mUlG8C67Adp
         lv05YlI/cQAB3bTcJo/T31TM71vnwsXb9fxkuV+ZJZ7DDgFfqFAhdT38FWnQ28X0GXoa
         Y4lAGY+X4rmIq+P0fwblNk8orEKg0t9ztCpT/0mLlEf+NXL3t+vlezWvQ2MgckkhCi+l
         XkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LwsvhgSu3llt3znh/vlryiffTNTLDnq/294g1wxgxfQ=;
        b=mHSsXrE63Hur1QZkMBymm5MadR2Y8cz4iBxRF3sBr9XoWoYwGmOMwPORpXX0s4Cc7k
         ZnggFmgWTnSOoeos3EFhU/1yZSEJBbKVP8MJBoeonc3wXoGXT95Hk4KzVsSUoEnFTHcM
         d/xADIJPm44ZRFoY3Zba0EzBEFtQzY94ZMt7IdtclIRcEjQptDd5itDnbcsw30wJtUiY
         z/0kIEUy24PsxYXl+hvUpfNON/yZHmJBayMNU/epRD7C3NdpOqy7JWh0sg8UtErprp2o
         5KOEdY7skZzgJbw2cbNEMmYwd41ikmAurNhZmcZW8DyMDf+63tu54HOrMe3M5lKCYzQ0
         TyBw==
X-Gm-Message-State: AOAM5310sAi3xFM2c/Pe3P9lZqWKRMzDIEBIV2/ksTMpAwKPGmvF68TC
        2B7FwqQwuHkaOXHr5ACwcqlxbXUSfQ==
X-Google-Smtp-Source: ABdhPJxZYeCOnEeq1GGeuLvWfQcp1rrGGS2+VECkVulaJTvmV5GEPYmscB7mhB0hAblegN9bzJVpSkFpmw==
X-Received: by 2002:ad4:4429:: with SMTP id e9mr2000606qvt.143.1592311017654;
 Tue, 16 Jun 2020 05:36:57 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:36:23 +0200
In-Reply-To: <20200616123625.188905-1-elver@google.com>
Message-Id: <20200616123625.188905-3-elver@google.com>
Mime-Version: 1.0
References: <20200616123625.188905-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 2/4] kcsan: Rename test.c to selftest.c
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'test.c' to 'selftest.c' to better reflect its purpose (Kconfig
variable and code inside already match this). This is to avoid confusion
with the test suite module in 'kcsan-test.c'.

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile               | 2 +-
 kernel/kcsan/{test.c => selftest.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/kcsan/{test.c => selftest.c} (100%)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 14533cf24bc3..092ce58d2e56 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -11,7 +11,7 @@ CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
 	$(call cc-option,-fno-stack-protector,)
 
 obj-y := core.o debugfs.o report.o
-obj-$(CONFIG_KCSAN_SELFTEST) += test.o
+obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
 
 CFLAGS_kcsan-test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
 obj-$(CONFIG_KCSAN_TEST) += kcsan-test.o
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/selftest.c
similarity index 100%
rename from kernel/kcsan/test.c
rename to kernel/kcsan/selftest.c
-- 
2.27.0.290.gba653c62da-goog

