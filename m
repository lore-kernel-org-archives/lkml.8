Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C48CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3550C20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQJdL1or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgGAMrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgGAMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29880C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so23637032wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phaHepEqEbU60VSdrxFqwpC3YbwLDxmZYay7m2R57bw=;
        b=JQJdL1orTD6yrnvu+G+Eb/HXTwwA1BYCd5yp8o/2fk74PgM7jUblE5zVqfHqU3Swq7
         EnCEMIFQOVslHGPA3VVxtzqf50unu1X/ugYbWoRwdC2gV8eLP194tZwfLF3qdwhMqiFC
         XuW41gKAyIJu/cpdbgQOOiGHnPuS7UP3a7vc8kC1P/O2/4VyLf1l+mZfUR2zrhp1/n9M
         UB7CHbqjd0FS0AytCmPJ8qTC0izQZsLz/vA6FYkp5RESKM1pgkjbWCafgr78ZiIIi2BK
         4GAoFq2K2JGd0y83LhXd8gmI4GDS7sNs/TacfyBk/2+G9VMK3lvuLTwVgcf6Lrq/13xl
         qpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phaHepEqEbU60VSdrxFqwpC3YbwLDxmZYay7m2R57bw=;
        b=R0HLfBsx4W/UDYzKVLODUx7wYXJrDMDtI1NsRxltYAPheRzd6WqTK81j+Mvwgytq/5
         /AmaFSU5vbxQD4X0H2yNbIT2zgdq73SSZYYeICDQyHSQc4lgncHW909AyxQIeMub4Qto
         d++Thux8N1SWgNuErAZrd6b/rdmjHzR1kY3O6aQ7Iv/OjeALjIP9ELkg09dF/Z1x2MVb
         9vdWzEuY/V/uy9pjHTXDrYEKBT2KOEEtsM6F6hZNH04TCaV4cOjwRFxisN+PeH+Aui1O
         vppIRzECUVRFLqFOksw10WW8s3SRdDdYTx5EX+AK5lkiIXI6cOheNpEYnqDOZGD4tbwx
         mnAQ==
X-Gm-Message-State: AOAM530ToXSBncIkauTqLE0DGcnSswjrRQrfngEuFce7o2XjrrmF9gze
        dEaHYsjNv+uyQbR7LLzBETJ7Ow==
X-Google-Smtp-Source: ABdhPJwgwINDi8Vx2k78e0LUbFfG5zxBt7MBPPGrr1Hcrg1wwapdPMMvrt5k5hC8U/MQ7E7z0g1dog==
X-Received: by 2002:adf:e701:: with SMTP id c1mr27181289wrm.350.1593607634878;
        Wed, 01 Jul 2020 05:47:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/15] mmc: core: queue: Correct misspelling of 'mq' in mmc_init_request()'s docs
Date:   Wed,  1 Jul 2020 13:46:54 +0100
Message-Id: <20200701124702.908713-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correcting this misspelling squashes the following W=1 build warning(s):

 mmc/core/queue.c:212: warning: Function parameter or member 'mq' not described in '__mmc_init_request'
 mmc/core/queue.c:212: warning: Excess function parameter 'q' description in '__mmc_init_request'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4b1eb89b401d9..6c022ef0f84d7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -203,7 +203,7 @@ static unsigned int mmc_get_max_segments(struct mmc_host *host)
 
 /**
  * mmc_init_request() - initialize the MMC-specific per-request data
- * @q: the request queue
+ * @mq: the request queue
  * @req: the request
  * @gfp: memory allocation policy
  */
-- 
2.25.1

