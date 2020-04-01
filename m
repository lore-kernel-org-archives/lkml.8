Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350D2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5mH9SLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgDAKgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:36:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30067 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgDAKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=05QXKWS1KqcrFB5NhBgUw/ejOvygxZ7y1z56i9t/j7E=;
        b=S5mH9SLpD9gwnEjGqBHEsbxztEJxr4sSiIltZn9etYWg9uM5HUsvZbcSfFnR1/IYRIDWDc
        X5a8b5c+z+jD+4mqmEtCJZ3FadTWx95jMxrjzgb/wZsgmpN6kCMVt71qtDmy0yC0650x7N
        sEWwhN4FLpfvKkUamTozkbgjv2Pa+eQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-B7HVfewHOU-FlN9sjUz8lw-1; Wed, 01 Apr 2020 06:36:43 -0400
X-MC-Unique: B7HVfewHOU-FlN9sjUz8lw-1
Received: by mail-wm1-f70.google.com with SMTP id u6so1640426wmm.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05QXKWS1KqcrFB5NhBgUw/ejOvygxZ7y1z56i9t/j7E=;
        b=f8+65fTCrS7j9wf7LS39L5Z1znTb7WCPOU3fIX+x9xhoR9AMhTl9hmG8LF32+5MtQU
         nGqJYZ9gIxF00qeQo94nXsDtmWIu7Q8/QhbpaJEKelZ5H/oIvqyLynkbtz9YfNOCALOI
         Bm46W8IImv3uD3AuPDHaJvpYNcgkR0ILpJgQCNmpQtvaV3kygwZB3cruo78jj1eScdEo
         ynmmhTqBw/55TNXaZ62jQu36PWXWZr+Sm7XaeUzAsqZkLAGXmSk3LG+sypBJ8TEuyz3z
         FYKODAnkc5nIIT9HQKzwA0+Xwsp/kJsUO6EsfrfuwiDXhkGRDXklcx1DduOEldal3X8n
         72GQ==
X-Gm-Message-State: ANhLgQ2qH1AT7xknvy4Ndg5Ocf+0Oku0SQoLTJKxYcsVQvHG8TnKCFql
        b7xdFJNLiTYUZ5qHvhj6pKhNT4dZ0QOWVdnHUuCk/qcXgC+Aqz+O7PowMKy5EXLa9EKtBYRrZYn
        wJv6MAXwzUUopLhRWsrmpIfJh
X-Received: by 2002:adf:a18c:: with SMTP id u12mr24808825wru.325.1585737401779;
        Wed, 01 Apr 2020 03:36:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsk3gwZaCIoqXICrLYVNkXNloxQDGeyLUThiGBS8+UIEbwtoL5GPxoeWEZeSzECi02DkiyAtg==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr24808800wru.325.1585737401541;
        Wed, 01 Apr 2020 03:36:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/5] Drivers: hv: cleanup VMBus messages handling
Date:   Wed,  1 Apr 2020 12:36:33 +0200
Message-Id: <20200401103638.1406431-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small cleanup series mostly aimed at sanitizing memory we pass to
message handlers: not passing garbage/lefrtovers from other messages
and making sure we fail early when hypervisor misbehaves.

No (real) functional change intended.

Vitaly Kuznetsov (5):
  Drivers: hv: copy from message page only what's needed
  Drivers: hv: allocate the exact needed memory for messages
  Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
  Drivers: hv: make sure that 'struct vmbus_channel_message_header'
    compiles correctly
  Drivers: hv: check VMBus messages lengths

 drivers/hv/channel_mgmt.c | 61 ++++++++++++++++++++-------------------
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 34 +++++++++++++++++-----
 include/linux/hyperv.h    |  2 +-
 4 files changed, 60 insertions(+), 38 deletions(-)

-- 
2.25.1

