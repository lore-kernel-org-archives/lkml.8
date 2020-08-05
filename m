Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF16C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6384E206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMUdIc1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgHEROG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:14:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51041 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728575AbgHERKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NE75uN6dBbbPR8XQJColAeceo7jKLXuooc66ABTACY=;
        b=JMUdIc1ZNu86nIuhwVOqZt6eHlE0190mrBuRjN60yeyd7eTt8FyseHcA2xaqeAgOxSc8TG
        VyamUcW6+HREIqGkjMJ/jhU91UDXsE5Kv37wkRlgYOQuZkgttPQ7XdFSQvDmOIYq9Ugir1
        kfrmCCSZTMqMyDZ26lPFRDbihjPjLNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-9B4J6hGUNOWmKgqkAPFrDw-1; Wed, 05 Aug 2020 09:43:54 -0400
X-MC-Unique: 9B4J6hGUNOWmKgqkAPFrDw-1
Received: by mail-wm1-f69.google.com with SMTP id c124so2474453wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4NE75uN6dBbbPR8XQJColAeceo7jKLXuooc66ABTACY=;
        b=Hp2xfbZsakt7Yugdw8w8nWZpFR9yJ9riAv/vhzbbfQ3D4C8LZsoCW17yo+CE1vwK9p
         UYcgvEWKc3OD5BDsib6PHIlPIQxxS+HdABE6msb7gPUh51LOwMIUaavPKBU0ifHk68JN
         OHZ4IfV8uC1PoZzguCLfN1RMk556Q+tO+L16pkdOv/XcgGCfESNHXSyOjCZnY49ajENl
         gBOta2O4o4gmx7WR9UM2tUxoB9lB5FG04CjiZYUPs6kxZTn4HwLmpF5rJggQEotfDvxw
         oBISNRNcG0OTB6YE1QMKUY++mGMiITXQx/1PSCW0kT2yda6EhoC3IIB7G3WIYD9IOdEF
         HYLQ==
X-Gm-Message-State: AOAM530HXY8x9hDeQrvquHew4/R8nvC3xAWAPy51xtVMx1vGDPAg/aq7
        jNWMzQ1BeFanBwSFmT1p0+XSKl2nrR3RqpFFivQkSRI88VqaH2hfnW04tMu2hhtqJ6YdRNzoyV/
        4vV/Z1ve24N+tCMu1E2xlpLZI
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr3306815wme.58.1596635033279;
        Wed, 05 Aug 2020 06:43:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvbf5VBxq2UIHSD8lBlCOsb0tG11fiC9qNl08h72rxXtyKWMb6SnWrzJs0vLKD2J9n9C6/Ag==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr3306801wme.58.1596635033054;
        Wed, 05 Aug 2020 06:43:53 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id j145sm3206544wmj.12.2020.08.05.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:52 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 13/38] virtio_mem: correct tags for config space fields
Message-ID: <20200805134226.1106164-14-mst@redhat.com>
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

TODO: check other uses of __virtioXX types in this header,
should probably be __leXX.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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

