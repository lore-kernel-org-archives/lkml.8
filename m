Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CBCC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E9320731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="uMSIOfAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD3UgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgD3UgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:36:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EC3C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:36:18 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so3748645qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B784zdzXLuU3MW7w8JpAGL5gMXtYDpBs4T/kLswGdYI=;
        b=uMSIOfAsn2hFGW45mcZRbvdrR0oZuPg46JRxQwd1lkwbaW1tw6jN0wtEHppuz5Pymc
         n+Y4RPXGucXE1ycwIGNO881w3MuJPfHQ9+AukN0Kr7jXSLyDsPEfsp6+V26u5lEeAAXR
         raxEz/VZOC4NpQSPTOjRxCyXgHAIO+E2YIdOCDbeZzoFznoyUfS0yaPv4bfRbkFTk9Gp
         yKj2IQmVAY+fL0ZvvRZ8yoBmC3BDIEOfdVUBGaLgKLLiCi8RnDs9YjPiZFN2nlUESzwJ
         vUjhQAc65LmMgTJyyxiGcH25a+/n5eqfhxh71vFy+0kVmRU1druUsoLoMT8Of73qIoaG
         GMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B784zdzXLuU3MW7w8JpAGL5gMXtYDpBs4T/kLswGdYI=;
        b=k82BLQaJhb3zxLbbjAOjoPUcLe7IVPOx0gFla76VAycseDCcqpkyiwdlU1ZGwOF8qU
         O5zPqqzFM/wSngQoryf+60swKQwEFl10vtV/OvxF0fClZwEg0tKYU2xcD0Y7iWtK1W78
         LzfsOd0uZhvvE+CWVFDKjmbSlIM2+kHc1NheXDqF1bUQ0iwpdlKR7SFqm8GFdeOt6HME
         PpxLkzEhIDPV6fDw3uIYBNDQjsRcn74qeu2Pvlvr0alOb7TBbPPDMtX2FUXjUEu/FfLe
         4DMqPJSDxHm0XrFowUSFFDxeUozYB+g+g4WIFcjt49kiWMTu/ckHDIvtSdSe0k4Aj4+V
         Mf9w==
X-Gm-Message-State: AGi0PubeVutRW76dBZ9SxUjOgsNO3cqOiFD/TD3McRlUJ40OcGMgZLS3
        yKUOR5tsUehCEoa5GHgc9fdM1w==
X-Google-Smtp-Source: APiQypLRQfPe42Gh0WlpFSxgINU5DSIJ3P7SrZAZXQDw5bA7/LeWQ/gEeg9sdUq15sUWFrw4nBj+xg==
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr832303qvb.122.1588278977081;
        Thu, 30 Apr 2020 13:36:17 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id v5sm926589qkg.9.2020.04.30.13.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:36:16 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     mchehab@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] docs: coresight: fix `make htmldocs` warning
Date:   Thu, 30 Apr 2020 17:36:12 -0300
Message-Id: <20200430203612.90404-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix `make htmldocs` warning:

Documentation/trace/coresight/coresight-ect.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Documentation/trace/coresight/coresight-ect.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/coresight/coresight-ect.rst b/Documentation/trace/coresight/coresight-ect.rst
index ecc1e57012ef..a93e52abcf46 100644
--- a/Documentation/trace/coresight/coresight-ect.rst
+++ b/Documentation/trace/coresight/coresight-ect.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+
 =============================================
 CoreSight Embedded Cross Trigger (CTI & CTM).
 =============================================
-- 
2.25.1

