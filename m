Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB04C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DC520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6gIRRmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgBFIBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:01:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728059AbgBFIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580976096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3tlkCnjb8Q/VM9TgB9qGpS6MVMK6ymwvGChTp9CUmG0=;
        b=H6gIRRmjIMnuh8TvboRRpcv50EvtAL32xOwRI6suEtTpZe/sjyzXAdRMtxNq2ki8NAx//D
        e61j5hez0L6YvZqJ4gZhx7sUQcpDWHLaa0//5BeMdmht4Mqaf1kIBIcbQo9Wv1N3j0OEri
        QgIFQo3M5OJzdeCbHeUSwgLuFvBbpYY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-UIVDLVSnPjeqJ5t-dsqG9A-1; Thu, 06 Feb 2020 03:01:34 -0500
X-MC-Unique: UIVDLVSnPjeqJ5t-dsqG9A-1
Received: by mail-qv1-f72.google.com with SMTP id d7so3192308qvq.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3tlkCnjb8Q/VM9TgB9qGpS6MVMK6ymwvGChTp9CUmG0=;
        b=lewpT4mblkKP0bPRC6q7vtCjTyheIxe5UbXwZhNk82fmCYimdVIypf6K/FoRNpDB2y
         0bMXXE7faXun1+bBpBut8RJRxnTigR9jSt9DCeWlZ+foYSE0xwrgwPzsOPH0Svz3rbWl
         6y/yyL904yJyz4/1moSD4YGdje/Ws7q4HwIplJiwtmRwTHD3JCGheTvbanf5R5n1kAZO
         +/x70iGxo0qnYNmWE3k5jh6pOxlGi9+8ff5r/XPh5Rx3Xa439eVXxRZfCDnzkFBekG1z
         ESIdChjtGT6lBeNZ3v6Oj7k2BLCmFPSxQRR9gt2HCQL7BvS/uJ8mNrjTEfiLrsPwhp7t
         U5ew==
X-Gm-Message-State: APjAAAV1KzynW/IxQI3Y76XNSXgHdoKxiM8ntyr4HhiwAZvv1o45T9AY
        lKW3bNYW3Ih8K1vS8zhjgdGrfhDmxWYyFQ51lBLApUzJSPQFfefFctDds+7C8bPqs7h1sjq2Qau
        wNok8S0L1vZ4xhuh1IjHQt7Is
X-Received: by 2002:a0c:fe8d:: with SMTP id d13mr1308099qvs.217.1580976093801;
        Thu, 06 Feb 2020 00:01:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDBfxSmanieDzWEXWVdX/CjC3Q/5KbnOAyJYXWTLuPb+oEDUAw9pAoLQDK+qxgWVtcbdYfBw==
X-Received: by 2002:a0c:fe8d:: with SMTP id d13mr1308083qvs.217.1580976093498;
        Thu, 06 Feb 2020 00:01:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id m16sm1025713qka.8.2020.02.06.00.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:01:32 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:01:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] tools/virtio: option to build an out of tree module
Message-ID: <20200206080125.1178242-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handy for testing with distro kernels.
Warn that the resulting module is completely unsupported,
and isn't intended for production use.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 8e2a908115c2..94106cde49e3 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -8,7 +8,18 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-poin
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
-.PHONY: all test mod clean
+
+#oot: build vhost as an out of tree module for a distro kernel
+#no effort is taken to make it actually build or work, but tends to mostly work
+#if the distro kernel is very close to upstream
+#unsupported! this is a development tool only, don't use the
+#resulting modules in production!
+oot:
+	echo "UNSUPPORTED! Don't use the resulting modules in production!"
+	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/vhost_test V=${V}
+	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/../../drivers/vhost V=${V} CONFIG_VHOST_VSOCK=n
+
+.PHONY: all test mod clean vhost oot
 clean:
 	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
               vhost_test/Module.symvers vhost_test/modules.order *.d
-- 
MST

