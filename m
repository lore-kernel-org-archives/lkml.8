Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E2C3B1BD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E77C24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581706740;
	bh=3g/vPR1HVaaTZ+7nebbZDxLTqe8TuTFwsIwIOwOIBlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jtFFESgIsS0x5iLbZcE0MGQWXGS9eIr5xMCOkWEZazh2VslnRFmG0AKbwNNS5habz
	 26Spw4cRJd3eEWINikYP/29bahcSJgxjfOCkY0U7YUu8S+F8pl3Z9dhtChsDEXa/Xs
	 qK2AkFCNZPofrGDPE/0VW2LBpRQZ0u+Ccvq0wGNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgBNS67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgBNS66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:58:58 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755A62168B;
        Fri, 14 Feb 2020 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581706738;
        bh=3g/vPR1HVaaTZ+7nebbZDxLTqe8TuTFwsIwIOwOIBlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYPOmT0wjyai78N5uGcYj3LSCbfJuabxCruqDX3QyxlmUJDnL/qJyCIIxiiERDQxy
         R1dKCHmBs4Rl5fcrRhwNe325fijbinZJbL8n9y1cm7uxEFLEZT0EydFb10kaLuhOW2
         PbDINOUs1vq5SCJdg72sdVsL03AG4VmGDzXbqISo=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: skip migration only when BG_GC is called
Date:   Fri, 14 Feb 2020 10:58:55 -0800
Message-Id: <20200214185855.217360-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214185855.217360-1-jaegeuk@kernel.org>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FG_GC needs to move entire section more quickly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bbf4db3f6bb4..1676eebc8c8b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1203,7 +1203,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		if (get_valid_blocks(sbi, segno, false) == 0)
 			goto freed;
-		if (__is_large_section(sbi) &&
+		if (gc_type == BG_GC && __is_large_section(sbi) &&
 				migrated >= sbi->migration_granularity)
 			goto skip;
 		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
-- 
2.25.0.265.gbab2e86ba0-goog

