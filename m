Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0049AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B548E206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR3nXJcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHET1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:27:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728645AbgHERNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1A99Kan+ToYvUmOMuODkd0BFkRSjBNq3WkT2nA5570=;
        b=dR3nXJcOxXQhXr4gn6VmnbjOJP1FxOpoj2yjDm2sGOB2XQpNQ99v7U/3kvvgfu2ewkayRf
        Mn68IMjrF78i0E6dWUf6UonGQbjnuSf6zeMNP4h7bmrKiCr5kRQkOMBWv3GbNGUE/rYh6a
        XuR6rfx7M4qLvf6K9kuF8xUCy8KVRQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-YGQs7NjpOLOPTbjI2RF8dw-1; Wed, 05 Aug 2020 09:44:15 -0400
X-MC-Unique: YGQs7NjpOLOPTbjI2RF8dw-1
Received: by mail-wm1-f70.google.com with SMTP id v8so2472111wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1A99Kan+ToYvUmOMuODkd0BFkRSjBNq3WkT2nA5570=;
        b=RmQjnOjh0hU13RKHQJropXLjhmfjSglH0WbBkyo/rEZJJ/yPBRrGOX+eU5vCwIa6sA
         A9hRyDt+i9QdMUtRKgkqpzXDQARRHA5KDE0FeuEHtrB3nsi5c2CLle5z4x93UnG2JTZ5
         pcSZZp3WGNCergW0SiXllQqIBLFHFaiLsvWeN6Z/vKSp7djIxlMZ/jwhVQPFVHuABpmI
         vyo4kBJrvVKzPQ4/5fRt5YCy9zGVytWEAkbYSB6xWs/HogFgXYi1JSpvYbEz6/GQXKgR
         0w82e+SI+hOSS0dZc+Bc/Gok3NVA74eOP0shV8U/3pj46pJNgEKFQyyCMD8eu/u+Ns/T
         k4oA==
X-Gm-Message-State: AOAM530nS37PNfNZ19yGdeOv/sU8/dWSA84L4ob5nNxjHloIUebpKMGP
        pQnWD9dO872K1A1O5MHafan3CAjixkHkLBySWPYg3USeIDlaP9hknCaojq/7IxS+jXVsXIvn0I1
        6u6hWOFdjrG29Yo4QzF8QTAW7
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr2815443wrw.311.1596635052938;
        Wed, 05 Aug 2020 06:44:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1s5cwBUNfyg52XUg786M5asAtfYsirHkxCrJWthFsY+eLaHorMKAhGdLmAYB5+K4MVfGhow==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr2815427wrw.311.1596635052770;
        Wed, 05 Aug 2020 06:44:12 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id o30sm2873971wra.67.2020.08.05.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:12 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v3 20/38] vhost/vdpa: switch to new helpers
Message-ID: <20200805134226.1106164-21-mst@redhat.com>
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

