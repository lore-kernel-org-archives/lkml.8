Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5003C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66372073B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 21:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7A2sf3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFGVV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 17:21:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25776C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 14:21:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so15463199qkn.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cQSDj+7so0T7k1BgVBgs5wD+MuPzNckE4uP70HqryA=;
        b=h7A2sf3NAFTKXBS9IbbBTbxpix/3Z+143NnMpVxGCJwoaqM1q8hQkqbA4rnMHSIzDO
         h6c64ZVJKN8EILdtQ67iu+lXtiaAd3/H/M6wmyxlkprIBa12rxSUKEIAzajVDZo1qtwa
         oGGc60tfPpdosZKNA7K80bQNCRuWXf3Dd8PH6h+UqFvc83bcwNF4Esllnj2asBC2iQfF
         +pRe8Vj523Rjmo0XYvcvpLjkACtJJndqtpOSnbmwPuVzL9e/RirY7QJaBIVUYRL34EJS
         JR1C+xdJcECs2fu9fcEjb1ckJdene5PpU0MY8moBDJkYevOeU+pbty2zgF3GPW6NGjuM
         kqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cQSDj+7so0T7k1BgVBgs5wD+MuPzNckE4uP70HqryA=;
        b=LxtSm9shcFldhh8lTLocz5tQpb9HyeOXBtL+lgkGZrM+AL4NX9wQ4oYjgLiQz9pePU
         D3SDV+mPIxS72ZodbJq+4uR7nuQO2rAMRh0nAQWD4S+061vKGb3/rGfai0wd9K7r8oM/
         gSb4Sei3Ov6EMOh5W7kIFy7A7iDeUpTsS61p96/0ujF0FRAnjb2Xv6I2TfOOKWPaDIkD
         po8rYGruEfeq7TEQTUhipdq3nglvosEIiuWdHrA7a7BkkB1EzSFRPzIfsy9QLhjFz2vF
         nlRIVIuolHlxTPFbLDXTT8pGciJfXFIVHrE6jYpsY21cMjxg+mBvt4tpr9YNZo7yinQz
         z9dw==
X-Gm-Message-State: AOAM531Gx4Z8XQO3Z689CnJsO7z7rjOvejrA/b/5JueFZ8o6sNUjPbvo
        xb7eP4WFXGPGfqrZ80fLqQ==
X-Google-Smtp-Source: ABdhPJw28PBaLu+3wXhVyEXsCdhxptWAexRVhvPQRHuom5rxKCtjuttJ1zq1/6pTjbui1hXdkXSI0A==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr19222688qkj.456.1591564887161;
        Sun, 07 Jun 2020 14:21:27 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id g9sm5786880qtq.66.2020.06.07.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 14:21:26 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     Keyur Patel <iamkeyur96@gmail.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ocfs2: fix spelling mistake
Date:   Sun,  7 Jun 2020 17:21:14 -0400
Message-Id: <20200607212115.99278-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./ocfs2/mmap.c:65: bebongs ==> belongs

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 fs/ocfs2/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 3a44e461828a..39a77e903fdf 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -62,7 +62,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 	last_index = (size - 1) >> PAGE_SHIFT;
 
 	/*
-	 * There are cases that lead to the page no longer bebongs to the
+	 * There are cases that lead to the page no longer belongs to the
 	 * mapping.
 	 * 1) pagecache truncates locally due to memory pressure.
 	 * 2) pagecache truncates when another is taking EX lock against 
-- 
2.26.2

