Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CE9C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B13E2078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1ih96sJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDFW0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31429 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgDFW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=R1ih96sJcIvdpAIyKwrz2acmyPZnIe9bL6K6Pf2Za8JXM+IP8zBbwlNiatS/nrOpu3r/wv
        NGoRmiiWMvTM8f5DvnBuCInLIirnOGLbpDOl/Axa/g94WAG+wi62j/mtcQAH0MaVIKQN4I
        Z9N3kok8E89pOBnPd2e97mW3vR3rraQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-zusFBQAbNYOl2R_f5OM70A-1; Mon, 06 Apr 2020 18:26:37 -0400
X-MC-Unique: zusFBQAbNYOl2R_f5OM70A-1
Received: by mail-wm1-f72.google.com with SMTP id s9so159163wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=INytPd6NNa07/ndYgrCb1AOjA5GwiFPAApBYkUhDi27i/kKcHbJHSDLfYCfFD7LW43
         0cRiKqXAO4rvtvQQBc1S2ucQLOQYXU72sOHIqAMra+ZWGOAxn8Tduz5Ys6hy3ZGfBZa5
         I22QLK1PFew2LcH7lf4Xo9tgftfIi6ikLGwf9cmAUE7z2Ig4/JqfbLgB0wB///UuwS+f
         J/B0QOMs0pC++IYFzrBShjUIGkw4af7BVUcn+GsgjhXeN++UtTW1XlKis9MWaLX0uuoT
         ml9PPwPgBvoWFh5MxLmiskWmNj1n4vex5yDsQKla+VXes5vK1eg+voCPJNGWoJ4EWDo7
         NTNg==
X-Gm-Message-State: AGi0PuaL3cJfwvn4eckJ33OXcg8/bxyZQ+mkI4RZ4dcL3EJWeSZyzQDw
        pKfDmsWTuqTsnjTwZxvlONXLSc+E6ol2z31+b9ylm52jWz+7cCvp0bfCuBqZBoHeFfjDJUxn6gy
        fXxZgaFiF6YJeonPnsUkpvgrg
X-Received: by 2002:a05:6000:1090:: with SMTP id y16mr1356897wrw.281.1586211995905;
        Mon, 06 Apr 2020 15:26:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBiJSqYUen7mSSXRpaMA2RRUCKg7gFj+QtdLfzH0FWN8clj2+GZO3iVNHgzn10ZwwLLS/ApQ==
X-Received: by 2002:a05:6000:1090:: with SMTP id y16mr1356886wrw.281.1586211995761;
        Mon, 06 Apr 2020 15:26:35 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z3sm1162290wma.22.2020.04.06.15.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:35 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 03/12] tools/virtio: define __KERNEL__
Message-ID: <20200406222507.281867-4-mst@redhat.com>
References: <20200406222507.281867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222507.281867-1-mst@redhat.com>
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

