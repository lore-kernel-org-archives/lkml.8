Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38874C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133082075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1T4VjjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHYO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHYO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:56:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED2C061574;
        Tue, 25 Aug 2020 07:56:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so4894857pgb.8;
        Tue, 25 Aug 2020 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36M2Iusv4U+OCFEiYExRiUaDkUkxrwxbrWzc7Vsh9kM=;
        b=e1T4VjjFxB1j7dvKVZizm2lxLTJuGB3BNBIRcL6pht42BVLznmpxoXKp/zWSPF77+2
         aN4ruB4jZJWZ0yt9TxDoQTxb7tz3axNSFftZjkoezqmVBxF9w7FgfaAuPnP0rlFC1ziY
         4AdogtsU9tENoHmt9lDJPvcUayZA0dwKrYJfTX+119c+yt6HnTYIcnr8DEeyAYzsU9pJ
         g6+uu7R2wkdS+JlY+JS26PcfD7Hx9z5DVtvbmXAiOJbHZLiAhKq9TK7Eltl2oZoU5Id1
         XOnfTcC81Hd+nhU9JcNeIAbAPKqxjxzMN++13KpTpsh1sPoRevLlnUc4PX2YM+JIivQP
         GqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36M2Iusv4U+OCFEiYExRiUaDkUkxrwxbrWzc7Vsh9kM=;
        b=rpWwJbgifZOKpHiDuaXXhERP2Xp20rE34HoMkFnJLlu7X6khZH+L8jFpyjLq8yEBph
         Wz5ci5l37m6aItdz9YAkgmzmNc6GhK7NchtPtKfCuBv8ZKvy/kp+O28N+BHFWQaMd0JB
         tyfE229q452XjDhujoM0+ONVq7znDNmdzFX104QZWgPZKi5RLkmlxbPwWK3A3/nivGIw
         9seGqZn3KMucCpmBuywWR7IrSrZR5UG9veCTfOq6W6gB+EJzzUJfksC/x84/ZHGVuIc4
         m8XEfsoRAWSNURnf5rA5mClOQB4NmRRSfReH5/R/GiqTz8HwpLi7HqYIacyddN6Z8xvy
         7lYA==
X-Gm-Message-State: AOAM530wZdISS/NynmDFlOGSAdi5874IQQYLwV11QA4eKsBP+SgB4KSs
        rIojs4djohONrp5hWEm0sVfRtiPGAmE=
X-Google-Smtp-Source: ABdhPJy7PRY8JaIMbSpHA/oHTH25qAn0hu9Guzga5FhIhatjbz8tTC1sJS6zu2XdB9QW44bftyAlUw==
X-Received: by 2002:a65:4183:: with SMTP id a3mr6852570pgq.448.1598367402178;
        Tue, 25 Aug 2020 07:56:42 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:8f0:6c00:89cb:88d1:b6b2:3345])
        by smtp.gmail.com with ESMTPSA id a1sm4469959pgc.54.2020.08.25.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:56:41 -0700 (PDT)
From:   Alexandre Courbot <gnurou@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <gnurou@gmail.com>
Subject: [PATCH 2/2] media: v4l2-mem2mem: simplify poll logic a bit
Date:   Tue, 25 Aug 2020 23:55:56 +0900
Message-Id: <20200825145556.637323-3-gnurou@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825145556.637323-1-gnurou@gmail.com>
References: <20200825145556.637323-1-gnurou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factorize redundant checks into a single code block, remove the early
return, and declare variables in their innermost block. Hopefully this
makes this code a little bit easier to follow.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 35 +++++++++++---------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 0d0192119af20..aeac9707123d0 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -841,7 +841,6 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
 				       struct poll_table_struct *wait)
 {
 	struct vb2_queue *src_q, *dst_q;
-	struct vb2_buffer *src_vb = NULL, *dst_vb = NULL;
 	__poll_t rc = 0;
 	unsigned long flags;
 
@@ -863,33 +862,29 @@ static __poll_t v4l2_m2m_poll_for_data(struct file *file,
 		return EPOLLERR;
 
 	spin_lock_irqsave(&src_q->done_lock, flags);
-	if (!list_empty(&src_q->done_list))
-		src_vb = list_first_entry(&src_q->done_list, struct vb2_buffer,
-						done_entry);
-	if (src_vb && (src_vb->state == VB2_BUF_STATE_DONE
-			|| src_vb->state == VB2_BUF_STATE_ERROR))
-		rc |= EPOLLOUT | EPOLLWRNORM;
+	if (!list_empty(&src_q->done_list)) {
+		struct vb2_buffer *src_vb = list_first_entry(
+			&src_q->done_list, struct vb2_buffer, done_entry);
+		if (src_vb->state == VB2_BUF_STATE_DONE ||
+		    src_vb->state == VB2_BUF_STATE_ERROR)
+			rc |= EPOLLOUT | EPOLLWRNORM;
+	}
 	spin_unlock_irqrestore(&src_q->done_lock, flags);
 
 	spin_lock_irqsave(&dst_q->done_lock, flags);
-	if (list_empty(&dst_q->done_list)) {
+	if (!list_empty(&dst_q->done_list)) {
+		struct vb2_buffer *dst_vb = list_first_entry(
+			&dst_q->done_list, struct vb2_buffer, done_entry);
+		if (dst_vb->state == VB2_BUF_STATE_DONE ||
+		    dst_vb->state == VB2_BUF_STATE_ERROR)
+			rc |= EPOLLIN | EPOLLRDNORM;
+	} else if (dst_q->last_buffer_dequeued) {
 		/*
 		 * If the last buffer was dequeued from the capture queue,
 		 * return immediately. DQBUF will return -EPIPE.
 		 */
-		if (dst_q->last_buffer_dequeued) {
-			spin_unlock_irqrestore(&dst_q->done_lock, flags);
-			rc |= EPOLLIN | EPOLLRDNORM;
-			return rc;
-		}
-	}
-
-	if (!list_empty(&dst_q->done_list))
-		dst_vb = list_first_entry(&dst_q->done_list, struct vb2_buffer,
-						done_entry);
-	if (dst_vb && (dst_vb->state == VB2_BUF_STATE_DONE
-			|| dst_vb->state == VB2_BUF_STATE_ERROR))
 		rc |= EPOLLIN | EPOLLRDNORM;
+	}
 	spin_unlock_irqrestore(&dst_q->done_lock, flags);
 
 	return rc;
-- 
2.28.0

