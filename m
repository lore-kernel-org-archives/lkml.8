Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C08204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ0h3mmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFJLgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:36:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728567AbgFJLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QQIo3L2MWWvjb6mzSKSfjdSEv1rN96HPXR5N45kiTKk=;
        b=IQ0h3mmHhHXgDgnHqOjtaa3CtekqcVQW6i1qBWvjFOZ4m4fgWSlDPDhbQNGBJcJn3uldgK
        aOr8zqCPV8A49lN90hSjwqrEAjfi+1nxGP1VQGPH6UYxi8Z/5aot7QL1Te94aW6haGlmE5
        O70lbQ5Wo3UyfdHloFOTCva1frdFzWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-HhZDURf3NXixCJ4ykUvukg-1; Wed, 10 Jun 2020 07:36:03 -0400
X-MC-Unique: HhZDURf3NXixCJ4ykUvukg-1
Received: by mail-wm1-f72.google.com with SMTP id t145so400972wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQIo3L2MWWvjb6mzSKSfjdSEv1rN96HPXR5N45kiTKk=;
        b=FEUyog4M3jFMjRQ1pzXe2dCkq7Jsxw1hGguSzvXH9UWt7uwn9mb7N9X+YcXEWBy++M
         ggHPGyg806J4bUzl99oCobbjnwMY+XH1D5sCFio45zKq/K4eEkaloj4MvHLoMjGtyXYr
         6nVvmkwl+mcdEELRupGIb2/dYRy1sPf+93ziqP6iVdJzGLlBwEnHvKHsRyvfWRMH6Bns
         1iRY3eQK4qedxhPYlDIWvFvlGaF9f/63a5Z74QOoedve0jhVHoEwvaijBUdVqrJ0aD9s
         uKeteXO+0wAdJqyd9J9V8p+lfi5BIXegeHVj/8QJ4PAX9zt8AAZsHLVi3VsPegtYXyP/
         5ImQ==
X-Gm-Message-State: AOAM531cVORyqmFLmNe/dPyGjvwC8z5smIXUF2hNkj/L9qWSGuWkIDTg
        vLmoGfirIXVpqqQ7wezupdOhSYta6KC3/cQEqDUrNIhMO24SEpt0g9Q9GxoQ17ePKbG6ahOJQD7
        EoL+eXmyuqOx6qq4pPmGyD5cJ
X-Received: by 2002:adf:a157:: with SMTP id r23mr3378910wrr.92.1591788962285;
        Wed, 10 Jun 2020 04:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAHBbn1Hm38GkVQUdC9QO7S3prwhr5Px+sKP6OuFbtKtCWmiw5G13O+k9LGPpnGaeJbpRtfQ==
X-Received: by 2002:adf:a157:: with SMTP id r23mr3378893wrr.92.1591788962077;
        Wed, 10 Jun 2020 04:36:02 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id c206sm7360362wmf.36.2020.06.10.04.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:01 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:35:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 02/14] fixup! vhost: option to fetch descriptors
 through an independent struct
Message-ID: <20200610113515.1497099-3-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 180b7b58c76b..11433d709651 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2614,7 +2614,7 @@ int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
 err_fetch:
 	vq->ndescs = 0;
 
-	return ret;
+	return ret ? ret : vq->num;
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc_batch);
 
-- 
MST

