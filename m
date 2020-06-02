Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407D7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCCF20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7tONeIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgFBNH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:07:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728157AbgFBNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591103172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXfjPrDyqejhZJQKUWL2cxT5rK4Jnqa149Nn7T1gq18=;
        b=D7tONeIjdMe3xClwMdIdsq0Snj4lbBqv5wlNqPoQhLRQ4EJdBuXHCOAjWD1p2SQdC3t1iW
        cXy513Jynoubo33hvT0Wk0nignYZSwpBGUPXX9McelNPSfns9bSPFiXloyBgRNhl7PnjHy
        HrYxgzsX8vhRR/FOFgCOGe1cNDXxBH0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-eSF7GpLhOoqXPxlshWZ-sw-1; Tue, 02 Jun 2020 09:06:09 -0400
X-MC-Unique: eSF7GpLhOoqXPxlshWZ-sw-1
Received: by mail-wm1-f71.google.com with SMTP id h25so891493wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EXfjPrDyqejhZJQKUWL2cxT5rK4Jnqa149Nn7T1gq18=;
        b=uDAyppgPUn5FdkUXsQoohD4NJsquOPor5GfXpwp7N3PI5XRAQrn9qiW8cKl0YSrz2V
         OUssYYcOp2N296sexLE8PESvW7aXOLoz5bgSQZTRwIbtUSJyqcesMxrZwV9N6bODYW/v
         wk/xuahZYTZ3UW2GXwr9dqjRFKqyhGvcYUVJoLuQp6P3CGp0pTKaysUtb3wPOqoRbo2d
         pFW2znXd1YC1v0zcaVMdUcuYXOfh3anIIWyf/sUJcg8WGRFcd1yNlA/CgOobIkOPOFBz
         CDrZSxhPwbkTc9C+i51GNrPS/xpql0GY5LnK9dN69NBiHR0Izk4BmylbbAEt71Fo53Lw
         fMjg==
X-Gm-Message-State: AOAM532OoqACmpok5EFG/p+8FmVXSrTGNOHyh/ssQ/QONjb9Xdqz9JAZ
        +xjSa0BgZz3vYKRUYc6+X0wl5ezpRmJO6UmaQmoi6jUE0f8/EpQNSYLLZrBmgKQfXk293301ds4
        ERhhVbxPERABYu6voRbjwbjjN
X-Received: by 2002:a5d:6391:: with SMTP id p17mr28295026wru.118.1591103165835;
        Tue, 02 Jun 2020 06:06:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycUSkpBa2fgUPLZAf/ybOapg7EllouqLaj5tY/W/L7i8gJ0j5W3iBZNA/fqWHGkhJHN82J9A==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr28295007wru.118.1591103165610;
        Tue, 02 Jun 2020 06:06:05 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id m129sm3760525wmf.2.2020.06.02.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:06:05 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:06:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 04/13] vhost: cleanup fetch_buf return code handling
Message-ID: <20200602130543.578420-5-mst@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602130543.578420-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return code of fetch_buf is confusing, so callers resort to
tricks to get to sane values. Let's switch to something standard:
0 empty, >0 non-empty, <0 error.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index aca2a5b0d078..bd52b44b0d23 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2146,6 +2146,8 @@ static int fetch_indirect_descs(struct vhost_virtqueue *vq,
 	return 0;
 }
 
+/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
+ * A negative code is returned on error. */
 static int fetch_buf(struct vhost_virtqueue *vq)
 {
 	unsigned int i, head, found = 0;
@@ -2162,7 +2164,7 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	if (unlikely(vq->avail_idx == vq->last_avail_idx)) {
 		/* If we already have work to do, don't bother re-checking. */
 		if (likely(vq->ndescs))
-			return vq->num;
+			return 0;
 
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
@@ -2181,7 +2183,7 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 		 * invalid.
 		 */
 		if (vq->avail_idx == last_avail_idx)
-			return vq->num;
+			return 0;
 
 		/* Only get avail ring entries after they have been
 		 * exposed by guest.
@@ -2251,12 +2253,14 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	/* On success, increment avail index. */
 	vq->last_avail_idx++;
 
-	return 0;
+	return 1;
 }
 
+/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
+ * A negative code is returned on error. */
 static int fetch_descs(struct vhost_virtqueue *vq)
 {
-	int ret = 0;
+	int ret;
 
 	if (unlikely(vq->first_desc >= vq->ndescs)) {
 		vq->first_desc = 0;
@@ -2266,10 +2270,14 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	if (vq->ndescs)
 		return 0;
 
-	while (!ret && vq->ndescs <= vhost_vq_num_batch_descs(vq))
-		ret = fetch_buf(vq);
+	for (ret = 1;
+	     ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
+	     ret = fetch_buf(vq))
+		;
 
-	return vq->ndescs ? 0 : ret;
+	/* On success we expect some descs */
+	BUG_ON(ret > 0 && !vq->ndescs);
+	return ret;
 }
 
 /* This looks in the virtqueue and for the first available buffer, and converts
@@ -2288,7 +2296,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	int ret = fetch_descs(vq);
 	int i;
 
-	if (ret)
+	if (ret <= 0)
 		return ret;
 
 	/* Now convert to IOV */
-- 
MST

