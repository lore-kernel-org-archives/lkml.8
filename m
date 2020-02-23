Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF29C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6368A20880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD4d+gFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgBWXSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36880 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgBWXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so3978151wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFuxxisMEYe+/8U1Zym099JlZSOgE3VEttxnE0HXI0I=;
        b=UD4d+gFyw0o+T97IJacOMIMKhMEsSWf7Xgels8RhPpisxO+jHkOTmu//OBuNrNCBlI
         TvAvQeBYrI3U+tGvbEOUUY022mdZfjFAMqi2ORR9WYsuZu97YRHueeWuFpZkBgLP7DwI
         OskSFocZVnXw4TX89MbbUxHkRgVkxaqzHiZ9qurCs4c6SZ7vKlKeltlAmxOCY9WEA2/d
         MVyVjnGJRTQcWRPcvQuZ4dh2bhZPRYNAunhI0xtS/I0NwHJ769jdeYgvwxo+zq9IyA7J
         h0cCZrkyPy+YJKcxzf3CMwQP/4tQppiyov4Fnot/RmxLPVWt0Qf/3VJszg0PVsVIAy+v
         r4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFuxxisMEYe+/8U1Zym099JlZSOgE3VEttxnE0HXI0I=;
        b=TspGrz6FJrQ9B3N1DXWAA9o00IAzstd0Naek7uvzAPuXKEF1vPHXIleXJ0ZT1jtxZV
         AfpVC6h/YwCiAg4MGEetHNPPDQIIZgmQfxQDs6yfR5u+IsNoRG3N9gpykHYKFfHuPczC
         7SwMOHvyVVOAoasl4Bn4WWZPTDrFwSLowRxD3o9AIjtbl4hQo96+N8WPmJHlXKMs+SuW
         ypd/vKxgmG/I6OqXUbZr6auMPjlPOiQbWNY5dItSSWy5TtLvYFFd1KoAX9Z3RHJdXoes
         XcVogB7fM1uf8KgJdFT/d6douXasyTE6o2hi6zoLyJg1LqOw3zJ+WKnwqYic3neIV8PU
         xgKw==
X-Gm-Message-State: APjAAAXNsbPLQOW6Y77PulfS+o+gKVny5YrvILaZ83kXlibqgZWGy0j9
        T/Z80a2soRf8Qb3knLZxfQ==
X-Google-Smtp-Source: APXvYqxAVsgm/trM7tHezLYbyeZyvVRYc8Us2IcaAJzj4wvZPBZUg0JJkJCal/cy2Jx4heZRTDzIvA==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr61778973wrm.24.1582499916943;
        Sun, 23 Feb 2020 15:18:36 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:36 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com (moderated list:ORACLE CLUSTER FILESYSTEM 2
        (OCFS2))
Subject: [PATCH 30/30] sgi-xp: Add missing annotation for ocfs2_inode_cache_lock() and ocfs2_inode_cache_unlock()
Date:   Sun, 23 Feb 2020 23:17:11 +0000
Message-Id: <20200223231711.157699-31-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at ocfs2_inode_cache_lock()
and ocfs2_inode_cache_unlock()
warning: context imbalance in ocfs2_inode_cache_lock()
	- wrong count at exit

warning: context imbalance in ocfs2_inode_cache_unlock()
	- unexpected unlock
The root cause is a missing annotation at ocfs2_inode_cache_lock()
and at ocfs2_inode_cache_unlock()

Add the missing __acquires(&oi->ip_lock) annotation
Add the missing __releases(&oi->ip_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/ocfs2/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7c9dfd50c1c1..0b87e0a63ab9 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1623,6 +1623,7 @@ static struct super_block *ocfs2_inode_cache_get_super(struct ocfs2_caching_info
 }
 
 static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
+	__acquires(&oi->ip_lock)
 {
 	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
 
@@ -1630,6 +1631,7 @@ static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
 }
 
 static void ocfs2_inode_cache_unlock(struct ocfs2_caching_info *ci)
+	__releases(&oi->ip_lock)
 {
 	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
 
-- 
2.24.1

