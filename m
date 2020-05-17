Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5296C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36C92067D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Hlzv4zqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgEQVrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgEQVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7797C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so9612421wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYgWnESh6GA5v0OESDXoG2vIRhhETFyg3jLhszcc4vQ=;
        b=Hlzv4zqWCxXGdAcTxIc9OS1xN3LebUTz2MMDfJR6xLkhfwU0aFx8WwBuj5L8Pj7jxt
         2ccD3GeoS2fsl4G1rY/ZSnT8Pg17X34UDACNqtLfaaVtvyBO4M+A7M5K7XMk0H1xwdQ6
         +0E07C1OE8fURg4557sLDZEkGl5bEpA/VwsVioBLsuSUcZD3VzHAJvgFPkuSPX8yqYOo
         9gEdbzs0lUYVU6mKPQkVU1ypkau7ic6QY3GbCGV1EJjGBavcrai+nuRh2PNo8wqtCHW8
         pM4LYrujE5Iz7sf+fMlkZKbNwrI15Jt1U8Aiy1/aL8mGKUkjO3FRl+tD60Ye2uePMotY
         bwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYgWnESh6GA5v0OESDXoG2vIRhhETFyg3jLhszcc4vQ=;
        b=nWk0i3Yc26oHE/t273BsoDyzOGXYw37TArzqJHHrv5xvrIq039PWP2JwinzxMcW3EW
         9NcZhKcK8GbA+elZztjw408vBe9izdjfsrhMI/KHXH9YDwtTNXBNNxH8FRyk4rmPAM4f
         wTkSIRlZfaNoAIyKxpN7cYVht9iJaFeiFDvcz7BGSfAlgcA9wioVHUaexJgU9nW/FHn1
         DJg4wVp8mbIs175h37ZwgL4kSnC+Ilo7k0laaM9lhn34EMDERxz9iFXEMToyuDJOPNGP
         7pKXGUnw6qfnoJI0RgWOyIqfE1S6B+u6oLRpBj0EOZrVqPPVZeEiSZXui0gCvthEjAHN
         Vc9g==
X-Gm-Message-State: AOAM532oAatfHZVFpXIy1Ieq7CL7cJ3CTp1cU4LjQUiYzpGVbNnx4jmJ
        IzcNXa4L0bA9gW4ANug7PCKHYg==
X-Google-Smtp-Source: ABdhPJzHC+j/C6W12BV0RZXccBWkgsR740m9gvaarHvrA3NRnsXUBi80uvh/EszrG9my18vXu5gKnA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr16312653wrr.260.1589752052451;
        Sun, 17 May 2020 14:47:32 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:31 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 09/10] buffer_head.h: remove attach_page_buffers
Date:   Sun, 17 May 2020 23:47:17 +0200
Message-Id: <20200517214718.468-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
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
No change since RFC.

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

