Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E2DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48C1206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFAQGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:06:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55326 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFAQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:06:49 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jfmxa-0006sh-Pb
        for linux-kernel@vger.kernel.org; Mon, 01 Jun 2020 16:06:46 +0000
Received: by mail-wr1-f69.google.com with SMTP id l18so191637wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeAmA4jTrmNARC3SDWl+jD/pueIRZYDlLrUDy+AkMLI=;
        b=qkaAC7IzTHNB5i7y+GvdwPYRuTNWCqAcKk7XeMo50NNapvKfCZ9rj+jm43EI3Hsq0k
         oVFojh4UuuWPKiXNPaQ59EnGWGP9R+TT4OhadYfxDMm94XT2BoNbmGbIZFZ6ptrU+blq
         yYdwqXXss8gNmLOdJB3+GAby+9aj95s2r/Isfl9ZdH4vC98zw0v67DoLYiCt6p6hmTzq
         H84eam7dY0lGUt96SlhACizkS1K3r+j7o0VmsYQ8277ib8eNe9vKGqOlPy5FT9TpoJ2r
         tCnpEYBbOZi3IQhhAYCe7NOsDXig4eIvQR+qcimbWQYew0SpBVU2Tx4pIcYBEOwEINO3
         vcAQ==
X-Gm-Message-State: AOAM533i/eLTfUd5OUDDiq3RJa1oMISIe1ZZPoBQ5ZaX6fQuiueePIE/
        l0UBgpOKE+NxexP3MOeMXQ2Vu4GU7aQdnI2IHCxIpbD+trS6cvWf8MuoJn6y2wMRHgBY7PkOdwv
        o2Es/ox9MyH5itlLZ1DR8ORmSOKJG86bYzD7LKOT65Q==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr24030204wrt.150.1591027606252;
        Mon, 01 Jun 2020 09:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+BHxqkANkdUGsMt1WVDpn254B7cTuPi/KBtVflfUw/QH3TY2FO0r0pIcgGqgmYltEFwHOJQ==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr24030186wrt.150.1591027605940;
        Mon, 01 Jun 2020 09:06:45 -0700 (PDT)
Received: from xps-13.homenet.telecomitalia.it (host105-135-dynamic.43-79-r.retail.telecomitalia.it. [79.43.135.105])
        by smtp.gmail.com with ESMTPSA id k16sm19719262wrp.66.2020.06.01.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:06:45 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm: swap: allow partial swapoff with try_to_unuse()
Date:   Mon,  1 Jun 2020 18:06:35 +0200
Message-Id: <20200601160636.148346-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601160636.148346-1-andrea.righi@canonical.com>
References: <20200601160636.148346-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to run try_to_unuse() passing an arbitrary amount of pages also
when frontswap is not used.

To preserve the default behavior introduce a new function called
try_to_unuse_wait() and add a new 'wait' parameter: if 'wait' is false
return as soon as "pages_to_unuse" pages are unused, if it is true
simply ignore "pages_to_unuse" and wait until all the pages are unused.

In any case the value of 0 in "pages_to_unuse" means "all pages".

This is required by the PM / hibernation opportunistic memory reclaim
feature.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/swapfile.h |  7 +++++++
 mm/swapfile.c            | 15 +++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index e06febf62978..ac4d0ccd1f7b 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,6 +9,13 @@
 extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
+extern int try_to_unuse_wait(unsigned int type, bool frontswap, bool wait,
+			     unsigned long pages_to_unuse);
+static inline int
+try_to_unuse(unsigned int type, bool frontswap, unsigned long pages_to_unuse)
+{
+	return try_to_unuse_wait(type, frontswap, true, pages_to_unuse);
+}
 extern int try_to_unuse(unsigned int, bool, unsigned long);
 extern unsigned long generic_max_swapfile_size(void);
 extern unsigned long max_swapfile_size(void);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f8bf926c9c8f..651471ccf133 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2121,10 +2121,13 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 }
 
 /*
- * If the boolean frontswap is true, only unuse pages_to_unuse pages;
- * pages_to_unuse==0 means all pages; ignored if frontswap is false
+ * Unuse pages_to_unuse pages; pages_to_unuse==0 means all pages.
+ *
+ * If "wait" is false stop as soon as "pages_to_unuse" pages are unused, if
+ * wait is true "pages_to_unuse" will be ignored and wait until all the pages
+ * are unused.
  */
-int try_to_unuse(unsigned int type, bool frontswap,
+int try_to_unuse_wait(unsigned int type, bool frontswap, bool wait,
 		 unsigned long pages_to_unuse)
 {
 	struct mm_struct *prev_mm;
@@ -2138,10 +2141,6 @@ int try_to_unuse(unsigned int type, bool frontswap,
 
 	if (!READ_ONCE(si->inuse_pages))
 		return 0;
-
-	if (!frontswap)
-		pages_to_unuse = 0;
-
 retry:
 	retval = shmem_unuse(type, frontswap, &pages_to_unuse);
 	if (retval)
@@ -2223,7 +2222,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	 * been preempted after get_swap_page(), temporarily hiding that swap.
 	 * It's easy and robust (though cpu-intensive) just to keep retrying.
 	 */
-	if (READ_ONCE(si->inuse_pages)) {
+	if (wait && READ_ONCE(si->inuse_pages)) {
 		if (!signal_pending(current))
 			goto retry;
 		retval = -EINTR;
-- 
2.25.1

