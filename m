Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6088CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9BF20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LifWSsa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFBNHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:07:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728363AbgFBNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591103183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkIC7lu04RjihR3CHtt6ay4K/Xfv1eAdqmqMBhW1nUc=;
        b=LifWSsa+dlAOqYvpOSxVpBrjO3E+PBxENGpFlQtx4cQYfV62b1jr+4Pbsf3V4bb6xvbLyq
        QZRqGkQCeXrnqgLbtIK0Pr2AIwjlxjHRVplUyUUGw96c2xRrykc3YhCUVNL7RIptsmY81l
        YEKpPIMCOrhWgmV1AGPLHWWLgRcI+ps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-7mmddS_9MGmqOd7FRXdWrg-1; Tue, 02 Jun 2020 09:06:21 -0400
X-MC-Unique: 7mmddS_9MGmqOd7FRXdWrg-1
Received: by mail-wr1-f69.google.com with SMTP id s17so1370628wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkIC7lu04RjihR3CHtt6ay4K/Xfv1eAdqmqMBhW1nUc=;
        b=bD5xUcEgC/luA58irekb8YSPSGSYK6nRcy12gNmovrtiWDRjW6mCkfhtdW3lhDZAzQ
         vOa1FrSVlkUB31zBgcigsFcUAMZ5yhn9UlnQChC6xWBTNAUzOBn4ZmMraLvgjpkef0br
         liFIwyQo7mvR5soa53lmi9hLkIJsShPeR7OHXGKaVQzFY17IpCzvTHTw9EZbcnTgsFgn
         HhIs0VKIm3DTWHDjngXoXO/dGUVwbExVAo1kKAIwLF5ZhaX7oQvVyxn9ksa2eDhFP7Aj
         In6f28/t++z8b1onvz9edpvM8TI4kouBhGk+0KEmVVva5KDkqnCyG1IAIyeqlAozHqA7
         6JpQ==
X-Gm-Message-State: AOAM531Lh6GUu0wbRi7evFtmRqioYajFiMxoL8sfDaoYKgxLHXXaUqVA
        8bf/bjCkMsuvuRhecIwaxALD5tofqbKVls8JJVi/L7i7DE7kWyEwEhVqZV/uWTmjMHths5226uH
        lSYqVq4X6lLKB6TKKixvxs5b8
X-Received: by 2002:a05:6000:87:: with SMTP id m7mr26716062wrx.306.1591103180173;
        Tue, 02 Jun 2020 06:06:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5w09ZL79wZ7Oh271xsfdoKTPaA5LzVH1a7uDl4PbLKlKnjLFOCQbjfNEw+zB0N+AN5b0WkA==
X-Received: by 2002:a05:6000:87:: with SMTP id m7mr26716050wrx.306.1591103179992;
        Tue, 02 Jun 2020 06:06:19 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id j5sm3782271wrq.39.2020.06.02.06.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:06:19 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:06:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 10/13] vhost/test: convert to the buf API
Message-ID: <20200602130543.578420-11-mst@redhat.com>
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 02806d6f84ef..251fd2bf74a3 100644
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
+		ret = vhost_get_avail_buf(vq, vq->iov, &buf,
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

