Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBABC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3F22B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0LpDi6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgCDQ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:59:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729926AbgCDQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMBT3ti1qkBV9aohZy3sm3nCwdAxuEQLpk1laEzUSL0=;
        b=a0LpDi6M7+ORD3m4vl+i1Id5Q7h6PLSVPtM4I7/8YB1g59bqhgHJSoTwem8TaTAZ2Yeyav
        wu3sQsaKnsJpak0g0tsIjX19hN9OjP8/MCJN90Zq9vP6RVKgE6WqrLWz4ivC73lyAththH
        DAKbto1amG41nsZR/e5gYCSwXl7jnJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-CZ0xLNOGNQOnC9KVtcyQMQ-1; Wed, 04 Mar 2020 11:59:12 -0500
X-MC-Unique: CZ0xLNOGNQOnC9KVtcyQMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36AD0DB61;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 906915C1D4;
        Wed,  4 Mar 2020 16:59:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 378E32257D3; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 01/20] dax: Modify bdev_dax_pgoff() to handle NULL bdev
Date:   Wed,  4 Mar 2020 11:58:26 -0500
Message-Id: <20200304165845.3081-2-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtiofs does not have a block device. Modify bdev_dax_pgoff() to be
able to handle that.

If there is no bdev, that means dax offset is 0. (It can't be a partition
block device starting at an offset in dax device).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0aa4b6bc5101..c34f21f2f199 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -46,7 +46,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t si=
ze,
 		pgoff_t *pgoff)
 {
-	phys_addr_t phys_off =3D (get_start_sect(bdev) + sector) * 512;
+	sector_t start_sect =3D bdev ? get_start_sect(bdev) : 0;
+	phys_addr_t phys_off =3D (start_sect + sector) * 512;
=20
 	if (pgoff)
 		*pgoff =3D PHYS_PFN(phys_off);
--=20
2.20.1

