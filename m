Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FEF20823
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa+zxmlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgEWVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbgEWVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 17:00:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0DC061A0E;
        Sat, 23 May 2020 14:00:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l15so16373018lje.9;
        Sat, 23 May 2020 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/EsWH2Z0Xvdv8zJjOt7cdEn91hyou87YyYLaPvp1v0g=;
        b=Sa+zxmlNg4c4JyBiPsaefryAVRYS6ONzMiCbRBmwpc+hAQNtYDz+lOIxj+ucvehdqo
         ypLmP2uZvIgBWdTDaWu3LfltZpO4GulH5Pgz3H02sv+xcBlYz4oe5LQI1pv01c44md7i
         Jo+F1VZys1v2hG+sClcfy3T/48pEXUIMHTU8Mij5YMtKou+s53bBLTfBeXoiIOf+M271
         LjlgjMJ5FvGIAeoFHQ1ecuUNorIrjgc1iIV1xSFp3vLj054ToUdfHJXfjayJidRx7bHQ
         Q5LUXMHe1NHAnUJrv8uyTP0VsLQ6Fu+py5AAZFpGwhi1KpISLvCn911JBwqbxDlaAxfT
         0huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/EsWH2Z0Xvdv8zJjOt7cdEn91hyou87YyYLaPvp1v0g=;
        b=YZ2UYnYYIeYihnR1VUpjb8RIrdR8NbCuX1Irr4j1s+uLppl3qxLHdAEHkvKGxUYMwO
         kCWs2bj9alBJA3X7TxA6fzy20GBB63PQSGEmbgy0G+wFr9J3nFXfcyq+UlLOuCLMqksH
         DDdi2WRqPD5FN5WnVCEhICxXrVdkNVTs2lzhppRxxCgDxxrlMpPGxh19uyBGQH+78/fN
         /74o/RhduPksOhWL+j3tpkKEZmoA/QfweiF0UWbAL3QF86R9S7CIlnuyRysD6OXEO+9s
         vDWQCqlGWXjIg/Ied9xYHfMrhqPqtKNaIT/ZwgGyAFpq8kfje3f/jHwSN9y8mS809Dj8
         8kgA==
X-Gm-Message-State: AOAM530dzT1B0TYFeB+ht4V4mF8IRxhskhioCGBBvGIdl5EYF5SZn9eu
        hLN010HMR8xBWdktrP0MhFIc5i2BV4UHuw==
X-Google-Smtp-Source: ABdhPJxqC3eua7TiWDvHzfAusUT8WgJI9LirGt3xhFJCsgjp4JjoI0zMuM6j3vW61/66xYpF6S7YIw==
X-Received: by 2002:a2e:b4f3:: with SMTP id s19mr3830469ljm.218.1590267612343;
        Sat, 23 May 2020 14:00:12 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com (c83-250-27-170.bredband.comhem.se. [83.250.27.170])
        by smtp.gmail.com with ESMTPSA id d22sm3320712lfc.27.2020.05.23.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 14:00:11 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] Documentation/features: Correct RISC-V kprobes support entry
Date:   Sat, 23 May 2020 23:00:05 +0200
Message-Id: <20200523210005.59140-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/features/debug/kprobes/arch-support.txt incorrectly
states that RISC-V has kprobes support. This is not the case.

Note that entries that have been incorrectly marked with 'ok' will not
be changed back to 'TODO' by the features-refresh.sh script.

Fixes: 7156fc292850 ("Documentation/features: Refresh the arch support status files in place")
Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
---
 Documentation/features/debug/kprobes/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index e68239b5d2f0..0ed80700bc35 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
-    |       riscv: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |

base-commit: 423b8baf18a8c03f2d6fa99aa447ed0da189bb95
-- 
2.25.1

