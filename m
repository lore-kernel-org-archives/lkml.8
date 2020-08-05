Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6680822E02
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxmaJmts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgHEROU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39288 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728579AbgHERKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QhVm0jpCx0j1VjzEJrlev45JExYE6+1Gd5oJ2Fv0G+k=;
        b=dxmaJmtsB6dawHsy7Kfw19SzlJH2OWRbz64voEFdpPu4W4cfHhYuHw227n/4Tc1PbvC0o9
        tknCAQzx8YsT3enSBs0nj3vcp224vkJSCbwtLQII1qLwae/oLnVkfo/JmNKGgawKshN8cM
        clPL+jPfVxbShJGhSk7bf4E2WQ9AtXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-jbu8dVIaNiOnTxIpgWzrig-1; Wed, 05 Aug 2020 09:44:06 -0400
X-MC-Unique: jbu8dVIaNiOnTxIpgWzrig-1
Received: by mail-wr1-f72.google.com with SMTP id e14so10117452wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QhVm0jpCx0j1VjzEJrlev45JExYE6+1Gd5oJ2Fv0G+k=;
        b=MqSle7ou0gaSQDCMHOjpmbZUUmo09A7uhgLUXEa2XlexTnU6kfVbfRHG0Nu66woJ3R
         2aId5BgjRD6iziYMboo8d7dIDEdS27nRwPBOJ94wJJid2JdEb3QDtT3knuRU5x4gtDiq
         LcmSKxku8J5D3oBrOvj+82mO4PZoErRNcp72Jtc6BB86wbSUucCU8lM9RyrX0pe2Wknx
         Ea9B62Ag5MroX/STs+SCao6xAJ/Ro2cVwBsPRkxw/ZSumpT7tJ+MF41/VGDUQ6Ob1jv8
         xDx5QyMrxZ0wWPVRJ9ORKGezl/HCw7bEVIhBqzoxUg0p/tya6iwZIBWfuulzVf8IfBB0
         m0WA==
X-Gm-Message-State: AOAM531D4io/pxb95BuGT1UejfZCRHAqLC+SE+PPytu00wXl49+9QQib
        4JzC8aMN3VEFjKIM5WRC9JHxAx5gJpqC5GbktVmKobRt7kHMhvihQv6YbPZyi8LsEyEecOBQaeX
        t57TRDuYNlsr+52RiNfTf32xW
X-Received: by 2002:a1c:e912:: with SMTP id q18mr3340532wmc.130.1596635044507;
        Wed, 05 Aug 2020 06:44:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNXwX/2HYdrh9bva0R4SCALRC4UH6tOenG7WilayDF9QXu8qTNoQRaplyGLd1b/SDfI6ylAQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr3340516wmc.130.1596635044293;
        Wed, 05 Aug 2020 06:44:04 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id t189sm2914860wmf.47.2020.08.05.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:03 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 17/38] virtio_config: disallow native type fields
Message-ID: <20200805134226.1106164-18-mst@redhat.com>
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

Transitional devices should all use __virtioXX types (and __leXX for
fields not present in legacy devices).
Modern ones should use __leXX.
_uXX type would be a bug.
Let's prevent that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 64da491936f7..c68f58f3bf34 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -319,9 +319,8 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 	__virtio_pick_type(x, __u8, __u8,					\
 		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
 			__virtio_pick_endian(x, __le16, __le32, __le64,		\
-				__virtio_pick_endian(x, __u16, __u32, __u64,	\
-					/* No other type allowed */		\
-					(void)0)))))
+				/* No other type allowed */			\
+				(void)0))))
 
 #endif
 
-- 
MST

