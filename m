Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A25C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E5420735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YC2Vfzsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbgEWS6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgEWS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4864C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so1561624pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAoC2D0g8n2nB3lVHnvM8l1E4Q5NdmCRN9F9KiRIdEU=;
        b=YC2VfzsnPeRpcE5DvmH1q7hRFR3ktyWmEBg1dhSrxX6BFoyD3fKdg4R2GLI95N/SE0
         13pLuYLICLL5TpTf7k8tOQCbfcWAg+LSSWYlWJ1suwm0ov6o2L9xiYsqhC/dE4f5VSym
         icycAN5rixlSrfpPHHd9LLwl47FKj5W+W548LOgLrXWRYNWFtPZlt+gcRvbc5/F/zgL6
         1FxFTEntDu/QcaUTMefGTsOHV6kxxyLa9N7whilVJyvdprYWKH11tzgAocRoJwCMs5sJ
         ORD5W6XVt276+iM8eGWGAHYZvutwMyV1kO9mZPyzKTsoS0Iqcx9DKWbS0Jhs1iPon9fh
         nHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAoC2D0g8n2nB3lVHnvM8l1E4Q5NdmCRN9F9KiRIdEU=;
        b=lyVDikp9YGw37DmCUymA1cbFrANsmvHX9odGX/C21dczXJX1m/P2wbxzqzTPyvy1kJ
         NgTPzo7YcQASlM6vV9W4yMzqTiQ9WxurmisVPuRClrCS1GDakKuctkpWSFBrTMuUy0m0
         T4CFaQLoCcxeV+xbIBcOHQPGLPmbRq/hgQ4wFhYKpzF0VWzuFApQcj3VSFqCrzgqTcIn
         9DBARBwJzAgCjlPaRi87YEaLW82Ch5+JwGS3mLmQzLoDTZskQ8EVzrI47z/pdImh5A4D
         UI7/yFSCJP4/FDbp+Ed6gOvkzZ++gGm+9v2m0ZNP+N5Jfj/GkC+8HsagxYHFcRFLDf+Y
         8uLw==
X-Gm-Message-State: AOAM533TF3CGJ5XlExotO4GnieCBSrP1WXiq3o8M2NfGWhjcofH2VWhb
        h1uadP20RNCpWVXd0ZBKnDiaEw==
X-Google-Smtp-Source: ABdhPJzl0A8QaNkybc86UdHrH0/anQq6XTkgCYB3IwOB3AK5hnXDj+grn+woPDxbu3W68oqJ/gnDQg==
X-Received: by 2002:a62:b618:: with SMTP id j24mr9943370pff.16.1590260293462;
        Sat, 23 May 2020 11:58:13 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/12] mm: add kiocb_wait_page_queue_init() helper
Date:   Sat, 23 May 2020 12:57:54 -0600
Message-Id: <20200523185755.8494-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks if the file supports it, and initializes the values that we need.
Caller passes in 'data' pointer, if any, and the callback function to
be used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d3e63c9c61ae..def58de92053 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -493,6 +493,24 @@ static inline int wake_page_match(struct wait_page_queue *wait_page,
 	return 1;
 }
 
+static inline int kiocb_wait_page_queue_init(struct kiocb *kiocb,
+					     struct wait_page_queue *wait,
+					     wait_queue_func_t func,
+					     void *data)
+{
+	if (kiocb->ki_filp->f_mode & FMODE_BUF_RASYNC) {
+		wait->wait.func = func;
+		wait->wait.private = data;
+		wait->wait.flags = 0;
+		INIT_LIST_HEAD(&wait->wait.entry);
+		kiocb->ki_flags |= IOCB_WAITQ;
+		kiocb->private = wait;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
-- 
2.26.2

