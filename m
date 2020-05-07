Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FE7C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33A520725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgEGWA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:00:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44025 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEGWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:00:57 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jWoYZ-0002Hh-5d
        for linux-kernel@vger.kernel.org; Thu, 07 May 2020 21:59:51 +0000
Received: by mail-qv1-f70.google.com with SMTP id w9so7138939qvs.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1x1mENpHEP5ot+awSAobGm/a7Ebe1DwB7eQXcB2jvE=;
        b=nIR5TJSE2dIRLAN0LlDn0padDAEieS86jQCu+008zKve+6f5v2rmEUb/UGyFin+ZwL
         NxgHMOwor6VQj2UK+CqiZYtUcDbTBe3t1wFSCMjAzbN8VBbyrtxWMVcjtjMAiLuAOZ1S
         NfawSqGDg4BWUuxoiwii0AbNVnOXXFq02ofVdsV+M52WPR0CZaPtRi8SQYR7SbtovPkl
         yaa7gyIY0jBTPPu38lFbd9iZXFmkMXLSPcbw0d6FWC3n3Lw1DIR2FZ8bcokk7PPXc5WK
         W6UaJLNejPC5K0utEhcUpvIkQV2E/nT1vZ3Jqlv13+mSid63ro/oyGiqCPm5Cyk3e1+C
         7QpA==
X-Gm-Message-State: AGi0PuYFqXWGzj9UjLgnETQeCDG7X30fARXC+G1qlfYT+j+plI8T9+Jc
        Lh+Gj+kE7bB1YTnS/BkLbLKHRkZ64LzL1zR/F434vNvLCQkHKSkKoF45Rr/Db/2Dz4OzJIqvd8y
        OE7tl4OiLxLSzRum5my7wFBPfTgyt/frcWykb6eStUA==
X-Received: by 2002:ac8:3406:: with SMTP id u6mr17008908qtb.100.1588888790307;
        Thu, 07 May 2020 14:59:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypKn7P+ZsPdBMfKkEheTB/2jdeakLAD1SUCaoK4gDmyBjSnrHINZlGPF+3PHlV/bvJU2bVvvZA==
X-Received: by 2002:ac8:3406:: with SMTP id u6mr17008882qtb.100.1588888790043;
        Thu, 07 May 2020 14:59:50 -0700 (PDT)
Received: from localhost ([187.56.73.116])
        by smtp.gmail.com with ESMTPSA id 33sm5208928qtc.82.2020.05.07.14.59.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 14:59:49 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        gavin.guo@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net
Subject: [PATCH] mm, compaction: Indicate when compaction is manually triggered by sysctl
Date:   Thu,  7 May 2020 18:59:46 -0300
Message-Id: <20200507215946.22589-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have no way to determine if compaction was triggered
by sysctl write, but this is an interesting information to have,
specially in systems with high uptime that presents lots of
fragmented memory. There's no statistic indicating if compaction
was triggered manually or ran by Linux itself, the vmstat numbers
cannot tell the user this information.

This patch adds a very simple message to kernel log when compaction
is requested through a write to sysctl file, and also it accumulates
the number of previously manual compaction executions. It follows
the approach used by drop_caches.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---


This patch was based on linux-next/akpm branch, at d0f3f6070c3a.
Thanks in advance for reviews!
Cheers,

Guilherme


 mm/compaction.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index fb43e731ac31..80e748b0bbb6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2465,9 +2465,13 @@ int sysctl_compact_memory;
 int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
-	if (write)
+	static unsigned compaction_acct;
+
+	if (write) {
+		pr_info("compact_memory triggered - it already previously ran %u times\n",
+			compaction_acct++);
 		compact_nodes();
-
+	}
 	return 0;
 }
 
-- 
2.25.2

