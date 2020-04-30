Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760DC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6271520873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="Eb/eEyZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgD3WMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3WMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:12:44 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781CC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:12:44 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w18so3918952qvs.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+8e16cOdQRUjz5t68beIqqL5FxfhTtgKZlj473a86M=;
        b=Eb/eEyZs/vpxlvhzjl0yHNg5L/G3YYpd/vnGDA3e19ChXB2l1VDf2uGpNUni3sEn9G
         QxnO6RNM7uo/M7PNXukyjY/9lcXjNofE0UMSQYpXP4L/kCb53Y3RW0De2mSNjyC/g9rX
         uEMbMEWz1zvReWekBTsqlBvyJ5n8Fq/gXPFpJnxsRfGjRneRTDyDZywqiidLmZnL8CB7
         JkQzkOJJFVTOxB9x5XdmK82mb6ysupWBdeLVjIv+vRUil7EBIe2kn2Kcdhi+rrwofu0g
         OEnWXaW5c4QzRp+TDjNM5WPb2sGMILUoRt0yF07Yy6xttRwblhTOMbTumbxZabUU8PNJ
         dEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+8e16cOdQRUjz5t68beIqqL5FxfhTtgKZlj473a86M=;
        b=jrS6k6Cm/LJIWkWKicHZOTVBB1yMcfgHXl6aVnvlEqec2/6Clujd4rnuvbEpUbuw5h
         DwaxG2Dkqx+EU7BXaq1bEhA3UQaWFIYSb6Axyng9sQ3/W1mm01+ah4Udf0P7AfZXQGJM
         jP2OhdI2aMSQzXy8ndrX6cX4i9oxwKSBURNjQYTcKyiiwLXqL5WUu8hPPr4IeDxe6+3T
         AgnDHs+uLfpcuIe74jRGaja4feFH/nu5mopxXZvx4BaQhask43BOikRXwYACAwXVksHq
         f8Fxm4zRgEWewK77sRSl61QUq+uMj9yDV3Im7i2QnfalKReTMoB3g55SVNj+x1gmido6
         YfFg==
X-Gm-Message-State: AGi0PubaTMbYJ96l64Uruz080DMI+7xPD345fy4PXL/P96wiOtlIa3rL
        yt/hses7+gjfBkgC9Ei28pL1DLrLX7SaSw==
X-Google-Smtp-Source: APiQypLRs9zog3u+05lAVNaP18w7qNd77encvvxAz4NjUHWfm/b97uwNKtE7Tanzzj9doiwukOH7ZA==
X-Received: by 2002:a0c:ed26:: with SMTP id u6mr1195099qvq.220.1588284763114;
        Thu, 30 Apr 2020 15:12:43 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id i42sm1023283qtc.83.2020.04.30.15.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:12:42 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     akrowiak@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] docs: s390: Fix wrong label Guest2 instead of Guest3
Date:   Thu, 30 Apr 2020 19:12:38 -0300
Message-Id: <20200430221238.101838-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:

Documentation/s390/vfio-ap.rst:488: WARNING: duplicate label s390/vfio-ap:guest2, other instance in /home/iha/sdb/opensource/lkmp/linux_doc/Documentation/s390/vfio-ap.rst

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Documentation/s390/vfio-ap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index b5c51f7c748d..367e27ec3c50 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -484,7 +484,7 @@ CARD.DOMAIN TYPE  MODE
 05.00ff     CEX5A Accelerator
 =========== ===== ============
 
-Guest2
+Guest3
 ------
 =========== ===== ============
 CARD.DOMAIN TYPE  MODE
-- 
2.25.1

