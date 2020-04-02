Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239ABC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E42072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7DVZrtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbgDBCRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:17:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36548 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgDBCRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:17:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id n10so1025946pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJrKI3sOaXRTv8Ad0U4S14lgWrsWnjsKnTjS+Kfpaeg=;
        b=S7DVZrtOCYLWFxSlZDxASKnuu6BLf21ZDe1ULQhiC5q0zG4NKGkp5yQDFHTBoKasDY
         8uJMxCSW/0QQAtzb2SPx6AL6kXD6tkLqnhuyx2XAeqMLd4LaYSNE386Y6tnYpD754WbU
         RNoRloJ3fdaIfilUPxvatcVvLAK4zMV+GMvu63+OLEjYlZtx1JQhbfz8AL+T5rnNoXgN
         W7t0BAqzKKJv8uPLbcoCvw1GMVGtvupji5eXEMvJnN/QL4ypFJRHvPe4b7ZquT5ICZgQ
         50TRT05Z96IrORh8EzyKlgB8is83nqJY66ACg/C3b/WQugXvVSBWBDAAQycSEIVfVFXk
         tYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJrKI3sOaXRTv8Ad0U4S14lgWrsWnjsKnTjS+Kfpaeg=;
        b=bBNysFscqa/R4l2U3PrAlI4/on1FcqPQGXlQb1592BR5On3yewIpy81/3hgNY48/Du
         vXw0iTOJUogFAapvvkItabc6lcAs5Uxhg9unDzGbBRkv9iCbZnM7ZMolFik2KdCPzPEi
         4OtHc31ip1FsEo5AFEWP805MZi9t3qS76YwMKZmIL1N3dgjyqtsnYE1qvz/ehbGraSmw
         o4Q/uZ8pJv0TaRxhKwriBKtxMnKksKbp1Dray0gvIc0u783QLCesIWGPD/O979ZXi90c
         dxNF0dIL3rVKYnqOJVgCTIOlZu/fAQDEGlXFxGLv+zSh7vWwtomGabB5TQykaa/xCyxv
         u7CA==
X-Gm-Message-State: AGi0PuZ3uBz9en1d5oBBR7TY6smwqsEZmv9mrenPYtujY/NZlpZbhZVn
        pUcQG5LRcS02yG/biVPqsJE=
X-Google-Smtp-Source: APiQypJtzG1x7/tlvsBjnXDIXaqdyRaDJ+l/Lb06RbRnLFxkBZmjQuOMnPH6KfKA/dY3vGnuvu2YSA==
X-Received: by 2002:a63:e558:: with SMTP id z24mr1154919pgj.368.1585793831273;
        Wed, 01 Apr 2020 19:17:11 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id c1sm2595336pje.24.2020.04.01.19.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 19:17:10 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH] staging: emxx_udc: Remove unused code
Date:   Wed,  1 Apr 2020 19:17:06 -0700
Message-Id: <20200402021706.788533-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused code surrounded by an #if 0 block.

Code has not been altered since 2014 as reported by git blame.

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index 9c2671cb32f7..bbfebe331033 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -9,12 +9,6 @@
 #define _LINUX_EMXX_H
 
 /*---------------------------------------------------------------------------*/
-/*----------------- Default undef */
-#if 0
-#define DEBUG
-#define UDC_DEBUG_DUMP
-#endif
-
 /*----------------- Default define */
 #define	USE_DMA	1
 #define USE_SUSPEND_WAIT	1
-- 
2.25.1

