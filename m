Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480F8C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FA3206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhFb3laO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgELPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgELPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:49:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06999C061A0C;
        Tue, 12 May 2020 08:49:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so5541123pls.8;
        Tue, 12 May 2020 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eoa1xQNEPX4jXVHUTkSQYPzGJpFeEJnTdyT5mWwO+vA=;
        b=DhFb3laOgiPk+PWrD5AUYNdMsQWNoM7OJfNwxa4Nk/62MzXebSXb0VT4QQhYd5kBXV
         H0qAjrXzy3kNWBfqkAeC9v0hwEcz3ZD3UBdTG37t59DlO4oszwQA5rOWZPS7QKJjqfwY
         62WZxYHMtsSgTu05XLNnRXkjdXbVrReO6gH0P1iQeQib8qmSNnq3C16hvThrbu6HjJL8
         774zYk7oSZia/k4AQesxhvVHjXDl8MbiTLENNn9MXrI5bJifEZ2Rcr9PMt7n2o+SqCxO
         IkLbaav46e4RXrGzgPuwwC4ctR8KrkOuSsi/uPmIIdu9VbD9Z9KgaWD3r+AvZlxGvZlX
         jD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eoa1xQNEPX4jXVHUTkSQYPzGJpFeEJnTdyT5mWwO+vA=;
        b=l8COJN0jRNmNpT+ULBUq8hVRrYYCBYsN6fF9X+7Csj7/QXtruZb7EIl4DZuGdArYmS
         kN0dclNcPNt60z4uO1OXmvwXQKn0Rbx6IzkBe1QNaDNzHSMphIFGABNMZ8Sk2HJFsmJu
         cAHWqrlc0eWhkw4deenOBbqLaVDB8Bj7izmyKf+p4BYZdwIWgPdXhAumiOvraer0yUVr
         bsVm78hW4ycvbe9ssd6iG181dw8JdxzK8krS7OEyMGTYbfzTin+exvH2ENMmZTZjef2g
         herv6Ae9W3dSUeiULeEXH3v0BKXFjbH9xYmqX1OUehhsAo6bCNRGQtlCMVx+sy33k6xv
         sOjg==
X-Gm-Message-State: AGi0PuYakpOdWKFk+mCkYiGy4tNrCbovTLP6XySgw4Wf82659JoXfcOw
        U8dn87Ih1gOkHkM56gbcGZ1419s3
X-Google-Smtp-Source: APiQypK0Ukd8uGnZxzLqwlfbERSLYlhFqF3CVw5MDJ5uGYe9pH6ouz6vyRK7//LCP8ktjqJTWaQsuA==
X-Received: by 2002:a17:90a:6403:: with SMTP id g3mr26372674pjj.99.1589298556441;
        Tue, 12 May 2020 08:49:16 -0700 (PDT)
Received: from localhost.localdomain ([47.240.72.31])
        by smtp.gmail.com with ESMTPSA id b16sm12397954pfi.74.2020.05.12.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:49:15 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] of/fdt: Remove redundant kbasename function call
Date:   Tue, 12 May 2020 23:49:09 +0800
Message-Id: <20200512154909.279788-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For version 1 to 3 of the device tree, this is the node full
path as a zero terminated string, starting with "/". The
following equation will not hold, since the node name has
been processed in the fdt_get_name().

	*pathp == '/'

For version 16 and later, this is the node unit name only
(or an empty string for the root node). So the above
equation will still not hold.

So the kbasename() is redundant, just remove it.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 drivers/of/fdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 8a8e07a8f03d..ea31b2ae8474 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -643,8 +643,6 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 	     offset = fdt_next_node(blob, offset, &depth)) {
 
 		pathp = fdt_get_name(blob, offset, NULL);
-		if (*pathp == '/')
-			pathp = kbasename(pathp);
 		rc = it(offset, pathp, depth, data);
 	}
 	return rc;
-- 
2.25.1

