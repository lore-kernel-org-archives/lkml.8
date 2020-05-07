Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F18C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA920870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MiE+Ud43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEGVo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEGVoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C4C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:22 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q8so5911246eja.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=du3Ie5iI06/rdz6CvBPo+dvSjUqDqQE7i/LV2aJP+GA=;
        b=MiE+Ud43dKkBLTxwwtjTs8umgmPkN0BYwfIJF9NimpzgXaIoLUNwUPzrYIMfxjp/wE
         9z7US+ja9ZyQtJgqqQIWp21xQ1iOfe4ZgjJytHnEpV/HgRot8yYEuaSkR1lrjKRQtJWL
         SDy6+wKTfKyvFcVN2gr2WozwC7ThujTOvGVSBqNU8k8SlUaLgdDrqXEEzDqPLenmaVQf
         AEriawM+qcLmVmMqDnbfaqwG2jfhJisNwoFCodJ2W0L86jMRiXofvUsXlEKRNlHFYKFy
         UbH5e9SqflHWa7fKLZUcGwAbbt7xfzUDABCLtZyQIvIAQQxPhVa/Vfs12FCp3Tp5aLxs
         zQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=du3Ie5iI06/rdz6CvBPo+dvSjUqDqQE7i/LV2aJP+GA=;
        b=p49ohM4JnSDlRoG48mqeHcYnvv7My4RyTSJbzw8C+9yMVLwkQgDkv8Cuwxd7k/bfvs
         JQHX3cufGu8VyuwAc38ZodU6U2zBs59I/yrMs0CE6Mn+gzOkgOGCNgHSduMsh7VaM2gS
         QotQZoy562JkDPSErzE3q9DRBTdVOkr2Lzs8ZTEceNrKPgL+S9qz9CmTX+nEUjyGs8VG
         lzrKZ2d4GREKTGnV4dKMdpmiktVkpJBe51lPRECNfGqepvl7Z5CHmLg1Ac5/Z8VJiqAq
         co325CuAlWvBFVSgoTpwup0c4dw56VI6aLhIPp9M8Gm3epTDu4EIC899s3rhsv//RQW6
         HXKw==
X-Gm-Message-State: AGi0PuZixzeikrba29/2qLGTTfJ6+x8b0nRPoS6MHD3yS/fhEU30pDeH
        37fEQCRJfq7txKZ+W0hqoVTaZQ==
X-Google-Smtp-Source: APiQypL4O3/QHa4GVRZbemx7icFjGNwfTGUsTYsyFOjCkG+jrsEi/Fe+zD6Xr+OUjvj3miNQGayvRw==
X-Received: by 2002:a17:906:ce4b:: with SMTP id se11mr14818360ejb.178.1588887861475;
        Thu, 07 May 2020 14:44:21 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:20 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH V3 04/10] fs/buffer.c: use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:54 +0200
Message-Id: <20200507214400.15785-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in buffer.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..059404658d5d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -123,14 +123,6 @@ void __wait_on_buffer(struct buffer_head * bh)
 }
 EXPORT_SYMBOL(__wait_on_buffer);
 
-static void
-__clear_page_buffers(struct page *page)
-{
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-}
-
 static void buffer_io_error(struct buffer_head *bh, char *msg)
 {
 	if (!test_bit(BH_Quiet, &bh->b_state))
@@ -906,7 +898,7 @@ link_dev_buffers(struct page *page, struct buffer_head *head)
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 }
 
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
@@ -1580,7 +1572,7 @@ void create_empty_buffers(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
@@ -2567,7 +2559,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
 			bh->b_this_page = head;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 
@@ -3227,7 +3219,7 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
-	__clear_page_buffers(page);
+	detach_page_private(page);
 	return 1;
 failed:
 	return 0;
-- 
2.17.1

