Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18545C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259EF22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8X/HPr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgHCU6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:58:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728605AbgHCU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Gl2dylMgFGi0Gx2NZhfogviRtCkoLcQlgV/aPlSIlQ=;
        b=B8X/HPr/9fUXW084Q7wnokc7u/FeHrAPETo+t6WJ370nIpn8INp7zSPmF5UvRKPUwgdPa8
        AcEyMeIdtiXU9oYLMucELQs0p3NtLSiPglSV1HfYo/mVhKDjgVijZZCDv6iRCMmkSIQMbn
        4zPDNbMqaow0x99gRFbf9ucCwBJmRb8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-6C5xqDbQNoClozyNTuVqww-1; Mon, 03 Aug 2020 16:58:47 -0400
X-MC-Unique: 6C5xqDbQNoClozyNTuVqww-1
Received: by mail-qv1-f71.google.com with SMTP id j13so17877736qvi.17
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Gl2dylMgFGi0Gx2NZhfogviRtCkoLcQlgV/aPlSIlQ=;
        b=GeQRPc2xOgoj1O2tTH0glkCCYtWgnj/3UxItxUav5uMg0P476axDhJiTarb3Czcd14
         Iul7eP8FKvbETQn/RcYE9xOyARL/LvqxSbFCDeY0Pg5rL4VgyXqkhmJs6mn84YjKjn/R
         1It59Ou+o8pdX9yZtHmnf+pRVxSR61hpGygVgTeFIdaX2yFl6FU+BRK39HZieyNZddK0
         nbzQcdNyYFKa+sTRpzkl+fiQhjYMCMTJ/3nsbaEa9BJ+yxWWka/Tn9Fo9uDjcKT6El+x
         EQ8dl0Sbb4aYa1WOj9znBc16AMmx8kfCTbBwZYTeySYiVyYMr7Lm2LF0THFw2xM28v3O
         QcnQ==
X-Gm-Message-State: AOAM530xkIKzkCRGtTXudf8vaDax+4vV3tdS+SwpfSWW1PHyASyBIu8q
        vlUyu/A9004pgW3TO1B5lwqMKcBzgq8x8XeYeAG/QTW2vzZzRBNwa/7jr+0xSfVI24hPo2tGIcK
        v5bImK8Avn0jAoH6OB6IzdSi7
X-Received: by 2002:a05:620a:151:: with SMTP id e17mr18106845qkn.173.1596488321785;
        Mon, 03 Aug 2020 13:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEzdxjjAwaWwjwF+kSAMNrLrHcU+XPWDiBIGO+tn5kBn2karRqLrbCrl8SKBeGaGBSURQVuw==
X-Received: by 2002:a05:620a:151:: with SMTP id e17mr18106835qkn.173.1596488321605;
        Mon, 03 Aug 2020 13:58:41 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id x3sm20452087qkx.3.2020.08.03.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:58:41 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 01/24] virtio_balloon: fix sparse warning
Message-ID: <20200803205814.540410-2-mst@redhat.com>
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

balloon uses virtio32_to_cpu instead of cpu_to_virtio32
to convert a native endian number to virtio.
No practical difference but makes sparse warn.
Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 54fd989f9353..8bc1704ffdf3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -600,7 +600,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
 	while (virtqueue_get_buf(vq, &unused))
 		;
 
-	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
+	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
 					virtio_balloon_cmd_id_received(vb));
 	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
-- 
MST

