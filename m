Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0325FC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12BA20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MVZuBrg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgD3Vwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgD3Vwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCAC08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k8so5995665ejv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RDyvyO8rwFmcvJyegxtOlIWyfKh2lKfO2lMdBviLIWw=;
        b=MVZuBrg6oa0B3+oPEUC9E3MHJsz7b1vOQU68STAjII2XEWrovdVYpyUKVXwhxlLycC
         6SqHUtbNoruOVUIG50+L5nfg62ylVmz1h1arB+uxy+ffqXcJcnB9vGyFOM9Hcnutr0Mo
         5YX2gldpMUjtoeZ7A+F5CNuYlTkLT5QhTIacRexmuxsOFdV0d21RO4SlSbIqGtGjwxzU
         +rydx4uwGaY+fpxemnQmqtoDGz1KBM8nzE9ame1omYKoK/Xbo6tQAtwnCu+wf1CSn/xl
         QgL3r7YzLqopwed5S5NrJLno49ahjtsMP5BxXsM0X/3Z8ZnkSXCYulEZcuFq2lxcIBMh
         Ve+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RDyvyO8rwFmcvJyegxtOlIWyfKh2lKfO2lMdBviLIWw=;
        b=G4aWk+UnyhgNasp4TB1q4m0O8kbcPKwRB8zJE8JCLst5O4ey9Z8EVqXKB8OVZi22Vm
         0czE34B8RpPpInksXco/95gLvKRcV18wGV58A8d1uKqZ8Pv5k0lTnMFL+YuuvWaOHO4A
         hxSd/C1uLCf1URHjyH++a1NJfNnGXHL+LmtZ2yyJ/g8Ql6EYY8L9sd1BsJUbWs8xHIiS
         rmZ9c+bzUETu4Yieri7tcxLGGUlUDKTzBQQuu1Qdu0d5BDXkv8+7OnmbD8L/nX4UsLE9
         yZi0mrajV68Hl8phM+f4qVFyhaq674wAHW0xzA4u2CKOA/GuG5iAbibWffenmr8DVuHf
         aHdw==
X-Gm-Message-State: AGi0PuatEHfYa/yxabz7g/BBqj9jx7LrPV7WHgtfdpftA/1XLlHQZMWk
        pOUdcQPzdDC4QAn1vXIsqqjYCe3rt56UhQ==
X-Google-Smtp-Source: APiQypJG7QnDdETcRAJ6jnMQlEhFUkN8OM6SSlzSW0BC0GNEexmz4jIQLd3z5S87e1gEFOPgjS+QKQ==
X-Received: by 2002:a17:907:11de:: with SMTP id va30mr519015ejb.121.1588283560575;
        Thu, 30 Apr 2020 14:52:40 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:39 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH V2 4/9] fs/buffer.c: use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:45 +0200
Message-Id: <20200430214450.10662-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in buffer.c.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..60dd61384b13 100644
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
+	clear_page_private(page);
 	return 1;
 failed:
 	return 0;
-- 
2.17.1

