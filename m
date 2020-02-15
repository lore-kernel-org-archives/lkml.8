Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44115C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2897820726
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgBOSJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:09:35 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:27437 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgBOSJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 13:09:34 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 289109782C;
        Sat, 15 Feb 2020 18:09:33 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 48KdYm6bFrz4Wy6;
        Sat, 15 Feb 2020 18:09:32 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from skull.home.blih.net (lfbn-idf2-1-900-181.w86-238.abo.wanadoo.fr [86.238.131.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 7FA00197EE;
        Sat, 15 Feb 2020 18:09:31 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
From:   Emmanuel Vadot <manu@FreeBSD.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@intel.com,
        efremov@linux.com, tzimmermann@suse.de, noralf@tronnes.org,
        sam@ravnborg.org, chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Emmanuel Vadot <manu@FreeBSD.Org>,
        Emmanuel Vadot <manu@FreeBSD.org>
Subject: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
Date:   Sat, 15 Feb 2020 19:09:10 +0100
Message-Id: <20200215180911.18299-2-manu@FreeBSD.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200215180911.18299-1-manu@FreeBSD.org>
References: <20200215180911.18299-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Vadot <manu@FreeBSD.Org>

Contributors for this file are :
Chris Wilson <chris@chris-wilson.co.uk>
Denis Efremov <efremov@linux.com>
Jani Nikula <jani.nikula@intel.com>
Maxime Ripard <mripard@kernel.org>
Noralf Trønnes <noralf@tronnes.org>
Sam Ravnborg <sam@ravnborg.org>
Thomas Zimmermann <tzimmermann@suse.de>

Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
---
 drivers/gpu/drm/drm_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index b031b45aa8ef..6b0c6ef8b9b3 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 or MIT
 /*
  * Copyright 2018 Noralf Trønnes
  */
-- 
2.25.0

