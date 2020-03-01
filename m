Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8B921D56
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4niIOWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCAPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:30:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44362 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgCAPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:30:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id a10so763859ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ubSe/iv847hRz3go2vcVkh5paHl2lJ7NU6C3tPrE1OQ=;
        b=R4niIOWre5oK0ZblTbLQzhTKf17NjJYu1fAvKbO8W+aBE05PXMYfrEKaT0rSMHY7mP
         A8Z1vGVG4MLqLJ+GohxngccxJQLR+wwr22XkTZJrQUEDLenEivFQFgcv7rNnkHLwchr5
         AtX/ZC+8Bm1QhBzIK+3aUg/4R/HweizU3kms3QlY1/W2tpWdyenNe+2gS7R+1OelNGKV
         X7g0gS3F9a8J775AiIRhDpBbPyoLHtlY9tC+a7xRAmHuhnTnSfp6N8elggF0mDL7kv5n
         kBWj0cvjyRFtl4Bi5jfIhzwiBQgtlPumWEpdUNJQQEzgLbJnMZ+OnffdGrbObGQSJ66l
         V5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ubSe/iv847hRz3go2vcVkh5paHl2lJ7NU6C3tPrE1OQ=;
        b=fbwizGrd99iXS+Ujt+98rxINwlbCu/Szt35kR1nZYaBlHPsnpkv+nlXDngVw/GKwRd
         HVEcx/ZQl2x6k5Uve7wV9t4yQJQh1pelVE9bBadJSRd1oIqKQwncK8UWW3zgVX+JGPEe
         xMC7N7smSccD/o60zRCxU9/IsKad+TSi9PWdI1RyxGnWF7nVR32pQfC6klWqzWAIS01P
         jLzcBQi23943kpb2tr8zRJc1CRyCSpS5OSuqox0H4r/MKP5kXARo0dUEmVzjDcG0pq9S
         RpOnvPvKOiWQKqQZSnoCGJEjCc8BoivEofyK7kp8nflh70bpCOySPBKnhdbJe8pc2t89
         kOQA==
X-Gm-Message-State: ANhLgQ0yz5K1wc6CT2huIJVGJEcVF1pTmJ3VyuKxtQWrotNxXqrnOVYU
        K1ffyPNfHqS7e65g+iFg2Wk=
X-Google-Smtp-Source: ADFU+vvxXRdE5Fwx+uniobYvAmhUEaO8QHObek2+depma7eZfhEd9ma0PDMBas/14gjCNSwz+8iJ8w==
X-Received: by 2002:a2e:3214:: with SMTP id y20mr8735810ljy.69.1583076633263;
        Sun, 01 Mar 2020 07:30:33 -0800 (PST)
Received: from localhost.localdomain (188.146.100.83.nat.umts.dynamic.t-mobile.pl. [188.146.100.83])
        by smtp.gmail.com with ESMTPSA id g21sm9876384ljj.53.2020.03.01.07.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 07:30:32 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, hughd@google.com,
        akpm@linux-foundation.org
Subject: [PATCH] mm/shmem.c: Clean code by removing unnecessary assignment
Date:   Sun,  1 Mar 2020 16:28:32 +0100
Message-Id: <20200301152832.24595-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously 0 was assigned to variable 'error'
but the variable was never read before reassignemnt later.
So the assignment can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/shmem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 31b4bcc95f17..84eb14f5509c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3116,12 +3116,9 @@ static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *s
 
 	error = security_inode_init_security(inode, dir, &dentry->d_name,
 					     shmem_initxattrs, NULL);
-	if (error) {
-		if (error != -EOPNOTSUPP) {
-			iput(inode);
-			return error;
-		}
-		error = 0;
+	if (error && error != -EOPNOTSUPP) {
+		iput(inode);
+		return error;
 	}
 
 	inode->i_size = len-1;
-- 
2.17.1

