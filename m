Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD8C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4A207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="h2hh4ukd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgD3Vw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgD3Vwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D06C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r16so5831685edw.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVC4XtCI51zwuXU4kfWUPmx3mXCoCkfv76JEys4qRWI=;
        b=h2hh4ukdjcrj1rKmeKUhGkIVIjVb+CMDuH/sGucO7vCFGioyAXpgts7c4azzs0Gv7I
         wrrOrJwzU58JHtDYO/oOtVLQCBlpEQUKurGOOWp5RON/lTp6xfIclss2781r6FT2zQjS
         waJNn4vy45DkGKi2F57eOjNlloFB9D2TGMAF2DfeQd8ohuFn2EMA9lBw3MtHlItasTn9
         wOTEDBE7MleC0ix9SqqkvpZrZ1sgdUaF2T+Av7FJzZBBcKhUcdAmdu9JJMmDy91e2g+Z
         LF1NGTxFVnN7PPxwmfknLpvMMpUf8O1hq9o353eJlvR73KIYEeo13Rl69tHDdOm7Bj85
         8f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVC4XtCI51zwuXU4kfWUPmx3mXCoCkfv76JEys4qRWI=;
        b=GVnJPwelL8yZAn9SDTh5tsnErVbfw3nTBVkkFXzxS9nbOTf46rObc3/X6rrKNKGGEr
         9FvkptTMkl7jpIB7Gt7MfJDm0OLIyL5FT0PoCrFuVi/WZ/k/6Xnwmp1+9xfZhSnCSj8j
         Y/6X5kmwra+B2K5orvzX6U3I/7vWeeGqZ6E/fUIerT/Bf+kxx3PgrY7RsBFTyv8U3zM+
         mEisM3flPMlRjTKLj1wcTbXHiZZOoqa4+RdohTuSVwZpAKACyOebnTHE03bdmNK6MRJp
         Szb9Y3rORCxmLBHYzc9E5rUXYz6pNMo6K1Reno5SvChDMAJ/pn2gJeQz72GsGUoDjM40
         4ylw==
X-Gm-Message-State: AGi0PuZ04Gbvjul8Mc5U9FwrXyi4zaF6y+1Yvky/NjZ7cx5bRQ/w5cgc
        JNEqrZhz3iotCXdb8hnWjB5xqw==
X-Google-Smtp-Source: APiQypLipNJe1CcB6DTPAa4UTwx9mH+5ihqyAcGLs5v0DbpMIgL9Cfj+7fXuU233MI38OzTIhsROgw==
X-Received: by 2002:aa7:d481:: with SMTP id b1mr1073575edr.226.1588283565949;
        Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH V2 9/9] buffer_head.h: remove attach_page_buffers
Date:   Thu, 30 Apr 2020 23:44:50 +0200
Message-Id: <20200430214450.10662-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers have replaced attach_page_buffers with the new function
attach_page_private, so remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 include/linux/buffer_head.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 15b765a181b8..22fb11e2d2e0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -272,14 +272,6 @@ void buffer_init(void);
  * inline definitions
  */
 
-static inline void attach_page_buffers(struct page *page,
-		struct buffer_head *head)
-{
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)head);
-}
-
 static inline void get_bh(struct buffer_head *bh)
 {
         atomic_inc(&bh->b_count);
-- 
2.17.1

