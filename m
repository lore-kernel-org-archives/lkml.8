Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA39C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496E02063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490961;
	bh=NupKDHaU0vDTr4mFGVn6du0MAD0o5CYqbcBOyesCm5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKE+obcBqUTPejeLahKGnJVW1KdcYfgZO+b8Iu1X476EjC/6Vja0AoprsUD0BxYcP
	 x8HNrYIlawqe2L4ieLfY8rFqdJctfQn0K0vl2M7Ns2eFTEZeY/5E7X9FEblolGkx4l
	 jYX0+5W0h0Q0CVduOmzrptWyC/gVuioLVA0Y6Hl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgDJDtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgDJDtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:49:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F1D214DB;
        Fri, 10 Apr 2020 03:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490579;
        bh=NupKDHaU0vDTr4mFGVn6du0MAD0o5CYqbcBOyesCm5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TDkgc04WBcHuxr0GgsE0JOhLig0zz0XM2+ha7bCn5PWwLsRsikb5goNRO8VI2epj
         FJLuO7j0JNPOlKLjEYQ6+yQnVCM7oWIE9FFfr5Gqsyv+K1OHgWvg7ubkUIlSYjQ7uK
         8p98Lj5pO9jR9tDPrOjVHPjzqLmjmzJSt7wIYy+k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     chenqiwu <chenqiwu@xiaomi.com>, Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 25/46] pstore/platform: fix potential mem leak if pstore_init_fs failed
Date:   Thu,  9 Apr 2020 23:48:48 -0400
Message-Id: <20200410034909.8922-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034909.8922-1-sashal@kernel.org>
References: <20200410034909.8922-1-sashal@kernel.org>
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
index 3d7024662d295..cdf5b8ae2583c 100644
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

