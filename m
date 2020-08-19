Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C261C2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597824033;
	bh=UKcRSGUs9osnVCmOgLuXwzMZc326OMLm9uylAeaY14c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kbBmu8d25sjKygC7HiWJtyJVHzg5VbasEbaET7xU7o6Ny293630x/xgt2g6OiNhBT
	 9R+9C1uTcpAFuiz3K2hGQEkNVfYvNmetSApui2b7GpyydmcmnkeGC7xCLkKISxy3YI
	 ABi9dUmXbEXSZqEYTS7dCcRw8elclk/+3pE/4hJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHSIAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgHSIAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:00:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6892067C;
        Wed, 19 Aug 2020 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597824031;
        bh=UKcRSGUs9osnVCmOgLuXwzMZc326OMLm9uylAeaY14c=;
        h=From:To:Cc:Subject:Date:From;
        b=bbDsZCFr7dFcolGF9dkSwppOc+T9hVMu9eYsofS/IysNbLT/0P9uah6LP8JJklxbz
         XKiIKwvfR1XwyNP133DmpZdYrJNK6IbxsPOZYrx4N1pRCmjkDexfxlrsXnIAKSfxsz
         Ul7zh0bap4pwhoRfdH0NmnvO8294WmXka7xKjHLE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix missing function declaration
Date:   Wed, 19 Aug 2020 11:00:26 +0300
Message-Id: <20200819080026.918134-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The compilation with CONFIG_DEBUG_RODATA_TEST set produces the following
warning due to the missing include.

 mm/rodata_test.c:15:6: warning: no previous prototype for 'rodata_test' [-Wmissing-prototypes]
    15 | void rodata_test(void)
      |      ^~~~~~~~~~~

Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 mm/rodata_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 2a99df7beeb3..2613371945b7 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt) "rodata_test: " fmt

+#include <linux/rodata_test.h>
 #include <linux/uaccess.h>
 #include <asm/sections.h>

--
2.26.2

