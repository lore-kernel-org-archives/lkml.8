Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7BF2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj71QmAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGHfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:35:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgBGHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581060909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SKYdikAA+hgb/0T2Zklcmqt1kU5M2t66zJpHfvIrUeY=;
        b=bj71QmAi3NHG86goSZxavlAOsLGOtgT5r8BHjWVhEYXduOrVquz2yX6NDgt0bQJtneDaeD
        WBUOvqKMycmeq+iJmcc8/Lqoui3ZJPaSR9ATw1XE/565Lq+vTvSUkJgYyGxtTp6IaxQF0o
        +y9PS4mQxJVdXP6GLneZ60WBbppGsaw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-z6G8_fikOs-A-Qe3axIcoQ-1; Fri, 07 Feb 2020 02:35:07 -0500
X-MC-Unique: z6G8_fikOs-A-Qe3axIcoQ-1
Received: by mail-qk1-f199.google.com with SMTP id t186so838017qkf.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 23:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SKYdikAA+hgb/0T2Zklcmqt1kU5M2t66zJpHfvIrUeY=;
        b=bkAhQ/db38x7KRy7xAEHZUF++U2kugwl4yvl7olpiQby8WcKsfYLpkt9GZgU1L3Q1b
         c02i3noFD8HlNjBfXDKUHz7y9+5EH64sVuL6SEm0hzCPVJPCrSo5VShR6qSTlSx8k58u
         7ggCYQOnrIsg0g+fEFt6VAwgjrpwxDeYCya8WeO102TUxrn8OjN9PDaBAJC4OO1tedSE
         XW40gdSKMJs3N9+Kb84ebMRtqhcHrpgEP5ZfLVOiEmq2EWpj2qfFryqgDbOzq4jBC6WI
         sTUxq1nffl9GHJiRsMsMrepT5a4KceCtsekwtPYdaM22VCTdBEHeuPSa+3HQTi91iI/Q
         b2Sw==
X-Gm-Message-State: APjAAAWj+jPuIeK5waE1RPh+KMYFwNci99wOz3dCFGQQBKDifQkWRKrO
        U7w6uPCvkeiDymlzyfyf4VFKAk8QSR/qlBKqh2O9Eh30KKlNfQBhOg7PDMSKeSE3TtAaKnhk11l
        ON6G+BVLCnb7KOqrckRwYJrVv
X-Received: by 2002:ac8:7607:: with SMTP id t7mr6135762qtq.51.1581060906349;
        Thu, 06 Feb 2020 23:35:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkY0S9VVJNL8wo6HngYhCdVY4p0ebnk5lOl5ttMEUPbpIfJZMY14kdE+ZHEy15vyZHaKEXgQ==
X-Received: by 2002:ac8:7607:: with SMTP id t7mr6135749qtq.51.1581060906060;
        Thu, 06 Feb 2020 23:35:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id k5sm895159qkk.117.2020.02.06.23.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 23:35:05 -0800 (PST)
Date:   Fri, 7 Feb 2020 02:35:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] tools/virtio: option to build an out of tree module
Message-ID: <20200207073327.1205669-1-mst@redhat.com>
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

Usage:
        make oot # builds vhost_test.ko, vhost.ko
        make oot-clean # cleans out files created

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	lots of refactoring
	disable all modules except vhost by default (more of a chance
						     it'll build)
	oot-clean target

 tools/virtio/Makefile | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 8e2a908115c2..f33f32f1d208 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -8,7 +8,32 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-poin
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
+OOT_KSRC=/lib/modules/$$(uname -r)/build
+OOT_VHOST=`pwd`/../../drivers/vhost
+#Everyone depends on vhost
+#Tweak the below to enable more modules
+OOT_CONFIGS=\
+	CONFIG_VHOST=m \
+	CONFIG_VHOST_NET=n \
+	CONFIG_VHOST_SCSI=n \
+	CONFIG_VHOST_VSOCK=n
+OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
+oot-build:
+	echo "UNSUPPORTED! Don't use the resulting modules in production!"
+	${OOT_BUILD} M=`pwd`/vhost_test
+	${OOT_BUILD} M=${OOT_VHOST} ${OOT_CONFIGS}
+
+oot-clean: oot-build
+oot: oot-build
+oot-clean: OOT_BUILD+=clean
+
+.PHONY: all test mod clean vhost oot oot-clean oot-build
 clean:
 	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
               vhost_test/Module.symvers vhost_test/modules.order *.d
-- 
MST

