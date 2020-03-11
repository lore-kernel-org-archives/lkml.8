Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7C4C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B25F22464
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYQFm7zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgCKNzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:55:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729460AbgCKNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583934939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B0fQvRnnbCIzTHm/Is/o3N8IvV36jYDTfCd8QuUaXqI=;
        b=WYQFm7zBpLKQjK+8I2LvjuWJoWjJng17T16vZ4KczBDMnSv6OwcrRmtdIqdnXiZbaNQsii
        DuR9cLx0CJ8QIB7SRTSdVf8JHsjYGUQXJOt/KNf6HtByyJf6IajCuJbwN2kFCqWx7cvBAb
        9vXFb+fXVSEFYOKgJVXom6XjxieF1Go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-2UXIatH7OA-f802487RpQQ-1; Wed, 11 Mar 2020 09:55:35 -0400
X-MC-Unique: 2UXIatH7OA-f802487RpQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534A41005513;
        Wed, 11 Mar 2020 13:55:33 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A72DE60C99;
        Wed, 11 Mar 2020 13:55:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v4 0/1] mm: virtio-balloon fix to go through the -mm tree
Date:   Wed, 11 Mar 2020 14:55:22 +0100
Message-Id: <20200311135523.18512-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew, as this fix is based on free page reporting, can this go through
your tree?

Patch #1 contains a proper description.

v3 -> v4:
- Add Ack from David Rientjes
- Minor tweaks to test details in the patch description

v2 -> v3:
- Use vb->vdev instead of vdev in all feature checks. We'll clean the
  other ones up later.
- Add one empty line virtballoon_probe() to make it look consistent.
- Drop one unrelated added line in virtballoon_remove()

v1 -> v2:
- Rebase on top of linux-next (free page reporting)
- Clarified some parts in the patch description and added testing
  instructions/results
- Added Fixes: and Tested-by:

David Hildenbrand (1):
  virtio-balloon: Switch back to OOM handler for
    VIRTIO_BALLOON_F_DEFLATE_ON_OOM

 drivers/virtio/virtio_balloon.c | 103 +++++++++++++++-----------------
 1 file changed, 47 insertions(+), 56 deletions(-)

--=20
2.24.1

