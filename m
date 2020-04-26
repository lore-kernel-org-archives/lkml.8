Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE62C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC422071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="UVHO4nSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDZVuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgDZVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DA0C061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr25so12456172ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N8gIKFIeQ8z9XfDXF8aFsZf0JuueUHPpH6m+yfXK8b8=;
        b=UVHO4nSPWFPUha6gMtRlBXjUrSChfrVkXAZEtZZU15RWikI+an77gAQsrAsj2TRuKY
         f8LhPsVlGMxZNx4YrPwaJ6tHcz//7ndRkxJqOqrnmstPz15M7dqlJlk8gd2Lq3TYW1Ec
         osx4eOIGOKy4DTfNKVG+bVsa6lhQm9tjU/Gny9MW7P6wTFRiU7mxiO8g/fojnB1+05DN
         MhOmuakavYZSMaYyJ84Nvp+ib+10DhtEG+cWtDFZQTdpQnxmXGiYr6Iv3irIuInrPx9u
         eALbJkHQnCwuxGwMiSlcCw5iMndeGJXPdQJCKiFTEtH4GozkC0fGF8zwGvRlvf/2resF
         /39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N8gIKFIeQ8z9XfDXF8aFsZf0JuueUHPpH6m+yfXK8b8=;
        b=VKXLdpksIH5ljrHxIlKdC2ugl1M/pku2XzMF17OXIEPh+zg5J1CfTHj61qcnF7vw3F
         JMy59Y8xFfuC2UaoOX6+ptmpl46aR/XBEH2AOOKfeon4C7RrDSxpO4jdcOFdY8+liEq4
         kBeYozACLEsrcQiH1CMGSbgQpo2/Z3NIsIBGHTsiC+/EfI2iRBw4CnCddTcWWIaVSzWE
         gdRNLJepMmKjhcQNbuDfT7uSfT8et8fDUAWzVOtmSCqOJwSfmctSkHzqQZDNew/7n1kp
         BNlA2ypggM6DV6RXPTZsOmHLUewo6WZpvURh1YowBNC+iQTuS9tBOP1NaYM1mr8QJb2C
         drvw==
X-Gm-Message-State: AGi0PuY8RwMQz/Q2IjfOtDwMGnuTqQdx/7R1AiUyS/B9ZzrJA2YoKJa7
        tRikx0ddDlMGUmxkZfaQgFHknw==
X-Google-Smtp-Source: APiQypJ000Dnx98h+ZTnqQQF4cE5/V9vJpP0CmGnXbwOYfUf6hYD0XVxm08loMwo7oxpYoNuTMUnjA==
X-Received: by 2002:a17:906:9450:: with SMTP id z16mr16426992ejx.166.1587937795586;
        Sun, 26 Apr 2020 14:49:55 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:55 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH 9/9] buffer_head.h: remove attach_page_buffers
Date:   Sun, 26 Apr 2020 23:49:25 +0200
Message-Id: <20200426214925.10970-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers have replaced attach_page_buffers with the new function
set_fs_page_private, so remove it.

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

