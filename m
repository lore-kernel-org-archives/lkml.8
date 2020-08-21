Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA6CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34EF20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHUUMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:12:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40538 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:12:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id 185so3178517ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyeWE+LKBU/Cc6jZ0EOliLucORAUIo1fVngoaszDbjk=;
        b=OYgNc7HbASF8O5UCqWAcjBQySKnwXu5iR2+HOj5P8ANdgeEa2glHwJc3Px9xnEP+bH
         hvL8a7znqMf3sYj2ohLkmsmlimwejhzdkTesxtP0+6o9YXqnxi2Ed/FymGEQxfjZ4eKO
         VMIZrQBI4QxxELKUDldyi1b3jXA45WEW11985ADmDt+qLAG7RiLWMWqCj5QzKHEF6AsF
         6jAU4r+87rfoQU2WLLw0qSd/aBt5IhAmkReJDUplclKtjUOUq53nuVBCsAbizm0t1Cof
         harHQfL+ABubgtF+FOBVNEcvQBtV03tqCzDPv97ouIDmvEAX3lJFJcf54cwCVoGoOZXR
         N3jg==
X-Gm-Message-State: AOAM533ylRRYDrLrQNYtF3cXaaSx5kFAATOB84iHnsEB9VZumocxMHv1
        qDNEPLjeFcercrh0qk9XQpE=
X-Google-Smtp-Source: ABdhPJyhagp9to2mtAwdA6ErEpfc8xGN5letkxAA0MMYvoQImxKRAqu0ePqH9Pqx/HdmxRb1JIU5AA==
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr2422415ljl.69.1598040722687;
        Fri, 21 Aug 2020 13:12:02 -0700 (PDT)
Received: from localhost.localdomain ([213.87.151.123])
        by smtp.googlemail.com with ESMTPSA id v1sm572695ljg.60.2020.08.21.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 13:12:01 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: api: add kobj_to_dev.cocci script
Date:   Fri, 21 Aug 2020 23:11:37 +0300
Message-Id: <20200821201137.446423-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821153100.434332-1-efremov@linux.com>
References: <20200821153100.434332-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - "symbol kobj;" added to the rule r

 scripts/coccinelle/api/kobj_to_dev.cocci | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci

diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
new file mode 100644
index 000000000000..cd5d31c6fe76
--- /dev/null
+++ b/scripts/coccinelle/api/kobj_to_dev.cocci
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kobj_to_dev() instead of container_of()
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: kobj_to_dev, container_of
+//
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+
+@r depends on !patch@
+expression ptr;
+symbol kobj;
+position p;
+@@
+
+* container_of(ptr, struct device, kobj)@p
+
+
+@depends on patch@
+expression ptr;
+@@
+
+- container_of(ptr, struct device, kobj)
++ kobj_to_dev(ptr)
+
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
-- 
2.26.2

