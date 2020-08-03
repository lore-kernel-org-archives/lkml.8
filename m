Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3502C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA09F22CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMcBNFtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgHCU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729079AbgHCU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xI/ZbWF2py8QNl8K4JvYs5q6EbwT+mCnh8MoqYwvB8=;
        b=VMcBNFtV+nO1jTQy2e51QsjVoywxbkz+G9b1y1N2xCXQzbrqIxO6LMaBCcJLos8HRXSBim
        uCXTCY/Koiyc4WrI5csusNcB2LzIyPyPcLzHrxXw7dBFAwKfsj0A4/9IBTci1NJDeUiCfw
        xQ7Kiwyp8lSw8xOHN87MOLGYbesc3L4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-6I5sR6mdNViAEwvQz64Wtw-1; Mon, 03 Aug 2020 16:59:32 -0400
X-MC-Unique: 6I5sR6mdNViAEwvQz64Wtw-1
Received: by mail-qt1-f199.google.com with SMTP id e14so20007098qtm.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xI/ZbWF2py8QNl8K4JvYs5q6EbwT+mCnh8MoqYwvB8=;
        b=Ao4GS1RIWLh00O0OmNZboxX08/I6GwRMax/7ZU7ztFZb+waHpDyoERWfjb1bdiI85e
         gMbPZVfUfM2Ne+57OAsnby6B0SXFylRTPD/wky9TZs5goZqlNMhLjVmzMvd3hcPEQRyK
         yFQFsoMmJ/dOTXWuKAWil6pVzW0d63jpVDkT9meYCMyWlOalfQBHfjN6w4FYYayvXbrZ
         loYgXj0sNiljxnMRGkFI4InwOLlLcN9s4qbtJRLEZ4IHCuG9/r7I16KhJHanggyBFalV
         lD9kfXB8SxdFBLndNu9KmAMwl+QrgU3R3KaHtxq+pJOBBfBJ5kMrDzB9NUlOQ4YEktW1
         q14A==
X-Gm-Message-State: AOAM530MPBjQmyNonop1MKJGd801n2MyBb6HarXNdzEKpELMC4MSgE97
        Hi6tlCBCe9FOmg6ilxBSfxqiz4i6Gj3v5AW3CjSmO5FlAYPD271y9OuBHXCJpNGUqJtIuMsnM/Q
        HY61QiYDZmUhMmGbRy40hi1eP
X-Received: by 2002:a05:6214:2a4:: with SMTP id m4mr19500143qvv.120.1596488371966;
        Mon, 03 Aug 2020 13:59:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynR48xJ6D4DOziFIFJBOXMH9jlnKkDjS+iRN3OJhEHYTDmDbmB5mxmE4Lvgl56jXzaOzntUQ==
X-Received: by 2002:a05:6214:2a4:: with SMTP id m4mr19500129qvv.120.1596488371743;
        Mon, 03 Aug 2020 13:59:31 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id b23sm19696745qtp.41.2020.08.03.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:31 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 12/24] virtio_iommu: correct tags for config space fields
Message-ID: <20200803205814.540410-13-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 48e3c29223b5..237e36a280cb 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -18,24 +18,24 @@
 #define VIRTIO_IOMMU_F_MMIO			5
 
 struct virtio_iommu_range_64 {
-	__u64					start;
-	__u64					end;
+	__le64					start;
+	__le64					end;
 };
 
 struct virtio_iommu_range_32 {
-	__u32					start;
-	__u32					end;
+	__le32					start;
+	__le32					end;
 };
 
 struct virtio_iommu_config {
 	/* Supported page sizes */
-	__u64					page_size_mask;
+	__le64					page_size_mask;
 	/* Supported IOVA range */
 	struct virtio_iommu_range_64		input_range;
 	/* Max domain ID size */
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
-	__u32					probe_size;
+	__le32					probe_size;
 };
 
 /* Request types */
-- 
MST

