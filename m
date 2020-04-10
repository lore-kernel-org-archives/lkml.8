Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC2FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D782063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490870;
	bh=LfWkDjywQCoxUu+49IHyA0f/oOATnPdQz1zBNlFyEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXJnOyt7MYqzqL6GCaJhz02pNYi//ke21Fc27E79wS0UyAPPFXc/UWzjY4ErI84wR
	 urLO/PWgMgFjJAWPBcbdQKcqx0IcPCyW0qYBunNskD2jOpxzaZoc9nRZo/97dwRRrO
	 F2kC4RL+XHN8B++xSY347fYjeBq2UxWUTScNJLrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgDJDy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgDJDuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:50:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C13206C0;
        Fri, 10 Apr 2020 03:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490624;
        bh=LfWkDjywQCoxUu+49IHyA0f/oOATnPdQz1zBNlFyEoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rL3umnWKRC41ZKNJeeiEASud1qTPWnlP56VIZQ2knkiZb/oeXPmKgS9mymQCPxTl0
         vwv5j6Ip0sQbLb3Bmk62QhPJa+dycAzdjJundhnyMRs6JqhqTE/+oUE2JETshxKzXz
         gykrjse5yI6cj+T+ftwl/XBnd9Tf3Q1pt6Xc6bgc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     chenqiwu <chenqiwu@xiaomi.com>, Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 16/32] pstore/platform: fix potential mem leak if pstore_init_fs failed
Date:   Thu,  9 Apr 2020 23:49:49 -0400
Message-Id: <20200410035005.9371-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035005.9371-1-sashal@kernel.org>
References: <20200410035005.9371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

[ Upstream commit 8a57d6d4ddfa41c49014e20493152c41a38fcbf8 ]

There is a potential mem leak when pstore_init_fs failed,
since the pstore compression maybe unlikey to initialized
successfully. We must clean up the allocation once this
unlikey issue happens.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
Link: https://lore.kernel.org/r/1581068800-13817-1-git-send-email-qiwuchen55@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4bae3f4fe829d..dcd9c3163587c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -802,9 +802,9 @@ static int __init pstore_init(void)
 
 	ret = pstore_init_fs();
 	if (ret)
-		return ret;
+		free_buf_for_compression();
 
-	return 0;
+	return ret;
 }
 late_initcall(pstore_init);
 
-- 
2.20.1

