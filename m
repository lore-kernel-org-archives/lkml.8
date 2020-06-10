Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD702078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD3DXviU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgFJLhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:37:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29258 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728661AbgFJLgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nqpRKPPRu97i04+lEwiVZnVP4RAISD6OyeyY71/1iaw=;
        b=PD3DXviUIXZSvLoLAGuF692PzUijlWhppV55ZYxp5ZvJhdv/oOyKxnqycdlsIKlAl05Ro9
        vJXmZKpt9/tjiRcITzJF7kZ+lqnPFaDR6sRdKl9FT8WvPsPF/3XlmhxsbBVFUDAcD1u2C4
        Q8BCO1YTt5uaGYZRw8wu8KRy9OYKJWc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-dq12sjCyNT2fCVMm2nr8wg-1; Wed, 10 Jun 2020 07:36:20 -0400
X-MC-Unique: dq12sjCyNT2fCVMm2nr8wg-1
Received: by mail-wm1-f70.google.com with SMTP id v24so401502wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqpRKPPRu97i04+lEwiVZnVP4RAISD6OyeyY71/1iaw=;
        b=h06zfjyWln84MFaL0M7III3AQ1SIdWcefiLl0DaPO6cI84d4PI/37rL0CnPWjhnYqb
         LzJTLXpmL4EAPEhYkcNZ3T4pXwgiojTHeIKdeO5KNrZH+Ok6rq+A1JZrc7KJfwSD5Bju
         nwfRmYwtMIjIpkr3vhL4/oeM5RsLW/EmQ09xnIv/Je68J8FqomjKe93Fb9WrPSlGgoMy
         MYDvOczDQEhrEamchLjp4T6LNP3mnK158hIYmn1dCG/GCvjZxKOr3zbUjx8emk+sJlLE
         4sQpb+hNd8KyhlbtOkabvKi8eoFzz5b7qPeN2/a93kdHygDbQ0OllqK6fU6MA6StEDGf
         GqYQ==
X-Gm-Message-State: AOAM532TGIvecDPLY/n8OYhpGil79kIf7gp/FxZDmownHVlXH6pO1rJf
        ztrgca6qPV0ITVyOLyoXyPkWpb6CdpyT6PC2MfC5gfCjpbyJQfmuxuAr6xhmJo0iU9+Lv2/dtPd
        hj4cCvP4KM5yjqF4y9OpBuelT
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr2749318wma.148.1591788979281;
        Wed, 10 Jun 2020 04:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk/lBSoKqQEzUm0ygb+JThKfl+fyQkS7QcmVzzuz7sF0aMX0Q8Jh3FrRflgePDOX+1hNCqVA==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr2749304wma.148.1591788979097;
        Wed, 10 Jun 2020 04:36:19 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id d63sm6775894wmc.22.2020.06.10.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:18 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:36:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
Message-ID: <20200610113515.1497099-9-mst@redhat.com>
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
 drivers/vhost/vhost.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7a587b13095c..03e6bca02288 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2205,10 +2205,6 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	last_avail_idx = vq->last_avail_idx;
 
 	if (unlikely(vq->avail_idx == vq->last_avail_idx)) {
-		/* If we already have work to do, don't bother re-checking. */
-		if (likely(vq->ndescs))
-			return 1;
-
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
 				&vq->avail->idx);
-- 
MST

