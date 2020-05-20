Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D21C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE6C207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPg8qEoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgETRHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:07:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbgETRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R5gtdRsL9ifN7yCZuWFMi81hopoNqGWuqIuJGxvm7G8=;
        b=jPg8qEoAI7dNR1EN3jYX+8odSmxfTb2IUXUJ6+6AdSzt85f+QZJpFn5qMDAMKsCRcwCZvB
        u2gHjA2OFmAn/kQUZT4EdhUyKp0PLouxrCsPQtf99yt/OPUMut/OOidO41sWubQFmwR65l
        YmmqxJCmOmq8HiKjG+6cSUkS1BiwulM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-oN6WkiXXNK6Q3TAEU-U9FA-1; Wed, 20 May 2020 13:07:18 -0400
X-MC-Unique: oN6WkiXXNK6Q3TAEU-U9FA-1
Received: by mail-wm1-f72.google.com with SMTP id u11so1082890wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5gtdRsL9ifN7yCZuWFMi81hopoNqGWuqIuJGxvm7G8=;
        b=BIfSnuGuH63BmWN5ZnQc6TDyMDZrltUY4adfSo3Hx20nRymoPMD+sx0DgpzhGSjXN5
         ibtuf6TFkHlMnMpydtFNkev6RajOpIaRl197/2jd4jZrrYbg4EPtqg5i4MIvnS6EDRNW
         HOeasvuelYa1JOEppTpLXekO5luvhXyWeIvluMJoqsfoVnQwcFmKOl++DqBEYSUkrsud
         RclXE31x+LPU8F8NmCee2lPFU8ANP1nl/jLBan1LKRzo8bjfQqCVQanhTmxl9YKlyg8f
         IXuVIXjmug4g9bbZnBi0i5FOdWALzDmYv73vKeATuKZDjFFvZ/+E4YcvocunXpf3oH75
         7hjA==
X-Gm-Message-State: AOAM532F+nxbFHMpo36S8rdpoNZghkfh+xeDFGpd7A3Jk+fxdVMz+GNI
        a6/W9QlCengXF4agFtRNIMPIbs9FD4h+2px3dolEumFzRpKhIRMISlWNLlfxJrlRzgZnuu+ziSQ
        hLuJLR/I8NZVpjB5S0LNsX3s+
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr5197376wmi.164.1589994436451;
        Wed, 20 May 2020 10:07:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynFVFxeMMZ/CQT3A/ITIWWt66gwDGDa673jWSyagjowp7jh7Bk4zmW7lu95gMGrueShnLeLg==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr5197360wmi.164.1589994436149;
        Wed, 20 May 2020 10:07:16 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3768614wmu.13.2020.05.20.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:07:15 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH liburing v2 0/5] liburing: add helpers to enable/disable
 eventfd notifications
Date:   Wed, 20 May 2020 19:07:09 +0200
Message-Id: <20200520170714.68156-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on top of a new IORING_CQ_EVENTFD_DISABLED
flag available in the CQ ring flags.

I added io_uring_cq_eventfd_enabled() to get the status of eventfd
notifications, and io_uring_cq_eventfd_toggle() to disable/enabled
eventfd notifications.

I updated man pages and I added a eventfd-disable.c test case.

v1 -> v2:
  - renamed io_uring_cq_eventfd_toggle()
  - return EOPNOTSUPP only if we need to change the flag

Stefano Garzarella (5):
  Add CQ ring 'flags' field
  man/io_uring_setup.2: add 'flags' field in the struct
    io_cqring_offsets
  Add helpers to set and get eventfd notification status
  man/io_uring_register.2: add IORING_CQ_EVENTFD_DISABLED description
  Add test/eventfd-disable.c test case

 .gitignore                      |   1 +
 man/io_uring_register.2         |   8 ++
 man/io_uring_setup.2            |   3 +-
 src/include/liburing.h          |  34 ++++++++
 src/include/liburing/io_uring.h |  11 ++-
 src/setup.c                     |   2 +
 test/Makefile                   |   6 +-
 test/eventfd-disable.c          | 148 ++++++++++++++++++++++++++++++++
 8 files changed, 209 insertions(+), 4 deletions(-)
 create mode 100644 test/eventfd-disable.c

-- 
2.25.4

