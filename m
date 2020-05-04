Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C43206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoupBZji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEDMPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:15:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728587AbgEDMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588594547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=q5qLe/YbLa8g+76m0wKCJz9sEFGWHkbwiwLtZx/ZVFk=;
        b=BoupBZjinqWOG60CRL1nwi+ttchJJbX0UNYWrTc0U4ZfNvu8j01xdyxYUaoMen9ob3/VDH
        7+LD20bUUoSII35T8mXnqx1GIKOuO0P4it5g/LcjFyLFTrwGngSlhuHxMoamfcPP0o91iJ
        2DHfcVLnxELFkWrWpBwBu80wkVqpQRI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-OeNESl1lNqa3kXw8ft5Jfw-1; Mon, 04 May 2020 08:15:43 -0400
X-MC-Unique: OeNESl1lNqa3kXw8ft5Jfw-1
Received: by mail-wm1-f71.google.com with SMTP id f17so3376788wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=q5qLe/YbLa8g+76m0wKCJz9sEFGWHkbwiwLtZx/ZVFk=;
        b=czWeT1QRDGW31TM0xHOctWuFoWC3UJZeDe7XcRRNu7DDor3qEeelxW+yi0V9d4FvbA
         BzSWDcLpGN3oJWKoIlT/kc66fs6m9LwKRG3Oy7GKTaJ7dd48c9PrCzfCGX5Mvn27qGx+
         sG6jiFA5ZjAPt6PnOftdUe1cZ7nz2ivtFXKctoKOaJrGPpxX1ChfD+9bDIo3P0jS3hvx
         i+dA9GKX1Jm0Y1mF0gTz4CZ4zqeOuztwcCP3HCa9fUYA9aXpiBbf8FxIg6SBFsUkYmoH
         L0gJ3EP/dVKUfqnauaL7Dn9RYoM67jkZbsSXOMHv8XCMo4y62EZLiQRbD9VzgtFbiAMS
         YT5g==
X-Gm-Message-State: AGi0PuYa25M6hV5kVizAgoruf4jrPrRHOxaWyrUuCvwqqzxhLtDqr7ce
        rik8oAlaxre4aSoLaxjd+v2e1frspCahOxROq1HSA8GUqGVauBIGULXQGdxZ05r/5zQ/mQNxoRt
        NLATTRlfYuzz8EPQBl/wE8anJ
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr14085618wmh.186.1588594542755;
        Mon, 04 May 2020 05:15:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypIAWbJGa73k/tJK0QUm1DfayD29dwoou70hN0HhHJnMSNr/UKPo3sTuvVCseBF2z+tgI/8tzQ==
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr14085601wmh.186.1588594542532;
        Mon, 04 May 2020 05:15:42 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id s24sm13455322wmj.28.2020.05.04.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:15:41 -0700 (PDT)
Date:   Mon, 4 May 2020 08:15:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        justin.he@arm.com, ldigby@redhat.com, mst@redhat.com, n.b@live.com,
        stefanha@redhat.com
Subject: [GIT PULL] vhost: fixes
Message-ID: <20200504081540-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0b841030625cde5f784dd62aec72d6a766faae70:

  vhost: vsock: kick send_pkt worker once device is started (2020-05-02 10:28:21 -0400)

----------------------------------------------------------------
virtio: fixes

A couple of bug fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jia He (1):
      vhost: vsock: kick send_pkt worker once device is started

Stefan Hajnoczi (1):
      virtio-blk: handle block_device_operations callbacks after hot unplug

 drivers/block/virtio_blk.c | 86 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/vhost/vsock.c      |  5 +++
 2 files changed, 83 insertions(+), 8 deletions(-)

