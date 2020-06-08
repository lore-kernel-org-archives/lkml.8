Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 05:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3F420656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 05:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9xcP4Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgFHFpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 01:45:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727836AbgFHFpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591595128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ez7Dws5UfJEZt/nF/P3hd8sxkPeP7mYHFdp1Ir5GgJQ=;
        b=a9xcP4Izln8WgM23nZ/fwh4x9nwMB9bS9o8qKoFhTw2OpCElW4NU5HhTWlUhM8tZ4RPvij
        noJAvjdFHcxyOZuZFYkoJmAdIQzBlJgVgunbdxQ54aLo2kmXfdMMpKVTXzyHSQX+zCu9T5
        0Of8ulm/9pCakwCD9NQiuKebMOERwjI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-KG8ryGUHPxC-KRTfOv0myg-1; Mon, 08 Jun 2020 01:45:27 -0400
X-MC-Unique: KG8ryGUHPxC-KRTfOv0myg-1
Received: by mail-wr1-f69.google.com with SMTP id i6so5093412wrr.23
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 22:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ez7Dws5UfJEZt/nF/P3hd8sxkPeP7mYHFdp1Ir5GgJQ=;
        b=HtpEOHeAfO+i6P2kePdC3kj+AuXW7ykFJqMr3ilm5RHPsKtUSovlfPHLBcnegnpo6h
         GzvydOIzqc3hdUqGMmIBSMd/EEWDgU3b3vj/LdjpaJJZWC20FNylT+VbvxagPSSqPqB7
         uaTrjSVsN76qD8aTrP2jBsgR3+dnQjtusr7iU30UvfwJe7RlDgnfyYNIp8X2+FxGl7+Z
         5Sd7YfPMST2FexGIT4exNX5Z9T2nHDW0HGj++cRNxx7svAKGck3Ex0uyWzqFnQ3B69dN
         uVH8o6elugyx/+IUI3iknWl/c2GMsI9MpunkAYWciBuQXa4GCacBO1gSw+FZOHNgVKeH
         SWLQ==
X-Gm-Message-State: AOAM531OTzfMwc8wvxRP169RLBG/CWxE33o+bO5FzDRD4REqUnbwwc6Z
        6jArvGmUd2oJyzRDSLhkdboB5pWOQ/vaDN0jNp/+P45QS4lc85sg3prN5mQDv/aPbfb4BK+lbrx
        LR7yTYlmBc16ZdgbAduMV4b/6
X-Received: by 2002:a1c:7215:: with SMTP id n21mr13172740wmc.10.1591595126086;
        Sun, 07 Jun 2020 22:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEIxwo/TLPKQznbdhpqOhXK0+Kt5d6VZ/+K6/mxUvM5HR7j5GwB8GO7qmXBD6gO6AIzOG84Q==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr13172711wmc.10.1591595125755;
        Sun, 07 Jun 2020 22:45:25 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id l17sm22316198wrq.17.2020.06.07.22.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 22:45:25 -0700 (PDT)
Date:   Mon, 8 Jun 2020 01:45:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio-mem: drop unnecessary initialization
Message-ID: <20200608054517.708167-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rc is initialized to -ENIVAL but that's never used. Drop it.

Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f658fe9149be..2f357142ea5e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1768,7 +1768,7 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
-	int rc = -EINVAL;
+	int rc;
 
 	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
 	BUILD_BUG_ON(sizeof(struct virtio_mem_resp) != 10);
-- 
MST

