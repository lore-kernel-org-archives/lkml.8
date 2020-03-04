Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9ABC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E742B24671
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZMF/8H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbgCDQ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:27:08 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:33362 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgCDQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:26:51 -0500
Received: by mail-wr1-f73.google.com with SMTP id d7so1075695wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KkLXOOSG3EccFvXnveAsAjlCd4Cuj/e0jkzvyAbgB9g=;
        b=qZMF/8H31N+tU9HXK3934/ePKJPPhUukwvNWbO2CngiFnO2S1pZA5D04fryyHOjcic
         hcn/37cJE8ZiJAlv2eXPofk+HXUOZCp++XlFjjV85KedIeF9bNjDRJGCHSiFmdadFZDp
         BTSItRnZH2VkQwfN7Byv+QQak8Hg6e5SeUFyC5dFzgUUbfK3g81V6GuShW+YVeLOA/Qg
         258s1gSYoGYox8oAsvfLAO7NwEagbmwJml4qVauqIoDbr6miG9fNkB0ld/457wur/5Mv
         uE9AGIVTu6sALEIIiU/8qo4V55KzCD3SOq8w6r/9aVJF+JjhZxNw2UWZO0oTS75RQMDk
         sHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KkLXOOSG3EccFvXnveAsAjlCd4Cuj/e0jkzvyAbgB9g=;
        b=NelBVsGcPHii7ipXBrWstyyM7k067RRg/tVD/2HzJyhmE/o8tGc31DLy1ZPMuE95fT
         yylQxaMtrFr+2bCpeWzNWBtjCYcmkCYU9SUJPzXB/KOWcJnDhzDeAEHxKhCUpBiNvt1l
         xSakkl9rjT5mFTx1toBYr1qAjpR4OcPS8deKnQOaA1qkVN4qL8v1fzmtqTYnlQgkIg5c
         fEhVw9r1Fii0GkS748aHbYTgYK0WujeLKKUwouvnWaAXHMxjwXBlOriZF6Mdh0umP3Wu
         CsRjXONhMG69mAhxkW/EFKwP0nm3VWgovp3dOs+oCG+5ybJq9yN5ZCttIXIoer9dUhRk
         poIQ==
X-Gm-Message-State: ANhLgQ0IYcwBd2yM/uBDHiOqZvzgPdkLwzIXRWentD2wfH7J8iVS0yER
        j5JUVfIuYEn9lvqkZ+4HoK25i0+2FQ==
X-Google-Smtp-Source: ADFU+vuwHYHwbkfL0PNKCtBj5UcdevPUZcsHif32DA8cz76eBj0bRnn5n5s9CUCgRlXNld1pzFBAFR97Rg==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr4909942wrp.168.1583339209473;
 Wed, 04 Mar 2020 08:26:49 -0800 (PST)
Date:   Wed,  4 Mar 2020 17:25:39 +0100
Message-Id: <20200304162541.46663-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 1/3] kcsan: Fix a typo in a comment
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/slots slots/slots/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
[elver: commit message]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index eb30ecdc8c009..ee8200835b607 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -45,7 +45,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 };
 
 /*
- * Helper macros to index into adjacent slots slots, starting from address slot
+ * Helper macros to index into adjacent slots, starting from address slot
  * itself, followed by the right and left slots.
  *
  * The purpose is 2-fold:
-- 
2.25.0.265.gbab2e86ba0-goog

