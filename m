Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9901CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCBB22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCnZDM7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgHCVAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54850 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729208AbgHCVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1A99Kan+ToYvUmOMuODkd0BFkRSjBNq3WkT2nA5570=;
        b=TCnZDM7LuL2r5CuPjpYrYgCS8hG7jUIZ3lyQhApZT64N0zxKgx7eMAloCQXBrC2QgsX3zT
        FhifUM5mXTUjIOTJx0pEC08qRdxwwS0xvTtrZSGsWGbYaNNIoRwvKuspUzqeSdc8nIkwca
        rX4oqcu3kXqUZYzsmTohxO/OR66fmYA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-V8Aa0evPOMyTXK_KAP5IMw-1; Mon, 03 Aug 2020 17:00:17 -0400
X-MC-Unique: V8Aa0evPOMyTXK_KAP5IMw-1
Received: by mail-qv1-f72.google.com with SMTP id p15so13850637qvv.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1A99Kan+ToYvUmOMuODkd0BFkRSjBNq3WkT2nA5570=;
        b=X/g/vcElOTg29ltbMhLM9hQRnKd5hlr+ULzmS7nW6mWrX1b2Z6KOnVDk3Uh+Va9vM9
         787DlMleRqrPruFE8Ssq2SYowY1yxvQjvs4abee6hH7QdFc2WptQw4QhpUih8h2rFe2s
         CsDRsWUYeXwiWQ4PwCXmAXej9bToiONwkdPbk3THlXK7VqPJtMOX9h6STCu9lAzAvcpq
         bgUadXQyFufESz2929bWAMXgBOmcw7U436g1f8Fuz5nq5LFVFSL/e9T0hKhVeEQiywQu
         P/+YejzDeJTLDvfYaifHJ3t2h/RuhjjuwKceu/IEt8bNpuHuBLp0LBt3S3Vw9tSP/XKP
         npbw==
X-Gm-Message-State: AOAM530MopXxwUFQDZsOPHxIcA0e1cnzRXYL8G2tQIfMcdmBPYydvt5k
        84jqBVtqwGpSRr3Bz50/XZ0QyggWne5xCu1rlZ+PmRQN2fiMIbUc4pnnpVc80coOI0KQRcQbTaN
        IKvW3O/S7bWv1gV+LtP5rAeYP
X-Received: by 2002:ae9:f409:: with SMTP id y9mr17081841qkl.383.1596488415775;
        Mon, 03 Aug 2020 14:00:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOLsF2kRKHhVMrVuK1ExTkYEV3u00bvHZC77i72ooYLjKbjM4TmW/w7ndizuS2cvXbLFA8ag==
X-Received: by 2002:ae9:f409:: with SMTP id y9mr17081819qkl.383.1596488415580;
        Mon, 03 Aug 2020 14:00:15 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id x137sm20654324qkb.47.2020.08.03.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:00:15 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:00:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 20/24] vhost/vdpa: switch to new helpers
Message-ID: <20200803205814.540410-21-mst@redhat.com>
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

For new helpers handling legacy features to be effective,
vhost needs to invoke them. Tie them in.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vdpa.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 18869a35d408..3674404688f5 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -118,9 +118,8 @@ static irqreturn_t vhost_vdpa_config_cb(void *private)
 static void vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	ops->set_status(vdpa, 0);
+	vdpa_reset(vdpa);
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -196,7 +195,6 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 				  struct vhost_vdpa_config __user *c)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	u8 *buf;
@@ -209,7 +207,7 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 	if (!buf)
 		return -ENOMEM;
 
-	ops->get_config(vdpa, config.off, buf, config.len);
+	vdpa_get_config(vdpa, config.off, buf, config.len);
 
 	if (copy_to_user(c->buf, buf, config.len)) {
 		kvfree(buf);
@@ -282,7 +280,7 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (features & ~vhost_vdpa_features[v->virtio_id])
 		return -EINVAL;
 
-	if (ops->set_features(vdpa, features))
+	if (vdpa_set_features(vdpa, features))
 		return -EINVAL;
 
 	return 0;
-- 
MST

