Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17871C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F3821741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE5qbyxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBEQeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:34:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46159 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbgBEQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580920474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rexFf3u9dwOgKF8qwa6CKc29pRBkdXMGcoOgim7g7N4=;
        b=TE5qbyxxU+s4K2sR75Ci1TtW8PcT1NI2MJ1jlTJJt83M++wECgsDRazU//Bgsk6Dvx6Xe1
        vyYEN3+lkL2oFb2JvRGRCWYWtTkHGTETbz5PeXG0iMuy9frQ91CpdDxOh6kccvebvMDdQ7
        MKhJV/W5z5sdobX3sUVC/jiNwP5gCgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-ei-AHbADN5qyeyeQL7fMRw-1; Wed, 05 Feb 2020 11:34:13 -0500
X-MC-Unique: ei-AHbADN5qyeyeQL7fMRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64CD4190D37B;
        Wed,  5 Feb 2020 16:34:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F28231001B05;
        Wed,  5 Feb 2020 16:34:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Jason Wang <jasowang@redhat.com>,
        Liang Li <liang.z.li@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 0/3] virtio-balloon: Fixes + switch back to OOM handler
Date:   Wed,  5 Feb 2020 17:33:59 +0100
Message-Id: <20200205163402.42627-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for issues I stumbled over while working on patch #3.

Switch back to the good ol' OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_O=
OM
as the switch to the shrinker introduce some undesired side effects. Keep
the shrinker in place to handle VIRTIO_BALLOON_F_FREE_PAGE_HINT.
Lengthy discussion under [1].

I tested with QEMU and "deflate-on-oom=3Don". Works as expected. Did not
test the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, as it is
hard to trigger (only when migrating a VM, and even then, it might not
trigger).

[1] https://www.spinics.net/lists/linux-virtualization/msg40863.html

David Hildenbrand (3):
  virtio-balloon: Fix memory leak when unloading while hinting is in
    progress
  virtio_balloon: Fix memory leaks on errors in virtballoon_probe()
  virtio-balloon: Switch back to OOM handler for
    VIRTIO_BALLOON_F_DEFLATE_ON_OOM

 drivers/virtio/virtio_balloon.c | 124 +++++++++++++++-----------------
 1 file changed, 57 insertions(+), 67 deletions(-)

--=20
2.24.1

