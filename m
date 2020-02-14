Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F31620637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700177;
	bh=VjGmQW4ZaEIwBplxGXhjzp+VjZggaABay/iw0AmQNss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1OFw1OcSLO3Gk9jsc5I2qn9RrfEiOsbF4VT/eYAibyYMyo5xpsXzgIJxO4QVg8Vbv
	 lX6SOh+5gvQ3gZrPEbB5n5IumtNZsKfdMk3/VhuuxJihyXLMFbGGBo26orkIF2qg2x
	 xehG9DbJMreQJfe5Oaeqh5Ek6x7a5f/NqsIzMvrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393976AbgBNRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392218AbgBNQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135AB246CC;
        Fri, 14 Feb 2020 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696830;
        bh=VjGmQW4ZaEIwBplxGXhjzp+VjZggaABay/iw0AmQNss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0L97qoQ3Wgn674naHHVwpJYS25nh1nLNLVDHUre5Eyta1+CAUh5LeLBKFAkFi24bY
         1Wyivz7Yc0tnO1pymsd3yL/C9q+jm9OskIrVXQk/2/dia7obTpo+fuOfphotH0n8g2
         u0sM3+3oMsym+ETOUk101K0cZexfjed5jGvgN9wI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 096/252] reiserfs: Fix spurious unlock in reiserfs_fill_super() error handling
Date:   Fri, 14 Feb 2020 11:09:11 -0500
Message-Id: <20200214161147.15842-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 4d5c1adaf893b8aa52525d2b81995e949bcb3239 ]

When we fail to allocate string for journal device name we jump to
'error' label which tries to unlock reiserfs write lock which is not
held. Jump to 'error_unlocked' instead.

Fixes: f32485be8397 ("reiserfs: delay reiserfs lock until journal initialization")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 6280efeceb0a2..de5eda33c92a0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1954,7 +1954,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 		if (!sbi->s_jdev) {
 			SWARN(silent, s, "", "Cannot allocate memory for "
 				"journal device name");
-			goto error;
+			goto error_unlocked;
 		}
 	}
 #ifdef CONFIG_QUOTA
-- 
2.20.1

