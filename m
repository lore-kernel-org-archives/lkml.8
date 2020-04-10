Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6ADC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475A520936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490457;
	bh=otK5x4Ls3x9usVl63svp8ToBMJhcukjNtYux7ORX/Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNBciPpicRMT7aDVqct/Q6FWfTEjUvN44fZ/Jhr7h6NufpM6ZSPWArf0O66GeN9vb
	 JxjrqASHBWRThUr7BRDfAWJwSUgiyILlP2F/m4uyPmXjoIJJnr7A4rRVWHaGKekhf6
	 07fYCmcy7gWAT4JGUoNkJGbrkJEaAGCKI/j61+Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgDJDrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgDJDr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:47:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB0E2137B;
        Fri, 10 Apr 2020 03:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490448;
        bh=otK5x4Ls3x9usVl63svp8ToBMJhcukjNtYux7ORX/Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdvdLheplKy6o4pDIGqA5mmCZg1kge1fIqaMc92EjSswwEwu4ru6Q0PSqws9y77Tf
         2DpPQE7WIjrP+gjdmE9YKbi+M+HDdjXdDgJ2sNA+SgAK+qHVExjxaOUuLV4JhKvTZV
         Vevs0atuc75BEIzLmkEfYSqVuEwBo1OYvCtLZWQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     chenqiwu <chenqiwu@xiaomi.com>, Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 44/68] pstore/platform: fix potential mem leak if pstore_init_fs failed
Date:   Thu,  9 Apr 2020 23:46:09 -0400
Message-Id: <20200410034634.7731-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
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
index d896457e7c117..408277ee3cdb9 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -823,9 +823,9 @@ static int __init pstore_init(void)
 
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

