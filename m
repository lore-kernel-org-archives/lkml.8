Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AFFC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013F2311C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REJcxGWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgDFPf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:35:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgDFPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586187327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=U9FPI4YqTuvhUVUIJ1WaAsAFx+IRK/5JQT6MEVHh44M=;
        b=REJcxGWSzBwP3A/kPkpKZc+AHWLUkRczioXGo1V5SQF4pPp/UCxomTmbVP7hOeiE2l7Ymp
        rAb+IkUavpShM185eJtbG20OPB5JFz6/gwyr7QXVAvCMzTNQ2SfaSQsEo+gOcI+7kpq6x3
        kirP8JWfAC5dbQOVHfdrYLFxxnzNBsc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-6AVUUpLkMgaIq09uEVPHVA-1; Mon, 06 Apr 2020 11:35:25 -0400
X-MC-Unique: 6AVUUpLkMgaIq09uEVPHVA-1
Received: by mail-wr1-f71.google.com with SMTP id y1so8545546wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=U9FPI4YqTuvhUVUIJ1WaAsAFx+IRK/5JQT6MEVHh44M=;
        b=PkabvZ3b2YJViTyQuZearZd/Yl376y4FGNXrSz/UZtfqRSs0cv+ledaEGILJZ9FuBH
         xR1ysIknnyX/ny6KZxRQ4SiuxUr1vaZHfp7aM/H8EOAKWyvWoILOuC+Kpvhe8RRHKhfe
         Reip36ux5zAH5RwIH1MOgkNp6WhZ10S9cwU/ChvZ6AF+boCbwbAjC7MUgecpb1nAjmtH
         Zv/vxm5ckzfifbf0+X5K0NV94Rf+UzyugS6Lhj0UXi5hxHtz/UvZHbFoVVWkT2N+wEnX
         np3XFicBIuLU3rQ5opMSunlIXPGQOWqWfjM3E+EmXQlKOHMrHLCf05P0ZbemgffESVYz
         G/jw==
X-Gm-Message-State: AGi0PuZT6FlGw6xGcEl3w08clzPBHrmc/vYQfygDx/Mc5Q8JnR44PNjw
        vfTuzCnDEstZLwl2yS07Z3l8amoz/zTZwU6BTVZ36QdQquurU8b/EwClwF1S37r2UDdl5sw2uQO
        qag6SoxloczVOtpG4jk0dDNUR
X-Received: by 2002:a05:600c:2206:: with SMTP id z6mr263951wml.188.1586187323701;
        Mon, 06 Apr 2020 08:35:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKhj4TivWftTw1bB2oE6mwrZ5BkHsKdX2BUKyCnCZ90lN34C1uBMaBQtKpx7zoKOuhBqm2uFQ==
X-Received: by 2002:a05:600c:2206:: with SMTP id z6mr263929wml.188.1586187323423;
        Mon, 06 Apr 2020 08:35:23 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id s66sm26355199wme.40.2020.04.06.08.35.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:35:22 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:35:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] virtio: alignment issues
Message-ID: <20200406153245.127680-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternative to
	vhost: force spec specified alignment on types
which is a bit safer as it does not change UAPI.
I still think it's best to change the UAPI header as well,
we can do that as a follow-up cleanup.

Jason, can you pls ack one of the approaches?

Michael S. Tsirkin (2):
  virtio: stop using legacy struct vring
  vhost: force spec specified alignment on types

 drivers/misc/mic/vop/vop_main.c          |  2 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c | 10 +++---
 drivers/vhost/vhost.h                    |  6 ++--
 drivers/virtio/virtio_ring.c             | 10 +++---
 include/linux/virtio.h                   |  2 +-
 include/linux/virtio_ring.h              | 46 ++++++++++++++++++++++++
 include/linux/vringh.h                   |  2 +-
 tools/virtio/ringtest/virtio_ring_0_9.c  |  6 ++--
 tools/virtio/virtio_test.c               |  2 +-
 tools/virtio/vringh_test.c               | 20 +++++------
 10 files changed, 76 insertions(+), 30 deletions(-)

-- 
MST

