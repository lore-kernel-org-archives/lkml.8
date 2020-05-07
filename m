Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FEC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3798F208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Js03/NCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEGVob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgEGVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59259C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so5906555ejx.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKELhdYWYdAhzUDf2017C+zkiBNUO+dgi+kWgqsMaQo=;
        b=Js03/NCa0TzF0VfdeXIzvkro8wybq6NjNQGCqPdKQimeJrwvTYtam+cSE0RRwMUm3v
         UKO22AXxUWq/amzRnIRIwO0Z5TTODWjNj+FTzFVyBu30xNOBzSAfGNyNMKkLB+Armh8i
         nvTYb6dHmiGx9DTByyKmOD/rNqQhoVbdn/2HvmK0gC/pAmGrkxCsvIYzi4qm0lTF/Dof
         bOzxMb3YXJQhTb0g/oiCNAhJ7f03rlHoxMG7flnajSrFCu0UUpFwCNuCbH6q4YTGwB58
         tjjHhZ0vmnw9ocarUaxvdVGuTgV9Gh2fHuamzzNAgyG4ZfzqwxeVh4dcPrvW+ZQdPafm
         8E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKELhdYWYdAhzUDf2017C+zkiBNUO+dgi+kWgqsMaQo=;
        b=ls/7YRx1yeZqJb4Mxmt1x49cTAzIXct5oActw1C0mKqnMitK4c350aGbr4HhpiB8uW
         eYAx0E+On1AEr/pp+yGTG3QlnUKwQEn9j2HXpfUMir4wymrLid1pBG/sXMleW585diUU
         SCAaPRRkYWsiIqrYw8pF8p4/jF4ejDiNBqevz9SFWdLnuWXgyD75VXF8BIbvFd5BBIsP
         C096+8LF6Q/CEYgRkVYz1J+kr6wIbQZREUos22jVPJpXKu0dRlxDvV1tRfmqywS/bGLu
         4R/jpEwJskCXOQZcxfrH9PxD7/UgFDE95anu8jUccd0Gz/1ef5PLwBHUZJrTrx7g2I0n
         GzlA==
X-Gm-Message-State: AGi0PuYAgYHWlmZLcBkwEdZium3JGNufso7TfH6fu0/evdKM4TOVsdtk
        rlP0lRnwY72xHWtpmG/7zcQuTw==
X-Google-Smtp-Source: APiQypJzdpl8spMfNAAlzzO6AXeNQL/Cqjj7WRO6qZUO8sBaGbOHi6SshrS0cNwvt3L9wQtnEzsBJw==
X-Received: by 2002:a17:906:6990:: with SMTP id i16mr13653114ejr.175.1588887864765;
        Thu, 07 May 2020 14:44:24 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:23 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [RFC PATCH V3 07/10] ntfs: replace attach_page_buffers with attach_page_private
Date:   Thu,  7 May 2020 23:43:57 +0200
Message-Id: <20200507214400.15785-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the new function since attach_page_buffers will be removed.

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3: no change

RFC -> RFC V2
1. change the name of new function to attach_page_private.

 fs/ntfs/aops.c | 2 +-
 fs/ntfs/mft.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 554b744f41bf..bb0a43860ad2 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1732,7 +1732,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 				bh = bh->b_this_page;
 			} while (bh);
 			tail->b_this_page = head;
-			attach_page_buffers(page, head);
+			attach_page_private(page, head);
 		} else
 			buffers_to_free = bh;
 	}
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 3aac5c917afe..fbb9f1bc623d 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -504,7 +504,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 			bh = bh->b_this_page;
 		} while (bh);
 		tail->b_this_page = head;
-		attach_page_buffers(page, head);
+		attach_page_private(page, head);
 	}
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
-- 
2.17.1

