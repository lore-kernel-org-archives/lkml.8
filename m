Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C010C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52E72075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8oH3T8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHET2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20858 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728606AbgHERLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTaDCFq9EEd7EtxWljV0ocT/0BezQzutVLOCNJo6y1g=;
        b=P8oH3T8XsDtZXkvU7I5oS3CifsJbfbGIbYPVN6AEWvlJFhVBZ8OdlqOAiujL8JKQngwI/T
        wRYGJmyb0JJbMIYCuj7yd8VKsF565amwA9yW2ohJnF0N4Xa1VUK5Jeg3JyYeVA2OPshQXw
        YJ1/jDccJe3frDRH/OPHea5kybluP+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-mKMlaaoOOdqqnCl_NdRkxQ-1; Wed, 05 Aug 2020 09:43:55 -0400
X-MC-Unique: mKMlaaoOOdqqnCl_NdRkxQ-1
Received: by mail-wm1-f69.google.com with SMTP id f74so2745317wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTaDCFq9EEd7EtxWljV0ocT/0BezQzutVLOCNJo6y1g=;
        b=FWMYAF2Ua2u5L/TM8MvbSEEGCDwElNRjVHQRg9ioimxLcPOKJJO8Bt/DkaM4Q5MhOh
         eB/fkKcnXxSjBHNpRiFCCx51Vn0Z48kRJWVUh2iOVH3O+ECx+aD863N2AiXs+aww7vp1
         WUc9uo0DtOjNJlE/PPURX5lHzjrf12gADqeUMHp3SP5H4nrYUYyxxc+Qb+bfctWCRDHt
         YPnAwDK1J1U2H1jIwauY97QsNsaMZg8MCeQtChs4XW69JZRb3tjrrr6SKu3A2/2p+huO
         JlGPJ4koGHCmf/ZlgYHC0jQ12lPUm654IGnDOMim2zYJJERZNFwgA11/NqGmo7XIQ1oz
         DCtQ==
X-Gm-Message-State: AOAM533D2PsensYeWL414UH93O6+1lEgi0B4L32wBzNMiNA5QRzTlQrd
        hj2fPLaqXdMhP9HRK0i+RvQpfA9NHDnwexZ0NMy+3fX1Oz+RivSCAC0f6wHEHYX7uQcla0LGhSa
        OOQiJgYHuXlSf2LOg03Cf2sdy
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr3336548wmf.65.1596635030700;
        Wed, 05 Aug 2020 06:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT1f4LtdHhh5Ky3zKW65+1UGCe/Bl8zMSMSLYR6HxdNcX+9Oze99mEQYLayP5cnoDyV6YEGw==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr3336534wmf.65.1596635030516;
        Wed, 05 Aug 2020 06:43:50 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id v16sm634wmj.14.2020.08.05.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:49 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 12/38] virtio_iommu: correct tags for config space fields
Message-ID: <20200805134226.1106164-13-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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

