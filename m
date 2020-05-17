Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C601DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A087C20671
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Bs05wU9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEQVrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgEQVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B6C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g14so20994683wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WyfshxYosCgau1zTEoWowNAhvi8t2lUhv/c0HzUyrKk=;
        b=Bs05wU9wzW1d2HEtTlH1j1H8fyfeFw+pw5GoU+zVKtLvAVHhoZH6uIMduo9fweSrzP
         +wSr4pJOnToFw6FVyd0uCOgdBLBaINBDRgwtvtzdGRmvapBfTsWwwL7jcC39dvsUW3tX
         enN8R20xnUzqf68gk90uh69SUHAsLLDNCA1vu9VrD3Cs2s4BBaVwV89YaJSfddwHbQrx
         hA2qKEkYkhcO0kArDZh06TzsowxDg+zeG3Dw6oMaC/tnnbr7mryttQLMPjsxLH0kskAc
         Qv6XSpt3PsNrmBZgI/a+GlfPKz7D9j1weMqtx3ZX8xldHJSNWXAVZGQTwXFYHzoTDAA6
         WAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WyfshxYosCgau1zTEoWowNAhvi8t2lUhv/c0HzUyrKk=;
        b=F+5ujlK0HHxN/PJXPH+MIfXKIz7D2zd4mWLfG8b1SLc6gPl5oFjHebxoHhMRmzKeiR
         twUv1jmW8Pra7RuVHuGuJORyC35G42t+X7xamWZwno9EOFgAK/kfEQzj8iv3mBWMY76z
         kN76uvQga6pJv/dgV8rnCtOa/ppNRPx00egGC7zTZ+wEO9gXRZoSEcz/qpGLKUAv3uXF
         z5EsD/8AejrSDjrsos2JOBvspB4VXaOTV04YQaqyuzOyQbOTmQuTnfAoa0gpNaApD4hc
         Dq5bq8B9dNBbVYr72dMChxzpze/MMp0BgY9kqKy+C/3gw3meu8gypuz5+y834M3VALuD
         hLLg==
X-Gm-Message-State: AOAM532r/C6GRXMR9O5To5r4Px7bZfc35pSqy0sHhNHxOy528HWq4HCh
        tU4mzNwZpWFFc+PaI/9bonBWJg==
X-Google-Smtp-Source: ABdhPJysVCvJ86kV1LLnsHsIYN/+fRuQ/BR+JjvyWf0DCIbENehPVGDAU2/G1LZ0Ba3H3c8j+G0oBQ==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr3492289wmj.86.1589752047212;
        Sun, 17 May 2020 14:47:27 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:26 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 04/10] fs/buffer.c: use attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:12 +0200
Message-Id: <20200517214718.468-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in buffer.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V3.

RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 85b4be1939ce..fc8831c392d7 100644
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
@@ -1624,7 +1616,7 @@ void create_empty_buffers(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
@@ -2611,7 +2603,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
 			bh->b_this_page = head;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	attach_page_buffers(page, head);
+	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
 
@@ -3276,7 +3268,7 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
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

