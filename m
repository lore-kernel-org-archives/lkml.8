Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC5020706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHXM5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:57:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47083 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHXM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:57:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id v12so4209177lfo.13;
        Mon, 24 Aug 2020 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmefo9JeNKbiRxEroXLrRSeRCr+DW21/6Xw4UwzMQoc=;
        b=XcKMfPCEpXGeYjpqTmoaXolEKE/Ivw/H1eykj8pfM7ZYKbv2kf93GuTy0GlPL5r7tf
         mhNYlITtlA2qU1TzVpRoN/STVT6I4Bix+G6hbbQ524s2bINamWMzscCB11E5wRojTv41
         xacrMeFKBgS7cpfwZgaekoo2V4UYjxNVpdiZAJc4D7xfMIylJ4nmgX3pK7kfMYRlUYFU
         5HWMdarsdfFS27PSN0p3fe2V4hI8za2O586oUwFmEnyu8SZ5S4wXGikHyA6KWLEHtTVa
         nkwPX6VDGtEw6VAfa3Sa3G6UGAyqgWSPWpfZImhodl/xMiJ0UtU+j+kNibsTYNB8VucV
         2hsw==
X-Gm-Message-State: AOAM530qxg7LlFbAjSUznbp4I7dlfCBUxJ6WftbS8YsakrLVrGXC5tOv
        3wMAJJTGlmkc1+ezw2rLgeI=
X-Google-Smtp-Source: ABdhPJxtnD6qvH6S/v6pUQKAXjJ3kPM7Was6MUf+d493WDabRGlk5LdXUSSZL6wSpamAK3++ZnAtrA==
X-Received: by 2002:ac2:46d4:: with SMTP id p20mr2560894lfo.109.1598273817247;
        Mon, 24 Aug 2020 05:56:57 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id z18sm2171906lji.107.2020.08.24.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:56:56 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] namei: use current_fsuid() in may_follow_link()
Date:   Mon, 24 Aug 2020 15:56:32 +0300
Message-Id: <20200824125632.487331-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify may_follow_link() to use current_fsuid()

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7..1a47c9d8ce13 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -958,7 +958,7 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
 		return 0;
 
 	/* Allowed if owner and follower match. */
-	if (uid_eq(current_cred()->fsuid, inode->i_uid))
+	if (uid_eq(current_fsuid(), inode->i_uid))
 		return 0;
 
 	/* Allowed if parent directory not sticky and world-writable. */
-- 
2.26.2

