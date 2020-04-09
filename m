Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F5C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="gGAFmj/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDIB22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:28:28 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33644 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDIB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:28:24 -0400
Received: by mail-qv1-f67.google.com with SMTP id p19so4779986qve.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 18:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAZ49xsLFafBw1eWwQbQgcyCMLWhUsSohaRadPz3t44=;
        b=gGAFmj/fpiuOrhiYazOd8ZJKb6FeO5AcwBXbcykszik2Cxb11C6INXDPGjZMgX/IFL
         +8D0QXaBjKOfXqrfiz6uxYMOaI+BTDldCTv+XLW5SH3eY3eJ9F4BdJAQvelqu8zm58RA
         kOFtmJcThBkMtMItCWkwgfjkzJVC141uKOV6IXm/dAyZ0eueS4wO3b437dyZRrVzdG6I
         601kOarVFZTFtZOMcPJkE9U7ugiUoPFoXsFT+CLNnzBlQ5DKbHJQpeHrHCMSO18ArPJ6
         5XSjo+2ShjDn/GNQK7IhGamQxv+BtZuN4R9pV98ffL7O6gPAENUwTiasoXfWUWVkjRf1
         j2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAZ49xsLFafBw1eWwQbQgcyCMLWhUsSohaRadPz3t44=;
        b=t64Qx2dvsulTSxOaHapV3iA9grhT21zgni1Ya22L1oiEI69tPB4ASi+3SO9po8jNng
         SwYdfpORRiEDBv2n9uK1MEyV4mzclm+EHUb0CcnGC/j2zzJESkLoXPc9E5g74Zrp+9MX
         ObWh7o2CR7HwC6bBNGsv9GrFwYxiLDeP/wAeC0JENfI5aZzeGYRrtt7QgIrDmherIg9b
         VIbPDBYR+xFC1tQ6swJaqH1PHhROEcfhChLrRQJW1dk43nvMbiFzqlt1eI8wZGNwl08Y
         akH5/Stz0vgzRI/C5WaUozaq91uumuqAph9WPxPzOfaA42MBpFsz7/h+OCKSWsKXvZsJ
         Y1jg==
X-Gm-Message-State: AGi0PuaH1AR4opmpXJz6FSUw5z85mN/y+R2fSpAK2W2Xd/obGUjvxaLE
        dpZbEPD1vpKMFY+lzqIpEry/5Q==
X-Google-Smtp-Source: APiQypJc2DhYwtTtM+Ce7usYBK/yFp24XNfCDvHn8AqXL3/muK8IGYc5YthGfwGZy0C04JbdRiUWqQ==
X-Received: by 2002:a05:6214:9cb:: with SMTP id dp11mr9948057qvb.60.1586395702443;
        Wed, 08 Apr 2020 18:28:22 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 18:28:22 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     christian.koenig@amd.com, alexander.deucher@amd.com,
        David1.Zhou@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amd/amdgpu: add print prefix for dev_* variants
Date:   Wed,  8 Apr 2020 21:28:14 -0400
Message-Id: <20200409012815.22309-3-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409012815.22309-1-mail@aurabindo.in>
References: <20200409012815.22309-1-mail@aurabindo.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define dev_fmt macro for informative print messages

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 67d654a89..7a52d37e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -34,6 +34,12 @@
 
 #define pr_fmt(fmt) "amdgpu: " fmt
 
+#ifdef dev_fmt
+#undef dev_fmt
+#endif
+
+#define dev_fmt(fmt) "amdgpu: " fmt
+
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
-- 
2.26.0

