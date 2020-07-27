Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E327CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 03:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A21206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 03:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgG0Dsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:48:55 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34389 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgG0Dsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 23:48:55 -0400
Received: by mail-qv1-f67.google.com with SMTP id t6so1946776qvw.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 20:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVIOi8enUGpBtLqtmUD4Tl/qpQ9yEu8l3OUS23dMPao=;
        b=cEipDgdfAt9lpLWMCv1Kx6xieCQX5aI27pP2YYBN+qpvCX0JjGG7UrwoQhXSFfyaXG
         WlqDHc2SrYrTCE3tKSZzXtw6LUnbCoE4IbHjK8E2Dh67iCxExAaIChh8iZpD/545zA8V
         g6DKrYvSRiI3vxh+IaxU3W/hUReVyzPtlawCcD2QI0VT6Ise1iTjeXinIVz59VknPRfd
         1udQoKIIVZY81VBAdYxvQ8iy2QCxvAx0E+jddRxEav6vEs/nNSQVEUC6uE86W64fMDPh
         HI+fRy04cjqfGs7h08vbfMoLCHda4kpcBgOrBvcu3YmHqeXInkyxnJ4jm+aZkuJKSjCd
         YOiA==
X-Gm-Message-State: AOAM531Vqqqv33Eiepzx27FZMHP49sWe0t9obEJmDVwReK+VyAVJaLHP
        4ubEZp9dM4dDuT6fqIzhIE8DCbXy
X-Google-Smtp-Source: ABdhPJxfAWjZJYYpQLUq6iCzlAbSQoYClkEl0wXtKgAH4OqroY4oRu+9s+SzTvcBEljuc1PaD+FA8g==
X-Received: by 2002:a0c:9e4f:: with SMTP id z15mr20642425qve.119.1595821733986;
        Sun, 26 Jul 2020 20:48:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b4sm17134861qkd.75.2020.07.26.20.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 20:48:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] kernel.h: Remove duplicate include of asm/div64.h
Date:   Sun, 26 Jul 2020 23:48:52 -0400
Message-Id: <20200727034852.2813453-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have been added inadvertently in commit
  72deb455b5ec ("block: remove CONFIG_LBDAF")

Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Christoph Hellwig <hch@lst.de>
---
 include/linux/kernel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 82d91547d122..ddaaaf53a251 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -17,7 +17,6 @@
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
-#include <asm/div64.h>
 
 #define STACK_MAGIC	0xdeadbeef
 
-- 
2.26.2

