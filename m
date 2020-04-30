Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE084C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877E22076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgD3Ozp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:55:45 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:16249 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgD3Ozp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:55:45 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 2472A74D45;
        Thu, 30 Apr 2020 14:55:44 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49CdjW6TRmz4trR;
        Thu, 30 Apr 2020 14:55:43 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from tails.home (lfbn-idf2-1-900-181.w86-238.abo.wanadoo.fr [86.238.131.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 9A0C419F4E;
        Thu, 30 Apr 2020 14:55:42 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
From:   Emmanuel Vadot <manu@FreeBSD.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, noralf@tronnes.org, kraxel@redhat.com,
        tglx@linutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@FreeBSD.org>
Subject: [RESEND 2/2] drm/format_helper: Dual licence the header in GPL-2 and MIT
Date:   Thu, 30 Apr 2020 16:55:37 +0200
Message-Id: <20200430145537.31474-1-manu@FreeBSD.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source file was dual licenced but the header was omitted, fix that.
Contributors for this file are:
Noralf Trønnes <noralf@tronnes.org>
Gerd Hoffmann <kraxel@redhat.com>
Thomas Gleixner <tglx@linutronix.de>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
---
 include/drm/drm_format_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index ac220aa1a245..7c5d4ffb2af2 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
 /*
  * Copyright (C) 2016 Noralf Trønnes
  */
-- 
2.25.1

