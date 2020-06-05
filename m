Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439DBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB6A207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFESPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:15:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44733 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgFESPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:15:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id w15so6324070lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 11:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzTrpawMm7O0gb9SBDejxurvPz9n3lKWKd8gdwMZTqc=;
        b=WCaVSD5i/+hKGKvBtmaugqxlnzMO3TMBtHQeYag8IeCReKonEmrsnL1Y9S1tUofgWb
         zSytchCsGAmKrDgK+tX7bfRZdfy0Lm9ephsWR1YTv/omK3BHNuBAwcRQYqaanqmrOCXu
         n2h7C0hBEfrPKqDEq6HvjMyD1XV/gGk6xd2oS1da90ZNx8sMh3WaXMVei7BbVSnE8Mj0
         UU9GFAEYJIA2ie0VpGjUSBMmy6cm8djqZNnp75vF13D3wG7d0FOcNLFqmgyh4dxHc66J
         h/Ji7f/gg+jWLu0CYNyCa83UxVKllrbHDMMNgl9SpuuhywS21kqrvNjcPgTJxUXucBl/
         s/kA==
X-Gm-Message-State: AOAM530b7IuvWzsIwLWjvbj0bq2WledidHIZKSjf0PYjqxlgSq1Zicsu
        wrisw4WLOLmJY9ENXCFz68YKk31DdPE=
X-Google-Smtp-Source: ABdhPJzS0ySE70abv12q8PAXQnaxqUsoCsmWcoB6VQxt9iAJI1Oi5J6udwx5tG9MKHTxOZrZWfbTgg==
X-Received: by 2002:ac2:5481:: with SMTP id t1mr5967357lfk.102.1591380945576;
        Fri, 05 Jun 2020 11:15:45 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id x69sm1254625lff.19.2020.06.05.11.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:15:45 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] f2fs: use kfree() to free sbi in f2fs_fill_super()
Date:   Fri,  5 Jun 2020 21:15:33 +0300
Message-Id: <20200605181533.73113-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181533.73113-1-efremov@linux.com>
References: <20200605181533.73113-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree() instead of kvfree() to free sbi in
f2fs_fill_super() because the memory is allocated with
kzalloc() in the function.

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a3c8eba37e2..39b644c7e9d4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3812,7 +3812,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi);
+	kfree(sbi);
 
 	/* give only one another chance */
 	if (retry_cnt > 0 && skip_recovery) {
-- 
2.26.2

