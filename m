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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5181C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Y8bY0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbgDBBZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:25:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39392 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbgDBBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:25:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id k18so716759pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECaKk1XEhaLeQWM1QY7b2cbJfc2H+NtdzI3cEs6W3bc=;
        b=e0Y8bY0Qfsg7n02ddZ8uiswipY9fuSgKm6X1sbnDAv/lfkxMia058WZBkqhK1Shm17
         rbhURDSsKfGqJjKOlUlUV1hPqO/r5cxIWXuo9ebuaF40Cwx1NIv7hgfZMYswHlnED/uy
         laXWmR2WR+D2bLl2xpsyRKvB0q1LRWQVbwujyCMO2IHN7v2HyE4eonQeMS3SafncKKi9
         a5LEam9Ct4DCAiN63J2BaN5vV43vEQlKajNeDrT0wioFYYpGMIJpTJQ8+Z2XAvX1LnzC
         wY/Y10MjzbOx4iwbFW0KTzL8oVlYWuoOPNiEIHLJXBzBwB4He1uIlnNFMg7OraR5KX3D
         xWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECaKk1XEhaLeQWM1QY7b2cbJfc2H+NtdzI3cEs6W3bc=;
        b=e9BGjkM5oqPrJILd+HSRSLkH+Qg3w+ztXaR/BPQlKb6mXXRx3k2mmOQljrEljazOyC
         wcfvsBfBUvoABymVflsdUmS02WmY8U8auUlCE3540oe3AUo/Z1KkF9zWKt7AoXzMmXlt
         4M1+OBIRh93X0EOPCMEO9rYdi/bi0/u5uzeoLB/Un5GSSURnn0VhSLF+SxM+iE8Y4gdl
         yS6Jj1ea2JT4PLQXtNwa9rJpDuJoOScIQYY0WFzodg/+4Kq5k4DhUHtxdRCKh/09ai7p
         myyLyjoRYIoJK0RNAyBuALYnyQ9H9D1AkIpb+SYyZXxMJTcLETBiLRfSyabxi3Ee6P2D
         twWQ==
X-Gm-Message-State: AGi0PuZ24Xtpw4yzwG6eK30kn0Iz+PYS3/fz9hF8AdV65vKWloC7zIJQ
        Yp1PASAiQzeyo5+P4X8alzA=
X-Google-Smtp-Source: APiQypLOFU9FlGJw8iOOANTLu4h97F20JAA88jZyZ5O8imCDYlYaifG5zMltxu9kuj6+J1fWyc7dAQ==
X-Received: by 2002:a17:90a:36c7:: with SMTP id t65mr946992pjb.182.1585790720459;
        Wed, 01 Apr 2020 18:25:20 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id q71sm2516633pfc.92.2020.04.01.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 18:25:19 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH] staging: android: ion: Fix parenthesis alignment
Date:   Wed,  1 Apr 2020 18:25:15 -0700
Message-Id: <20200402012515.429329-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 2 parenthesis alignment issues.

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index f85ec5b16b65..0198b886d906 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -37,7 +37,7 @@ static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 	}
 
 	mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
-							1 << pool->order);
+			    1 << pool->order);
 	mutex_unlock(&pool->mutex);
 }
 
@@ -57,7 +57,7 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 
 	list_del(&page->lru);
 	mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
-							-(1 << pool->order));
+			    -(1 << pool->order));
 	return page;
 }
 
-- 
2.25.1

