Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A15C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B5220768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ljx+eeAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGBQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbgDGBQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=Ljx+eeAUDkXY9CO+4YXdnYj64F/UmSNsc94xmsxceKUYw7wFmaSZ+b8eh92E02NdmC2S/n
        VZX2UwdOZ5DTNCtwvs2/gYSjyPinNoAvsaNneo0UPRt0KwfQHacDBgBATGGNY7XeiRqbH1
        yowuv32CqYbAiukcF/Htlvetb5RV5K0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-NSf2AMWgND6qBL_Ts1KdCA-1; Mon, 06 Apr 2020 21:16:36 -0400
X-MC-Unique: NSf2AMWgND6qBL_Ts1KdCA-1
Received: by mail-wr1-f72.google.com with SMTP id w12so839204wrl.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=ooOaOgoeCS926zClsUNmwDhAVOm9qcRpd4d2UCdHEop6QXFDbX/hLUfP2tp1GecU9F
         iU7KEUftTW6l1GXTRyKAuWsVuXX1octKYtynfpuhDJ0cwC1V+rY4LsSeiZjfN4ssSIOv
         ih1ftsNagg0Y0mOpxdxLs1UJW4Z9isqhm6gxQuJYFKAeZG5/+EUX6dxRlByzrcfGoWC7
         2JSLdwnE7hoEV666CqVELqXnnJfh9kM0LlXm0xo6VqSstgyJoxqog1MgH4DjQh+SZ0TV
         BgmmOuxCsSLcD97wiZKv9Ta0RuQq8g+KWs+s9l9gBjSrQZGw3y3N8XCmp1hSossnY9+v
         zU2g==
X-Gm-Message-State: AGi0PuaD/dnIfVeIyxKkuUTnw7x55H1sg1PBGz66G6G0eeleThsB7lMl
        F65m+qedlX65gJD+NNamyhANGsL7Zqom9p7UCYBx7nyZbdibuuqXwXw8k0I+GhcLOJCo2sO7onH
        +Qxi86PC0jdf2QQwNf1qTTYyA
X-Received: by 2002:a5d:4246:: with SMTP id s6mr2029045wrr.321.1586222194940;
        Mon, 06 Apr 2020 18:16:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKWkr4ZqkSRYtTLBgfGpJ5Yb/IYOEqHTM8Xx2O8GLLhIbQ9pozRiRQPOpPSDWHvw3XND59nHQ==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr2029035wrr.321.1586222194738;
        Mon, 06 Apr 2020 18:16:34 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id e8sm20324384wrw.40.2020.04.06.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:34 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 03/19] tools/virtio: define __KERNEL__
Message-ID: <20200407011612.478226-4-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we are building in userspace, we are emulating kernel bits.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index b587b9a7a124..ea6674307507 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
+CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -D__KERNEL__
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
-- 
MST

