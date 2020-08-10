Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014EEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B69206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xal2rq4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgHJM6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:58:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20133 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgHJM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597064322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0XWxoXgTd+Cmn2+Y+VXXovIx+yerjTcX1eN21KuFyjg=;
        b=Xal2rq4iVe3bQCuOWOefzw9WUXU1SJOLVd84mlyHC7iPfvHAQSZD/+6K4++U1c3xP4rtR/
        th01CfaI5lzgR6+sBMUbSJ9+PLWAfdjEqrGG1b4Zvtxb7dh6+Xuni3Xu2tm5hSLibq1TnC
        TCI3HI5ASMvM+i5nou0NVto3YY8dO4o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-ib8iGnd0OACZx5CArPkNpw-1; Mon, 10 Aug 2020 08:58:40 -0400
X-MC-Unique: ib8iGnd0OACZx5CArPkNpw-1
Received: by mail-wr1-f70.google.com with SMTP id w7so4202347wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0XWxoXgTd+Cmn2+Y+VXXovIx+yerjTcX1eN21KuFyjg=;
        b=LnYVW0bzK3YM4jhBU01BXeKNLV7QJOx1PU+Y30XW46TYEbyZE8Qt6bQ8V8Sldlzc4/
         LRy9HijSeg8Z/bB9/7toLp52O8c//jco6TsvVEuDJKVqCy7AsylkrGZmoHfeTedAtwZi
         tDUuKU5gDJOdzb78dzX9inYWe+8Y3aoDa3CydJNbBdrDYA2rl4zBBggqKp6DeHTLnmCk
         neqQKXjRkv4+YCRHpoSFrUlrrYW3gfctIlGQ/jaB7WuqrXs9h3lFqsYhudbvt3HGXm/L
         aPgYxGbB1P+ZnbVRQOeo446Y6/77G7WZ91XTwU4PA3axteM8pVdsDJXaGA9e9I2/oHc0
         3n2g==
X-Gm-Message-State: AOAM533fiiInduGpnKlAgMuDI8EJT0j3uwj2pwJq3CDz40ddwHsX1uad
        30kWbyTUh1DWCFXOAC7t/RG2xcEQ7j0PHGWFgCmb0K7kLqSrARe8db+u3KIdxjMIhIzgVRxitJN
        dNe5oTMADATFHZnoX7aYwf503
X-Received: by 2002:a05:6000:141:: with SMTP id r1mr23576324wrx.69.1597064319483;
        Mon, 10 Aug 2020 05:58:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgVrjE6ddfYhHeuXfquYYvBR+ne2IStmNs3q7O3IT77a7Q8nyuM1ewjqhkOrzQtMEqJjKPvg==
X-Received: by 2002:a05:6000:141:: with SMTP id r1mr23576314wrx.69.1597064319331;
        Mon, 10 Aug 2020 05:58:39 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id 31sm20844627wrj.94.2020.08.10.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:58:38 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:58:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim: fix pointer math in get_config
Message-ID: <20200810125833.1556552-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a pointer math bug here: the variable cast is a struct so the
offset is in units of struct size.  If "offset" is non-zero this will
copy memory from beyond the end of the array.

fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 604d9d25ca47..62d640327145 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -558,7 +558,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, &vdpasim->config + offset, len);
+		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
 }
 
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
-- 
MST

