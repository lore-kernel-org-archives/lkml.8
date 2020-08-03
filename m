Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC89122D08
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGjhGlnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgHCU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729079AbgHCU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rgbr3S7Op26qakIXtpfCwbs62McqD9fRJN/CcHSJJtk=;
        b=SGjhGlnMTrVPh3t08aRafnGuO1qx7F3luuYOuqwL5+OPIhcp49W/Q2040nLPKkE83d+R+a
        2hRkCG26ab5q7Ifk/Wmm2nJprO4iYKX4CsUzySdEut4GQk04mVUXNPvKCnSBu+ZaAPjCSB
        qPMIcGSuvjljZv4r2GurwEZ5x+Nu650=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-dwJcWuqlOqyBpZB_fAgMvg-1; Mon, 03 Aug 2020 16:59:37 -0400
X-MC-Unique: dwJcWuqlOqyBpZB_fAgMvg-1
Received: by mail-qt1-f199.google.com with SMTP id r9so27755113qtp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rgbr3S7Op26qakIXtpfCwbs62McqD9fRJN/CcHSJJtk=;
        b=J0U+kYJBI230S+PhTtNv6SrQEj7ck0kpNIWJAwUfTb57aReZEAFoQvNHzww4Ek8XZj
         IkY+3Aqk4bT+rV+Z8Fi0T3aGppnvH6RWcK1pds4+qtsyE3+xUwgElCiW5goTejnrI+Hx
         ozKmoqHCnxdDebjfa573VVczt0KZKjljFLekc1dTvXpw5BC8mxQisvQ1ITqSGH62bfGK
         MdawgqyOJierXh0FWUqBTxsLMYbzd/teuMQfWpsENTwJY3GVMBv37bPnctDHkIdJ9ERJ
         jNnw62CRj6Y6gKqKREHqobtFywaXnA1znf4+1+TQ62V18ASplmYTM3BFkwQ/bBt+mmYg
         XdNQ==
X-Gm-Message-State: AOAM533K46K8idFkvLnysj8s/5LpGiA3m5qJwrY9FQeKlKbtHTo5OV9j
        GocNqNz+xfYQ+DS1zFafOp+v3bwHpstNo/RYwN8k2o0+AkAnQbkBUJGaZVyoFneHxoFRL+DHQHy
        VTbvwsA2bqPqTKQzryaiBnnB9
X-Received: by 2002:a37:e04:: with SMTP id 4mr17763984qko.269.1596488376482;
        Mon, 03 Aug 2020 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydECTgbLYKr4hjShvtJWKB8TcEkpEIhhziBGJusR6Qak9+rn18ZeFUCSzURruspK65XnYsog==
X-Received: by 2002:a37:e04:: with SMTP id 4mr17763967qko.269.1596488376274;
        Mon, 03 Aug 2020 13:59:36 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id x13sm21991885qts.23.2020.08.03.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:35 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 13/24] virtio_mem: correct tags for config space fields
Message-ID: <20200803205814.540410-14-mst@redhat.com>
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

TODO: check other uses of __virtioXX types in this header,
should probably be __leXX.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_mem.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index a9ffe041843c..70e01c687d5e 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -185,27 +185,27 @@ struct virtio_mem_resp {
 
 struct virtio_mem_config {
 	/* Block size and alignment. Cannot change. */
-	__u64 block_size;
+	__le64 block_size;
 	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
-	__u16 node_id;
+	__le16 node_id;
 	__u8 padding[6];
 	/* Start address of the memory region. Cannot change. */
-	__u64 addr;
+	__le64 addr;
 	/* Region size (maximum). Cannot change. */
-	__u64 region_size;
+	__le64 region_size;
 	/*
 	 * Currently usable region size. Can grow up to region_size. Can
 	 * shrink due to VIRTIO_MEM_REQ_UNPLUG_ALL (in which case no config
 	 * update will be sent).
 	 */
-	__u64 usable_region_size;
+	__le64 usable_region_size;
 	/*
 	 * Currently used size. Changes due to plug/unplug requests, but no
 	 * config updates will be sent.
 	 */
-	__u64 plugged_size;
+	__le64 plugged_size;
 	/* Requested size. New plug requests cannot exceed it. Can change. */
-	__u64 requested_size;
+	__le64 requested_size;
 };
 
 #endif /* _LINUX_VIRTIO_MEM_H */
-- 
MST

