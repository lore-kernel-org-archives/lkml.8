Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C2C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B55B2176B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClIGS0yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGRQv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgGRQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:51:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E094DC0619D2;
        Sat, 18 Jul 2020 09:51:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b185so11604228qkg.1;
        Sat, 18 Jul 2020 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9YXkfG4mae7D/kQPuWy1/wziMNrDLom8h0lx0qxbpY=;
        b=ClIGS0yTVQUP9UjBPM38xmFMOUmn04jnItF9s1DYLC8K64D8rV9Pz63EtBv0B7KMYo
         dtoNzWBNMZB3dFD992kQ93fLUuJOVakIq3fJi2okYfwiJSVhyXuznp8Kils4tL+314q2
         icC5zVIL6dwr/ydP9HHDQBlH9OXBfzrq0LIP5CCS++9S8F19MJ5EBAmKimdnWLiTq5FA
         1rFp9uoJyTQ2wKeHuuOapUr99uekPhwdnWFhQ3Bxclvc/l5pjpYU8Sx3vdto0uKr079T
         Z7A6OhbsjPiS4nEQ9AIv00ziv8h8D6b0bZOkSMAR6xu9US+gQKUUOdnFhcvS6L0U5jiC
         zLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9YXkfG4mae7D/kQPuWy1/wziMNrDLom8h0lx0qxbpY=;
        b=VGBhW3Pwu7GzuNtYWN+RzGVmjgSIFj7FWHk1UGsoV/rsY/m80G+5Z14WGPiY2BWA6s
         KxkmbnlIMU2PR4KrVWdRsPEWoYY2wI+K7J5riDNL/hPZsgnOcfy5OMDe26v6ZIXwMDHL
         1H3p95bLkedbqcxEpAuzNEhugIPdIKBTuztL5GBES3HZJTfKLpBOfj6q50cSvlfCqoyW
         CsYG0MlnixDPmt/gzs0U3jIM3M7D/p04DaUQIt7pmF1kpi5jQmlSpY1CzEbM9zdfTVTT
         aanZNGG1yJ/+hiQt9AMRhv1KwVHCKCOp4/LteKCHtX8N3OXARRKl7p+ME3xOYJo+ZVCk
         P4WQ==
X-Gm-Message-State: AOAM533SPTNBD6vMErcYm8c/3jrgxvQx8C6AwwPZdTbdz8QgGjHCHtTs
        m1+2msCrOxEYUQJP+gIpTooIO5wc
X-Google-Smtp-Source: ABdhPJzdZNP/o5fBHD0pspMNziAHHlaWNZ4Lp185t93jzxIgXOnPLThIOS4fTWaR7iUnjVLJYE+QbQ==
X-Received: by 2002:a37:b941:: with SMTP id j62mr13845168qkf.233.1595091085112;
        Sat, 18 Jul 2020 09:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:51:24 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net
Cc:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: watch_queue.rst: fix malformed inline literal
Date:   Sat, 18 Jul 2020 13:50:56 -0300
Message-Id: <20200718165107.625847-2-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718165107.625847-1-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fix the following warnings:

watch_queue.rst:107: WARNING: Inline literal start-string
without end-string.

watch_queue.rst:107: WARNING: Inline emphasis start-string
without end-string

watch_queue.rst:184: WARNING: Inline literal start-string
without end-string.

watch_queue.rst:184: WARNING: Inline emphasis start-string
without end-string

Multiline inline literals are not supported.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/watch_queue.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 81d9d322b1c8b..d98af4f11804e 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -106,8 +106,7 @@ watch that specific key).
 
 To manage a watch list, the following functions are provided:
 
-  * ``void init_watch_list(struct watch_list *wlist,
-			   void (*release_watch)(struct watch *wlist));``
+  * ``void init_watch_list(struct watch_list *wlist, void (*release_watch)(struct watch *wlist));``
 
     Initialise a watch list.  If ``release_watch`` is not NULL, then this
     indicates a function that should be called when the watch_list object is
@@ -182,9 +181,9 @@ The following functions are provided to manage watches:
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

