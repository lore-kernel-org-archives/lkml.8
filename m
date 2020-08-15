Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ADC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8ECC206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+20G6uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgHOV4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgHOVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA8C06123B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 23:48:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i10so30969pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1UEjNo8FBjY3zOHNcMSpQLZ9ulspEjH4BS4O+4ISF0c=;
        b=l+20G6uGynVVHrnnRdzNF3Fh3VpleLP+EkvjlzL6Ihoj8BrtDflhsxuQap/puPx9vx
         Y5DS9R5phbsGF046MkBSx2YiepDjw9cXOF41ylVI1jUOP9Gg6wtjkxmap+dGxLtSTXoW
         bmEG6PPHN43EPUmbdBQpw5+Ohgy0M2mJW1cuVjfS3MXYBWgczFmUGHkSiB9txA2jSAzB
         jfA8oIuwNkIvDNCKP8Etl56gvVk3ERPw4fNbiKCLdnwYGJ/x6Iq00/oKsT7H3LXD9ZHi
         xiHU5Dl3yqFQS6B+FTPHDWbGVcW8sNv6mt12xCXJzgC/oqKVvF1ImcBV5jj22cgf39hg
         7+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1UEjNo8FBjY3zOHNcMSpQLZ9ulspEjH4BS4O+4ISF0c=;
        b=CiEbJENEQ1uUJ00EVGoGRWgDH8jZrgGjOe/jLkmFyzY12PiTTSi76s0AM+KlfusfiE
         KpHDXSJLHbor6406Q1vH8drsl8Vgfe47/D/9rhCvZzwYlAqFHz30G53g8fdporbmj6eH
         7tfKl5+aRar3tpYOEOHKiREd6I/ypXvrAa/a1VUxmf9xaNlFvIm4jnHDG94/t8XXBBiY
         R0QGbKtsQ670ldG/SFjL17/wa1AaayFJTiuX9jiEyGw5aq8FBrQoh2/n3zlYNPVmJSrq
         E64BvONt2zIMR9TH/k6k1EmPmrUpzR0X6eGSknUzCHCnFQFEIIrl6um7cGH+v5NqZq3Z
         +oAQ==
X-Gm-Message-State: AOAM531uq2MAgIY8rteyvTPcLk2FcxxASqvocpYuJaRfbVvnsGrNxOwE
        LdiZBtoeD5Fk2i66hzAH1OI=
X-Google-Smtp-Source: ABdhPJyDokbcNBNU6ZlOnvAx0b5d1g3l+PGfHIBTohbm9Oy6CbFfNDh9Ubt5zFfMlMd6VZd9Nc8BVw==
X-Received: by 2002:a63:5515:: with SMTP id j21mr3870740pgb.31.1597474097506;
        Fri, 14 Aug 2020 23:48:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f63sm10162940pjk.53.2020.08.14.23.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 23:48:17 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dma-mapping: set default segment_boundary_mask to ULONG_MAX
Date:   Fri, 14 Aug 2020 23:47:26 -0700
Message-Id: <20200815064726.20459-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
a decade ago by referencing SCSI/block subsystem, as a 32-bit
mask was good enough for most of the devices.

Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
while only a handful of them call dma_set_seg_boundary(). This
means that most drivers have a 4GB segmention boundary because
DMA API returns a 32-bit default value, though they might not
really have such a limit.

The default segment_boundary_mask should mean "no limit" since
the device doesn't explicitly set the mask. But a 32-bit mask
certainly limits those devices capable of 32+ bits addressing.

So this patch sets default segment_boundary_mask to ULONG_MAX.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog:
v2->v3
 * Resent -- no change
   v2 was sent 4 months ago https://lkml.org/lkml/2020/4/6/881
   but it has not got replied yet
v1->v2
 * Followed Robin's comments to revise the commit message by
   dropping one paragraph of not-entirely-true justification
   (no git-diff level change, so please ack if you tested v1)

 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 016b96b384bd..27df499aa041 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -628,7 +628,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
 		return dev->dma_parms->segment_boundary_mask;
-	return DMA_BIT_MASK(32);
+	return ULONG_MAX;
 }
 
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
-- 
2.17.1

