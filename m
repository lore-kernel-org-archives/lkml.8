Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949DCC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395E720747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="oNGBRMTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgDHNhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:37:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35399 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgDHNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:37:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id c63so79994qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
        b=oNGBRMTTT4G0ujvkoAxRMd3XDpqMEs3ISjiGTl3+WMr3y0jNbTYWFZVr6oSkfSctjo
         820mOtbknzXiP1a+VHzTLSrRoFPDtBkZyrvm3Y3KHV/5L1o66DFPQqYtjEqM7Q2tmeN2
         bZYbGMP/wDNJ20bM9UVlVtK9xYk0ZDHBaRHDUwPMUyRhgJFh220KAzu6Ob9GFKhlQauB
         xWQdo4bNV/1iV8qJjw+cDLSSoaWUxzOP+3oFmut9SJFXCDdi73L1QXjveEoi4S959mUF
         MlfOIVkuGAoI/PZErdQEivO3GhuWEOt1ALkBlCc746rf7CeiGoO3crXm+N6ddXc4vbo8
         YTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a8mBf/x6tKmxXEyAN6VSKYHc9JSU+mIaA50Z6TnFau4=;
        b=OvO0Ux3v+BlU2FNT+1qCdKzHKU8ipeDyNNb1bO17/QxfCiZjnMo5nJQ58kAtHsPSeK
         QXFTPGMdHIp0X25YJpQchGymkSI4tib8rVtLAgm7lNNcaQYHSz0YP6iOezJ4L0n3hGb/
         9+ozD+7SndbGd9HCX/mz1ukT5prEAHicrIvNQgoN0h8XBrETEHj67OKrzvzpNybI98pP
         lKQyS/3m7AlBdgpSWM9NJ1p/vLovc6me4b5i8A9m0LTrAX2DVpJeNKERjlgF4Uk45a4f
         h59J0COtj7immvd74Ein7EkJfQ0HuGa2Cs75Hi4AoNwrNNyM1qo+dbOhHy2M7+jQw+Bx
         GGSA==
X-Gm-Message-State: AGi0PuaesdlJabAsKehQTXcyWCMNcjBuyqmmNIjTtNlwcKDUdHM0EbNA
        Xhnl7IBPvJ9UAwLbg+f1Mgf8bg==
X-Google-Smtp-Source: APiQypLRBp+bZkFj4khOGASSTYhMEobSFxchIEOA/aHpRrEQBTYsVV97VRsDR3YR4b6DeyK0CmNFZA==
X-Received: by 2002:a37:9e17:: with SMTP id h23mr7319606qke.315.1586353060016;
        Wed, 08 Apr 2020 06:37:40 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id q5sm8493827qkn.59.2020.04.08.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:37:38 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     avid1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/amdgpu: add prefix for pr_* prints
Date:   Wed,  8 Apr 2020 09:37:35 -0400
Message-Id: <20200408133735.7679-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdgpu uses lots of pr_* calls for printing error messages.
With this prefix, errors shall be more obvious to the end
use regarding its origin, and may help debugging.

Prefix format:

[xxx.xxxxx] amdgpu: ...

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index da3bcff61..67d654a89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -28,6 +28,12 @@
 #ifndef __AMDGPU_H__
 #define __AMDGPU_H__
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "amdgpu: " fmt
+
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
-- 
2.26.0

