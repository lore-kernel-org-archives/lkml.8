Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2B320719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBm8Nf8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGBHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726552AbgDGBHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXdHnCPN9IKDzYXh6cSCK96yIk733FWewogK2tGBIaQ=;
        b=QBm8Nf8vBAEuKuDzFJINxLUMRLq4bmepJwcOSh0P7v30/j9yeAGNIi3C+dMKgim/SZCAWE
        tnIBx5BoUE9nc5QxtUynDdqiR9oaCrRpkL4whnS/HwyTINWmp7ybfHkrP7bD8dltd15Ffh
        jeeBWg8EH7ulAFOG2vUlNLvZgj/VNSQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-t6tbhrJHMxintePz3Npcfw-1; Mon, 06 Apr 2020 21:07:39 -0400
X-MC-Unique: t6tbhrJHMxintePz3Npcfw-1
Received: by mail-wr1-f72.google.com with SMTP id m15so870923wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXdHnCPN9IKDzYXh6cSCK96yIk733FWewogK2tGBIaQ=;
        b=BplijxARbyY7rU1jWVCEyRofjn28IJqPwtzm0tp1vwUp3OPNDZdF1HwOcYpyMgyZGX
         rqL8m2PFK4TBoi4VZcjuYjLnE0e5XO+AphS0qdFb5EJ5czaO5akec4hwx3jrE8p3xKhw
         Iv4W/6HvXjUv9+J9MXXTeP2ej/gMdZ+7VzIQNSzx5eu8R21Wijos6V5wPugeZKBlNLYX
         ONNYwuat3zIbjorFRoki4TL3/gbQgybgHpvcx5ecnFEzgoGGS28x2TehjZAKcJd6OugX
         YcSYgAN0bUjPItRy7IvBkp5Nbjvz6fXFbmqpwuMklmz3bEPGjMizZ9foKLt3V6yTKCJD
         LY/A==
X-Gm-Message-State: AGi0PuZFhC9A5K/q9pgHo2oPESkrH39/fkKtmOyJW/O0D2C3etccnmEn
        2Ofe9t+7ZWZtWF7TR7V9LuELbAuqrAYuosQpoi1GaU/tGABw7hwZARnhwICkmncv5W/nHCh3nA2
        ZLzibQ14HyYBKq0MqJahEn0a1
X-Received: by 2002:adf:9b96:: with SMTP id d22mr2187310wrc.249.1586221658595;
        Mon, 06 Apr 2020 18:07:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypK4RDCslYo3i2lHvzOQqU7u0oLmj6vW5yEO0Z36UmKBoS+EK0dWhGTEZV4YpT9+RwLo5TAivQ==
X-Received: by 2002:adf:9b96:: with SMTP id d22mr2187292wrc.249.1586221658447;
        Mon, 06 Apr 2020 18:07:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id w204sm123674wma.1.2020.04.06.18.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:37 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 05/19] virtgpu: pull in uaccess.h
Message-ID: <20200407010700.446571-6-mst@redhat.com>
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

In preparation to virtio header changes, include uaccess.h directly as
this file is using copy to/from user.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 205ec4abae2b..2342a8baa5f8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -27,6 +27,7 @@
 
 #include <linux/file.h>
 #include <linux/sync_file.h>
+#include <linux/uacess.h>
 
 #include <drm/drm_file.h>
 #include <drm/virtgpu_drm.h>
-- 
MST

