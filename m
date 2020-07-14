Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1EC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03C121D90
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olMroX2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgGNLUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgGNLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:18:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E7C08E8AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so4774334wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6/z2bmjZMbhtqS1hEM9SRMyZids/5Sm1LJ5PQCQzW4=;
        b=olMroX2nvIY5Lf+mJdh7YdFYN9DJVM3DML7ddb9rOUmNTds3C+m2JdC3mqOc4y2yki
         oCjN/ROWc7AHqc9tDEJzhS48Ft6N8WDIfr4nT2lTE5jdLWQGIWrolpNjO+lPcicdCRRM
         2fCsqXPM7bJUnvwrgFNVo7ICmUoZdIFs0+zJzOFi3XIgI9grTk89B6Pv4TQQAvkhtRye
         9sjSmijV4C2Z3rQ8tSb74WzoWGcSTqF9z7JoxwTfy5DhX28xoARq2ihF4ykZe7GW8r58
         nDxZdTjaN05xW+eeHH3pFOqwpav7WW2J+QyIHz+GahF3UcEzGl7obV8i3hDK+YXlBs7R
         Pf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6/z2bmjZMbhtqS1hEM9SRMyZids/5Sm1LJ5PQCQzW4=;
        b=qfm47azfmCw6qBpdMNPumMlyNn/skmcpW86n1x7rskCUent4x8dgwnXapIfYHl9tXQ
         A7ns7s/47rj/JWoaQ6vCiRP1/hUPqLzKiUsXdPjEgUfHHCi2yJEjrTSEzG4/OUnmtMOb
         QLaORKw2si8QZDQl2eyJ+HYC34Nfza2XjVFPcQK2bnkSlf+IVFqzGxElpIIl/5lvnQCe
         cUEE6BgqxBcqrz0l++iqIh0ecjorPbVQPjMJkdhA3ivwe0VcE4wavJHnS2FAg6J8Xwog
         D4uNewJRtAPV7t0qtAHSWEJyRlrns6WmAwp9uq/Zv6I4DOR+lq+yLQvwG4Eae5eHzM8n
         1EJQ==
X-Gm-Message-State: AOAM530UNeSbeSRZTe1pRPCT7olZKT0V5OLyorbNJcva/cx9251nwZoy
        2XscY/FaJ1lvm6yq9/Fe2WblZw==
X-Google-Smtp-Source: ABdhPJzfCBA237+MDiPPiC6gnBUiuuivn5CvYJKDoBxN2PB52EY3xNb72wTKP7tCyZ9qJUnt4SpQXw==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr3892120wmc.150.1594725369516;
        Tue, 14 Jul 2020 04:16:09 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Leonid Ravich <Leonid.Ravich@emc.com>
Subject: [PATCH 17/17] dma: ioat: dma: Fix some parameter misspelling and provide description for phys_complete
Date:   Tue, 14 Jul 2020 12:15:46 +0100
Message-Id: <20200714111546.1755231-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/ioat/dma.c:202: warning: Function parameter or member 'ioat_chan' not described in 'ioat_update_pending'
 drivers/dma/ioat/dma.c:202: warning: Excess function parameter 'ioat' description in 'ioat_update_pending'
 drivers/dma/ioat/dma.c:465: warning: Function parameter or member 'ioat_chan' not described in 'ioat_check_space_lock'
 drivers/dma/ioat/dma.c:465: warning: Excess function parameter 'ioat' description in 'ioat_check_space_lock'
 drivers/dma/ioat/dma.c:591: warning: Function parameter or member 'ioat_chan' not described in '__cleanup'
 drivers/dma/ioat/dma.c:591: warning: Function parameter or member 'phys_complete' not described in '__cleanup'
 drivers/dma/ioat/dma.c:591: warning: Excess function parameter 'ioat' description in '__cleanup'

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Leonid Ravich <Leonid.Ravich@emc.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ioat/dma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index fd782aee02d92..a814b200299bf 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -193,7 +193,7 @@ void ioat_issue_pending(struct dma_chan *c)
 
 /**
  * ioat_update_pending - log pending descriptors
- * @ioat: ioat+ channel
+ * @ioat_chan: ioat+ channel
  *
  * Check if the number of unsubmitted descriptors has exceeded the
  * watermark.  Called with prep_lock held
@@ -457,7 +457,7 @@ ioat_alloc_ring(struct dma_chan *c, int order, gfp_t flags)
 
 /**
  * ioat_check_space_lock - verify space and grab ring producer lock
- * @ioat: ioat,3 channel (ring) to operate on
+ * @ioat_chan: ioat,3 channel (ring) to operate on
  * @num_descs: allocation length
  */
 int ioat_check_space_lock(struct ioatdma_chan *ioat_chan, int num_descs)
@@ -585,7 +585,8 @@ desc_get_errstat(struct ioatdma_chan *ioat_chan, struct ioat_ring_ent *desc)
 
 /**
  * __cleanup - reclaim used descriptors
- * @ioat: channel (ring) to clean
+ * @ioat_chan: channel (ring) to clean
+ * @phys_complete: zeroed (or not) completion address (from status)
  */
 static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 {
-- 
2.25.1

