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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF1EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC47A20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3bc78NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgGQS6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGQS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD3C0619D2;
        Fri, 17 Jul 2020 11:58:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so8420772qtv.8;
        Fri, 17 Jul 2020 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saknfDjdL//qlbptxMkfiFmoeqGGkft+AapmeCiHUwU=;
        b=H3bc78NS4IL74Wp4i5HqemqCvidGQILZsd0xcviIacMyByC1HdDa3fr49mDG08eYfE
         dcdGXzplPwlni0RmMYYoPklmBOsweladiNwr28NvwQzQuslTK0MArpIB3Is5l3ruUD1R
         CLUCQRAjudryHH9sLF3iodJGZMj9gaktdt1eBl1Kx8UqgL4P3BtmpH96DrAJ0Y3+97cd
         n1nJ43zdJD2HrVCMq8lScc9st45Wpt3JfghpraP5E8VW5W5V60WuJxrjbfmAJVdyMNo5
         wzcb3GgMvlCNDm7zjRD1M5/TNu6alu4XVD+gAV2Y4yZrs1/isk2pyQ622hXTgcF4Tapa
         1gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saknfDjdL//qlbptxMkfiFmoeqGGkft+AapmeCiHUwU=;
        b=oDug5SRasaA8hRKD7Yp42MD6d3zPyTzDY9k/EnTOUUISDePmaBLVmkixFw+mFhpvtl
         AZ62/FcHBO1fNhvUUu0XQ0LaDectrXM7TvOtEiPJmRHJmBLORYcBfrnT6EeN6zIVPDab
         rQJHD/5XDHlA2MzyC2uHdr7EexXZfpPn8LqUYDfPKHBHpufdLP+pjedD5aJCpnn6MlPa
         P3Cs5dLz4DiP/H6GJFJzXZdauzo1av44tAu5q0BMYdneJB1bWSMZq7xuwP8Z5aaBxeNY
         Go9BCkU5c9Wb7EOXpA8Hmneqmpg1VYlfhCMoBU2D5hyFCFPqfjL/2/i7m43mgJ3lD0CK
         O32Q==
X-Gm-Message-State: AOAM532435eFC0suWERk3T+XKJCbxjAgjPgIShvqe1mGvDwJe0zlxdv3
        m79DLkSZXLvnmo+j29mE7ri/f6gw0UY=
X-Google-Smtp-Source: ABdhPJwjo4b3Zfi5yJsOCPZS3ONfEJZfSRRyIsJXN0DkdzWqsehgDzpYK+kFl11akYAaNSsY13mcbQ==
X-Received: by 2002:aed:2cc7:: with SMTP id g65mr12182806qtd.248.1595012298531;
        Fri, 17 Jul 2020 11:58:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:18 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/25] Documentation/core-api/printk-formats.rst: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:18 -0300
Message-Id: <20200717185624.2009393-19-dwlsalmeida@gmail.com>
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

WARNING: Definition list ends without a blank line;
unexpected unindent.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/core-api/printk-formats.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 8c9aba262b1ea..01b86bd9719cf 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -494,9 +494,11 @@ Time and date
 	%pt[RT]t		HH:MM:SS
 	%pt[RT][dt][r]
 
-For printing date and time as represented by
+For printing date and time as represented by::
+
 	R  struct rtc_time structure
 	T  time64_t type
+
 in human readable format.
 
 By default year will be incremented by 1900 and month by 1.
-- 
2.27.0

