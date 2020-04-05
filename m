Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E979C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1202E20644
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF4MhJ8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgDEIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 04:14:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60130 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgDEIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 04:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586074446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ouQfW90npHD033GMDM+a2FinSD7SQ9pCB41aFB2pv8M=;
        b=TF4MhJ8ilZ3z80sTnRyU8vqcXjxl5/ufWgK9Q9ebcq65MmGWE/zHOGqO81+0J9+uBQWPuw
        SmQsFhEBY0DjroWq0UQWiXhVch+tIZVeMlkAZqmS/gFJ74AsalcKVHQSzmeqUcYAYOx66g
        NKB7KBrTumYAJIPGUaJdvSl5UoeoOT4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-VLUgp2LhMPSsOfxsZ1fNng-1; Sun, 05 Apr 2020 04:14:04 -0400
X-MC-Unique: VLUgp2LhMPSsOfxsZ1fNng-1
Received: by mail-wr1-f71.google.com with SMTP id h95so6090983wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 01:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ouQfW90npHD033GMDM+a2FinSD7SQ9pCB41aFB2pv8M=;
        b=diVRUM0SfIts6UbIFPs0jUOSpyli/4u24BjePXtGTLGALMKVEhP9t7wzRjTwvQk4Zk
         70YoNptBssfpzZNgR1JFtEZwtSLhX98+/7jR7Lrguqh9mNFsgWrxWnLAJQ/o5mHkULOW
         cc76G8eDu3VEFm1r2T9mrzuChRMzlVHdMtWLltfLQvN+CRn27uqKW6FcR0v5PDbOTxmv
         RSeAl+qb9N87w9T1fzxg+uFzqDrbAdYcgbOpIrLmLgYaso3ooc1uqIfBVDelpinnozYs
         eXJsoBc2pZ39iC87SetVDgN/jbRb5ai6Rhp4VnUK3bCUw7RSdzogw1WpXa+cSEwfR7El
         jq9g==
X-Gm-Message-State: AGi0PuZ1JhdFdc8E/Sr1+KGhdM0Mnqc3DJbC+igIBLjkcuq+BTPGZ+2e
        xJRQL4Q5Y9wsy+lwInzJdNsQE95T7gavg4jvMn+f21ewoc4XbTpY1YIb05YSo++p/XD+8FqYWR/
        74EbBJrpgPJcB7nME3hlWbrbn
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr16757529wmd.186.1586074443074;
        Sun, 05 Apr 2020 01:14:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLsqstklH0xgI1XJZTMg34Svue6TUFMK2IJ5TbkAsLUDmWLphQPBmK7xc/ECUJgj3fwvYDLwg==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr16757512wmd.186.1586074442920;
        Sun, 05 Apr 2020 01:14:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h188sm5491054wme.8.2020.04.05.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 01:14:02 -0700 (PDT)
Date:   Sun, 5 Apr 2020 04:14:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa-sim: depend on HAS_DMA
Message-ID: <20200405081355.2870-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_dma_ops isn't available on all architectures:

        make ARCH=um
...

   drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
>> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration of function 'set_dma_ops'; did you mean 'set_groups'?
+[-Werror=implicit-function-declaration]
     set_dma_ops(dev, &vdpasim_dma_ops);
     ^~~~~~~~~~~
     set_groups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 08b615f2da39..d0cb0e583a5d 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,7 +14,7 @@ if VDPA_MENU
 
 config VDPA_SIM
 	tristate "vDPA device simulator"
-	depends on RUNTIME_TESTING_MENU
+	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select VDPA
 	select VHOST_RING
 	select VHOST_IOTLB
-- 
MST

