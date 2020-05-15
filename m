Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422CEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D1420709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auwsXi5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgEOKyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51053 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725835AbgEOKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589540060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v6+7HSHBKR8s0hEc33VZWCAeaUDT8hTqdZCAfgvJPF0=;
        b=auwsXi5ChYKGe9gfeUvtqL62zydkMAhZSHybWOWtL2afFS2HcwvMftLHTfwCzdx7LN8q+y
        Zb846USVkIbP2M/Wai8jWGoA3QpuH0+2V/yuK3ei0yqhgG1o00bkD5cZrEqPOElktCdtid
        skRVMi+wXmLFHBTRckfPCjSpudt/2Fo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-X7dsn6_OMbGZOYC2dsUqdg-1; Fri, 15 May 2020 06:54:18 -0400
X-MC-Unique: X7dsn6_OMbGZOYC2dsUqdg-1
Received: by mail-wr1-f69.google.com with SMTP id 90so990050wrg.23
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6+7HSHBKR8s0hEc33VZWCAeaUDT8hTqdZCAfgvJPF0=;
        b=DXIVe+147Xq29v08TP+4z91I4lzLmDz9jQzGXGFmI4JZ0uxi2N9YUdfI3gqf6HOnH+
         JFufShULDxH99tZ1XpH75WfUuSoZFWJ9v8JZT++/hKuobj+BDQiJcTPTnlVHxoiJkb4r
         JAwHpIrgpIyRFyIdg8TetPFdUk9anb91jNm3HR0aLfDrWZ8KM12wOJC2J6pBLW9Q08sa
         tsGUiALzxcX5gkR0AeHc0G6aUMulkEblUo2+jg4BS/ChTAxiRLh3cAAyylTqQWp0XjHX
         VkwLVKG8YfTnGfNFf1g1JFdnwOkQDMgV/61gdCtJeN/ThzfFxfWiwSeMmhAWrt45YdY/
         rHHg==
X-Gm-Message-State: AOAM530U44La202fZC6P2aGkinFsWCd4B9pPpBLgsVCs01+A2RyTfF2G
        Sj2wC7OvfEchH2jfRzGzio6EXznbFGotHigGwDGthOKnr7XY3NTK5rE4xnfDMDdP5LP5NMpzuZm
        83EWDid8Egcakmi1xPJJKGJ45
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr611343wmh.141.1589540056767;
        Fri, 15 May 2020 03:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGKSyZ3EcGNQMbE2oXkZ+N+V0uB4B/vMGscbFwTRyBx5EdRM7q4us6BaR9smbe7DP+QNBN5g==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr611327wmh.141.1589540056541;
        Fri, 15 May 2020 03:54:16 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3081713wmu.13.2020.05.15.03.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:54:15 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/2] io_uring: add a CQ ring flag to enable/disable eventfd
 notification
Date:   Fri, 15 May 2020 12:54:12 +0200
Message-Id: <20200515105414.68683-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds the new 'cq_flags' field for the CQ ring. It
should be written by the application and read by the kernel.

The second patch adds a new IORING_CQ_NEED_WAKEUP flag that can be
used by the application to enable/disable eventfd notifications.

I'm not sure the name is the best one, an alternative could be
IORING_CQ_NEED_EVENT.

This feature can be useful if the application are using eventfd to be
notified when requests are completed, but they don't want a notification
for every request.
Of course the application can already remove the eventfd from the event
loop, but as soon as it adds the eventfd again, it will be notified,
even if it has already handled all the completed requests.

The most important use case is when the registered eventfd is used to
notify a KVM guest through irqfd and we want a mechanism to
enable/disable interrupts.

I also extended liburing API and added a test case here:
https://github.com/stefano-garzarella/liburing/tree/eventfd-disable

Stefano Garzarella (2):
  io_uring: add 'cq_flags' field for the CQ ring
  io_uring: add IORING_CQ_NEED_WAKEUP to the CQ ring flags

 fs/io_uring.c                 | 17 ++++++++++++++++-
 include/uapi/linux/io_uring.h |  9 ++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.25.4

