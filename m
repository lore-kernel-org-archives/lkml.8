Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1639EC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1672073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+ceakp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404608AbgDCQvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:51:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403998AbgDCQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585932704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+TgfKjPk2T5P2zzuaFMRdLZ3Utt6NiSkelGon/Wg0oc=;
        b=B+ceakp9bFQhgWUY1QcR8OFVTuy007M26zVulVFI7htiG3xa6M+hrUksZX163otlJ/v9HD
        haTwB5jOSHgSTpFXPAOm3FQ0QKchACaixZ2eC9jqeS8Dd6cAMKwzCVD23HH4ObClp4BB/S
        YL/y6ELPAhMge22T321pPHujzDKU1eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-FS9jkDrXPjKkupA58dS5qg-1; Fri, 03 Apr 2020 12:51:42 -0400
X-MC-Unique: FS9jkDrXPjKkupA58dS5qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2655A1005F82;
        Fri,  3 Apr 2020 16:51:41 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-113-28.ams2.redhat.com [10.36.113.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A450A18A85;
        Fri,  3 Apr 2020 16:51:38 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/8] vhost: Replace vq->private_data access by backend accesors
Date:   Fri,  3 Apr 2020 18:51:14 +0200
Message-Id: <20200403165119.5030-4-eperezma@redhat.com>
In-Reply-To: <20200403165119.5030-1-eperezma@redhat.com>
References: <20200403165119.5030-1-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/vhost/test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 251ca723ac3f..789c096e454b 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -265,7 +265,7 @@ static int vhost_test_set_features(struct vhost_test *n, u64 features)
 
 static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 {
-	static void *private_data;
+	static void *backend;
 
 	const bool enable = fd != -1;
 	struct vhost_virtqueue *vq;
@@ -290,11 +290,11 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	}
 	if (!enable) {
 		vhost_poll_stop(&vq->poll);
-		private_data = vq->private_data;
-		vq->private_data = NULL;
+		backend = vhost_vq_get_backend(vq);
+		vhost_vq_set_backend(vq, NULL);
 	} else {
 		r = vhost_vq_init_access(vq);
-		vq->private_data = private_data;
+		vhost_vq_set_backend(vq, backend);
 		if (r == 0)
 			r = vhost_poll_start(&vq->poll, vq->kick);
 	}
-- 
2.18.1

