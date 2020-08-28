Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56512C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325772086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="buvukgVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH1OGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgH1OGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:06:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EAC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E57ufVy/Xyp2As9q9f5ZuJpwUNN0dS/jixbFSkhJ07w=; b=buvukgVRXIgzOeVt9OWrYHn1jf
        xByVXZMtFrzIj1qVmd9mts1RKXSuTLap8rB29x7viWy4eQPDZWW1bfxsUhxZJwFKTUVzPiDJFwm3Y
        By7fLAkRWsFfaUZ/fCarjMr6yzXeUNJERNGNCh5zMLSsAiUC4t75VPBNoy5X13sFvvCOOOBvjp5+l
        y+l6EFzW7tM9Fcz307V7T3fO1GwVwdk3JiozgEAgtsJ/0RU09QhStRTgp4djEep7uqbHRnms0bWik
        Whzy6W1zgEsK/ozbyf54qq0a3PzWhX+/PenL+k1BGX/CSTn/JEfgYLRqdPbgLMmZrZ+PUXDDl0DfI
        42DCxmjw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBf0y-0005nF-Hx; Fri, 28 Aug 2020 14:06:00 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] drm: virtio: fix kconfig dependency warning
Message-ID: <7481fb88-6b04-3726-57e0-0f513245c657@infradead.org>
Date:   Fri, 28 Aug 2020 07:05:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig dependency warning by using a different Kconfig symbol.

WARNING: unmet direct dependencies detected for VIRTIO_DMA_SHARED_BUFFER
  Depends on [n]: VIRTIO_MENU [=n] && DMA_SHARED_BUFFER [=y]
  Selected by [y]:
  - DRM_VIRTIO_GPU [=y] && HAS_IOMEM [=y] && DRM [=y] && VIRTIO [=y] && MMU [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
---
v2: depends on VIRTIO + VIRTIO_MENU (Gerd)

Found in linux-next but applies to mainline.

 drivers/gpu/drm/virtio/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200828.orig/drivers/gpu/drm/virtio/Kconfig
+++ linux-next-20200828/drivers/gpu/drm/virtio/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_VIRTIO_GPU
 	tristate "Virtio GPU driver"
-	depends on DRM && VIRTIO && MMU
+	depends on DRM && VIRTIO && VIRTIO_MENU && MMU
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	select VIRTIO_DMA_SHARED_BUFFER

