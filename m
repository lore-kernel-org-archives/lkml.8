Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6194C2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L00RFt4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgHET2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728599AbgHERL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsePUp5bwDzPkeGMt9DhuoyzhxlPvsYKTxQ+QKtzY8M=;
        b=L00RFt4hyZphKEkzOLKgLtwumDIYN0ka0yiSzXi3Lxkxo0DUCDZZ6eKg3TGRf6zfhXvtWR
        7gKepz9QStTnZtbGqHcA+9dtlFWmw3DOgS1X9FDgfroL9Vz2G3Aanpvhw7LL70/NH0wb8d
        n/mECgc9MFl+7dZNNT+mCUELluNK8hg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-qXjyYV8GOJ63X808JCdliQ-1; Wed, 05 Aug 2020 09:45:04 -0400
X-MC-Unique: qXjyYV8GOJ63X808JCdliQ-1
Received: by mail-wr1-f72.google.com with SMTP id b13so10876161wrq.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsePUp5bwDzPkeGMt9DhuoyzhxlPvsYKTxQ+QKtzY8M=;
        b=dJLeetCIT4mmlidH0LsgEQG4gbOUXaLw0e/e/vr9EwxkWUGAXEGkCVCYq8wrS9Ow4j
         KzTd7T9FayoZB7Db+LO3XtozH+mgpTamIjaeDW/USAvBtckaQvK4B7ZTwUC7YglrqIKx
         hMVdsQ4cVvmLQap+JeDQN7c6KQHWOUvULsdUoIKhTsPElikuv49GfU5IWYfgIzOdAPnI
         wTO78MZjFnmLUNd6nSlJ2sqLL02+9VATxEzDQi8bvSx8ioHlILzHeewx0WiWdXDWgqlE
         pC1tNUOsFgcEqstXHcKjiL8p3vC4Xr0cYbZBcC9NFEwwxN+6U1i+26myo5YEejQhwCTI
         TjMw==
X-Gm-Message-State: AOAM533ziHBw5S1Ct5sKP+IEhx1WA2kq/i9ERs1thcxgM3DAqKSpDq9T
        LvhmQz9j/6VxBiwdRA9nhkR1dCmS1grCt3dNiWVeaQoqDBW5EuNt0+UmmfPaV/jfCCJgU12e+2y
        jZ2xI0/dAzGM1+Iyr+tHWpxxy
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr3540959wmd.72.1596635102978;
        Wed, 05 Aug 2020 06:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhLoRx7IzuivQlViG9F0fDgIgMdjMVV9PC0dBe4LfMZpIiYNNk/XwHbeS7FyfdebXIBXrqkg==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr3540940wmd.72.1596635102770;
        Wed, 05 Aug 2020 06:45:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id e16sm2907812wrx.30.2020.08.05.06.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:45:02 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:45:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v3 38/38] virtio_net: use LE accessors for speed/duplex
Message-ID: <20200805134226.1106164-39-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speed and duplex config fields depend on VIRTIO_NET_F_SPEED_DUPLEX
which being 63>31 depends on VIRTIO_F_VERSION_1.

Accordingly, use LE accessors for these fields.

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c        | 9 +++++----
 include/uapi/linux/virtio_net.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba38765dc490..0934b1ec5320 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2264,12 +2264,13 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
 		return;
 
-	speed = virtio_cread32(vi->vdev, offsetof(struct virtio_net_config,
-						  speed));
+	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
+
 	if (ethtool_validate_speed(speed))
 		vi->speed = speed;
-	duplex = virtio_cread8(vi->vdev, offsetof(struct virtio_net_config,
-						  duplex));
+
+	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
+
 	if (ethtool_validate_duplex(duplex))
 		vi->duplex = duplex;
 }
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 27d996f29dd1..3f55a4215f11 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -99,7 +99,7 @@ struct virtio_net_config {
 	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
 	 * Any other value stands for unknown.
 	 */
-	__virtio32 speed;
+	__le32 speed;
 	/*
 	 * 0x00 - half duplex
 	 * 0x01 - full duplex
-- 
MST

