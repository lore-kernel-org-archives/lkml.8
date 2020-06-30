Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35D5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F39206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBX0I1Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbgF3Nw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388313AbgF3Nvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727AC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so18905146wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU99x7wrPL/01EJwaTy/8jjc+2wcUgkGTNBMFf55IvQ=;
        b=DBX0I1Xoz1RB0rHsREV4F1DBHNvh6YXcIk5gJTQM+hrPpe/ulAYPEBf3SY/1fdFdwQ
         iTLLW0oG7YnIeQaEnVmgmsJxPq85bgnw02059tpG1WH/kSFOUkX9FEy+MxGDMeN8NuNZ
         TJcEhQPSsDI3Dm8CYkl12pqFw0v9tlzqY1n/QV0VEBd2omHuCM4utDdThU+PIvkGKd7a
         ynrV+MLQC0MeV/7OtudGaup3/p3XVgsYmofHRBHLFBgC0T9HvJI+yNsd+Ztk3Hcg/6dQ
         eMDPtojOGYIvAeDvoMdE/+U/0BjMDImQcGQUOYi/C4KFtRvT9ZhWC5UwQGYgPoBJtmLD
         1y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU99x7wrPL/01EJwaTy/8jjc+2wcUgkGTNBMFf55IvQ=;
        b=MfjRmyBggwRF5zZM8dnmAnZWxDk98nFe2ZrJKsTNMzayhMZdypTwY/z3aysEEy1LWZ
         AMwDIuguIVLLv7pUBNmskyeC0c74gdmp1+T+qtlqDwHjZDi0yIRTOeftcEORWR66Zbji
         9ZvnikYYrwRrbe3yOB+6Skaas5Fsx98aKddvBEsU2hRRTdc/Up69CSX7/waKCHgc46WC
         WqJoi5Cc2Zvf2dwS98c9c9UKissDB8vpVKcXyy7T+y2XakjgcEI/oUA+mD7A7nArzFj8
         +G8RVIaZ2oKLkgA2+oNAdbeV2OnJgG8K+GQTLwQT7nFNWu/r6fyxr5BDz5sHYbQ+JV4S
         9RFg==
X-Gm-Message-State: AOAM533H1ngDhcj0EAdfzb4g21rPS4L+u4hbr3iZDov7EMFFAeGojM1K
        6mZBO5xT3Iv2fYQxCvtLCrPGqw==
X-Google-Smtp-Source: ABdhPJxxX6DLAxnAOLXJaTGQjMHo/F+wmeM2ttmW7ZKu2Qki+qguyXmwlzw33EFjUo8ZheSVrZSmCg==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr21826376wmk.77.1593525098319;
        Tue, 30 Jun 2020 06:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 23/30] misc: mic: scif: scif_dma: Fix a couple of kerneldoc issues
Date:   Tue, 30 Jun 2020 14:51:03 +0100
Message-Id: <20200630135110.2236389-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly demote scif_rma_destroy_tcw()'s header to a standard
comment as no attempt has been made to document any of the
function arguments.  Secondly, provide missing description
for 'prot' for scif_register_temp().

Fixes the following W=1 kernel build warnings:

 drivers/misc/mic/scif/scif_dma.c:110: warning: Function parameter or member 'mmn' not described in '__scif_rma_destroy_tcw'
 drivers/misc/mic/scif/scif_dma.c:110: warning: Function parameter or member 'start' not described in '__scif_rma_destroy_tcw'
 drivers/misc/mic/scif/scif_dma.c:110: warning: Function parameter or member 'len' not described in '__scif_rma_destroy_tcw'
 drivers/misc/mic/scif/scif_dma.c:344: warning: Function parameter or member 'prot' not described in 'scif_register_temp'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_dma.c b/drivers/misc/mic/scif/scif_dma.c
index c7c873409184c..401b98e5ad79a 100644
--- a/drivers/misc/mic/scif/scif_dma.c
+++ b/drivers/misc/mic/scif/scif_dma.c
@@ -99,7 +99,7 @@ int scif_reserve_dma_chan(struct scif_endpt *ep)
 }
 
 #ifdef CONFIG_MMU_NOTIFIER
-/**
+/*
  * scif_rma_destroy_tcw:
  *
  * This routine destroys temporary cached windows
@@ -332,6 +332,7 @@ static bool scif_rma_tc_can_cache(struct scif_endpt *ep, size_t cur_bytes)
  * @epd: End Point Descriptor.
  * @addr: virtual address to/from which to copy
  * @len: length of range to copy
+ * @prot: read/write protection
  * @out_offset: computed offset returned by reference.
  * @out_window: allocated registered window returned by reference.
  *
-- 
2.25.1

