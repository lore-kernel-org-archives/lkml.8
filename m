Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F79AC4CEC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872E720736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cyjd/D0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgCKRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730362AbgCKRQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583947004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8uHgWgRrKhjOS0/8z1+bbTJM5VUQNPPAg1DCmOx02I=;
        b=Cyjd/D0bXCZLp8TYtNSXBshwLqYXHbrtyWMC9BtyTBzITP0FQ0cXj012ngDtRgpVKee02i
        pxct2wRoJ4OrzrZmJf5kzFCWdOJBLu0QabIppWxmga+AwAKS1kenP00PR+ivOp6RU2/S2i
        htZE200AAg7S+82BmlKJ1dV0nIcsZbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-0R_hVMT8Osu2Hnt2IwParA-1; Wed, 11 Mar 2020 13:16:40 -0400
X-MC-Unique: 0R_hVMT8Osu2Hnt2IwParA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43FB4800D5E;
        Wed, 11 Mar 2020 17:16:38 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C87DD60BEE;
        Wed, 11 Mar 2020 17:16:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Igor Mammedov <imammedo@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 09/10] virtio-mem: Better retry handling
Date:   Wed, 11 Mar 2020 18:14:21 +0100
Message-Id: <20200311171422.10484-10-david@redhat.com>
In-Reply-To: <20200311171422.10484-1-david@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's start with a retry interval of 5 seconds and double the time until
we reach 5 minutes, in case we keep getting errors. Reset the retry
interval in case we succeeded.

The two main reasons for having to retry are
- The hypervisor is busy and cannot process our request
- We cannot reach the desired requested_size (esp., not enough memory can
  get unplugged because we can't allocate any subblocks).

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index aa322e7732a4..48e96702d4ce 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -138,7 +138,9 @@ struct virtio_mem {
=20
 	/* Timer for retrying to plug/unplug memory. */
 	struct hrtimer retry_timer;
-#define VIRTIO_MEM_RETRY_TIMER_MS		30000
+	unsigned int retry_timer_ms;
+#define VIRTIO_MEM_RETRY_TIMER_MIN_MS		50000
+#define VIRTIO_MEM_RETRY_TIMER_MAX_MS		300000
=20
 	/* Memory notifier (online/offline events). */
 	struct notifier_block memory_notifier;
@@ -1548,6 +1550,7 @@ static void virtio_mem_run_wq(struct work_struct *w=
ork)
=20
 	switch (rc) {
 	case 0:
+		vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 		break;
 	case -ENOSPC:
 		/*
@@ -1563,8 +1566,7 @@ static void virtio_mem_run_wq(struct work_struct *w=
ork)
 		 */
 	case -ENOMEM:
 		/* Out of memory, try again later. */
-		hrtimer_start(&vm->retry_timer,
-			      ms_to_ktime(VIRTIO_MEM_RETRY_TIMER_MS),
+		hrtimer_start(&vm->retry_timer, ms_to_ktime(vm->retry_timer_ms),
 			      HRTIMER_MODE_REL);
 		break;
 	case -EAGAIN:
@@ -1584,6 +1586,8 @@ static enum hrtimer_restart virtio_mem_timer_expire=
d(struct hrtimer *timer)
 					     retry_timer);
=20
 	virtio_mem_retry(vm);
+	vm->retry_timer_ms =3D min_t(unsigned int, vm->retry_timer_ms * 2,
+				   VIRTIO_MEM_RETRY_TIMER_MAX_MS);
 	return HRTIMER_NORESTART;
 }
=20
@@ -1750,6 +1754,7 @@ static int virtio_mem_probe(struct virtio_device *v=
dev)
 	spin_lock_init(&vm->removal_lock);
 	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vm->retry_timer.function =3D virtio_mem_timer_expired;
+	vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
=20
 	/* register the virtqueue */
 	rc =3D virtio_mem_init_vq(vm);
--=20
2.24.1

