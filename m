Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4620C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70BB2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kmi45ixE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgGAIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgGAIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F34C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so22892211wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU99x7wrPL/01EJwaTy/8jjc+2wcUgkGTNBMFf55IvQ=;
        b=Kmi45ixESDHOhqIYiUTUX5GGBbJkgWv5XCYsOTKDIZXZHXdCVyrvmprS5/DFthaPKz
         DLJNAGYrGhCqD7ugLtTtXQDJ4U6mLA2DlOhUSYXtnTGrgV/NvWJ6ZAqSQLVB0l09Qzvp
         tYB+SLgqS+MkEUHGgBuU92LgXm2kyHgAXkeNcGfLWQopRjM9xJHsH7hrbwNAVaWFBsDt
         vVtWLSYwCmz0aq6f4JAALuZRSsz0C7etUPf4wF5d+wd9hRIkpO0xStsPo9WsU9DtpJDV
         OLHF+5/Q8JXISaB4D5jc8ATX0D/1m9/9kXTy5S+z2xD9dA5r/tsU5azQnkahP3PlxgQ2
         4I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU99x7wrPL/01EJwaTy/8jjc+2wcUgkGTNBMFf55IvQ=;
        b=hItZPKAtlt3lwUYPlc3blwUrUXm4M4sAboeVuLdRnujLoa42CsFRSYNl+VGl3zDyQa
         VGXmz4OfHDpZaoGiC8rG7x1VCICm52tVexcPodYmIklve6LCHqYOxaPrUZYVoYY1KPaA
         XNantP8gpAJ8Q03jkfKAR2C/mC8zZqSD1i79RKI/81+IUJBJQbZmV56+cGSS9j4+lZ+S
         dEAtrlXYYsSNHRXUa5ctwUuLCDzEBXvxiVafUV0kRkklj2DzVvvHEoMCL0tLrowenbl9
         8XvuJztx+UEFISCzocObCqNs8FsZ4GHTgCIhnLJL7PQQCq9L+j9kLRmIFNd5EsXoyZDx
         DI8g==
X-Gm-Message-State: AOAM530z96UVcmpUkJltmA5vObH7xMxbxgfF+lXYPd6sHoSIy9v1965K
        yCp5W1rggU9rRGOuiUqPdedI6g==
X-Google-Smtp-Source: ABdhPJynmQiP6zs1Abq21Wj9DPhvDQ4iPF31PBd5UVp2GyqjlPh8Z0Dg1FBfgQ/5tDja4cdbnGwemg==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr25593808wrw.19.1593592310575;
        Wed, 01 Jul 2020 01:31:50 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 23/30] misc: mic: scif: scif_dma: Fix a couple of kerneldoc issues
Date:   Wed,  1 Jul 2020 09:31:11 +0100
Message-Id: <20200701083118.45744-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
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

