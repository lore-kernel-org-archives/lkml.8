Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F68C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AA520708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdqM4NMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGINHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGINHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:07:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D1C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:07:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a32so1570359qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Y98dnFuhKZXUOEw7Gz1NRQLDKcW5Uky8iV/XCzB1Y8=;
        b=sdqM4NMWO5dzN69yq1MlWY/QKkWthK7J3mCBnPKsOKRjt9khpP/w4nRm7Zd+PMfSsa
         bUrI7UxN53qcPz8Yg2Nuv2yp9arensG/37Z4I3jeN6fRqrnfuhFVcPng99EGFjioDCkS
         aT2d1g4vOMb9kjDpa6vg1lKQCGRRzHY8tXcMgu6Zx0E54pqSSUAbiMU71CRb8qylri1R
         dSlU5Y+GXqub812lb82UGpnmnrxXVg5lV0ImOVRngvNpNk6syIkwu5gWrfO+PMqZRGy3
         JUNFKhA054OD+9MtABPMMuKhourZJJbdAuTJyG9IJkHYSUXn7s30Cd8kTdN9tU2cND2c
         OUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Y98dnFuhKZXUOEw7Gz1NRQLDKcW5Uky8iV/XCzB1Y8=;
        b=qziY/Lxya3WpQ63FGHVaXwJJWt1rdAJ+gKnG7CCnjnwN642a+9lxn1ic1Zh9P8NMUn
         GaTcMcyEaQQO8cLFg9Ba6+t6/AzZtxaofQCGrslmKuS96rBjk8W9sboVM0giakIyG2wS
         cFiXX9dhW9I5jWvnZsPJSkPdBYqO/ulPbx5sDvsHvMGTuBrLtRW61ApJdi3giOVqQGx/
         blCV35pjp4Ojh7CRF+/YbAiy/QVSr5aiqzci8gHlFdYVLi1o4X1S76pj4TxvhIieDDQn
         GAFQ14dFjnB3i+UNU+KFoec7+t264NXNHPHp0gybQbs6D+HBllpGpG1qjhEt+AilEYXT
         Sluw==
X-Gm-Message-State: AOAM5304xu90/qkng99hQ0CnoS7kE9ShXhbUj7RL9IbzA+IQZg65mwh9
        IlTvnmDuUt/c3655gqLorJY=
X-Google-Smtp-Source: ABdhPJzz+hrnw2R8tXY5WXXoIDe8IxmQkAb0gLzJiB4xrLY5xP07CqwRf6uGsNMBV2R2FIxE+OIKOw==
X-Received: by 2002:ac8:7956:: with SMTP id r22mr45428795qtt.359.1594300059916;
        Thu, 09 Jul 2020 06:07:39 -0700 (PDT)
Received: from k8s-master ([111.202.144.35])
        by smtp.gmail.com with ESMTPSA id 125sm3949202qkg.88.2020.07.09.06.07.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2020 06:07:39 -0700 (PDT)
From:   qianjun <qianjun.kernel@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, qianjun <qianjun@didiglobal.com>
Subject: [PATCH] perf-c2c: Fix the wrong description.
Date:   Thu,  9 Jul 2020 21:03:15 +0800
Message-Id: <1594299795-39394-1-git-send-email-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianjun <qianjun@didiglobal.com>

Use L1Miss to replace L1Hit to describe the correct scene

Signed-off-by: qianjun <qianjun@didiglobal.com>
---
 tools/perf/Documentation/perf-c2c.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 98efdab..083e99a 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -186,7 +186,7 @@ For each cacheline in the 1) list we display following data:
   Store Reference - Total, L1Hit, L1Miss
     Total - all store accesses
     L1Hit - store accesses that hit L1
-    L1Hit - store accesses that missed L1
+    L1Miss - store accesses that missed L1
 
   Load Dram
   - count of local and remote DRAM accesses
-- 
1.8.3.1

