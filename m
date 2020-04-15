Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45220C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D4F20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955645;
	bh=YMmXqky6rmP92ItU3MKEGwQVyOGLaDsUIhUp21CgvFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/pI7D3SevyJz9reuiZjUos0ueDd+6VxcFBLqUvd+rznWqYlzicYejSszpKyVIy4I
	 JqGJPBvznGE9NauHkqRoN9NrkLB3ksO4XdMyUeWcat/vjJ138f75+pRZt3rReH+w0n
	 1copOws8nGwFVqcd91LesR8FL8L/5ihn/VlgBWbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505707AbgDONAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897176AbgDOLgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FB520737;
        Wed, 15 Apr 2020 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950600;
        bh=YMmXqky6rmP92ItU3MKEGwQVyOGLaDsUIhUp21CgvFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2vhJ/LkRGvEUrizTa+zytw+yrN3BrmRApvbdtg90Q5n9h0CPL7S4/s5ruQitycoy
         6BP210gL7YVKSkxS5C4CDpdBY6R7VT+yLVe8BmaIHBzQ3aD57o8P9VzeqCOEc/KioT
         ciSXbXmAUHF6YyhoxT+jbwrHmJj8fG8Pomc6Leeo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.6 096/129] f2fs: compress: fix to call missing destroy_compress_ctx()
Date:   Wed, 15 Apr 2020 07:34:11 -0400
Message-Id: <20200415113445.11881-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 09ff48011e220e2b4f1d9ce2f472ecb63645cbfc ]

Otherwise, it will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 927db1205bd81..1a86e483b0907 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -395,6 +395,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		cc->cpages[i] = NULL;
 	}
 
+	cops->destroy_compress_ctx(cc);
+
 	cc->nr_cpages = nr_cpages;
 
 	trace_f2fs_compress_pages_end(cc->inode, cc->cluster_idx,
-- 
2.20.1

