Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D38C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D7E2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McaMgNKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFGOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:11:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36069 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726522AbgFGOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 10:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591539086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OWdfFlhdvAuK9m65CuOfAgwGAWbw+S7EDp4ZxipnEDI=;
        b=McaMgNKEYodpEFWkgxnMNM7DdYEtfsPoFRTC7LqdtwcH5RUTNxp95K89hd5W6FVd3ai/Xa
        EKeIT1/XnqeN7ELZ7x0OF/n3jegH2NlFPb0qISGF8ql8o/AT99T16Ln4HTCXO9cbE3KeaX
        ivv0PHhhlh2ezpLfiSaSM20EnLS9znA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-7j031QoCOV6v5OI9yU-7YA-1; Sun, 07 Jun 2020 10:11:24 -0400
X-MC-Unique: 7j031QoCOV6v5OI9yU-7YA-1
Received: by mail-wm1-f72.google.com with SMTP id b65so4289075wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 07:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OWdfFlhdvAuK9m65CuOfAgwGAWbw+S7EDp4ZxipnEDI=;
        b=VijY20ZOmK1b9wZh1Sf2wMUFPwBhlVwTKMFuvDf77QjgzTYd2y26S131y1/VddWXXi
         mPgtQGZXAv664Il4gLzRPPIsksKcFyvRjWmo0gaaP+0Bpg9Tg8ut3dRH/IYapqrtQM4U
         nD+ZZE+sD2eTr+Yq0gJIYvRz0PPaWUz5n0G6CmcbDCBDWrpHj0fXSRXby5ZyHm7Fa39U
         E9BdkjuQBtvDIJsyJOHRl6w1qat0f/SP9NoIFGG5t5ixQhjHXGpw7wXRxg9XXRNlvy9Z
         p7fSVSd+iGYVG9nSiqrec3tvgGY5ev6HdS7aqhIvVpKKiYHWg8bJdl19COYhc7DvINIW
         C7KA==
X-Gm-Message-State: AOAM530OUGF2eMhRl1xV6wTty1B4xjyq6oZa0c9RrSprc55bUZxe8ZfT
        3xQ0IVXeNQn1cuGiqGqbsdWnf6boXE3LwHERDDRFBpAMqRiBE+UT59OoFyMDaWYhjMmlBN1XhB9
        /hklXm77kb0P9MBTG3N1HxvBC
X-Received: by 2002:a1c:6583:: with SMTP id z125mr12068653wmb.102.1591539083091;
        Sun, 07 Jun 2020 07:11:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV7ZWEoPal74PMq+69HAL799WrVxakjuqYm1EYkHAsqG9CYVZ+7zhU5OuON8EQ3eWowy87cg==
X-Received: by 2002:a1c:6583:: with SMTP id z125mr12068635wmb.102.1591539082879;
        Sun, 07 Jun 2020 07:11:22 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id u130sm20174752wmg.32.2020.06.07.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:11:22 -0700 (PDT)
Date:   Sun, 7 Jun 2020 10:11:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v5 00/13] vhost: ring format independence
Message-ID: <20200607141057.704085-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This adds infrastructure required for supporting
multiple ring formats.

The idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

Used ring is similar: we fetch into an independent struct first,
convert that to IOV later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

For used descriptors, this allows keeping track of the buffer length
without need to rescan IOV.

This seems to perform exactly the same as the original
code based on a microbenchmark.
Lightly tested.
More testing would be very much appreciated.


changes from v4:
	- added used descriptor format independence
	- addressed comments by jason
	- fixed a crash detected by the lkp robot.

changes from v3:
        - fixed error handling in case of indirect descriptors
        - add BUG_ON to detect buffer overflow in case of bugs
                in response to comment by Jason Wang
        - minor code tweaks

Changes from v2:
	- fixed indirect descriptor batching
                reported by Jason Wang

Changes from v1:
	- typo fixes


Michael S. Tsirkin (13):
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched version by default
  vhost: batching fetches
  vhost: cleanup fetch_buf return code handling
  vhost/net: pass net specific struct pointer
  vhost: reorder functions
  vhost: format-independent API for used buffers
  vhost/net: convert to new API: heads->bufs
  vhost/net: avoid iov length math
  vhost/test: convert to the buf API
  vhost/scsi: switch to buf APIs
  vhost/vsock: switch to the buf API
  vhost: drop head based APIs

 drivers/vhost/net.c   | 174 ++++++++++---------
 drivers/vhost/scsi.c  |  73 ++++----
 drivers/vhost/test.c  |  22 +--
 drivers/vhost/vhost.c | 380 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  44 +++--
 drivers/vhost/vsock.c |  30 ++--
 6 files changed, 441 insertions(+), 282 deletions(-)

-- 
MST

