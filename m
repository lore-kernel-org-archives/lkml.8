Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD4C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C028F2076D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbumPayO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgGLDbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 23:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgGLDbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 23:31:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E1C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so5676287pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CSSDnsVzCbm4HJvWsVbXXkGEs9xedyGKl/Rt6nKFdOE=;
        b=dbumPayO/fDTRmwmbfWoGMopnkBa2rTRRdhdRZxImMg+IAEJ4iJ8xxqnf4pNPHIBg1
         Twl174xM19B2sWzwefd5I9eq27cj5l4WVLLgvH8RrIDAYsmA5AKM/GXypd5+wBM+d3m0
         b34IyrConj/4kSOSkZLRoYbZzX/ILotrFvuLHy95osDmsX2ON1+iwKFO8738TKSReZYJ
         2C7jOsaov4l/WQlCt1iLyoWVRE7qOPoZ20O3E9H/PPRrrQd7alB/0C/ybSJlCGcI7Ou3
         aoh4/zO9wrDfQLZg6SgO+lQTHtcB2q2Xm6GAxchCvbsre8RS+cGwptniFoffEJI5O9D6
         h6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CSSDnsVzCbm4HJvWsVbXXkGEs9xedyGKl/Rt6nKFdOE=;
        b=qzOfGsutkt3b+mspsD/Ekuuu8d+YAyMsvannPA32m381Nmea+VBf65GNKUlL1UUi1u
         /8An//91mq2x4ahiJfj9uWGmOEC8B1peNmtnb84HZJP+gJIsWrSKYZqUJeMF1bT1PjBn
         nzfdvJmqL5STeJYdshbu5/w3V4n7ec5SFxVtUah/zdo38GuVmLUulV7ziP6bnviUTuk3
         u/MmSy2eXdcDPB7aJv+0ThtfNlmEvI+zUz67Wb3bctMdY7ubgkbmEFDBPpquMXlAHfbq
         XVjg2E4MPGbrVR1Z/yAb3+GD/OhtxNwrr4qQa9B1kle0l57RGjAgJGxUAVBPriM1fTQ6
         O5KA==
X-Gm-Message-State: AOAM531011BHhTfNo4Vi6JZ1tIPT9Y4r1CKtY0E7A5AUCp4YxZ7I2zOU
        zJNcz+cSqZR5iIL6TfVVUEE=
X-Google-Smtp-Source: ABdhPJxjvGahtoyXNSccUhl0AeaffkZO4kJLPbsRyYmRclGhUYpFdroi35MHWOJWvCcdaQoqJ6BZFw==
X-Received: by 2002:a17:902:904c:: with SMTP id w12mr22660155plz.147.1594524707025;
        Sat, 11 Jul 2020 20:31:47 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.224.89])
        by smtp.gmail.com with ESMTPSA id s89sm9750271pjj.28.2020.07.11.20.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2020 20:31:46 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v3 3/3] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Sun, 12 Jul 2020 09:09:55 +0530
Message-Id: <1594525195-28345-4-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 5 as per document [1].

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
 drivers/xen/privcmd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 079d35b..63abe6c 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -593,7 +593,7 @@ static int lock_pages(
 		if (requested > nr_pages)
 			return -ENOSPC;
 
-		page_count = get_user_pages_fast(
+		page_count = pin_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
 		if (page_count < 0)
@@ -609,13 +609,7 @@ static int lock_pages(
 
 static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
-	unsigned int i;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (!PageDirty(pages[i]))
-			set_page_dirty_lock(pages[i]);
-		put_page(pages[i]);
-	}
+	unpin_user_pages_dirty_lock(pages, nr_pages, true);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
-- 
1.9.1

