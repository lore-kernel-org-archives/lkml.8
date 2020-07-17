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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6171AC433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3020704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNQ4J5Du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGQS5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgGQS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AF6C0619D2;
        Fri, 17 Jul 2020 11:57:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w27so8413061qtb.7;
        Fri, 17 Jul 2020 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0i8p+ns0If3wT/lvnlMpp8saZ33WmdsIsXppYLHPsu0=;
        b=UNQ4J5DuJBuLRfCSpXQnpjFwOcCsSL9ZgG6eyppZnxFAY9phQjlwmXp1ivueRBK7Bk
         0Fzd09SHyHv3/47QYwppaF8drfi+Bf+OVoxkCKL6bVvlJtHAoT0jk9xQYcazTqUajJm1
         sqBTFo9R/XN3HLaB/Ev04e9yQkZcqe+7T8MaNt7oUwL/YWV8716zgjBjkI/JL3a0BLeu
         NItudlu3rC0hDZMP652vhdrasW7gsH94pAKq37l5xkpSFkH+44Xkjj8d8OFH7vSetqYY
         EBcfrnuidoLYk9iKbEzvYKnixDGXO5IMDCKD8V87Rbeoq+Hyl9BAey5J2lvcKNQ5LGYB
         uAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0i8p+ns0If3wT/lvnlMpp8saZ33WmdsIsXppYLHPsu0=;
        b=PSJ5fCS6KgSm8CuSrghO37SgEwJ/1o/zphjecfQV8hpwDnCN3VoyI53gWCMr2tvhFN
         dPwFBRqQ1nrwzsRrR1Pdw26xZXnXcCKlfMY7TImRLzsWZeCfnSXHKu6UIIzMeqTDS/67
         ApfICoQHvCxd6YQnIF2woDtZNv6zPQvNAc333qlaBf6+/tA0pkJOe0ZL/E0IInaVZxG7
         4f5R/69pnZzT1837NijJN0KDF1KyS1uME2oyj40x7GaKo84nXoSFAJVi2YNPhQUiKvvE
         oXwEZd0orW3/H6ZQFMW8Aa0QPLK2voXYF4Pglzp34trTsbDg34OHZeew4veMbmuAwBPC
         Uvvw==
X-Gm-Message-State: AOAM5334neBx6xKwKUiw1M/I8/LbTTbSmVcmL1utdeD+J6dXVJTcX0bv
        GRO/tGXtPT4jTLY+4l8z6CU=
X-Google-Smtp-Source: ABdhPJxBvPIdCjfN4hOYDr1SOmOUy+c9OuCYJq7KSYz0w0sQcD+STA5WonIddBKvxjIlqi/EoonbzA==
X-Received: by 2002:ac8:35d8:: with SMTP id l24mr12355168qtb.300.1595012230834;
        Fri, 17 Jul 2020 11:57:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:10 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] Documentation: events/block.h: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:07 -0300
Message-Id: <20200717185624.2009393-8-dwlsalmeida@gmail.com>
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

Fix the following warning:

warning: Excess function parameter 'error' description in
'trace_block_bio_complete'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 include/trace/events/block.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 1257f26bb887b..f69569b70d44d 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -254,7 +254,6 @@ TRACE_EVENT(block_bio_bounce,
  * block_bio_complete - completed all work on the block operation
  * @q: queue holding the block operation
  * @bio: block operation completed
- * @error: io error value
  *
  * This tracepoint indicates there is no further work to do on this
  * block IO operation @bio.
@@ -639,4 +638,3 @@ TRACE_EVENT(block_rq_remap,
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-
-- 
2.27.0

