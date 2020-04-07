Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89667C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD812078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc2jK+O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDGBHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56379 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgDGBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=Wc2jK+O4L8cuHovyT7AddsE3SuaXUa8/tqbt/3wbz3PD4rlIdSgXY7l3KoDfk3yW+RQdOh
        sXJzuuZv02kC79O+KQl0mw8Om5j+DdO1feYmNrJ/vLABJqAum0ev//4GTkh8YGQiovKkAk
        /g8XdFt8ATVS8NUY7ikqhQqvGXqQrp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-2JbT7Yv9NnOMm-aNd-dZ0A-1; Mon, 06 Apr 2020 21:07:35 -0400
X-MC-Unique: 2JbT7Yv9NnOMm-aNd-dZ0A-1
Received: by mail-wm1-f71.google.com with SMTP id d134so5849wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=HZQjqpAsku6cWEBSBoA548Wlus9SfwGj8mQYfmPCG2YKk2c9pQiLPLSrJNVKBLGpJ0
         ooR8coAvtxF5YwV1LPiYqf0wmBZg+dwOXIc7IYbXmbHiY3BtKM8X0vaVynZemRk8Lcc3
         WnlL1pQZkBDjDdTskvNfhLLMf2JAxazzzaXDzo9Pk+QjaWa2LohYbby8oV+gi1Fy6CNr
         vErHJbADwlcjoM8pTW3wECuV7yRWuhm+hOyvCznSP1y5tWstDHseA052zZ/T4w2Zqrsn
         SCvtjrx+gEBAgRSPElJfOK2GC3vs8HIFDd7EWj8JfX0Uzf/ZvCtD3GwM1vl6KsAD63r9
         EJqQ==
X-Gm-Message-State: AGi0PuZ/8pyMNuJWhYEAM3WqaidzLDlDf8afDeXV9aiNNUK/nOVXQbr6
        3kU2SyTLSRMOFoqwbs3MgghSTR/835wGkF+tsrKg3mr0XTVk8xzox3NgpUm0I7ul1o+LJBCSqrm
        UKv6pwDc7Wp2WyE/edWzc0Vm8
X-Received: by 2002:a1c:2842:: with SMTP id o63mr1697292wmo.73.1586221654166;
        Mon, 06 Apr 2020 18:07:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxuMMzBcs/LvUTLzcWLGFp2EnijdskDTwCLcN2NKwovn4HRWiTvfYCo9g/8VdEVNOsiDnXLg==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr1697272wmo.73.1586221653949;
        Mon, 06 Apr 2020 18:07:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y22sm105023wma.18.2020.04.06.18.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:33 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 03/19] tools/virtio: define __KERNEL__
Message-ID: <20200407010700.446571-4-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
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

