Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97958C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0320753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDFF/r12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDFVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60679 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbgDFVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=KDFF/r12yuTXWqHbz8i/fPKqKyeWeFJiMW5BcKWR1wO8xIPqhWEfEY+FrRcUQJWqCL6uDe
        fpdV2F4VIsNu11/luFoMWgRbF/S/qkPne8SxUst9Q9BvIooL2P9d8SG9o0cMUywuetJZ3V
        6zAbwbXsydEuZyQUR6+6JUu41t91dfg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-usBq063ANYqw0RUWQEEsFQ-1; Mon, 06 Apr 2020 17:34:34 -0400
X-MC-Unique: usBq063ANYqw0RUWQEEsFQ-1
Received: by mail-wm1-f72.google.com with SMTP id f9so409874wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=qKNwysfS9zB7YE/We2nznJy5mhYMbnnhRMDvvVBOW1G9UtOigfIU3LKHKF9XnbrXOr
         DNvnGR9dmyHpUz5WLO8Ej2eoUAHiQm/AJuv/0ZRZpHvWcdlc8PTia82BmC7qOIh4INyI
         iH2unfbX6OaMHtveR5mYa7eiltqA/RlbDLAm515R1+cdWT8yzRjCcOnXK7u/Z0AvL824
         ka75dWRwwH3CVV3JcuR4ssguC1M8+4Zvjo+K/+iWUMO7avM1/Ge1t2VNjR6UTY1sAT7m
         w6haFtUnbW0UKXvMI1IsDjWueOw6l3uv7Y2Cuf6Cn9/Sx934+SPmMGU86jGkXyma8j/i
         hB7Q==
X-Gm-Message-State: AGi0PuY3RDiPC0IFud+eFQzaiMli0Ydv6Mqsv1/+YJ2dMCPjek/3ovDz
        zgxCff9Zsk9Dp8h/Qq5pFxRJI1IemcwXwft7UX3NMlK9/c+pg7ZdNfi7D4vl7VNP3S4Yf6i6q98
        CPY0MA8+PhJPjyanFIvY2bQIg
X-Received: by 2002:a7b:cbd2:: with SMTP id n18mr1068233wmi.74.1586208872976;
        Mon, 06 Apr 2020 14:34:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypKsDLUhGQC/Tn+0qnGfmRAOsV6x9/Q1yC0yzxYjjrHjRbm6CASil7gnkQZHykkq9cDFgqyFnw==
X-Received: by 2002:a7b:cbd2:: with SMTP id n18mr1068219wmi.74.1586208872813;
        Mon, 06 Apr 2020 14:34:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f16sm992072wmc.37.2020.04.06.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:31 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 03/12] tools/virtio: define __KERNEL__
Message-ID: <20200406210108.148131-4-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200406213430.0cMyWmqz-gAbTHMs4AnqbspIEzMzMkvzsSwLBx3jmqc@z>

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

