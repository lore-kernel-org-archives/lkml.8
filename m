Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A356C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228820774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps0Qb/Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgC2Les (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 07:34:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31788 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728171AbgC2Leq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 07:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585481685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZwSHSfoVZBLh2uVqxeFvTZlYVnfU5BIn50vsgPZBrY=;
        b=Ps0Qb/MfRGA6dEcZ6QSjdIyXovwRN4bvQQ6+XlRZsIg6LLnTVfY3wmtyj5WuURXRX0H+tl
        mobZulr//sSAyF4ap3/ikde6aiBazIk2lwu0GI1HJo959ypWfZOSleAAvRf+3X+0rHfoJx
        biLD8BMf2GdjqiG79PsOMSJmUu/Gajg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-69s3iLlsOYC-Ei4_8RmrFQ-1; Sun, 29 Mar 2020 07:34:43 -0400
X-MC-Unique: 69s3iLlsOYC-Ei4_8RmrFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01B71477;
        Sun, 29 Mar 2020 11:34:42 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-112-95.ams2.redhat.com [10.36.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66FC85C1B5;
        Sun, 29 Mar 2020 11:34:38 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] fixup! vhost: batching fetches
Date:   Sun, 29 Mar 2020 13:33:59 +0200
Message-Id: <20200329113359.30960-7-eperezma@redhat.com>
In-Reply-To: <20200329113359.30960-1-eperezma@redhat.com>
References: <20200329113359.30960-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old code did not take into account the _SET_BASE ioctl.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5f84f29b6c47..1646b1ce312a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1652,6 +1652,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *arg
 		vq->last_avail_idx =3D s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx =3D vq->last_avail_idx;
+		vq->ndescs =3D vq->first_desc =3D 0;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index =3D idx;
--=20
2.18.1

