Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D943C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116CC206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loAfKpvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEEOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729060AbgEEOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:50:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D39C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:50:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so469432pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FHjXPsU26H0OF2JRAex/ddIqer39oiBwJgvFSKTEKIY=;
        b=loAfKpvrXy8JZk/co9QVvVYUvjTD5FZP/X51udmNZb9CVrPWUPLJjgkVeX4yzMNuos
         i4s9co+v9pPLXg7fiTwT8CjSc7DvVUck2Pw5Il4WWHdId9tQN417sNnw+0dnKWo/srlQ
         tCcXviaPvUcA2ReZgq+YemUOsAIppGo9k+H+EGZmfugrabUOZD8RZDeKTvWEKHTvciss
         OXYim4bYgvD2sSoUH99mEJ4Rr0zPYRIbmMTpXm7a2M2P/s3ukqKIgrE3KS2mDbf06dt3
         IJQYwsmGwUj1njTjH9KNy5V9q+ZVw39HViCX6XuXZ20ONqc4h3HKcCv2FfRS+Xpc0TNr
         GcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FHjXPsU26H0OF2JRAex/ddIqer39oiBwJgvFSKTEKIY=;
        b=IxFXZM6Cjm21Xw7uFh9lEwMfS/eFwXvMfuNLIjAXDggHYjEMCxOgBGW2R2iCz5PpRL
         6pX5Tgr21/KjeQTvwNui/PUpXR7Qg0ems96zi/DpK35Syg8+iUm5qvnYZSCmYgpOaiJj
         NfPk2g6ruPtOtHQbe8NlY+eS9wpvR9WBo7F0T7ZbzYSzwCLjfmn7o5ZgArOLO8S8Gxqa
         P9h3Mr8UdYRDdnVTO4vEcSE+07gv11CE3kQDfwnk3bM8rSwE1UUoujrlK6w5jXV3JWly
         FzPZ9Cd89Uq9iiU4qrS66nC0kxaUK+nfAQ0st71zuGzdO2dcQOFwAN/1K5+84PjszzLh
         5q7g==
X-Gm-Message-State: AGi0Pua15sJWDcvp8NUntqTQxsPec6u1UXtqTexlvne8EvbsJe3k2AKD
        A1ay5qrRKvMWx60LiunJK8c5xue+5BUN0Q==
X-Google-Smtp-Source: APiQypIQMNjcbl+8Wcw3aymz/pGlaLzA8y3jtrAd6BgNWxq7pxYsvDuca1/u9Gn2cd0YEexhcSq+bg==
X-Received: by 2002:a17:90a:2645:: with SMTP id l63mr3610638pje.54.1588690202879;
        Tue, 05 May 2020 07:50:02 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id c84sm2288400pfb.153.2020.05.05.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:50:02 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org, Markus.Elfring@web.de
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] fs: jfs: fix a possible data race in metapage_writepage()
Date:   Tue,  5 May 2020 22:49:30 +0800
Message-Id: <20200505144930.7990-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions metapage_writepage() and lmPostGC() can be concurrently 
executed in the following call contexts:

Thread1:
  metapage_writepage()

Thread2:
  lbmIODone()
    lmPostGC()

In metapage_writepage():
  if (mp->log && !(mp->log->cflag & logGC_PAGEOUT))

In lmPostGC():
  spin_lock_irqsave(&log->gclock, flags);
  ...
  log->cflag &= ~logGC_PAGEOUT
  ...
  spin_unlock_irqrestore(&log->gclock, flags);

The memory addresses of mp->log->cflag and log->cflag can be identical,
and thus a data race can occur.
This data race was found by our concurrency fuzzer.

Thus use the spin lock "mp->log->gclock" for the assignment of 
the data structure member "log->cflag" to a local variable 
in this function implementation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Change the description.
  Thank Markus Elfring for good advice.

 fs/jfs/jfs_metapage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index a2f5338a5ea1..026c11b2572d 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -351,6 +351,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	unsigned long bio_offset = 0;
 	int offset;
 	int bad_blocks = 0;
+	uint cflag;
 
 	page_start = (sector_t)page->index <<
 		     (PAGE_SHIFT - inode->i_blkbits);
@@ -370,8 +371,14 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 			 * Make sure this page isn't blocked indefinitely.
 			 * If the journal isn't undergoing I/O, push it
 			 */
-			if (mp->log && !(mp->log->cflag & logGC_PAGEOUT))
-				jfs_flush_journal(mp->log, 0);
+
+			if (mp->log) {
+				spin_lock_irq(&mp->log->gclock);
+				cflag = mp->log->cflag;
+				spin_unlock_irq(&mp->log->gclock);
+				if (!(cflag & logGC_PAGEOUT))
+					jfs_flush_journal(mp->log, 0);
+			}
 			continue;
 		}
 
-- 
2.17.1

