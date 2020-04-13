Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB6C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF1220692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhGuNrjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgDMJhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:37:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27622 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728050AbgDMJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586770671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SGRl8QigNCMEctxjQ4r6IljMkZq1Kqqri1Hlxh7uGgk=;
        b=bhGuNrjgtxGCwGNlFmA1G3QHmBHCPrJbMacDXttZ+lHmFNQglU51WDqzZ/eRjCXmTC5HXo
        bpqMHm9Gq+PBkuPHMUuRhXvWB280w3GUgKCbXlj5E8dRK7rP2yzU28pIoIW2G/BgV4b4cH
        EJK+rHIxnVhrImhNcrSx4kpxuf+DER0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-gn_bCVhtP_KIDWurWq3pbg-1; Mon, 13 Apr 2020 05:37:46 -0400
X-MC-Unique: gn_bCVhtP_KIDWurWq3pbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE908018A1;
        Mon, 13 Apr 2020 09:37:45 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-79.pek2.redhat.com [10.72.13.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A964E1001925;
        Mon, 13 Apr 2020 09:37:40 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eli@mellanox.com
Subject: [PATCH] vdpa: fix comment of vdpa_register_device()
Date:   Mon, 13 Apr 2020 17:37:38 +0800
Message-Id: <20200413093738.28467-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function should be called only after a success calling for
vdpa_alloc_device().

Reported-by: Eli Cohen <eli@mellanox.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index e9ed6a2b635b..ff6562f602e0 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
=20
 /**
  * vdpa_register_device - register a vDPA device
- * Callers must have a succeed call of vdpa_init_device() before.
+ * Callers must have a succeed call of vdpa_alloc_device() before.
  * @vdev: the vdpa device to be registered to vDPA bus
  *
  * Returns an error when fail to add to vDPA bus
--=20
2.20.1

