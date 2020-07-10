Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928C5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D60720748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCu6qD2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGJKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:48:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbgGJKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594378137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zH+SoJc9FA+IxVxr5cux+vmHnM4kK2aczPlNcB2fA0g=;
        b=CCu6qD2xeuXD069jcmoAyMEpEqxMptebGue8VtnvIK71BNbBpDu2Uhj6MhZbHVbf5wDhw2
        5QvKiyVisdPw9WDhy8i9SGwBF1Yun3fu7ZbtFEpc1pVXW78SsAgJJfmgCWWXsYkcHCsoUR
        uCpprH09Vdk1880Mmqc8g4ItfM/nRUU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-g7GDDSAnO3eHdRBzfMbPrg-1; Fri, 10 Jul 2020 06:48:55 -0400
X-MC-Unique: g7GDDSAnO3eHdRBzfMbPrg-1
Received: by mail-wm1-f69.google.com with SMTP id g6so6361899wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zH+SoJc9FA+IxVxr5cux+vmHnM4kK2aczPlNcB2fA0g=;
        b=F0tOVJ1rU3DFRLuzemxIsr+SlJmDuDB7MCioy6RQ5oTD91FDa5jnUCcIrclhqY6jky
         RMRd1nt3YQ0e0wGE/86EYWsV3zBkrqs9Lx4GA4qdYL39JjMd3T6ECiv00dYlqU3VGM9Y
         aTPqpzm80iZpcZJmpp/kwqE7iUmRxoJ3yhQjhWsGywfu2FUCQVWoUxzXuqxGwp+JPLfk
         r/i+dy4T0IIsjPs5092E0otIPDi/jbZeLLYa8moFEI926LIkc/xe2KBkWexmY4r8u1u6
         GcjqizXXAY9boEjTScuGxelz8Qiv+XO5DrYkJvJ3Ug76n5mhBN8NNHGpXH1EdlAbbRlE
         i8vw==
X-Gm-Message-State: AOAM533uRywe5yqhzAYg4Y1khINrVZNsZyqq7ZZAyeDESm/wmDaB9WBc
        Dpv/uma7rilcu+uGZIMqPXFrvUB8JdFWeTkL7PnKC7iiHAeFIw5tiif8MZsg4pbsuvIocg0ZsN/
        f+aVAltTFHsh/JEMhTBYh57/t
X-Received: by 2002:a05:6000:1143:: with SMTP id d3mr55214241wrx.235.1594378134133;
        Fri, 10 Jul 2020 03:48:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw4fIgUrx6Lb8RIpTWJ39EeNc2fRHHzE0+AdkrVCaNR8Aj75HUF42WJR8yehI/TNv6QqsbOQ==
X-Received: by 2002:a05:6000:1143:: with SMTP id d3mr55214221wrx.235.1594378133933;
        Fri, 10 Jul 2020 03:48:53 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id 68sm8898710wmz.40.2020.07.10.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 03:48:53 -0700 (PDT)
Date:   Fri, 10 Jul 2020 06:48:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] vhost/scsi: fix up req type endian-ness
Message-ID: <20200710104849.406023-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost/scsi doesn't handle type conversion correctly
for request type when using virtio 1.0 and up for BE,
or cross-endian platforms.

Fix it up using vhost_32_to_cpu.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 6fb4d7ecfa19..b22adf03f584 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1215,7 +1215,7 @@ vhost_scsi_ctl_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			continue;
 		}
 
-		switch (v_req.type) {
+		switch (vhost32_to_cpu(vq, v_req.type)) {
 		case VIRTIO_SCSI_T_TMF:
 			vc.req = &v_req.tmf;
 			vc.req_size = sizeof(struct virtio_scsi_ctrl_tmf_req);
-- 
MST

