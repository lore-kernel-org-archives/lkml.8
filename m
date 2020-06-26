Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A31CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D97C2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjeADPj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgFZNFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D238C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so9386002wrj.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAj330t/cLz/0OA5LR4Jx3FFMEjm0vNa388Rc6BW4E8=;
        b=hjeADPj+J8vNOwmitxg9Sq/bkOGvPZqy5wI5dY78aKilYPQ34vfHpdzTNNXwUUda7a
         TeAh0Vy3PKN3+5oOUCy3GnILWKVTXX9wvt8Qq4rF8ic9I5U4XegFPlEsffv2Yi3lcvi8
         BdfZNJkUPRKfF5m/DikKLMAd024eQ2QQSLb/Y8B+XcAnnAz7sI6aA9iT7b3kQWFE2aLQ
         IKEIVVaGH7mRmTnXSqC5d92uZuiVUJrtmwRDZyHMD/fvC4IJDyEFdXf1FGu4vNKPvT+K
         qBgMz360dqdXTLJNuZzZ+bk/WGh+WGtTly/yXu6npw/+hb+xylgPxq2jL9GqPpBfesdb
         285w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAj330t/cLz/0OA5LR4Jx3FFMEjm0vNa388Rc6BW4E8=;
        b=sUTULA4o4kCJFeeh9d1S2ATsDfSEA88H43I0TCN+/+/DysjeVknnPYY4VETHrf8uyI
         jgZZwuJ1GmumMvrDDKsg+EtiEanBSenPkm/sLubIV8UvGiNIuXnNMZAFvFca1xRyry3h
         10/6Ox0e1u5ELqrbU9czl+pYTI/ZEcN7oPrEEknAqo5N67+8Dlo58C0LixEyT447C6h5
         bjjJGymJ/bHjomif5c6hiNibtlG7/RbUjdNawq4fs7A6oC8gEKdXxQ8ilvlGYjcYfH3b
         wChOtWWZI48mWHoVm2O+t4TDFXfpT/0Jn7F52YifkzWF0w/ZaolJHnsRw0JDMOITvML+
         bIbg==
X-Gm-Message-State: AOAM533/+SlBXbsj8mE/DSFsnO7XVG6gsvzecwtA5twL5Tqz4Amv/EMR
        KvAFcypGQbLdae/ubed+y1sE/w==
X-Google-Smtp-Source: ABdhPJz0Z/3IvuQkcNWe4kc7SPhrizHq3K94NdYdMbd/faRkSyqVl19ju6hkKCpPo/dFz1MB0suI5A==
X-Received: by 2002:adf:9148:: with SMTP id j66mr1872622wrj.311.1593176733769;
        Fri, 26 Jun 2020 06:05:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 04/10] misc: lkdtm: bugs: At least try to use popuated variable
Date:   Fri, 26 Jun 2020 14:05:19 +0100
Message-Id: <20200626130525.389469-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result may not be intereresting, but not using a set variable
is bad form and causes W=1 kernel builds to complain.

Fixes the following W=1 warning(s):

 drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_STACK_GUARD_PAGE_LEADING’:
 drivers/misc/lkdtm/bugs.c:331:25: warning: variable ‘byte’ set but not used [-Wunused-but-set-variable]
 331 | volatile unsigned char byte;
 | ^~~~
 drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_STACK_GUARD_PAGE_TRAILING’:
 drivers/misc/lkdtm/bugs.c:345:25: warning: variable ‘byte’ set but not used [-Wunused-but-set-variable]
 345 | volatile unsigned char byte;
 | ^~~~

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/lkdtm/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 736675f0a2464..4f94296fc58ad 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -334,7 +334,7 @@ void lkdtm_STACK_GUARD_PAGE_LEADING(void)
 
 	byte = *ptr;
 
-	pr_err("FAIL: accessed page before stack!\n");
+	pr_err("FAIL: accessed page before stack! (byte: %x)\n", byte);
 }
 
 /* Test that VMAP_STACK is actually allocating with a trailing guard page */
@@ -348,7 +348,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 	byte = *ptr;
 
-	pr_err("FAIL: accessed page after stack!\n");
+	pr_err("FAIL: accessed page after stack! (byte: %x)\n", byte);
 }
 
 void lkdtm_UNSET_SMEP(void)
-- 
2.25.1

