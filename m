Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B07AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFB8204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P87VHWxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgFJLhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:37:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48912 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgFJLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nNh1TL7xZUtXOusVSg8tIG35kTb/6beDbMDeGMbkL8c=;
        b=P87VHWxuTfnukgUrCDq+ZV0PAsllRZt0SQGz7oPSEJGvWJ6OgpAfEvurLMcLmecsVBG4cD
        tF4fK64wtV+2U3CpTO7OccaVQySQYTOaWvfnwBdLFGUc9aFRX2wXFh1bprodYeFjPLwv6q
        aKpqCBFGoFb7qrgZVakyw/VECVnDzjI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-q72119zAMACM80rN4-6UAw-1; Wed, 10 Jun 2020 07:36:28 -0400
X-MC-Unique: q72119zAMACM80rN4-6UAw-1
Received: by mail-wr1-f72.google.com with SMTP id s17so963136wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNh1TL7xZUtXOusVSg8tIG35kTb/6beDbMDeGMbkL8c=;
        b=A26zy1oXBoQNWbOf2vvS+h7cILizmRvlj1cnpoiDGErig22FIHGhPX2tzS12sYPPRu
         j0Ta8CsCB2zvrd78qoBttdt/MR5ilyA7apCo/CfSjPOxhF6fiTp9qD5ELD9xq/yFKj0A
         g3ysedZrzNCVFhoOephe0Jnwaw+ZhYVlS6CXCFqU5olecsqNe070LaUnJWlQN3P0PUfH
         wWLYTrQZcsavsviOSOoHHryrY9lrv7N8+A/nwDVjqrAYzlIYW9J1DyhB6hZKxbwWfhJ5
         dy+SreFyJtBw7mcgDY+vS5ELT3bMCMzzzXuM2eYZVIwwMnq7nuT7T94kjfej2PpZbBn1
         D7Uw==
X-Gm-Message-State: AOAM533bv+lFwr5qNAxKxlEiwGyPVpo8BASckgAdKdmeIsb2CZUJdQxE
        Ye/tEhHRi/9x2ssC2QhOEaQZxrLQNjbztZ43JGhDa3Ae5gDzT4GrAhMZJxiEVq5bHwVLKcktuMH
        GelHQQSe6VVQvsgJFYO+db/++
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr3131429wrn.86.1591788987303;
        Wed, 10 Jun 2020 04:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+fpU0gApAo9WdU2/MAJH8DR4JAaeeYujgzZhmzjJ0R2CYxZQQqTFJTYVCM7So04QnKQlLdw==
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr3131407wrn.86.1591788987053;
        Wed, 10 Jun 2020 04:36:27 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id a16sm7675327wrx.8.2020.06.10.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:26 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:36:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 11/14] vhost/test: convert to the buf API
Message-ID: <20200610113515.1497099-12-mst@redhat.com>
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

