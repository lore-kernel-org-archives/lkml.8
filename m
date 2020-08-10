Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC60D20716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7NvJSKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgHJVSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:18:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbgHJVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597094328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2lrokUfoGQAhbbN5B0q4Eo9DnItokSH8gIcb/T1Xy8=;
        b=Q7NvJSKtrzht3ue4p/CybZnz5ntTs+P9xUZfVSlILpJHMKepGJC+7U/DoxX6jvAHoVSm/7
        7U0FTJrJg9hlNJwVoKwb6bVAb+TOdL3T79sVCiNVJ3WoLC0lZwxMa2+Qk4owD02OW74+C5
        hlS0vpqaTQL+IOJQrIZ8AN2Gr2jRDdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-OUZDo_1aPkmYw61eUWUvDw-1; Mon, 10 Aug 2020 17:18:47 -0400
X-MC-Unique: OUZDo_1aPkmYw61eUWUvDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D351005510;
        Mon, 10 Aug 2020 21:18:45 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-28.rdu2.redhat.com [10.10.114.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5645779CF3;
        Mon, 10 Aug 2020 21:18:44 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/nouveau/kms/nv140-: Include correct push header in crcc37d.c
Date:   Mon, 10 Aug 2020 17:18:37 -0400
Message-Id: <20200810211838.37862-2-lyude@redhat.com>
In-Reply-To: <20200810211838.37862-1-lyude@redhat.com>
References: <20200810211838.37862-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like when we converted everything over to Nvidia's class headers,
we mistakenly included the nvif/push507b.h instead of nvif/pushc37b.h,
which resulted in breaking CRC reporting for volta+:

nouveau 0000:1f:00.0: disp: chid 0 stat 10003361 reason 3
[RESERVED_METHOD] mthd 0d84 data 00000000 code 00000000
nouveau 0000:1f:00.0: disp: chid 0 stat 10003360 reason 3
[RESERVED_METHOD] mthd 0d80 data 00000000 code 00000000
nouveau 0000:1f:00.0: DRM: CRC notifier ctx for head 3 not finished
after 50ms

So, fix that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: c4b27bc8682c ("drm/nouveau/kms/nv50-: convert core crc_set_src() to new push macros")
---
 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crcc37d.c b/drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
index 9afe9a87bde0c..814e5bd974460 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
@@ -6,7 +6,7 @@
 #include "disp.h"
 #include "head.h"
 
-#include <nvif/push507c.h>
+#include <nvif/pushc37b.h>
 
 #include <nvhw/class/clc37d.h>
 
-- 
2.26.2

