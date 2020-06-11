Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7521C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5EE20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjMgwzQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFKLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:34:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39954 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727109AbgFKLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591875260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kvOkZNSYFeD+43Sy08lFqOoYp/OFi1aiv2h8v9KKAP4=;
        b=OjMgwzQzSg1JytLc2ue1MicyXMwsUb3YsVYufc3+QL1xSkgnsr9301ptlAFhofYdWMhhze
        VMuORscLd/Kwx1oRKMlFZZ/0hhmAXWBch/tyzIMDzDHlZaQFFe8hYSdK1exRCBpgbpMyf4
        ovkIbQbSiXxzzAKx2fQIDZj2qsnWsMs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-R3lgsAQ2OHm6_IPc4jW4yQ-1; Thu, 11 Jun 2020 07:34:18 -0400
X-MC-Unique: R3lgsAQ2OHm6_IPc4jW4yQ-1
Received: by mail-wr1-f72.google.com with SMTP id x15so1080069wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kvOkZNSYFeD+43Sy08lFqOoYp/OFi1aiv2h8v9KKAP4=;
        b=MyC+hjZP7hRSfZkxVOrh6f0QFEpXH4iw7hF1a4Q2b9c9WjJbvkrmrFI+/nRqFEgtLc
         IjClqT1pnXbB4w/wEbOMHCoPbjbtcyHvrDW7i1tOA5oL6B/VksYnLb+4gv4aMTsZjX2j
         /1nb9rRQ8mceH3No31mrnWix2eq2GzBNrp3xqCy1mbxgt0y0fCD7vzr/7iqJxjaqka7o
         dyeUYB5VAAA0OXy1HWRkTN9fX8TWyGaNaTubl/GnJyScXNXV0BXYjaqSI5O58Lzasp+o
         lXcVZUFIH52rkhKQE3RFpWGrnDK75qDfO6TazsUliIATpT1MJdyAbJ4838Utm8lwQ1ap
         rHrA==
X-Gm-Message-State: AOAM530J7TVXVl6Fp6orRODYHzlzSIFSjwwvV0ao0YIJ99+zQ/ToVrXA
        zg7OVg5pfQhcUvKKuKMhmkutvZpfXEiVj1L+c5VUdootA9Gvv2HH2DdBrKYGprfmnmHAlgJY+9A
        kVwOoo2ZHX/7cDI8qOpokrQ0q
X-Received: by 2002:adf:afc7:: with SMTP id y7mr9022431wrd.173.1591875256651;
        Thu, 11 Jun 2020 04:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMVwGtIAyLyKuJe/rvxpW01IwwfuztK2wzsTcAeYYTwafjhy8A/SBGUsb9zgk1wtRdA+tFzQ==
X-Received: by 2002:adf:afc7:: with SMTP id y7mr9022405wrd.173.1591875256447;
        Thu, 11 Jun 2020 04:34:16 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id k12sm4673844wrn.42.2020.06.11.04.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:34:15 -0700 (PDT)
Date:   Thu, 11 Jun 2020 07:34:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v8 00/11] vhost: ring format independence
Message-ID: <20200611113404.17810-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This still causes corruption issues for people so don't try
to use in production please. Posting to expedite debugging.

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

changes from v8:
	- squashed in fixes. no longer hangs but still known
	  to cause data corruption for some people. under debug.

changes from v6:
	- fixes some bugs introduced in v6 and v5

changes from v5:
	- addressed comments by Jason: squashed API changes, fixed up discard

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


Michael S. Tsirkin (14):
  vhost: option to fetch descriptors through an independent struct
  fixup! vhost: option to fetch descriptors through an independent
    struct


Michael S. Tsirkin (11):
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched get_vq_desc version
  vhost/net: pass net specific struct pointer
  vhost: reorder functions
  vhost: format-independent API for used buffers
  vhost/net: convert to new API: heads->bufs
  vhost/net: avoid iov length math
  vhost/test: convert to the buf API
  vhost/scsi: switch to buf APIs
  vhost/vsock: switch to the buf API
  vhost: drop head based APIs

 drivers/vhost/net.c   | 174 +++++++++----------
 drivers/vhost/scsi.c  |  73 ++++----
 drivers/vhost/test.c  |  22 +--
 drivers/vhost/vhost.c | 378 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  44 +++--
 drivers/vhost/vsock.c |  30 ++--
 6 files changed, 439 insertions(+), 282 deletions(-)

-- 
MST

