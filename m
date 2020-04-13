Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23CE20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="2BcCxaxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgDMOrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgDMOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:47:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF8C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:47:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n10so4588083pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Sm2TzUdkC6hw1ndCjQ7aP7HJefqahFEuBiubec5j08=;
        b=2BcCxaxNRSFHLmG0N4cIxzZa98Q3C9wp71K/ERLhsbyo/1uKurISkkAOutnvBWrlUQ
         h+jd3XAmujnuxzWNzdbj75eOQBKO2377ULkRLYQ5YWkl9OlAMTT4YKjv8K4OsSPVVTq4
         8ULUEE39/AbzECqh4NBsK3ohbTDL2yB4b7XLctibU0JwtW2lCTp/3WesibNL02Ce4so+
         GfYGEu0C+K2rYU89gJOk1rPQKbnjz35t22uf51e9MewfEZ0cirJUxu40/MhWW6/4WzbT
         QEaS39qTrZiQtFnDq/lOLCVDZ63poHJVKHTW0TlHtIWrovtk29tsnXtLhS6bXSwuhM/j
         VzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Sm2TzUdkC6hw1ndCjQ7aP7HJefqahFEuBiubec5j08=;
        b=eQyztBBLWlo/OPO7qP3BqEybuZBUILHzw7kVki7jqar8wHydd9Y9MoHUAeyQK2dS+m
         0KkWIEbG5+7V/S7BxMo6KzFC0aSt3uk+YB5gHA/BQbO7H2jfAQ4f+gUEa911V1yi+6Z5
         r5QywnSftn3NH28NH/ffm/REG46z97KxyI0viw+SdMG/viifWbsXP3xEsrWRODJOoajR
         wnDrW5N755ohApM909XW3NL7b7Qqp3Bq8h602Sjfs0XKTIIcajHjLKIzhwAAMMCyP5BP
         AQLtJLxxWTs1in98ez6WvrAA78DcwTXMJm/JThkPyJJywccX00J488LCZm16vUoZRjmH
         LqYQ==
X-Gm-Message-State: AGi0Pube8h0pCBYBgmfLntS2wzdlfCwcuAX7rUtNIoWPB5lo539oOyC9
        rfrw5DIyJV3kOtMQXQphjhw2+Q==
X-Google-Smtp-Source: APiQypL6KPqZFybu6lwtYsU35C+jXJEjwanQwqw1PlNI4ppX9nkOq/wc0h4AoWUIWz4UdkkAAmpC+Q==
X-Received: by 2002:a63:1053:: with SMTP id 19mr17941569pgq.60.1586789268356;
        Mon, 13 Apr 2020 07:47:48 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id g185sm2981601pfb.6.2020.04.13.07.47.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 07:47:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, mingo@kernel.org
Cc:     peterz@infradead.org, shile.zhang@linux.alibaba.com,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] x86/unwind: Make some variables static
Date:   Mon, 13 Apr 2020 22:47:27 +0800
Message-Id: <20200413144727.51258-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables are local to the source and do not need to be
in global scope, so make them static.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/kernel/unwind_orc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9cc182aa97ee..0dbabc469ce2d 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -16,11 +16,11 @@ extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
 
 static DEFINE_MUTEX(sort_mutex);
-int *cur_orc_ip_table = __start_orc_unwind_ip;
-struct orc_entry *cur_orc_table = __start_orc_unwind;
+static int *cur_orc_ip_table = __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table = __start_orc_unwind;
 
-unsigned int lookup_num_blocks;
-bool orc_init;
+static unsigned int lookup_num_blocks;
+static bool orc_init;
 
 static inline unsigned long orc_ip(const int *ip)
 {
-- 
2.11.0

