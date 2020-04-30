Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCEC83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A6320757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="LxmFwU7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgD3B7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD3B7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:59:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8702DC035495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:59:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so3776249qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVFXHIsh0/YRSKtqr5ljSmMbeR52DAiwA44HTGSUEYs=;
        b=LxmFwU7TGw7y9TAZafLVzvatQZ0gZjRW65fHnG9mih+vMFlq42rxUunxAOoL/uGZwV
         b5K/FJ8TlMReE9NuZwdRSN6JlWVx8OuU2m6gEcAXGPHBij943y09p3qom6ajQqpAGCDL
         DkgvAmBO0xKju/EuTeKYhKvfU/Vh10jMxTnMlNsbKhjkRYiFRaS9DB/KBcYIG1mCBMbw
         C5iSVrlzItgv9jyBA+YiqNlUYGLVHSg4H1/08Bcf6R2/x3tcYJFHZ+r/5kUSPSwN+Wts
         /0wnxrhLKsD/Orm3kO/tYZVEOjnATZK4APJk6ZCQ2tof62k6ScOI5t0iHP4HngekMbhA
         fsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVFXHIsh0/YRSKtqr5ljSmMbeR52DAiwA44HTGSUEYs=;
        b=WD4ii8IB9YlF56jeNdXtH0QnMGYD8RKGMmrO8DL5JFLIeuEnDwfO5zAOpCu7EDiLTR
         OMSL//w+527wyE3QBHUUm6Ds0WGJOcczxF22ltzPGp0MUmJxdNU51FJFUXlziNAyv9v8
         IIsbJQGDFq8MEuJwhaiOHUc/sxVCsrpYU4PWF/tyruwXZOUzSkI9YVIk8E6GXOs2nnd5
         0SJi1vrGVVOrDrg0Tz5250hrY3L8459K7sjFH33Au8iWiTnMmfuenXO1OSKyCQ+5dZ8R
         qtz67hwEmjN2OJ22ONLrKo95+1h7vnZeOZmeefzohmZ4qzRqJ1HovNySHVomMDRa7PXq
         FOGw==
X-Gm-Message-State: AGi0Pub8owrsd2rAt3AkKQvrVafSmMH4MonhLiQM9f/EI/8mwy3iMcix
        Uw4sASn/cXH7qxV2X1891tMHaw==
X-Google-Smtp-Source: APiQypJoSfYUsyxQnQO9ATp9PPbiyFH/GL856p8ztpAhtz6K1Fy0hNXDM3D+1FjMDNceAVO1N+vsvA==
X-Received: by 2002:ac8:51cb:: with SMTP id d11mr1332622qtn.370.1588211975468;
        Wed, 29 Apr 2020 18:59:35 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id l24sm836378qtp.8.2020.04.29.18.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:59:35 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     dri-devel@lists.freedesktop.org
Cc:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] dma-buf: Documentation: fix: `make htmldocs` warnings
Date:   Wed, 29 Apr 2020 22:59:30 -0300
Message-Id: <20200430015930.32224-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed ":" on kernel-doc function parameter.

This patch fixes this warnings from `make htmldocs`:
./drivers/dma-buf/dma-buf.c:678: warning: Function parameter or member 'importer_ops' not described in 'dma_buf_dynamic_attach'
./drivers/dma-buf/dma-buf.c:678: warning: Function parameter or member 'importer_priv' not described in 'dma_buf_dynamic_attach'

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ccc9eda1bc28..0756d2155745 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -655,8 +655,8 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
  * calls attach() of dma_buf_ops to allow device-specific attach functionality
  * @dmabuf:		[in]	buffer to attach device to.
  * @dev:		[in]	device to be attached.
- * @importer_ops	[in]	importer operations for the attachment
- * @importer_priv	[in]	importer private pointer for the attachment
+ * @importer_ops:	[in]	importer operations for the attachment
+ * @importer_priv:	[in]	importer private pointer for the attachment
  *
  * Returns struct dma_buf_attachment pointer for this attachment. Attachments
  * must be cleaned up by calling dma_buf_detach().
-- 
2.25.1

