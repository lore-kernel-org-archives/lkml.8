Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B5FC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B2420700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Jp65FI7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgDZVt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgDZVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260CC061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id pg17so12450496ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nk7EV8qONapDcMrz48oPwtLT8Zin9+cq+j0iMab0m4A=;
        b=Jp65FI7Lo+Cn8/FOgWCuXZHNnKbn3DioxWHStDkNrmH2gVOtVcURqIHsod5j6u5BLR
         /bzkNSBHvR65E7Cc8qY4fKAkGe64M3OAQyMWt4e89dAlgVvLImCOAq02qBwmXSn+VHvK
         T3Ei+CxAHR2A+azyaRyZCEtKDP0LyhjtDBp4T4MPxOCW8FBvLTK1mMFO06vPCAhZC/UZ
         4Y365TApm81j5lGrkPGBW0G54qzQUXcDXG2jNf7vIprZiYAlXUdj7DbHP0JH2jfk4bsF
         p7Jkpb1gKLj0A7hYSunF2Dox+xkU5KikPl1Pl0jESVe7A/kkxilmSAif+MqAH2hA6/up
         oM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nk7EV8qONapDcMrz48oPwtLT8Zin9+cq+j0iMab0m4A=;
        b=kDJcjl26REnKpsl5tUr2AMGG32mNwKCMxy74nZb02BMFfOKOK+0UIQaQLes00MdutR
         OFajnVASbgyf/PDstVRi/2x5T6WNQl6jV2eZwH4jH/0bsbdraTZ0iItRgrQstIC8gAyE
         zDiKkEo+xAmdSM8bCNUdAElC0i7LlSK9Jw8KGmuxAh2MOtdrqXVzZ851a84YsErH50e9
         s8zABPFtlph6B+cA30JbTFrAkZQMOuCD1EJCDGMGfxors9H+LlVAprXgYoaXEmyan6ko
         RtLL8tF7yZi4jAApfJNky2yLzbju78Y0PwIgDPXWmS9Bm/d87SElG8IOnlVvRwScw9AC
         Bwrw==
X-Gm-Message-State: AGi0PubvbkUEDXuRFNemy4aGS05VsbBDwEKi1vxTSlfswuGkSBdw+Bir
        6hOWEP0hNVvFU5l0pvlZRY4QcA==
X-Google-Smtp-Source: APiQypIPM3/WHEI2bnt8PhQVPXZZ9xFUarLWq3VdADMkJuzy3kZOX2mY6i1kz2a/wwgLRKeFp4qKZQ==
X-Received: by 2002:a17:906:6b05:: with SMTP id q5mr16557099ejr.329.1587937790675;
        Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 4/9] fs/buffer.c: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:20 +0200
Message-Id: <20200426214925.10970-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in buffer.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..1d9b32e77c2b 100644
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
+	set_fs_page_private(page, head);
 }
 
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
@@ -1580,7 +1572,7 @@ void create_empty_buffers(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	attach_page_buffers(page, head);
+	set_fs_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
@@ -2567,7 +2559,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
 			bh->b_this_page = head;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	attach_page_buffers(page, head);
+	set_fs_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 
@@ -3227,7 +3219,7 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
-	__clear_page_buffers(page);
+	clear_fs_page_private(page);
 	return 1;
 failed:
 	return 0;
-- 
2.17.1

