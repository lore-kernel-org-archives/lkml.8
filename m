Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C89C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B942072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXqcIbn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgFKLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:35:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728130AbgFKLen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591875282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nNh1TL7xZUtXOusVSg8tIG35kTb/6beDbMDeGMbkL8c=;
        b=FXqcIbn2v+qxSBDsbkCkLCjYpC5K55x3LIXgklMhrgsP3ZzXmNZqYms7UUmLydnFQp2plb
        vHHQenyRNpvDNGRvwO5vS66UCpPdpkYMhbN6SNEfw1tqFGaNxzO+Tg34oYA9fDlHF4mSCS
        MgxehsFtmX4v6fKTrze1xUvLVPhpIgI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-OZRIfYZYNTSbEo4dlgl_4Q-1; Thu, 11 Jun 2020 07:34:37 -0400
X-MC-Unique: OZRIfYZYNTSbEo4dlgl_4Q-1
Received: by mail-wm1-f72.google.com with SMTP id x6so1234973wmj.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNh1TL7xZUtXOusVSg8tIG35kTb/6beDbMDeGMbkL8c=;
        b=VE7Fo5d8tazWz6CY8zlpymbAl/hVh8PS+Qt8BHsy9vpKPIRsUaRDqFI5Y1+0Ph12/8
         HzekwajMMNQy4Z11dCZ1yviIq195WuFFLB9uTh8bVpEjkpdijv4aMwyMC4SezEkfVWoG
         zTjaTpPu+jsSs/kXuHBoIGkWDaNHIUBUk6tvONfAceEaVAlJrsmmAv12JRxBZloHVAb3
         Ipd+b1af3mo78PiM6Saw+SnGCxQ4EKxB2uaJZpKMsXYRhOvR6QWsskJd9RcYAfLHn/yD
         3xWPd32Asd8I6WF/YMzYYp3epN+sln4GzjI7/1lG2/JSKgTINIqvBmhL4Tw6pnxtaB/h
         n5Cg==
X-Gm-Message-State: AOAM5324KV7cGCxM1Vv18wKfIiUV3M40IuI6qHODzXRgb8xvGqoXRdgP
        Id1npCNPyKBVt1QG3lu0nHEd8S6L0gPFvXDswoVgDhBMVbTzy/YAKewBiEuJjTIUg8PVDdksC/y
        6dlKmCy2xjvCK0zMmAn6Witp7
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr9625706wrw.277.1591875276456;
        Thu, 11 Jun 2020 04:34:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2zXWmmSHCI3WrhXi4UlhJiH0TBT9f7dUAngUHj4AqaFD4pDWyqbUiTnBy/EttZUS7AWNdGA==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr9625677wrw.277.1591875276191;
        Thu, 11 Jun 2020 04:34:36 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id h12sm4550238wro.80.2020.06.11.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:34:35 -0700 (PDT)
Date:   Thu, 11 Jun 2020 07:34:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v8 08/11] vhost/test: convert to the buf API
Message-ID: <20200611113404.17810-9-mst@redhat.com>
References: <20200611113404.17810-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611113404.17810-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 7d69778aaa26..12304eb8da15 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -44,9 +44,10 @@ static void handle_vq(struct vhost_test *n)
 {
 	struct vhost_virtqueue *vq = &n->vqs[VHOST_TEST_VQ];
 	unsigned out, in;
-	int head;
+	int ret;
 	size_t len, total_len = 0;
 	void *private;
+	struct vhost_buf buf;
 
 	mutex_lock(&vq->mutex);
 	private = vhost_vq_get_backend(vq);
@@ -58,15 +59,15 @@ static void handle_vq(struct vhost_test *n)
 	vhost_disable_notify(&n->dev, vq);
 
 	for (;;) {
-		head = vhost_get_vq_desc(vq, vq->iov,
-					 ARRAY_SIZE(vq->iov),
-					 &out, &in,
-					 NULL, NULL);
+		ret = vhost_get_avail_buf(vq, &buf, vq->iov,
+					  ARRAY_SIZE(vq->iov),
+					  &out, &in,
+					  NULL, NULL);
 		/* On error, stop handling until the next kick. */
-		if (unlikely(head < 0))
+		if (unlikely(ret < 0))
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
-		if (head == vq->num) {
+		if (!ret) {
 			if (unlikely(vhost_enable_notify(&n->dev, vq))) {
 				vhost_disable_notify(&n->dev, vq);
 				continue;
@@ -78,13 +79,14 @@ static void handle_vq(struct vhost_test *n)
 			       "out %d, int %d\n", out, in);
 			break;
 		}
-		len = iov_length(vq->iov, out);
+		len = buf.out_len;
 		/* Sanity check */
 		if (!len) {
 			vq_err(vq, "Unexpected 0 len for TX\n");
 			break;
 		}
-		vhost_add_used_and_signal(&n->dev, vq, head, 0);
+		vhost_put_used_buf(vq, &buf);
+		vhost_signal(&n->dev, vq);
 		total_len += len;
 		if (unlikely(vhost_exceeds_weight(vq, 0, total_len)))
 			break;
-- 
MST

