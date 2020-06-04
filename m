Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C822C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5257207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgFDOIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:08:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37521 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFDOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:08:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id e4so7488502ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XEypNhNnT+UKcy1b1PvwbnH+QucPWD84O3G9vxNRDY=;
        b=WSjAhuJhy0icWaMdRwZWcOeGIVT4Oxmg3Ubw9cqOkrvtf9mK0Zm87ORLkRCk7KQU/D
         CzZIyd6E69X9+n/LTUZmCtRQO6z7UdRSgoRMg1HplTrXuR+8ntu6mf7BX5OUczk/0kSO
         Tmp9AFon05+qaIas8ZwOY3FXIbbWqWEecBqLcGI4uuBiKL9dfSWU5TOKjKgYiP+8T+k+
         7TgwwOwP9CiQQItltEBV1Npn3vMWaPGCpvBrTAodNlestP1RiXtB2Z2HNXgHtw5OL/LP
         S4Srt+y9lCexttFka34SkUaGPd7dypAfHn055TU+qmXk3FRBXlGO73l0RaVyhnmG3DjP
         0/Cw==
X-Gm-Message-State: AOAM530BB4DxfEoHe2zjOZEFym9ElSko7n6pBBFrISnc+C4KwO6ze5ld
        41F5MQ2SwjvDtrU7VGyC6Q0=
X-Google-Smtp-Source: ABdhPJz9HUDfF6IfPeO7FOB6cVHTiPQE+UUfUHaNhd/awncMoLi7YDormQhrTauiRh6hIjY5qcIxvw==
X-Received: by 2002:a05:651c:547:: with SMTP id q7mr2054309ljp.437.1591279700104;
        Thu, 04 Jun 2020 07:08:20 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id w6sm1142864ljw.11.2020.06.04.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 07:08:19 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: add kzfree script
Date:   Thu,  4 Jun 2020 17:08:04 +0300
Message-Id: <20200604140805.111613-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for memset() with 0 followed by kfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Patches:
1. kzfree in drivers/w1 https://lkml.org/lkml/2020/6/4/438
2. kzfree in drivers/iommu/ https://lkml.org/lkml/2020/6/4/421
3. kzfree in drivers/scsi/ https://lkml.org/lkml/2020/6/4/442

 scripts/coccinelle/api/kzfree.cocci | 53 +++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..c6b8f7676af4
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kzfree rather than memset with 0 followed by kfree
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: kzfree
+//
+
+virtual context
+virtual org
+virtual report
+virtual patch
+
+// Ignore kzfree definition
+// Ignore kasan test
+@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
+expression E;
+position p;
+@@
+
+(
+* memset(E, 0, ...);
+|
+* memset(E, '\0', ...);
+)
+* kfree(E)@p;
+
+@r1 depends on patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
+expression E;
+@@
+
+(
+- memset(E, 0, ...);
+|
+- memset(E, '\0', ...);
+)
+- kfree(E);
++ kzfree(E);
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kzfree")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kzfree")
-- 
2.26.2

