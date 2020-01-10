Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD77C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344162080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XvXJIL50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgAJOvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:51:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38215 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgAJOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:51:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so2108899qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dP+yKJgC1PvcZ6U9Dq2dx4CeTIqnBT2BpMb+Wm9xBlI=;
        b=XvXJIL509aqMK2SYSrcuBHs3ubP49aSVcCcSnaLIVODThTeP9V7pW0nppWBOxcYAFa
         bjB4oOI3tAwc/h00HrwKTxD9G0UO1Lph0w6EKUqapEElolCyhF4Hf6oZ9FjVSetVEUdm
         O3JiR6QqZ8scDs44UW6b1b7U9cb13OfMwy/gFmwtV9CEegOsqB6RKUc0a72mfBUhejf4
         UigXKGLEtJigBM89KHaZovH43iToYo0COVkWVSQ9RFLznGLPm90tlcoKptpf0ur0fUlL
         DkJf8j4lx18+xVYkPyPNcnU2D3iwCSIoMQdS8fnzDRxhmmNsOI967yfdLiXyWadXNgUa
         KCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dP+yKJgC1PvcZ6U9Dq2dx4CeTIqnBT2BpMb+Wm9xBlI=;
        b=hCCabo4V+qykNFMzXaxKZaGjIyITWmHi4L5yqEaAPk9OWv7f46FHY2ShniWlbUDRCJ
         SBqR741oME+qPvrkDSiEeUpgaQ7UzgenakCNwYuznwdziKbQYacKj0Op3TxvQpSFPZaG
         rQ8PVpv2z5/hfwB6GWFFm3YoFpMkF+Ju0dRdmRh/dUuR68TotGl15VvrNaY2krHG4lXD
         UrlnGYXBMnvvp6byxRxTtPKdoOCcLSKx4wXWB1D5binfuUbGgXVJygyYvkQBReoCSsIc
         ln5QsvleAXpA9YgUhj8w1Ud55M55sH/BdNQHFJRebnsMlVqgOQDGJSvI04nafiInv7Wt
         bXZg==
X-Gm-Message-State: APjAAAX3ehPqy1/4GeBSBlxwu0mTDuzZyUoOZhA7AtymmWWpkgl31Wnz
        M6fVzEXdtQgjmk294paYwrVZew==
X-Google-Smtp-Source: APXvYqx9tJ3xrVEVF5uE1eywbilOUQ3Qf7BtHeKw64SIwazRSBjH4hEsmA1DxrDcg6Xwsp77x30DnQ==
X-Received: by 2002:aed:3ee5:: with SMTP id o34mr2772503qtf.164.1578667877943;
        Fri, 10 Jan 2020 06:51:17 -0800 (PST)
Received: from ovpn-123-250.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z4sm1093288qta.73.2020.01.10.06.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 06:51:17 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] arm64/mm/dump: fix a compilation error
Date:   Fri, 10 Jan 2020 09:51:12 -0500
Message-Id: <20200110145112.7959-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "x86: mm: avoid allocating struct mm_struct on the
stack" [1] introduced a compilation error with "arm64: mm: convert
mm/dump.c to use walk_page_range()" [2]. Fixed it by using the new API.

arch/arm64/mm/dump.c:326:38: error: too few arguments to function call,
expected 3, have 2
        ptdump_walk_pgd(&st.ptdump, info->mm);
        ~~~~~~~~~~~~~~~                     ^
./include/linux/ptdump.h:20:1: note: 'ptdump_walk_pgd' declared here
void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm,
pgd_t *pgd);
^
arch/arm64/mm/dump.c:364:38: error: too few arguments to function call,
expected 3, have 2
        ptdump_walk_pgd(&st.ptdump, &init_mm);
        ~~~~~~~~~~~~~~~                     ^
./include/linux/ptdump.h:20:1: note: 'ptdump_walk_pgd' declared here
void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm,
pgd_t *pgd);
^
2 errors generated.

[1] http://lkml.kernel.org/r/20200108145710.34314-1-steven.price@arm.com
[2] http://lkml.kernel.org/r/20191218162402.45610-22-steven.price@arm.com

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index ef4b3ca1e058..860c00ec8bd3 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -323,7 +323,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, info->mm);
+	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
 }
 
 static void ptdump_initialize(void)
@@ -361,7 +361,7 @@ void ptdump_check_wx(void)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, &init_mm);
+	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
 
 	if (st.wx_pages || st.uxn_pages)
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
-- 
2.21.0 (Apple Git-122.2)

