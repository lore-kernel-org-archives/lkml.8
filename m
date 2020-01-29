Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3902C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738D820716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrZvXtEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2JRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:17:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29935 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgA2JRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580289448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RGglrM7s5lSXQM0eAmEz+FQFKQqXY1sMI+jK3RokXCY=;
        b=WrZvXtECRQjq5EvS2g0g7hBdGqC1RCmyW3f4ATMvpgqOaXG1jIxOgDr02hAGvHo2j6R3X5
        tDYhoeQF2eWi3/9nM8vieezWpz9U6RrpMsEqQu5sf2EVg282Zdm8nfSL5W8cQi/SKEeMI+
        LyGERR5LKZaUPrEH8gfgZ+3iDlQ2lQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-zg9FZZGHOCiT0QOJUZuz4Q-1; Wed, 29 Jan 2020 04:17:26 -0500
X-MC-Unique: zg9FZZGHOCiT0QOJUZuz4Q-1
Received: by mail-wm1-f72.google.com with SMTP id z7so2129712wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 01:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGglrM7s5lSXQM0eAmEz+FQFKQqXY1sMI+jK3RokXCY=;
        b=tIWxd1QrkY0U0pYer56lcPDQRg/M206ei/3KrbBGBjtBAKJ06HMdPCoc1HssXFJs3o
         7Hm+mng0AeYoIAzv296dzI9C9bYF8gbPR/WO/WJmZx6eczPjDbBdfSZ3enfcQ9JT/jqA
         9bjVMnPhkoqxBLSOQ28XryYj9XsnXTTKDx5K6VzL12Nlyrny+c6hGt4CgkYJVxT8kavF
         Cg4UBpDABIGmk0htLsDTHoGgAlzhU6N1ZTIccwNXN/6RVuoQvkEM+OCNQmw7i4I8ei4M
         hD3OptVvvn3hbqdkIOMfQ8pagpHstdtIhhlRHvK4NCjrEgh2JljEZ4EkIqoDoYqF9bTA
         Sdyw==
X-Gm-Message-State: APjAAAW/uIHzgE2vBF0dKgFj/acXfhanMQnwgZ5OqZaBTDH7OmMB/3il
        MiVYAGowQOBgEUyAlzHiaj+qmkviGdtRrfxnCWgBvYPhL8qVBDDnb1avCSMCgtf2ZBV55X2r8VI
        p89lJDLi3q8mQhr2u/TAwJ8Pe
X-Received: by 2002:a5d:5706:: with SMTP id a6mr34179123wrv.108.1580289445162;
        Wed, 29 Jan 2020 01:17:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNEgRl6FoHBqOsuInbDXgnwmjNkSyuM8sX3+aZwGv9UkUvO1RB7XUCm8cQEi3IOEHAnJfT7g==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr34179089wrv.108.1580289444845;
        Wed, 29 Jan 2020 01:17:24 -0800 (PST)
Received: from steredhat.redhat.com (host106-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.106])
        by smtp.gmail.com with ESMTPSA id a22sm1550885wmd.20.2020.01.29.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 01:17:24 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH liburing v2] .gitignore: add missing tests to ignore
Date:   Wed, 29 Jan 2020 10:17:23 +0100
Message-Id: <20200129091723.16746-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1 -> v2:
    - rebased on master
    - forced 8-bit content transfer encoding (I hope it works)
---
 .gitignore | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.gitignore b/.gitignore
index fdb4b32..acbd30b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,6 +24,7 @@
 /test/a4c0b3decb33-test
 /test/accept
 /test/accept-link
+/test/accept-reuse
 /test/accept-test
 /test/b19062a56726-test
 /test/b5837bd5311d-test
@@ -36,8 +37,11 @@
 /test/d77a67ed5f27-test
 /test/defer
 /test/eeed8b54e0df-test
+/test/fadvise
+/test/fallocate
 /test/fc2a85cb02ef-test
 /test/file-register
+/test/file-update
 /test/fixed-link
 /test/fsync
 /test/io_uring_enter
@@ -47,18 +51,26 @@
 /test/link
 /test/link-timeout
 /test/link_drain
+/test/madvise
 /test/nop
+/test/open-close
+/test/openat2
 /test/poll
 /test/poll-cancel
 /test/poll-cancel-ton
 /test/poll-link
 /test/poll-many
+/test/poll-v-poll
+/test/probe
 /test/read-write
 /test/ring-leak
 /test/send_recvmsg
+/test/shared-wq
+/test/short-read
 /test/socket-rw
 /test/sq-full
 /test/sq-space_left
+/test/statx
 /test/stdout
 /test/submit-reuse
 /test/teardowns
-- 
2.24.1

