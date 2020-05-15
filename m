Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A04AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE862078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKHyoows"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEOQi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:38:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbgEOQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Bg7RWFLPly3TX4Y/V49rHB9a190dlTFcmjCSkHrUK0=;
        b=hKHyoowsetO0bI6QUhSJegZH3xguL7K4oybAIB2tZd8IFHSOqJrsynwchoU9R/bGDdnDpf
        GNItxYMt03Y2te6qc09hC2w4QJI/GwqetxIT0jRbWh8zqAel4MNIyMuLmvEqWPBOrsUWYU
        o/ibZsettJ79byymTDa45T7/C41xnsI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-b4jWKibFP7SJkQ1pfi1WLQ-1; Fri, 15 May 2020 12:38:09 -0400
X-MC-Unique: b4jWKibFP7SJkQ1pfi1WLQ-1
Received: by mail-wr1-f72.google.com with SMTP id 90so1424526wrg.23
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Bg7RWFLPly3TX4Y/V49rHB9a190dlTFcmjCSkHrUK0=;
        b=kSi15p/azszw5wtd458sxa7dvreVU6Qnn2uZMO8ssJ4nyX/Orr5iMbYUs1zsTzQmil
         dyj/gtizPBmSEw0uQ1MjjEv294sp13xZB1jDlla41niIGZwbaBhIjUV/bK6xhZc1P0GT
         8vLQyR2dTjHb81FADBY8reNcXfW0RYTbHXOQu56uKXeBCfudDLN1yrNT82HMLlasajUa
         GizlpoM3WnagIu4Mr0BY33wai4wZkEA2/Zb1lMIZsImm/vWGil1x+r0Ec9bXbsQ3RX9r
         knhuU/NJ1PwV4xkFrUcLhAwBKU1loe0gclGg0k8spoBex0bViZLs+Q9rv5ScNK1QbzGg
         5FpQ==
X-Gm-Message-State: AOAM533pxToiRyxNSo/rs1jXgFPQ00gjf/YPiFvuBV2C5LE0esRB7cG7
        g6O/QMxIw5rB70curbomN7m16YlWjZSW1Hf3CNUPsR+l71kvkPXW+gruaLaOyHymHRCmCbdigHh
        8EpaBKCHsYkTZ9Xpc3dP9pby3
X-Received: by 2002:a5d:5449:: with SMTP id w9mr5180360wrv.361.1589560687882;
        Fri, 15 May 2020 09:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ0wJAxWl28YCjenrP8G+kE5OMcm3BmJsWA9vMViZXynBcWONdSadJSiu/D24iHJbsAlDgVQ==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr5180340wrv.361.1589560687584;
        Fri, 15 May 2020 09:38:07 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id b145sm4680274wme.41.2020.05.15.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:38:06 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] io_uring: add a CQ ring flag to enable/disable eventfd
 notification
Date:   Fri, 15 May 2020 18:38:03 +0200
Message-Id: <20200515163805.235098-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
 - changed the flag name and behaviour from IORING_CQ_NEED_EVENT to
   IORING_CQ_EVENTFD_DISABLED [Jens]

The first patch adds the new 'cq_flags' field for the CQ ring. It
should be written by the application and read by the kernel.

The second patch adds a new IORING_CQ_EVENTFD_DISABLED flag that can be
used by the application to disable/enable eventfd notifications.

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
  io_uring: add IORING_CQ_EVENTFD_DISABLED to the CQ ring flags

 fs/io_uring.c                 | 12 +++++++++++-
 include/uapi/linux/io_uring.h | 11 ++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.25.4

