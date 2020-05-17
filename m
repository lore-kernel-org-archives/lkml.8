Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6A207F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="CHwAYPWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEQVr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgEQVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664AC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so9528055wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+wk8eJiuJkTmafHRN2lqlXH3cKLjXM5vs5pMzq94at4=;
        b=CHwAYPWVqx2xG0WKKNwAhXYS8gSUMjSVGqRoSLl/fQTpPWjrKxjaANisJJeMKqhAqz
         7kBLq9hp1zuHV0D6OH6y6TUFPbExeVal77Y/jRJqwickCAIf5kAAS/GZa36ZehDQ9ajh
         8ueNhXfcgUtJf+0Bw2cjv3+nlHsmxR1YXF+dPBVdvI6OXPpdjgGEw7WIhkaXqpx0Tl6u
         tQUrF1G/HpS0bUwOuhbmsWw34ZqLnRg2ST3FxmbS8PyiJgd7uB80CHkG+334Uye0pH6f
         DxZuokIjWM7IGLGQrLRY2vDbgzOyCo75X8Mh23lJEwebdOPhc3Ytt8SM1mkAY1w5TXxf
         Htwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+wk8eJiuJkTmafHRN2lqlXH3cKLjXM5vs5pMzq94at4=;
        b=N7JBT3Q+8d9KuSmOsGRqwgqVTxgPesFpCPp4whDi2WcTFChq0F734khr7Ix0UldBix
         Rp/UH/NrKSd6U4SoVZMib4MvuijWwW+LJSWW6JslKp1qlNEwceUFTHzsvuk0viAWt+Ry
         K4dHrwdnwSndcw0lW6EWVaO3RHGJZW6/uo5jEwQrS6Z335E3meh7gvaokUCIhkScW5UP
         DkThjo6JfCV0hM9mX1rxg9kF7HjWjr+2tJijym/jTDLGDkcZGbejFHZRhhQSYtIWfWXU
         k9FXlOb3shU+cJzqXJNrMWtChW/GDVDu6rHBNPPkPdjR3qeGoxSqfBKMD1zow3pXsh2D
         +K1Q==
X-Gm-Message-State: AOAM532zXq1K8t4gcN+Rmgo7Z41keROKq8oWeGAzfOjMS8SI+OEILfxu
        Ch+R7Yzq0Xeq5uk6M3NysTqeBg==
X-Google-Smtp-Source: ABdhPJyyj0MqyHctEZVnb5vi30vD5DWpT0PNj3+q7zNi/6gGxhYA+Upq6iCEPrNBuDtqBUzX0XJwFA==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr16139970wrc.6.1589752050205;
        Sun, 17 May 2020 14:47:30 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:29 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 07/10] ntfs: replace attach_page_buffers with attach_page_private
Date:   Sun, 17 May 2020 23:47:15 +0200
Message-Id: <20200517214718.468-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the new function since attach_page_buffers will be removed.

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V2.

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

