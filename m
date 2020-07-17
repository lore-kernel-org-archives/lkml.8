Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C05C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C315522B4E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0WK/pIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgGQS53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgGQS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E02C0619D2;
        Fri, 17 Jul 2020 11:57:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 145so9701749qke.9;
        Fri, 17 Jul 2020 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1MqGbj6LAb7S7pEqYFEy6qzkgy7MTMQbM+PSS0FCnY=;
        b=E0WK/pIi56nCrYEOFr40Bi+eti1rlsqao2Sgnxfgi4aHBeQ9X+n3toQQxLFxzlG4Nl
         A7HvrJvgb5SzsdNlXic/WtIDIjKbJkXcqnXuTnueertb7/9oMayUWVezpD2BetLcLEOE
         BLsiMFOlABbQQneb4CtgWzrju80kSZqiFjwdFcvXyNzE0gEMRXBK5XeD898u/AGUOh/m
         C0A5Y7Syu+4NaCnU8skNziNUxFH3Og8h3VdByB1sNtN1mQpjyqDcjNeird1N5/evAMl3
         1/Z8kTSGeAh6y6Ij4kcve9tONxsqM30xxpPYsL5ZcrXoKJ/ki0aPcnLKkpsawgdXVijM
         Seug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1MqGbj6LAb7S7pEqYFEy6qzkgy7MTMQbM+PSS0FCnY=;
        b=hBFCSEO7FfR94Tsie3Vg24XQs5wPLBu32kpMkMajPSJ8msferRaNb8TJxYba2JXJe6
         U+xbck5ANoTz/F8awouA5bLSd69FAC488YKtVfQfS5s4zJ6HvMJwSLUMAshIhLojuR/B
         fgxhUB744rc/QLj12amMorDdOBxSEOY2XQg+T9MPJiQEHyPAFdv8vmJdFWl3x1r/V86m
         ja+VXR54CxcUqUhnSaKnLPVxpg8npQfRqoCJPz3qc+FQkohlKsFutN1iUl83gIHT5X4v
         XF6j/+9Ll53ALgsz3cNtX3uoO0dB5K3BLU+uJkPpOa3bRH7dExiO/nG3N7/S902VSz28
         vOGA==
X-Gm-Message-State: AOAM5325I+/XWdntEoVw3waHUjING9EiAbedRDptw0tuid0vnz76BtnV
        xPL0FEt1KuEIAkwQ0ePQmLBWjKGIb3Q=
X-Google-Smtp-Source: ABdhPJz4cp6Pf6yEqVKZTTOjBSLwjeDQ4U8wBzrGDmteK1T+Rm63FZO3RdKerjrG3DAewwvRoP3CYQ==
X-Received: by 2002:a05:620a:1666:: with SMTP id d6mr10765819qko.449.1595012245938;
        Fri, 17 Jul 2020 11:57:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:25 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] Documentation: watch_queue.rst: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:12 -0300
Message-Id: <20200717185624.2009393-13-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

watch_queue.rst:107: WARNING: Inline literal start-string
without end-string.

watch_queue.rst:107: WARNING: Inline emphasis start-string
without end-string

watch_queue.rst:184: WARNING: Inline literal start-string
without end-string.

watch_queue.rst:184: WARNING: Inline emphasis start-string
without end-string

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/watch_queue.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 849fad6893efa..4c3098b8fa947 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -103,8 +103,7 @@ watch that specific key).
 
 To manage a watch list, the following functions are provided:
 
-  * ``void init_watch_list(struct watch_list *wlist,
-			   void (*release_watch)(struct watch *wlist));``
+  * ``void init_watch_list(struct watch_list *wlist, void (*release_watch)(struct watch *wlist));``
 
     Initialise a watch list.  If ``release_watch`` is not NULL, then this
     indicates a function that should be called when the watch_list object is
@@ -179,9 +178,9 @@ The following functions are provided to manage watches:
     driver-settable fields in the watch struct must have been set before this
     is called.
 
-  * ``int remove_watch_from_object(struct watch_list *wlist,
-				   struct watch_queue *wqueue,
-				   u64 id, false);``
+  * ``int remove_watch_from_object(struct watch_list *wlist,``
+				 ``struct watch_queue *wqueue,``
+				 ``u64 id, false);``
 
     Remove a watch from a watch list, where the watch must match the specified
     watch queue (``wqueue``) and object identifier (``id``).  A notification
-- 
2.27.0

