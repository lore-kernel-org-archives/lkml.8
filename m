Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68AC2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082FD212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d56SjWTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCaSAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:00:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgCaSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585677620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cFoxPzLg3hdCD0+oBUzFhDTOM1NMJFZ5aeMIjUALD/M=;
        b=d56SjWTAWP+qGQ5JfP6Xn9ZMqEL19UoW/3tPIqd9NEDNdvOeLZdw1vm1/WcQXAMb+7PEGr
        ln4LjRVu0eDrxgv0Iz1Xna1wtQYimgddwFab4Fz3Z9outPNCHtk08ex8QnGUIttbjednY6
        t9eTKAV/0GpkXQY5pbrsEhoqcd7VwDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-UG21D0t2MnuDehxvHf0PFg-1; Tue, 31 Mar 2020 14:00:17 -0400
X-MC-Unique: UG21D0t2MnuDehxvHf0PFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1FEE1084424;
        Tue, 31 Mar 2020 18:00:15 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25924608E7;
        Tue, 31 Mar 2020 18:00:10 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 0/8] vhost: Reset batched descriptors on SET_VRING_BASE call
Date:   Tue, 31 Mar 2020 19:59:58 +0200
Message-Id: <20200331180006.25829-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vhost did not reset properly the batched descriptors on SET_VRING_BASE
event. Because of that, is possible to return an invalid descriptor to
the guest.

This series ammend this, resetting them every time backend changes, and
creates a test to assert correct behavior. To do that, they need to
expose a new function in virtio_ring, virtqueue_reset_free_head, only
on test code.

Another useful thing would be to check if mutex is properly get in
vq private_data accessors. Not sure if mutex debug code allow that,
similar to C++ unique lock::owns_lock. Not acquiring in the function
because caller code holds the mutex in order to perform more actions.

v2:
* Squashed commits.
* Create vq private_data accesors (mst).

This is meant to be applied on top of
c4f1c41a6094582903c75c0dcfacb453c959d457 in
git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.

Eugenio P=C3=A9rez (5):
  vhost: Create accessors for virtqueues private_data
  tools/virtio: Add --batch option
  tools/virtio: Add --batch=3Drandom option
  tools/virtio: Add --reset=3Drandom
  tools/virtio: Make --reset reset ring idx

Michael S. Tsirkin (3):
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched version by default
  vhost: batching fetches

 drivers/vhost/net.c          |  28 ++--
 drivers/vhost/test.c         |  59 +++++++-
 drivers/vhost/test.h         |   1 +
 drivers/vhost/vhost.c        | 271 +++++++++++++++++++++++------------
 drivers/vhost/vhost.h        |  45 +++++-
 drivers/vhost/vsock.c        |  14 +-
 drivers/virtio/virtio_ring.c |  29 ++++
 tools/virtio/linux/virtio.h  |   2 +
 tools/virtio/virtio_test.c   | 123 ++++++++++++++--
 9 files changed, 445 insertions(+), 127 deletions(-)

--=20
2.18.1

