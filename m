Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C6C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A3320663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIfTKKi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCRAC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:02:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55471 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgCRAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584489778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N2Gtgkv06wnI4cyGTcKeuqfrpNMV9nZjixOcNqMDEdw=;
        b=MIfTKKi99BlmM/XE27/+/oL06Ey0OSfLOP5vjDirrD/va8aA7CPDedrfx6ccgWR+oAIdmE
        wKK9vkcJ4yjYDCiqemPI5I8rlHPqIXhL/DlB8ZUq/TDd9uu5Gbkzi4DQ0jVukzkP9PrYdX
        2wUFQCuWE2+x/zbQOu05uDn2S8BoJBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-pezQ8yvvMRenOOh_kZDzdQ-1; Tue, 17 Mar 2020 20:02:56 -0400
X-MC-Unique: pezQ8yvvMRenOOh_kZDzdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006661137842;
        Wed, 18 Mar 2020 00:02:55 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3AAD5C1BB;
        Wed, 18 Mar 2020 00:02:53 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Remove nouveau_bios_connector_entry()
Date:   Tue, 17 Mar 2020 19:59:45 -0400
Message-Id: <20200317235946.204443-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function doesn't exist

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bios.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.h b/drivers/gpu/drm/nou=
veau/nouveau_bios.h
index 18eb061ccafb..5495f004a297 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.h
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.h
@@ -163,8 +163,6 @@ u8 *olddcb_conn(struct drm_device *, u8 idx);
 int nouveau_bios_init(struct drm_device *);
 void nouveau_bios_takedown(struct drm_device *dev);
 int nouveau_run_vbios_init(struct drm_device *);
-struct dcb_connector_table_entry *
-nouveau_bios_connector_entry(struct drm_device *, int index);
 bool nouveau_bios_fp_mode(struct drm_device *, struct drm_display_mode *=
);
 uint8_t *nouveau_bios_embedded_edid(struct drm_device *);
 int nouveau_bios_parse_lvds_table(struct drm_device *, int pxclk,
--=20
2.24.1

