Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F946C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1748C20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3A8eJfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:43:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgBGMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581079437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/runWZY2kWww40/PYPKpoZtN7XMh1Bf5TMeaBp+f1iE=;
        b=A3A8eJfskMtLTFC73YOacXFsHnXHoR8RGzm/dvmNr09b3k5+EayPxsfa/+z3xNl8q1Fka1
        Snc1JoC27SshwKvx+OMKqQZV5TrKZUsBgu8O7qCZNllLSORyPxQncFrLwCzSmzrPay2ius
        jBLW5cGYwA9KDdx4+PIZi4mwH310fkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-a3Y7QnfzMUSfPwuriaC8SQ-1; Fri, 07 Feb 2020 07:43:53 -0500
X-MC-Unique: a3Y7QnfzMUSfPwuriaC8SQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC9D800E21;
        Fri,  7 Feb 2020 12:43:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0957360BEC;
        Fri,  7 Feb 2020 12:43:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 33E42A1E0; Fri,  7 Feb 2020 13:43:48 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/bochs: deinit bugfix
Date:   Fri,  7 Feb 2020 13:43:48 +0100
Message-Id: <20200207124348.21641-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whenever mode_config was actually properly
initialized before trying to clean it up.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index cc93ff74fbd8..3a755c911342 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -164,6 +164,9 @@ int bochs_kms_init(struct bochs_device *bochs)
 
 void bochs_kms_fini(struct bochs_device *bochs)
 {
+	if (!bochs->dev->mode_config.num_connector)
+		return;
+
 	drm_atomic_helper_shutdown(bochs->dev);
 	drm_mode_config_cleanup(bochs->dev);
 }
-- 
2.18.1

