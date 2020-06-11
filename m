Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADA9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470832072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdF1UaXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFKLem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:34:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728103AbgFKLeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591875276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yeTF/4xoJH8JkJEZ+aqTMVrfSsZomUNfl5tfcaaPRM=;
        b=GdF1UaXpd2XFc7NACGwxjeT3PZg6r6tCu+MG/rvcZOEEhb4Dkec9p0s7HicXcuYC/WZu2V
        IkM5EtJdm9di5Q7zBEfa8ot5UW1TKFL1w7Ixau1SXt37phwB8gucmDFUKjyatcWz0kfsfZ
        sMkzI7uWAA2HJl+ydzoyPrW1q2mT3XA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-7kvaPOOqMNOmtwqr7Z4yGg-1; Thu, 11 Jun 2020 07:34:35 -0400
X-MC-Unique: 7kvaPOOqMNOmtwqr7Z4yGg-1
Received: by mail-wr1-f72.google.com with SMTP id c14so2434762wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yeTF/4xoJH8JkJEZ+aqTMVrfSsZomUNfl5tfcaaPRM=;
        b=JkVLZAAQ9M+hFHFRP0hD/zsn9n4mh6R/yeMwI2KeeoyjytWWReR/dgdk8/rkqQLO+2
         5aXg6CVp2LNU0mm5esMVzfPUlDUZ8WtDAEvc9b6+ddO1EJlH/+0oR+SbeJQadchzLtXV
         P6eceQBOHEbE9xwLeitvYMVsQVbmSXdPRbvhHifSivL/NmBfG+BXbgMK1MsFnWr0R6su
         DVxmI3FcrnN7vw4lRHNL/6mV0IKp74frVzoPLTNvxBaldZLkNfPALML+1Y5MQwevqgtB
         ySr/zpJ5ZaTCWG/MM1AEi7ofNg070xS+JdxfgnmalqOgKwUHKkOvzVquixnkj/IetJoX
         cjVQ==
X-Gm-Message-State: AOAM533Tjq+auDQBfT58ME1aCjoMYsk+KzOrlFW7l+/6HS/J3d95UddK
        iGcXSu8W66sgky1BA8/4KdD83GQg/z6E70jzeZ5nlQUfzd5ogKnFL5xTiDH0QOKACrzQkl6ve42
        hAiNQFx+YmXlR0pRpuMLEUdEJ
X-Received: by 2002:adf:e381:: with SMTP id e1mr8683444wrm.320.1591875274095;
        Thu, 11 Jun 2020 04:34:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP1H7ZA1p3aDr58BVHo1lTwD6nnLZ5xDw5t6ge7P3fJgEClZF0S1h1hQVZzkshTgxNN4ZDtw==
X-Received: by 2002:adf:e381:: with SMTP id e1mr8683426wrm.320.1591875273921;
        Thu, 11 Jun 2020 04:34:33 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id o6sm3634582wmc.39.2020.06.11.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:34:32 -0700 (PDT)
Date:   Thu, 11 Jun 2020 07:34:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v8 07/11] vhost/net: avoid iov length math
Message-ID: <20200611113404.17810-8-mst@redhat.com>
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

Now that API exposes buffer length, we no longer need to
scan IOVs to figure it out.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 830fe84912a5..0b509be8d7b1 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -607,11 +607,9 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 }
 
 static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
-			    size_t hdr_size, int out)
+			    size_t len, size_t hdr_size, int out)
 {
 	/* Skip header. TODO: support TSO. */
-	size_t len = iov_length(vq->iov, out);
-
 	iov_iter_init(iter, WRITE, vq->iov, out, len);
 	iov_iter_advance(iter, hdr_size);
 
@@ -640,7 +638,7 @@ static int get_tx_bufs(struct vhost_net *net,
 	}
 
 	/* Sanity check */
-	*len = init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *out);
+	*len = init_iov_iter(vq, &msg->msg_iter, buf->out_len, nvq->vhost_hlen, *out);
 	if (*len == 0) {
 		vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
 			*len, nvq->vhost_hlen);
@@ -1080,7 +1078,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			nlogs += *log_num;
 			log += *log_num;
 		}
-		len = iov_length(vq->iov + seg, in);
+		len = bufs[bufcount].in_len;
 		datalen -= len;
 		++bufcount;
 		seg += in;
-- 
MST

