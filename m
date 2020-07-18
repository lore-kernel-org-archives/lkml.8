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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE672073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ98Nuk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGRQvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgGRQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:51:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC383C0619D2;
        Sat, 18 Jul 2020 09:51:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w34so10032265qte.1;
        Sat, 18 Jul 2020 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgz/bjqrYYuXfJJiYweI1bjndcl+QrBnvt6EE8RcSqg=;
        b=eZ98Nuk97kOV6dWfN8m14a8jBbGWOk9Ftl5lVJdZQSMFYr/4c23JWrX4IFR/LLPJ8g
         ZvWvmkO568a0ssK8u9spN5tnw8R/7QyzgMDYUDF4rUZu2+Q+1QIUgU8GZkWjACB59xxW
         OW5Sqnb9dMZoLs0/EAzM97UEjKAl8fCQPlm6lzZiI11NrPtg3IGr7WUpLxT/suWTX1A6
         qhvIj7PHEzlkbXhF/ch3q+ykoZVVN0Vdyt2IoEdqv5leKCOym2QsvyeI4Z2MmyvZcK/Z
         AuxNIOZScmrAcnRJztHWlGxZrnyhX68oYjf8dfiMQMqQDUNGo/x4RQtXvoJVxO/V2U6H
         1c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgz/bjqrYYuXfJJiYweI1bjndcl+QrBnvt6EE8RcSqg=;
        b=nC+idJohh1bzBVjnt7GGXNecNdNzM1y6ozx5vBBU2e4c5siZOF2Hw6AwY17DaqoukL
         00X9JOJaVuXwbKlwJCtI7iUGR6cO8c8ovUeRU7rSySBsi4L4IrtzID7RGqXVfg6jtavM
         6doOAzFYfqvvmAInY3ErOLenzYZ4fwRCH5O71KsOj/Besp1wNmkDswdG2WyeOCgi1doB
         U6sJ2C36088HI4pTnjgXq66pEn1ybEyuaauP57CZPmCvVxGLUj9wJBsF1GiNj/k6FCnr
         ygfaFZ8QQOlMcUj8zuYc0H4bY5Zc+9iPY/FigNRnkBIUS7be/vcTp7ObN8K2oqNWzBv/
         3njQ==
X-Gm-Message-State: AOAM5317/P3dyvsTAPuR7tuLUfAN5abIb5oK56ClD7RrUBVQ4CFEXAei
        1+cww06yhKwbHVopmXGY4FY=
X-Google-Smtp-Source: ABdhPJzXZklAJ4ZJ0QCecSanri2g0yoP6JHDzBTOQa3w1xuJpEzM6RjfcApT/jw2Ub1lg1vE9JfXkQ==
X-Received: by 2002:aed:25d1:: with SMTP id y17mr15743427qtc.126.1595091081841;
        Sat, 18 Jul 2020 09:51:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:602d:16d:d038:1a92:190d:65d2])
        by smtp.gmail.com with ESMTPSA id q5sm15361801qtf.12.2020.07.18.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 09:51:21 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide/mm/index: Fix reference to nonexistent document
Date:   Sat, 18 Jul 2020 13:50:55 -0300
Message-Id: <20200718165107.625847-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Fix the following warning:

WARNING: toctree contains reference to nonexistent document
'admin-guide/mm/nommu-map'

This was due to a typo.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/mm/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 774dad6d3d291..cd727cfc1b040 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -31,7 +31,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
-   nommu-map
+   nommu-mmap
    numa_memory_policy
    numaperf
    pagemap
-- 
2.27.0

