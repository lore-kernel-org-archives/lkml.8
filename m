Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B9C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017620B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0ZtyNNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDGBHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726594AbgDGBHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cpBCN9COwU5b1SJmxmkerQbIPy9Gv4aGbfqwyHnqUyE=;
        b=U0ZtyNNI27A6PTUoTRipZUk2sdeFvexe1JxLTzMx5Rj0JPRTAbYWQYMaiAjV7pD0vi53JI
        cF0k1pVgYPRtcFxVsI70bNEhXPQhJ1Sou3M3r2v2Xdtmth79vLyoXYh8TlZirAow3f5Jt/
        3WzXBELJPUbu4mmy3S93ge9vyTy3KEI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-r2CCk5l9NeKFYBzbV3WbIQ-1; Mon, 06 Apr 2020 21:07:46 -0400
X-MC-Unique: r2CCk5l9NeKFYBzbV3WbIQ-1
Received: by mail-wr1-f70.google.com with SMTP id a10so870753wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpBCN9COwU5b1SJmxmkerQbIPy9Gv4aGbfqwyHnqUyE=;
        b=eBEACa1xJA9+autBYT8OOZWkWruc0mrjJ4SgTXCnG9qTe13BZcZoa91P7bUm1/vNxt
         xNw8dFdYZa96ErT0yd348+w5v5tRVwirNdvVaO9LfAxPLoHxhl1cq4retiujSNl/yeI8
         QRVaWJ1xQTypNaiVNYXkTKLLEubm0KosC/YYR/G9tWY+j7SRKIRufPMJIFlLo6V5StLM
         anLpZKFte7zadzj+fwqAjCBqvtN/OjG76rUlHegccKiUFQyeVNwbDNrNV7ZzXx4f7FDL
         f0Db6/42nBXACC/OTPHeOAyusEJsCnHpV8hhbzTFjBekQPJXZdRFkm3mXj87Q8tBD3za
         qnVA==
X-Gm-Message-State: AGi0PuaMVbepZH9+FJCfzz31/DHocuplKsrIqlFe3lQDcqEnSLyFQvpE
        vxlIoBdod1KztlWniegLG/PwrV4MHvplWjWIol1+Zn6TTSTzLMPD08ZrQNoKl1BeR5cLznHSngF
        WgzqBphW4CjH7Y2ak5wzyydum
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr1782786wmj.111.1586221665028;
        Mon, 06 Apr 2020 18:07:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypKyn156xrUom9RCaQHtlxGxcH01DdoyrI1XR/UsjKHBvJZinnqUjeq2WfAbQgmW4gpjj0GFNQ==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr1782774wmj.111.1586221664872;
        Mon, 06 Apr 2020 18:07:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f14sm118556wmb.3.2020.04.06.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:44 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 08/19] virtio_input: pull in slab.h
Message-ID: <20200407010700.446571-9-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to virtio header changes, include slab.h directly as
this module is using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 5ae529671b3d..efaf65b0f42d 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -3,6 +3,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/input.h>
+#include <linux/slab.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
-- 
MST

