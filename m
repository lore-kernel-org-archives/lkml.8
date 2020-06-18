Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7282320888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bUiZ2Fxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgFROo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbgFROo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE10C06125E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r18so2986251pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=qG+PVAwYXEH3Rowu54+BkyZS7fslCJIulLcAGKfzRB8=;
        b=bUiZ2FxaCsZtyTAaJBoFcJMrX/CUga9qC0v2B0H5JcW44TVjLNQskpGK86a5Zb631M
         p0I2rj2UBPJFfNusO9HGLjnYw/iM43LqQ928bwfe2TjZbjF/4Hg7nfa5uPlMNvTn3vO1
         apcy+p2q8hky9Ls8gdUEdvgAwIA3LtH/8apm463k0TATUTGX0gwMdBhkDB52mw3XPrHh
         GrIGx+AghUZ13e4QtMHcv9dXOv4lssAk0Hv512Bg1on9er9ClFRT03k4kQjM4RRxOSPW
         6hvmoIIT3WZGyFLsTEshOvym+xTAnpq2veuMMOcqepVgDlq37cK5gOQh2kGyUaORNsIr
         A/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=qG+PVAwYXEH3Rowu54+BkyZS7fslCJIulLcAGKfzRB8=;
        b=fb2nqkLnQXNy1o+1HiEdx051NsNefwdzQXOld9h5qqfUnb/T5DCxfe9v8zsyp13ySh
         j21VDmbSeLgBGAaIaZXDj5juBni1LVoLIO5PSQpE+RVzDwUm5MYgFi2gxbQTogVZ1+If
         ogbfAQE8eV4GijVnpucobLPREC8Xdurwtcu6sMEsIm0nygoUK2QR4DXCly3IwusxsQ3F
         yTpirRfONDVGibXW2iBx2DNh5r3jA9WYJxwamgDkh5OwnK7tn4rNEEnO52uUSp7luLzE
         tYT66kp61MuL53J+lLnCJUs7gavuS4za4HClVL0M/h76tOCu8rj7JIY0kZ8GrJG5+EAY
         xhaw==
X-Gm-Message-State: AOAM531A5+igyesfAfQSqmSQGE7WWICQo448scb7pjkON5ngyEz+Higk
        hCe8t2hyyLbYb4+IXG/FDKJ2QhjJC3WJIQ==
X-Google-Smtp-Source: ABdhPJzzGfgUvN38nQlE0ltPql9r24L3d5fAFgRA+DRt5giXUwPYRi3iuK4YpxPwlcYuqcOquHT1Ag==
X-Received: by 2002:a62:7e95:: with SMTP id z143mr3898104pfc.108.1592491458734;
        Thu, 18 Jun 2020 07:44:18 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 14/15] mm: add kiocb_wait_page_queue_init() helper
Date:   Thu, 18 Jun 2020 08:43:54 -0600
Message-Id: <20200618144355.17324-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks if the file supports it, and initializes the values that we need.
Caller passes in 'data' pointer, if any, and the callback function to
be used.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e053e1d9a4d7..7386bc67cc5a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -533,6 +533,27 @@ static inline int wake_page_match(struct wait_page_queue *wait_page,
 	return 1;
 }
 
+static inline int kiocb_wait_page_queue_init(struct kiocb *kiocb,
+					     struct wait_page_queue *wait,
+					     wait_queue_func_t func,
+					     void *data)
+{
+	/* Can't support async wakeup with polled IO */
+	if (kiocb->ki_flags & IOCB_HIPRI)
+		return -EINVAL;
+	if (kiocb->ki_filp->f_mode & FMODE_BUF_RASYNC) {
+		wait->wait.func = func;
+		wait->wait.private = data;
+		wait->wait.flags = 0;
+		INIT_LIST_HEAD(&wait->wait.entry);
+		kiocb->ki_flags |= IOCB_WAITQ;
+		kiocb->ki_waitq = wait;
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
2.27.0

