Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6503EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AB8206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdK3hBal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgFHMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:54:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729626AbgFHMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nNh1TL7xZUtXOusVSg8tIG35kTb/6beDbMDeGMbkL8c=;
        b=cdK3hBalYnQTZ2ivoNup29kX+WgRgCaAnDsw5wfyGBdugUnta7zGmGaDV+15nJQns5GPRJ
        3GryBGOPIok8qhGcXLqe2hE9foMQtYKpzJzxjWt4OCmt5QWp2ExK7hHLytKKm+6LttVg4K
        zxoZmC//Jkzvnn47x3BXU0ECh6klymA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-5pZIiZpfMN-SBr3AmdEzbw-1; Mon, 08 Jun 2020 08:53:12 -0400
X-MC-Unique: 5pZIiZpfMN-SBr3AmdEzbw-1
Received: by mail-wm1-f72.google.com with SMTP id b63so5348972wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNh1TL7xZUtXOusVSg8tIG35kTb/6beDbMDeGMbkL8c=;
        b=OtUplquKGcnYOBybI7mhGjZ6PDm79jH138ArLRUGh/ZF7WDAKfLwD1BXa8soSvYrtw
         6KZxXUjCXgg96EIzvclHXxnNa7t11ey+ejsvQlwTxqJRPnDkxZEQ1ZOy6ahlXI+altco
         dfITt86Rz5X7InyKBMusdbhX/89FToO9Bu/Ube6vF/fYGGaQSPVbtnavue3bUUnJgVfu
         LXUu2He+tFhrTElpq0YvPixMGrHxPP0C4YX5F7fY0f7dov08XkJvoaDvwae9i1CD7ftL
         7isA8yzq1Flq57niUUM+MxyTwCn7qi1Tt44uM79HFXMt7fShIZw+H9+lH0biH9xz6UUK
         J48A==
X-Gm-Message-State: AOAM533jj/1FGUPPrg/fzymKF1DvzdXeInj9Br6EgDRCr+DrAVKA+NyZ
        yfcW9k2i3q0IHXiacmMNH3pKqli1RlnR1n2Jil5UBjipjH2OlAp4MxjtGAGoIDoPmZqZQ+RJ6ow
        El6JR5sU648JPifSAZ7qA/Ky/
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr22414161wrs.234.1591620790802;
        Mon, 08 Jun 2020 05:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweTCKDLbfiVGUFqWREKS9iQ8j4XUwzsDXWV07w/+PxSXiYAJVsAr7kpiUE/TGQ+cExzBaktw==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr22414144wrs.234.1591620790552;
        Mon, 08 Jun 2020 05:53:10 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id h15sm22578283wrt.73.2020.06.08.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:53:10 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:53:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v6 08/11] vhost/test: convert to the buf API
Message-ID: <20200608125238.728563-9-mst@redhat.com>
References: <20200608125238.728563-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125238.728563-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
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

