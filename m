Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F449C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237A4206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1BqtACx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDFVfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgDFVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=a1BqtACxxQ+usJ3OtBD73cfm2j2Bgby9awwVOC9s2Yk/efn8f1OG2dSHjjJvWG/kDbGLFH
        nIBz57qWeXVZi6cve7LPI180j53m5M55nEepQCUfAa0lSLcLEJNb+4PdcKbYjoBhPImSpP
        e7IVXWUtjj6kB8vN2i/2oukqA6/7LGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-a4XJ9AxTPaekH-pxGznokg-1; Mon, 06 Apr 2020 17:34:57 -0400
X-MC-Unique: a4XJ9AxTPaekH-pxGznokg-1
Received: by mail-wr1-f72.google.com with SMTP id y6so558718wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=h7xV9aWQsKL9VZoizCfiq4oQySeuL+venpmkmLSain5rbocghd7lYVgRPoFl2UzN2P
         RXkqQWmxZpHI7cthshPtSpCpA79RHHh7crUTu8DAVPpACGgCVN5d0U8L5VJKhBvxhbEz
         9Qj90cZMBqsT3f2MVHrCQZDRp275x/Bl7gA2aTRbvUUg//0SCfhxUPjyqvKDFsijhjXo
         aRaI5LqIOevvm3ASy/b7vpLdejAE75Vg9Gb6f4uGSf7N2oI25f8YNgDht20Tm2Z8sj+Z
         HdCC3GyA3bnkOhqsnwyUkVDLRvX1zYwaJHOW4IzJ318u8YIBMRHG3E1nI+GYc1/FVOe+
         OWwg==
X-Gm-Message-State: AGi0Puamd6WftYCiDEIi/+QRqWidg6eYQzp3Vuzo6t1gpitvayvRATY1
        R+oaI2pIq1r38xL0Vw7yn6RKbHPxMFs4cBCgBKxiDiDHueRCjXZrSFXd6BfATr9ngWyzfqr6VLn
        bq8NXxPDAs4KkzuHKnInC/qSy
X-Received: by 2002:adf:fc01:: with SMTP id i1mr1437810wrr.198.1586208896201;
        Mon, 06 Apr 2020 14:34:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLbeJ9XsXl+eX1MV9WTo/7Oa/xVm1oXSJ/RbY9U+Dj3CwqdzCsppgpS5TrfjoQ3IXNAATglfQ==
X-Received: by 2002:adf:fc01:: with SMTP id i1mr1437799wrr.198.1586208896068;
        Mon, 06 Apr 2020 14:34:56 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h10sm29241051wrq.33.2020.04.06.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:55 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 01/12] tools/virtio: define aligned attribute
Message-ID: <20200406213314.248038-2-mst@redhat.com>
References: <20200406213314.248038-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406213314.248038-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 903dc9c4bd11..2c51bccb97bb 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -7,4 +7,5 @@
 
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 
+#define __aligned(x) __attribute((__aligned__(x)))
 #endif
-- 
MST

