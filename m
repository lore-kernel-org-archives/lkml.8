Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E879022D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbd4MUPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHERLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:11:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728466AbgHERJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nsePUp5bwDzPkeGMt9DhuoyzhxlPvsYKTxQ+QKtzY8M=;
        b=Kbd4MUPyz5KLtsirjxwE9j/1dddSQL9UdrLzbAZQPAQL0nC3jDbOl942DZhhLjm7V+yjLI
        WURrq+rBxiNMHXU3bIx9aR0aGuvpEX2WwNPElxXlo/tgUnFhl6eegzOVbY1Qyv50Bnf3ud
        zdlvdjJEqDC6sPd3bkGL2SBwB+NFKgM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-wbachtwONJi36YeQtIotYQ-1; Wed, 05 Aug 2020 09:38:55 -0400
X-MC-Unique: wbachtwONJi36YeQtIotYQ-1
Received: by mail-wr1-f71.google.com with SMTP id k11so13082364wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nsePUp5bwDzPkeGMt9DhuoyzhxlPvsYKTxQ+QKtzY8M=;
        b=QoTWsdxqLZVQHX0jLF5K4s4wjEP//Zjnum637v4Y+KbGjoylbgrDQMlRRtVIqpgkDh
         VlM1d30abs5cdEi+zSTAwtAa1UweG/kwqWD/sM/cgj2h/ltXVQ5kSlakpvQF0L9dvjnW
         HOFXJDQyvlaZxVweBJhMQd78xb7izGlXAv9LR4ax0kYTzFj/WZA1/fCWaj9w37psHfTe
         +COKZ28WtzgyawFvXOpnj/vMgb7PbZY/2K2rwvP2IohrEF0t6GqPj6oJTTiufLbXjKpc
         6ov1UlRWtUMN5br/jzKxUX6Z0GR+ZREaNCrWZTF8AMp/JoAZtusPIy/Lf9VDzId8FKda
         r5ww==
X-Gm-Message-State: AOAM5324cPCLy4ySknDR0fE1rgLb1siO8Fp5nU9mYSGNvCSKgpvMWsL4
        AXzZHiVD8jZL4gsY7u7Trsj0/ZGGpxb9AHwpLYZf7vnhjuNP8x8Zf/xTDR9MJ8jhtMr+AQO8DBP
        +aHmqkmsidrRHse5FcivXGZcQ
X-Received: by 2002:adf:f486:: with SMTP id l6mr2832109wro.265.1596634733651;
        Wed, 05 Aug 2020 06:38:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrJHbiAkvwUZChxw62cK2kQ+h4SfhhoyHmbeMJJ3IoB9ua448nhQGhAU9Dt58uSQD6O7qCdw==
X-Received: by 2002:adf:f486:: with SMTP id l6mr2832102wro.265.1596634733486;
        Wed, 05 Aug 2020 06:38:53 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id w1sm2855531wmc.18.2020.08.05.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:38:52 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:38:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: use LE accessors for speed/duplex
Message-ID: <20200805133843.1105808-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

