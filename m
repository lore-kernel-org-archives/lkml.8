Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B33C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7206207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZXkuoMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgGPOAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgGPN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB0EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so7168515wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqxOwYWYCKbxRiFIfO8mQJ17c9E08hm9vRAt2tUzVrE=;
        b=BZXkuoMjqIRTS0/6QPnet0VkxaR+ZYIEPXHFKOFQCy3pYZVAsy32j3Drec+Le6Hkco
         8tc+9B8okcwu97u594OZnlUdlxm4otXS2uR8C726JZp7H4RoaQI9EYdpp1VWJWyynggL
         IBthvy4QEsA6VEnviiixeZxU2qiEyr8lwutFFtMmUR8ValadGnwQynlH+ACf9OZwx6d8
         3JTCFEI4quzR5QCrEyz/BrA+HTgjGdKGEergDADidFrMB1Ijpx65zyxJQsYnMcPo6gG4
         lK9Urh6g5WoxHoqZ5AJ93s15VWvqo1seLUdp+x5zW8uxoT205CgLvV13yM9QiC8cwl0h
         NlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqxOwYWYCKbxRiFIfO8mQJ17c9E08hm9vRAt2tUzVrE=;
        b=cs7wWar/ajTD63gons1CIUEVTEH2/2tri6WG5jiOrMU1PjSh5KHAGImeleVs/oJy0Q
         arSEkeNdZqhTx/dNph90U8PgTptPznZaAe1n5F2CDgc5F5rP2L4eWJns0eVWQHyj2mRR
         5pn41WadW1J1mjJcxdl0EUYGtN8UBgWLQ4gYQcKClFafN8bQpP+4+xmjfNohMCJN1HKD
         c1EDiMZyxAcHNkyqsjMB2h4CmoR5jA7qEv1+p2JKXfEjWo1PeDGLd5BdXTcIOhDiPO/S
         3CbSUbuPY+nnDEsT+ZEKf8gar0VTm409h/Vlfb2rBGyb/U2PsZbXxJbp5KlnQ8KQZ2TI
         AyCQ==
X-Gm-Message-State: AOAM531h58VK7RODog39cgHKmTOFwNCRrCLyFwxFfcxJedzcNfzL0ZU9
        TXb/l7lkkgLEa+pBOXTPr+ieqA==
X-Google-Smtp-Source: ABdhPJxYVAtXV1LzuFoU5IKqF3NfGCSxjIjAn6JnmZMWcEXVylAgyiNuD6x/dKuh428/yUB0CybypA==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr5163414wrw.244.1594907993734;
        Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 18/30] iio: dummy: iio_simple_dummy_buffer: Demote file header and correct misspelling
Date:   Thu, 16 Jul 2020 14:59:16 +0100
Message-Id: <20200716135928.1456727-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File headers are not good candidates for kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dummy/iio_simple_dummy_buffer.c:27: warning: cannot understand function prototype: 'const s16 fakedata[] = '
 drivers/iio/dummy/iio_simple_dummy_buffer.c:185: warning: Function parameter or member 'indio_dev' not described in 'iio_simple_dummy_unconfigure_buffer'
 drivers/iio/dummy/iio_simple_dummy_buffer.c:185: warning: Excess function parameter 'indo_dev' description in 'iio_simple_dummy_unconfigure_buffer'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 17606eca42b43..40d30c0a60ce5 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) 2011 Jonathan Cameron
  *
  * Buffer handling elements of industrial I/O reference driver.
@@ -179,7 +179,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 
 /**
  * iio_simple_dummy_unconfigure_buffer() - release buffer resources
- * @indo_dev: device instance state
+ * @indio_dev: device instance state
  */
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
 {
-- 
2.25.1

