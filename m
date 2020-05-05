Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C3C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F55C206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fl8nSvJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgEELy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEELy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:54:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2AC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 04:54:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so1307860ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uml5U42DUBDTh4vmv37IC5qSO5nYUkK5/4LFg2c0Ji8=;
        b=fl8nSvJhFZ0g5sbLGBqmv9Jt5aq4btP+PN321WfcrkM1oPwxWcTa24dNUSPmmEeocb
         M0/kSkMgncARzOWJNF+ASfjXvhDkxi5QGZY7PJtVL3qvrKD24k8UYRPNSUhXOhx6J564
         6k+wAnULsYQvmYYLLUG+B+55gLYS9gBe3VPBKld7R5+AIl5f/A4p+QslqkAz+xtEKx6b
         3Mg1s/iKCRjUPBqxFxk4UJ13JkOEoTN7XfrNXQqTj4epqqN0zc28k7zscqYo5iFaSLFm
         5ZiehNIJSLslbol7hT9Y8z4SG1W8hcrNV3UiPsT4bwssIssZaqS0KJLhzaOr6JdK6VKX
         8+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uml5U42DUBDTh4vmv37IC5qSO5nYUkK5/4LFg2c0Ji8=;
        b=GEJQmpIeXU6HQkGPB5Na8/HMAUOvhiMLWOzeRJY0OngDCwUrIjsVO28zgYYNHd7PTn
         CD44Tw2qi7U4EPXGUy9iMqvLl41P0r5sG0zfBwCICu1Qoo6M+Lzyu5WcIcH1WUkdXx75
         wLnGsVkOfUPDllx3AMWGnRU/pMUsVfwYahM6W7RHY4eR+HL9rg2bHcyBcYn02PH9gceJ
         HtnPkcbaCSswKdvjOiY5guCDBLHrJsrwToZXig5Qb8/4qwonckoTuBhUZq18sE3PP2r6
         yfTiVvYyovex4JKYyStueowB6+l/QpwGzbLHOiXd0TzO3Hu0HRZl+20DYmqkXz+M0y6K
         ioCg==
X-Gm-Message-State: AGi0PuYNYbSkJYEuSzQyTyDAUbP2lAn6H2Lq/sxNlTH40UwMDHH/tgTE
        1vuhqzfBKMx29ee4YxGN0Kz8DA==
X-Google-Smtp-Source: APiQypJnwDsbvj52jO1SlptQqc2ppigC6TLoB6HZ7LPx7W3OJyppghiHk6hhdd4a8VsxqxOW+U2HXA==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr1584565lji.31.1588679664636;
        Tue, 05 May 2020 04:54:24 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id q26sm1612347ljg.47.2020.05.05.04.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 04:54:24 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] scripts: fix deprecated always and hostprogs-y
Date:   Tue,  5 May 2020 13:54:20 +0200
Message-Id: <20200505115420.18765-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I did an allmodconfig build the following warning showed up:

scripts/Makefile.lib:8: 'always' is deprecated. Please use 'always-y' instead
scripts/Makefile.lib:12: 'hostprogs-y' and 'hostprogs-m' are deprecated. Please use 'hostprogs' instead

Rework to use the new 'always-y' and 'hostprogs'.

Fixes: ee066c3ddf7b ("kbuild: warn if always, hostprogs-y, or hostprogs-m is used")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 samples/watch_queue/Makefile | 4 ++--
 scripts/Makefile.build       | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
index eec00dd0a8df..8511fb6c53d2 100644
--- a/samples/watch_queue/Makefile
+++ b/samples/watch_queue/Makefile
@@ -1,7 +1,7 @@
 # List of programs to build
-hostprogs-y := watch_test
+hostprogs := watch_test
 
 # Tell kbuild to always build the programs
-always := $(hostprogs-y)
+always-y := $(hostprogs)
 
 HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3665b1a0bc8e..abdba70f33a1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -15,7 +15,6 @@ obj-y :=
 obj-m :=
 lib-y :=
 lib-m :=
-always :=
 always-y :=
 always-m :=
 targets :=
-- 
2.20.1

