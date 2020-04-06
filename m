Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007920753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cogNw3yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDFVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726446AbgDFVB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=cogNw3yj+I4t6kDKiLm6kMDngYwUXvwj4zlshmGue0vlpnv7LXmApYYJW2zIb24rqACaZs
        hUY9XeF1NmGVWAKt6C/MUoQRjtyG41eJLNBWQnLGaDAPzF5aflH6gjcQlPt8JLCSD5K7pD
        l81GDxQnNar4kTo8B0MjlDLORUF3+Ks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Ocjv9fMKNJSTJgHXk6ODrA-1; Mon, 06 Apr 2020 17:01:56 -0400
X-MC-Unique: Ocjv9fMKNJSTJgHXk6ODrA-1
Received: by mail-wr1-f72.google.com with SMTP id y1so533070wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avaeRkZ1JnKDUOT0Z2Dx4o4wqMo2IiZX1JaGDR9LW2A=;
        b=rzCmpmldmgh51Ly/keC09/LXHrEhxywoiXTdUAuJYWZZBHO3DwDqH+gTip9m5ugUm7
         nU2citQ4dIOkAseP9s4a/9wszKZyOQjvkVjMKREc6w4puKLto2bux3zKYlU9zxbfoHV6
         54LcRPyt5rMWnDvJphgB+tP867+kH/khIlbsyl3LsZrM/gRbr52UYV4ToABKvyWk4Gt6
         6F9MrmF+LcZbemNcj3KmfPVE1a1yk6rZu/qSK2IJNMD5Py0btqT9Vyc25ZDviiGasIod
         g96QVMeJiyoJjfIzp/tpz8+TVVtr4MT5+PZV5EVmHhi7/Y1Z0XAHiC/1FZqCI857SQih
         rfRw==
X-Gm-Message-State: AGi0PuZm46MvYX2CwB8N65mmLmfBQqGplfARY16m4E37w/KVjKdQKpMq
        a5jIAZ/cdW/cRYVvYiyuPXeUnvx6N9WtM8a3BK8Z8fjBCIj+amx54ZSwKDlUX2QhgFarR3I8GHu
        4ZHewaiwvqKHNYv5r+JTIQOIy
X-Received: by 2002:a05:600c:295a:: with SMTP id n26mr1077866wmd.16.1586206914192;
        Mon, 06 Apr 2020 14:01:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7PmatlCOEaiT44kklJY3XQDVlzCX6CQ5HXBSQbwSxFsprMcnd0G2gWziCsDYMLW7CcKPBfQ==
X-Received: by 2002:a05:600c:295a:: with SMTP id n26mr1077851wmd.16.1586206913969;
        Mon, 06 Apr 2020 14:01:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id t124sm975023wmf.19.2020.04.06.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:01:53 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:01:52 -0400
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

