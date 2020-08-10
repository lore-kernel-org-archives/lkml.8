Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57014C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D5C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFoQ/RLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHJMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbgHJMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597063725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=EfpMMW6Vx3J0Luy6MoDr3dSbyKrKFJoHO4ZG8rIQx5M=;
        b=EFoQ/RLdcmbs8b2M76w1Q21DVPU68D10I785T+pF9YWVPgKmO6O7wn0nLoQXX8/jTnNCRB
        0iUp4s9Wcseds9FzqRpBO+lo31eYp1eP8/rQWw6wUe2kW4I4WAhCXy6kcbrjcwfN0Tj6p2
        +UcJR8VPJVaYli37LnttKju7j3DdXvQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-OOjMJa0gOMindDvDX99UGQ-1; Mon, 10 Aug 2020 08:48:43 -0400
X-MC-Unique: OOjMJa0gOMindDvDX99UGQ-1
Received: by mail-wr1-f72.google.com with SMTP id 5so4161781wrc.17
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EfpMMW6Vx3J0Luy6MoDr3dSbyKrKFJoHO4ZG8rIQx5M=;
        b=k8VpOLYDQjfd28PMwkV9mQbNKkT9uPsm6opuZT1m2Y3f4s+Zy8ojyjoOcVjLAuLAKb
         zMq7JbNVojLNj4J48YLGPGV3PonvdQZnr6AMYDNwJgY7uXRjWl66NgYHbQ7XOeqprw0w
         mC7QobnxKRnpSMXbYTQHLseG36z4hefJRBXMtUONsySPaWdEwsU+OVlmupcogAkBd3go
         8ooS02Etc4ZEvkn4HI7ngkj23ywlUBujjaGHl2tz+glDEI3dR9zekHfxQB8x9CUe6bik
         pGfBKHFSx+X51vuMCcSHfKZXcFdfDQIR0EQtOI71GVp009A3+JCcehzxbPyR/5qHOWDp
         gBfQ==
X-Gm-Message-State: AOAM533SfFqcHryOr3EwQIsjiSe9AgHdJRwzREc8ggFS82sGGl2s9tsY
        +RF9JBK1jkN7UpakWIKFSX0jon+q2Ciaruup7Rnv+lbQdLd4l5r3XuE8DZhOGlrPnc21l2jtGPS
        3X6jFmLYExplqVIQLsrgt6DRW
X-Received: by 2002:adf:f189:: with SMTP id h9mr1333264wro.122.1597063722442;
        Mon, 10 Aug 2020 05:48:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQg4tk7pdRNPfnZDpCQdYiSarWXQWMHaUKFpslCi6kVUNoHOoJaD6xWEwdF7c0UDOSuRlE+A==
X-Received: by 2002:adf:f189:: with SMTP id h9mr1333248wro.122.1597063722253;
        Mon, 10 Aug 2020 05:48:42 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
        by smtp.gmail.com with ESMTPSA id o2sm22221324wrh.70.2020.08.10.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:48:41 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:48:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [PATCH] vdpa_sim: init iommu lock
Message-ID: <20200810124813.1555677-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adding the iommu lock did not initialize it.
The struct is zero-initialized so this is mostly a problem
when using lockdep.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Max Gurtovoy <maxg@mellanox.com>
Fixes: 0ea9ee430e74 ("vdpasim: protect concurrent access to iommu iotlb")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index df3224b138ee..604d9d25ca47 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -358,6 +358,7 @@ static struct vdpasim *vdpasim_create(void)
 
 	INIT_WORK(&vdpasim->work, vdpasim_work);
 	spin_lock_init(&vdpasim->lock);
+	spin_lock_init(&vdpasim->iommu_lock);
 
 	dev = &vdpasim->vdpa.dev;
 	dev->coherent_dma_mask = DMA_BIT_MASK(64);
-- 
MST

