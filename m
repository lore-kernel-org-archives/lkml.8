Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1691DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73332075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3Lnw1Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHET1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:27:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728484AbgHERLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b15p4KXARwEoNlM1WPMg2pSx9ElZxt97JOcTPOVUe28=;
        b=i3Lnw1HiFS8yHzfxOhhEqGfCcM1+tg+4mj9NRYGKSu7XjfypqsU62kD9okHzwov2MhysnN
        Vh+XKAucGsTKWdELMHNrFHzB/6dPU3bcYfAfELSUGc36bJQ7MQy1EXmIlUwFDHR7iks6Ew
        9AP1A8u/VZCCjcWR8qGWzFyrjemNTXY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-eEw80S1zOBa64Z7RfCHjGg-1; Wed, 05 Aug 2020 09:44:57 -0400
X-MC-Unique: eEw80S1zOBa64Z7RfCHjGg-1
Received: by mail-wr1-f72.google.com with SMTP id k11so13088606wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b15p4KXARwEoNlM1WPMg2pSx9ElZxt97JOcTPOVUe28=;
        b=uizYrap89vMU3cqdqtWHXbZaisASDhNSoSIneiymlee0GMBnVVaeItj16O1bR5RaBC
         0N+HeXLTge3SBKjQ5npE1iTivScyt4QcBm1NFIZUJ5BkHL8wBfLWNHX67TIRKBrSChhC
         MbcZFB68i6CC+cHtG0O4eimtqVfgPYv4qWapCUq8oy2fYdiSue3R1zuWhapgI7jUNjyR
         1rbaLMhBUC7TIJQpSRhsWqWd04bc6M5OQSZoxSVqeUteEQbfXeLHexW88AzwDl0/P+Pm
         XidZPjUj+ADyiKe8lqG9rrh5DjeUXHbnjg/ncYMvQDxgQgGriGpkHrAY476hqnX4EIWZ
         50VQ==
X-Gm-Message-State: AOAM532NyQbLYrCc0pxJiaiLyF5iKm6WN44DNDeBXyCXrMrF5ibujIqq
        N4UmW8nNq7ri8ZCHxtof/acggfjjMoRv42iZK556KtDaP8UErafuUUVcNoxyG53GwCGSaQrPy2T
        QUS8U7yOMunluLtEPcBsAxQIX
X-Received: by 2002:a5d:480b:: with SMTP id l11mr2753634wrq.85.1596635096342;
        Wed, 05 Aug 2020 06:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIX/R1ocyCLsQIShtCU4c22XE3xHsPPWnbXDGuQ6U2zNmRfwjcU+K6dqulnNoNKqfVGu6vnw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr2753620wrq.85.1596635096132;
        Wed, 05 Aug 2020 06:44:56 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id b203sm2926580wmc.22.2020.08.05.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:55 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v3 36/38] virtio-iommu: convert to LE accessors
Message-ID: <20200805134226.1106164-37-mst@redhat.com>
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

Virtio iommu is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/iommu/virtio-iommu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f6f07489a9aa..b4da396cce60 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1010,8 +1010,8 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
-	virtio_cread(vdev, struct virtio_iommu_config, page_size_mask,
-		     &viommu->pgsize_bitmap);
+	virtio_cread_le(vdev, struct virtio_iommu_config, page_size_mask,
+			&viommu->pgsize_bitmap);
 
 	if (!viommu->pgsize_bitmap) {
 		ret = -EINVAL;
@@ -1022,25 +1022,25 @@ static int viommu_probe(struct virtio_device *vdev)
 	viommu->last_domain = ~0U;
 
 	/* Optional features */
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
-			     struct virtio_iommu_config, input_range.start,
-			     &input_start);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
+				struct virtio_iommu_config, input_range.start,
+				&input_start);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
-			     struct virtio_iommu_config, input_range.end,
-			     &input_end);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
+				struct virtio_iommu_config, input_range.end,
+				&input_end);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
-			     struct virtio_iommu_config, domain_range.start,
-			     &viommu->first_domain);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+				struct virtio_iommu_config, domain_range.start,
+				&viommu->first_domain);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
-			     struct virtio_iommu_config, domain_range.end,
-			     &viommu->last_domain);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+				struct virtio_iommu_config, domain_range.end,
+				&viommu->last_domain);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
-			     struct virtio_iommu_config, probe_size,
-			     &viommu->probe_size);
+	virtio_cread_le_feature(vdev, VIRTIO_IOMMU_F_PROBE,
+				struct virtio_iommu_config, probe_size,
+				&viommu->probe_size);
 
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
-- 
MST

