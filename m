Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FBFC38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC5020732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3YSlCQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBXUl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:41:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:41:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so758938wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myk+lKJeHf/NwI1kOPcB/C/w3kbJudSAOTZpQWJrDy0=;
        b=b3YSlCQ2DhhT1QITJ97tuveUx5HUmQqLdz+spOgtQuuIvUoj1TPqRO4qJlnLa23T1Z
         GiZpa8KTn9prX+n5E6DpWEAz2eqSSYyKpO0MUthh+HNLxA0AdTppyHboDMcQQ/YhPrfN
         x8mjqUzAydJeQAEdpPphmdJzWI2rPQdduCVC6nCHL464zNbXsv2t4ojssmSiXwmaqfIR
         uTNYBh8gsjTxzI+BZWsaDfZN3MRjHEuKeKs1extqa5Irj+Mj1q2YDPQqejRXiXNqU9fS
         Folm1MWgCiceFpz6pol6s5uVGD5hNnQ3HFLR0k1nA2qJIPe0dZUplLTCvRUz/dwehhg8
         CQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myk+lKJeHf/NwI1kOPcB/C/w3kbJudSAOTZpQWJrDy0=;
        b=hwZ++Dl8HR8iXPXUwjTk8yue9eSsQoAaJCrSUrPxmweEMQlLxBt1queOOXiWG2vfyj
         oYZkRlQLVH0/WU/Ti0TaLjqHBLohgpH+WlrJf2nNlaeXSIyNdBMsHoLs6V4dDRO9nxyr
         8JS4f/VcE0qsDeQjUdrspfFFoloDQreWl+VsRqC//CJ0kwMVj+5zBng3eIO6oVC9nNOH
         HsltwGcXDeHvvRgxeh+lAS/d9HR5XHfnWL2HGcUSAzbfFjD8wh4rTd/JPBq4Xg5t3C3g
         Mpc83Qd57kDetJithA4aySKCciTr4TKqeOsethK2aeNSkBsdm70r43Amb/HhYCZwkUez
         QFqQ==
X-Gm-Message-State: APjAAAXvjbyN5SXJz3Q5C/Y8FCkVzPp8VAz1qp9RfmZ+n7p8RWz2hkk7
        huyQQjeJd57kzfgVUIpT4A==
X-Google-Smtp-Source: APXvYqwzyNh4fYpdcAkxTPstW6qmCCTN7eutGDv0MC2GBY2COJ6PGJe9MKA9fPgywPp0f4VI/LSMxA==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr796422wmr.72.1582576914733;
        Mon, 24 Feb 2020 12:41:54 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id h128sm863315wmh.33.2020.02.24.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 12:41:54 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     joseph.qi@linux.alibab.com, Jules Irenge <jbi.octave@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com (moderated list:ORACLE CLUSTER FILESYSTEM 2
        (OCFS2)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ocfs2: Add missing annotations for ocfs2_refcount_cache_lock() and ocfs2_refcount_cache_unlock()
Date:   Mon, 24 Feb 2020 20:41:30 +0000
Message-Id: <20200224204130.18178-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warnings at ocfs2_refcount_cache_lock()
	and ocfs2_refcount_cache_unlock()

warning: context imbalance in ocfs2_refcount_cache_lock()
	- wrong count at exit
warning: context imbalance in ocfs2_refcount_cache_unlock()
	- unexpected unlock

The root cause is the missing annotation at ocfs2_refcount_cache_lock()
	and at ocfs2_refcount_cache_unlock()

Add the missing __acquires(&rf->rf_lock) annotation
	to ocfs2_refcount_cache_lock()
Add the missing __releases(&rf->rf_lock) annotation
	to ocfs2_refcount_cache_unlock()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/ocfs2/refcounttree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index ee43e51188be..da99c80f49da 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -154,6 +154,7 @@ ocfs2_refcount_cache_get_super(struct ocfs2_caching_info *ci)
 }
 
 static void ocfs2_refcount_cache_lock(struct ocfs2_caching_info *ci)
+	__acquires(&rf->rf_lock)
 {
 	struct ocfs2_refcount_tree *rf = cache_info_to_refcount(ci);
 
@@ -161,6 +162,7 @@ static void ocfs2_refcount_cache_lock(struct ocfs2_caching_info *ci)
 }
 
 static void ocfs2_refcount_cache_unlock(struct ocfs2_caching_info *ci)
+	__releases(&rf->rf_lock)
 {
 	struct ocfs2_refcount_tree *rf = cache_info_to_refcount(ci);
 
-- 
2.24.1

