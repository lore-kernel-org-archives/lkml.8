Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCC422CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwkydxG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHCU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729079AbgHCU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=or+zNAibqtaoCeVVGOGdUm20NwzQtJQIDqrZeu9+GCU=;
        b=TwkydxG/QH72p48OLC6OaIreqgXJB38DjSy33FeNt36OWFT+QjSKpwiGD0BDC5UIgj0U4p
        Dxo0eJtmBlw31v8zV4ew6tTBjszgizSzRzDvOhyuFWne0UfdpalRrD9rcAwK8rSGk+VUN7
        NISfbN4+kTrisagAM/P1xlmG0QivN/8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-ELpv9psMOZ6bvRehq5RZ8g-1; Mon, 03 Aug 2020 16:59:18 -0400
X-MC-Unique: ELpv9psMOZ6bvRehq5RZ8g-1
Received: by mail-qv1-f71.google.com with SMTP id d30so7057245qve.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=or+zNAibqtaoCeVVGOGdUm20NwzQtJQIDqrZeu9+GCU=;
        b=pL3IexoZkdoJomJSLBSFIkGImvra5xKzbWgmkhKDVkCJ7cmHuUA95brR27HFv48b2e
         /+78bgMH8UIf4XX0Ysdw9WSiFX1KYd0sMZYmeqRNoyUhbwWHvfs2+sV24mb3aLEmGvME
         41iS/GpV7ksmmtr/hfPkXHz+UFpsaICW098uwe5jZkSuYx7DibS7oLujbaQOtoJuTQwO
         Y7yZdI76tM8JGMsQyk4kj8/IC1imPisJs+1wTtrR6skVrb+fPzcLE0a91SX4QXphuM4Y
         z3wjaWutVwvS617s+RFVXGlg39QMM8dyMXTmH0AIxSIUc9AMUdZHNlVSghn46RtOFnjS
         O3Yg==
X-Gm-Message-State: AOAM533+9PucmI4hk5eM/AHOAOqcGdqgLHza1b6rSgcKkpOn9t712pF6
        zyryhY3TGtxZyC4K0vipTFEPpe7XjHcPOTRir4LErp58XVRMF6qZK1dJkKHhOyhOtzbmso24yG7
        tvBOtGQoUjk9mo0Xa2DV60F4c
X-Received: by 2002:ac8:1084:: with SMTP id a4mr17555984qtj.83.1596488358265;
        Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrapOZB7Hdxu0x7Z+dBtzskHcpM/llP/zvUq8ucoKtu/KA509zj05FQ3vDOugv6knjeTkoqw==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr17555977qtj.83.1596488358075;
        Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id z14sm21310391qtn.92.2020.08.03.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:17 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/24] virtio_fs: correct tags for config space fields
Message-ID: <20200803205814.540410-10-mst@redhat.com>
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

Since fs is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index b02eb2ac3d99..3056b6e9f8ce 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -13,7 +13,7 @@ struct virtio_fs_config {
 	__u8 tag[36];
 
 	/* Number of request queues */
-	__u32 num_request_queues;
+	__le32 num_request_queues;
 } __attribute__((packed));
 
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
MST

