Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823CEC7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4004124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqLME2Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBTCcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:32:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46007 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBTCcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:32:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1105246pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 18:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zr5u8Chlfff2X4LtdmxMDdWIdJ3E6W1Jd7u1xAH1pgY=;
        b=YqLME2Upvbgry5x4ZwXh9NuaSkibHeECcLimobVcOq4rOxlslvdQi8bQpj47MPJpsT
         XZtF06I6/FVkWNuddpU0pb2IaHw9VWTjxq8wbM85XIePqlc8tqUew/GVhGEinnKRLCpz
         AswZ5COmSocVAf7kBzRzLtMgqRMw4d2zALjO31HxM/Bc97gieySrjgjX+Pr9z0JjyBz7
         zc009QD4iwZcjRkF0Rzk0AyezUcy1IwKYG3kAH1vvIXeFdiZo0yBCMuZYYcMtgM8xkq0
         a6GcBN8UlwayRhqvIdv5xrOXcR2p5NIBW9eDQjUc60ESzxdh2DbKy0NM3T43pDPM4SI3
         9kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zr5u8Chlfff2X4LtdmxMDdWIdJ3E6W1Jd7u1xAH1pgY=;
        b=Gn4CwqF6Uf9SwXyk74NQCR5uZQhmP533kzMfCgvA8UpLxZvXoucs0RSd+1Qd7vy5SH
         Uyh798WwquavV++jXikFud6ysU0fXuO/SJHjEkO54pBROqxq7woQVVnWyffdwkJm5fg4
         JPgnAC8QpzgWP1MaB+4Uk02BVh0IJvIlIkuf6ry6Lta48XXC0c5JwQUEpJ89MPCJoukA
         f8qN9sSwd/lKQdoJHLol+AsAr84cjxTVQH4nV8QO5hOFq+beu3vdtc1CL7o24xZKFOP/
         EiOwkPZ3nBu6KRACK+k1/tXBSuPDmxAH5FvxzWbO9cD0GiT32OZe6R02jod1RHymOFrC
         T2Vg==
X-Gm-Message-State: APjAAAXJyaB0jQHiLJoNx9BrLfROBb/Ycw2Klg7IXjUsl1jJ4/qdXqpR
        uizahv6hfxxreaiuYS8BQ6k=
X-Google-Smtp-Source: APXvYqyep9F5J3KoDhiCL/yaP5HvZoAj87AsHQagc3pwSgMRkO7tnGn55MApTjed/2XjmAO6L8mFMQ==
X-Received: by 2002:a63:8c5c:: with SMTP id q28mr30401414pgn.324.1582165924216;
        Wed, 19 Feb 2020 18:32:04 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12sm1049427pgj.16.2020.02.19.18.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 18:32:03 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] virtio_balloon: Fix build error seen with CONFIG_BALLOON_COMPACTION=n
Date:   Wed, 19 Feb 2020 18:31:56 -0800
Message-Id: <20200220023156.20636-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day reports:

drivers//virtio/virtio_balloon.c: In function 'virtballoon_probe':
drivers//virtio/virtio_balloon.c:960:1: error:
	label 'out_del_vqs' defined but not used [-Werror=unused-label]

This is seen with CONFIG_BALLOON_COMPACTION=n.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtballoon_probe()")
Cc: David Hildenbrand <david@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365d9372..341458fd95ca 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -959,8 +959,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
+#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
-- 
2.17.1

