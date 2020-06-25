Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09522C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99E620791
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RBKdveDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436575AbgFYUhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbgFYUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32AFC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so2420579plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH4NCz4WUaJ18HzpAMLRB8JzZlzE4XmxaFkgad5236Q=;
        b=RBKdveDB6/6TryZmoNNALhVnkzSsz2R1ULWjvCpcvukqeMwo0hJIk9HrScRw9ugson
         xp2VUC3/+oZibhV2ktrPBevQZ01heoCGaHB/q3pX2tYDKAkzMDAnS509Kjmw6py7sBnO
         iDJiP31nLw90dXJS/kd9DdxoeZQKV42Tk6wmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH4NCz4WUaJ18HzpAMLRB8JzZlzE4XmxaFkgad5236Q=;
        b=ApuVYL+yxgmpuhTouJsAh3Hrb2dfIjjkOvF23XuVHtwcuiP4YtvIJDcxU5LP3mqe44
         J/xn8el2qt4rEHGuw7wSadJBwyDkhao5oDQFrNqbTJaau6dq7LFRaD51KmbgBWTTMXzc
         wmJe17y+vAhGreBQIxfB6DN/Awcd5dmsfbxf1e1Y7nD74jhs0SAaKRObok27GjEcI4oD
         SPcbaWRIpBz15QoAvlt07cqgrod3g5sW0HH/yT6qUHxYQEG0JBGvrImtBuBrjIgvGtlq
         J4qUX2f/R7dCrmVn7DoKKfD/qqvJwLd2f9CqopgGyDulIeVn1Q7sSiSQUbTqTz6SmHL9
         mvQA==
X-Gm-Message-State: AOAM5324as5UEa17P307T84Ha4t2bnmB57IAvFkK9kuHldQxfRLUO5ts
        ko16ir9HqxVrLH/OKGNicOvYWQ==
X-Google-Smtp-Source: ABdhPJz2pFPgByh8wHP5gvDAbO6WFvVcu96QLX6WXAcgHZxo44RtCOOw8GvDsRRsJb/3q0x6ZUOY1w==
X-Received: by 2002:a17:902:dc86:: with SMTP id n6mr35678275pld.82.1593117429438;
        Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm13sm9447469pjb.5.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 2/4] lkdtm/heap: Avoid edge and middle of slabs
Date:   Thu, 25 Jun 2020 13:37:02 -0700
Message-Id: <20200625203704.317097-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625203704.317097-1-keescook@chromium.org>
References: <20200625203704.317097-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Har har, after I moved the slab freelist pointer into the middle of the
slab, now it looks like the contents are getting poisoned. Adjust the
test to avoid the freelist pointer again.

Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 3c5cec85edce..1323bc16f113 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -58,11 +58,12 @@ void lkdtm_READ_AFTER_FREE(void)
 	int *base, *val, saw;
 	size_t len = 1024;
 	/*
-	 * The slub allocator uses the first word to store the free
-	 * pointer in some configurations. Use the middle of the
-	 * allocation to avoid running into the freelist
+	 * The slub allocator will use the either the first word or
+	 * the middle of the allocation to store the free pointer,
+	 * depending on configurations. Store in the second word to
+	 * avoid running into the freelist.
 	 */
-	size_t offset = (len / sizeof(*base)) / 2;
+	size_t offset = sizeof(*base);
 
 	base = kmalloc(len, GFP_KERNEL);
 	if (!base) {
-- 
2.25.1

