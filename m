Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0841C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B941A207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HjzFMoyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgE2UEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgE2UD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:03:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801CC08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:03:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c75so440935pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH4NCz4WUaJ18HzpAMLRB8JzZlzE4XmxaFkgad5236Q=;
        b=HjzFMoyGUyktwlVN5FORoAWqwNgHvmexB7iDIOcfLKLW/T9yqbrFjWx1NKmPw+bwy/
         2prka+MqpOVB8+46qAcUJD0B8qL0wd/LrW8r+/GIajBa+p2Dg54XkajVIaC7iDqBuA06
         GG4T6Lz8zrHhgzmDYePSUxL691mFdV0oWo8ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH4NCz4WUaJ18HzpAMLRB8JzZlzE4XmxaFkgad5236Q=;
        b=jvH1QqP/Bl7CA3oepH/a6fjxlEtacisyfJLmJSVRzaXUQw/tBY1izkUSXblbVXZaAM
         C4LCTT73548GF32S+Fgpj/Cr6XAQ/Gyy9UHzW6H7IHjJV4EBpjc6gP4NaLrFPg+iBToL
         nQON5BLr09veN+AwGMNxEvO8mHBDVPx2nJ9RwoGFeu3byEJ/5CmQDoCLMQoa8ObhiBAV
         SmXjvIqPjugDn8aoJVmf79eF5vGjlsONtHSuaMFsJjqdErJ/rvdnU8PWZ8KPaJKqjo1Q
         mHNjGxEHLrct7RnaaGd8FZ66sLRowJ2JjU2n8RyiDSRD4svVkNPadW6yw4b0QOpV09OV
         X2dA==
X-Gm-Message-State: AOAM533J1OfvFDSeXTQ2eYaFqPDTUXF4tm4hbKed2cs2Puaw1rsF6YgB
        oabf5g7/8GpN9MfqIIj50SPXOA==
X-Google-Smtp-Source: ABdhPJylwnFPmKnKBrVZK7qSGFJ3fxjbUGwRsA0TE8f9s0GojXSpLE3VBHMUm6+6aD6Upxf869jrvw==
X-Received: by 2002:a62:e419:: with SMTP id r25mr10194795pfh.82.1590782637067;
        Fri, 29 May 2020 13:03:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm8055147pfp.89.2020.05.29.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] lkdtm/heap: Avoid edge and middle of slabs
Date:   Fri, 29 May 2020 13:03:45 -0700
Message-Id: <20200529200347.2464284-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
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

